// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "myShader/Study_SimpleShader3" {
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
				return fixed4(i.color , 0.1);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
