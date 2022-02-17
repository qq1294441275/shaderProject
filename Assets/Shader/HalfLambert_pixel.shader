///Lambert的光照公式是(C-light · M-diffuse)max(0,dot(n·I))，
///光照颜色 * 漫反射颜色 * (0.5 * dot(法向量*光照方向) + 0.5)


Shader "myShader/HalfLambert_pixel"{
	Properties{
		_Color("半兰伯特(像素)",Color) = (0,0,0,0)
	}
	SubShader{
		Tags{"LightMode" = "ForwardBase"}
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			//引入光照函数库
			#include "Lighting.cginc"
			fixed4 _Color;

			struct a2v{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f{
				float4 pos : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
			};

			v2f vert(a2v v){
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				return o;
			}

			fixed4 frag(v2f v) : SV_TARGET{
				//获取环境光
				float3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				//法向量
				float3 worldNormal = normalize(v.worldNormal); 
				//光照方向
				float3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
				//漫反射
				float3 diffuse = _LightColor0.rgb * _Color.rgb * (0.5 * dot(worldNormal,worldLightDir) + 0.5);

				fixed3 color = diffuse + ambient;

				return fixed4(color , 0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
