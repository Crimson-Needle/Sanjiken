///@arg vertex_buffer
{
	var _vbuff = argument0;
	
	shader_set(shdViewDistance);
		shader_set_uniform_f(g.u_viewDistance_viewFar, g.viewFar);
		vertex_submit(_vbuff, pr_trianglelist, -1);
	shader_reset();
}