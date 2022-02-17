Shader "myShader/Study_SimpleShader2" {
	Properties {

	}
	SubShader {
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct a2v{
				//POSITION 语义指定 用模型空间的顶点坐标填充vertex
				float4 vertex : POSITION;
				//NORMAL 语义指定 用模型空间的法线填充normal
				float3 normal : NORMAL;
				//TEXCOORD0 语义指定 用模型空间的第一张纹理填充texcoord
				float4 texcoord : TEXCOORD0;
			};

			float4 vert(a2v v) : SV_POSITION{
				//使用v.vertex 来访问模型空间的顶点坐标
				return UnityObjectToClipPos(v.vertex);
			}

			fixed4 frag ():SV_Target{
				return fixed4(1.0, 1.0, 1.0, 1.0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
