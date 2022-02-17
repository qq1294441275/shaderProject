Shader "myShader/Study_Properties" {
	Properties {
		//umber数字
		_Int("Int数值", Int) = 2
		_Float("Float数值", Float) = 0.2
		//slider滑动值
		_Range("Range滑动数值", Range(0.0, 10)) = 3.0
		//Color 和 Vectors 一般是float4
		_Color("Color颜色数值", Color) = (1, 1, 1, 1)
		_Vector("Vector矢量", Vector) = (2, 4, 6, 1)
		//"颜色"贴图{}
		_2D("2D贴图",2D) = ""{}
		_Cube("块状贴图",Cube) = "white"{}
		_3D("3D贴图",3D) = "black"{}
	}
	FallBack "Diffuse"
}
