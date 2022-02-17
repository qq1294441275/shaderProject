///Lambert的光照公式是(C-light · M-diffuse)max(0,dot(n·I))，
///光照颜色 * 漫反射颜色 * max(0,dot(法向量*光照方向))
Shader "myShader/Lambert_vertex"{
	Properties{
		_Color("漫反射(顶点)颜色", Color) = ( 1, 1, 1, 1 )
	}

	SubShader{
		//正向渲染
		Tags {"LightMode" = "ForwardBase"}
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
				fixed3 color : COLOR;
			};

			v2f vert(a2v v){
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);

				//获取环境光
				float3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				//法向量
				float3 worldNormal = normalize(UnityObjectToWorldNormal(v.normal)); 
				//光照方向
				float3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
				//漫反射
				float3 diffuse = _LightColor0.rgb * _Color.rgb * max(0,dot(worldNormal,worldLightDir));

				o.color = diffuse + ambient;
				return o;
			}

			fixed4 frag(v2f v) : SV_TARGET{
				return fixed4( v.color, 0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}


