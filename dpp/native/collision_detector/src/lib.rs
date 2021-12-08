extern crate ncollide3d;
extern crate nalgebra as na;


use na::Point3;
use ncollide3d::shape::TriMesh;

use ncollide3d::shape::Ball;


#[rustler::nif]

fn add(a: Vec<f32>, b: Vec<f32>) -> Vec<f32> {
    let ball = Ball::new(1.0f32);
    assert!(ball.radius() == 1.0);
    let new_vec = vec![a[0]+b[0],a[1]+b[1]];
    let points = vec![
        Point3::new(0.0, 1.0, 0.0),
        Point3::new(-1.0, -0.5, 0.0),
        Point3::new(0.0, -0.5, -1.0),
        Point3::new(1.0, -0.5, 0.0),
                    ];

    let indices = vec![
        Point3::new(0usize, 1, 2),
        Point3::new(0, 2, 3),
        Point3::new(0, 3, 1),
                    ];

    // Build the mesh.
    let mesh = TriMesh::new(points, indices, None);
    new_vec
}

rustler::init!("Elixir.Collision.Detector", [add]);
