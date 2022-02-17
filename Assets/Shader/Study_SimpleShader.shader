// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "myShader/Study_SimpleShader" {
	Properties {

	}
	SubShader {
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//POSITION 语义指定 该顶点在裁剪空间中的位置(输入)
			//SV_POSITION 语义指定 顶点着色器的输出是裁剪空间中的顶点坐标(输出)
			float4 vert(float4 v :POSITION) : SV_POSITION
			{
				return UnityObjectToClipPos(v);
			}
			//SV_Target 语义指定 把用户的输出颜色储存到渲染目标(输出)
			fixed4 frag() : SV_Target {
				return fixed4(65 / 255, 1.0, 1.0, 1.0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
