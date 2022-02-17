Shader "myShader/Study_SimpleShader5" {
	Properties {

	}
	SubShader {
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct v2f{
				//SV_POSITION 语义指定 顶点着色器的输出是裁剪空间中的顶点坐标
				float4 pos:SV_POSITION;
				//COLOR0 语义指定 用于储存颜色信息
				fixed4 color:COLOR0;
			};


			v2f vert(appdata_full v){
				//声明输出结构
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				//可视化法线
				o.color = fixed4(v.normal * 0.5  + fixed3(0.5, 0.5, 0.5), 1.0);
				//可视化切线方向
				// o.color = fixed4(v.tangent * 0.5 + fixed3(0.5, 0.5, 0.5), 1.0);
				//可视化副切线方向
				// fixed3 binormal = cross(v.normal, v.tangent.xyz) * v.tangent.w;
				// o.color = fixed4(binormal * 0.5 + fixed3(0.5, 0.5, 0.5), 1.0);
				//可视化第一组纹理
				// o.color = fixed4(v.texcoord.xy,0.0, 1.0);
				// //可视化第一组纹理坐标小数部分
				// o.color = frac(v.texcoord)
				// if (any(saturate(v.texcoord) - v.texcoord)){
				// 	o.color.b = 0.5;
				// }
				// o.color.a = 1.0;
				// //可视化第一组纹理坐标小数部分
				// o.color = frac(v.texcoord1)
				// if (any(saturate(v.texcoord1) - v.texcoord1)){
				// 	o.color.b = 0.5;
				// }
				// o.color.a = 1.0;
				//可视化顶点颜色
				// o.color = v.color;
				return o;
			}

			fixed4 frag (v2f i):SV_Target{
				return i.color;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
