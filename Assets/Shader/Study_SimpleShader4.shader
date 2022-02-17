Shader "myShader/Study_SimpleShader4" {
	Properties {
		_Color ("颜色值Color-Init", Color) = (1,1,1,1)
	}
	SubShader {
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag	
			fixed4 _Color;

			//常用的结构
			// appdata_base  	顶点、顶点法线、第一组纹理
			// appdata_tan		顶点、顶点切线、顶点法线、第一组纹理
			// appdata_img		顶点、第一组纹理
			// appdata_full		顶点、顶点切线、顶点法线、四组纹理、顶点颜色
			// v2f_img			裁剪空间中的顶点坐标、纹理坐标

			struct a2v{
				//POSITION 语义指定 用模型空间的顶点坐标填充vertex
				float4 vertex : POSITION;
				//NORMAL 语义指定 用模型空间的法线填充normal
				float3 normal : NORMAL;
			};

			struct v2f{
				//SV_POSITION 语义指定 顶点着色器的输出是裁剪空间中的顶点坐标
				float4 pos:SV_POSITION;
				//COLOR0 语义指定 用于储存颜色信息
				fixed3 color:COLOR0;
			};

			v2f vert(a2v v){
				//声明输出结构
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				//v.normal 包含了顶点的法线方向，分量范围在【-1，1】
				//代码将分量范围映射到了【0.0，1.0】
				//储存哦o.color中传递给片元着色器
				o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
				return o;
			}

			fixed4 frag (v2f i):SV_Target{
				fixed3 col = i.color;
				col *= _Color.rgb;
				return fixed4(col,1.0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
