///@arg vertex_buffer
{
	var _vbuff = argument0;
	
	shader_set(shdViewDepth);
		shader_set_uniform_f(g.u_viewDepth_viewFar, g.viewFar);
		vertex_submit(_vbuff, pr_trianglelist, -1);
	shader_reset();
}