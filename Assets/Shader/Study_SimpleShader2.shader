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
