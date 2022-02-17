///Specular= 直射光颜色 * 高光颜色 * pow（max（dot（当前点的反射光方向，当前点到摄像机的方向），0），高光反射参数）

Shader "myShader/Specular_vertex"{
	Properties{
		_Color("漫反射(顶点)",Color) = (0,0,0,0)
		_Specular("高光反射(顶点)",Color) = (0,0,0,0)
		_Range("控制高光光圈大小", Range(8, 256)) = 10
	}

	SubShader{
		Tags{"LightMode" = "ForwardBase"}
		pass{
			CGPROGRAM
			//声明顶点函数
			#pragma vertex vert
			//声明片段函数
			#pragma fragment frag
			//引入光照函数库
			#include "Lighting.cginc"
			fixed4 _Color;
			fixed4 _Specular;
			half _Range;

			struct a2v{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f{
				float4 pos : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
				float3 worldVertex : TEXCOORD1;
			};

			v2f vert(a2v v){
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);	
				o.worldVertex = mul(v.vertex,unity_WorldToObject).xyz;
				return o;
			}

			fixed4 frag(v2f v) : SV_Target{
				float3 worldNormal = normalize(v.worldNormal);
				//将光照方向转换到世界空间下，并做归一化处理
				float3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
				//获取环境光
				float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rbg;
				//漫反射颜色
				fixed3 diffuse = _LightColor0.rgb * _Color.rgb * max(0,dot(worldNormal,worldLightDir));
				//反射光的方向
				float3 reflectDir = normalize(reflect(-worldLightDir,worldNormal));
				//当前点到摄像机的方向(点到视图的方向)
				float3 viewDir = normalize(UnityWorldSpaceViewDir(v.worldVertex));
				//高光计算
				fixed3 Specular = _LightColor0.rgb * _Specular.rgb * pow(max(dot(reflectDir,viewDir),0),_Range);
				fixed3 color = Specular + diffuse + ambient;	
				///返回的是漫反射 + 环境光 + 高光
				return fixed4(color,0);
			}
			ENDCG
		}
	}
	FallBack "Lambert_vertex"
}