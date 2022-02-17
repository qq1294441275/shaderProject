///Specular= 直射光颜色 * pow（max（dot（当前点的反射光方向，当前点到摄像机的方向），0），高光反射参数）

///逐像素
Shader "myShader/Specular_Pixel_Blinn" {
	Properties {
		_Diffuse("_Color",Color) = (1,1,1,1) //物体本身的颜色
		_SpecularColor("_SpecularColor",Color)=(1,1,1,1) //高光的颜色
		_Gloss("Gloss",Range(8,256)) = 10 //控制高光光圈大小
	}
	SubShader {
		pass{
		//正向渲染
		Tags {"LightMode" = "ForwardBase"}
		CGPROGRAM
		//声明顶点函数
		#pragma vertex vert
		//声明片段函数
		#pragma fragment frag
		//引入光照函数库
		#include "Lighting.cginc"
		//外部属性--漫反射颜色	
		fixed4 _Diffuse;
		fixed4 _SpecularColor;
		half _Gloss;

		//顶点输入结构体
		struct a2v{
			//顶点坐标
			float4 vertex : POSITION;	
			//顶点法线
			float3 normal : NORMAL;
		};
		//顶点输出结构体
		struct v2f{
			//屏幕顶点像素坐标 ，模型空间->世界空间->视图空间->齐次裁剪空间
			float4 vertex : SV_POSITION;
			//输出颜色
			fixed3 worldNormal : TEXCOORD0;
			//输出颜色
			fixed3 worldVertex : TEXCOORD1;
		};	
		//顶点函数实现
		v2f vert(a2v inPut){
			//定义顶点输出结构体对象
			v2f outPut;
			//顶点坐标转换到屏幕像素坐标
			outPut.vertex = UnityObjectToClipPos(inPut.vertex);
			//通过矩阵运算，得到世界空间下的顶点法线
			outPut.worldNormal = UnityObjectToWorldNormal(inPut.normal);
			outPut.worldVertex = mul(inPut.vertex,unity_WorldToObject).xyz;
			return outPut;
		}

		//片元函数实现
		fixed4 frag (v2f outPut):SV_Target{
			//获取环境光
			float3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

			//将顶点法线转换到世界空间下，并做归一化处理
			float3 worldNormal = normalize(outPut.worldNormal);
			//将光照方向转换到世界空间下，并做归一化处理
			float3 worldLight = normalize(UnityWorldSpaceLightDir(outPut.worldVertex));

			//带入公式运算
			fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * max(0,dot(worldNormal,worldLight));

			//反射光方向
			// fixed3 reflectDir = normalize(reflect(-worldLight, worldNormal));
			//当前点到摄像机的方向
			fixed3 viewDir = normalize(UnityWorldSpaceViewDir(outPut.worldVertex));

			fixed3 halfDir = normalize(worldLight + viewDir);
			
			//高光反射
			fixed3 specular = _LightColor0.rgb * pow(max(dot(worldNormal, halfDir), 0), _Gloss) *_SpecularColor.rgb;
		    	
			fixed3 color = ambient + diffuse + specular;

			return fixed4(color,0);
		}

		ENDCG
		}
	}
	FallBack "Diffuse"
}
