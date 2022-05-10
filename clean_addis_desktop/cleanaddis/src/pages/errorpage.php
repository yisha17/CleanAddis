<?php 
// Block direct access
if( !defined( 'ABSPATH' ) ){
	exit( 'Direct script access denied.' );
}
/**
 * @Packge 	   : CleanAddis
 * @Version    : 1.0
 * @Author 	   : CleanAddis
 *
 */


?>

<div id="f0f">
	<div class="container">
		<div class="row">
			<div class="f0f-content text-center">
			<div class="f0f-content-inner">
				<?php 
				$errorText = esc_html__( 'Ooops something went wrong 404 Error !', 'philosophy' );
				if( philosophy_opt( 'philosophy_fof_titleone' ) ){
					$errorText = philosophy_opt( 'philosophy_fof_titleone' );
				}
				//
				echo '<h1 class="h1">'.esc_html( $errorText ).'</h1>';
	