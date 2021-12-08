extern crate ncollide3d;
extern crate nalgebra as na;
extern crate kiss3d;

use kiss3d::light::Light;
use kiss3d::resource::Mesh;
use kiss3d::window::Window;
use kiss3d::event::{Action, WindowEvent};
use na::{Point3, UnitQuaternion, Vector3, Isometry3};
use std::cell::RefCell;
use std::rc::Rc;
use ncollide3d::query;
use ncollide3d::shape::{Ball, Cuboid, TriMesh};


#[rustler::nif]
fn collision_detect(a: Vec<f32>, b: Vec<f32>) -> Vec<f32> {

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

    let cuboid = Cuboid::new(Vector3::new(1.0, 1.0, 1.0));
    let ball   = Ball::new(1.0);
    let margin = 1.0;

    let cuboid_pos             = na::one();
    let ball_pos_intersecting  = Isometry3::new(Vector3::new(1.0, 1.0, 1.0), na::zero());
    let ball_pos_within_margin = Isometry3::new(Vector3::new(2.0, 2.0, 2.0), na::zero());
    let ball_pos_disjoint      = Isometry3::new(Vector3::new(3.0, 3.0, 3.0), na::zero());

    let prox_intersecting = query::proximity(&ball_pos_intersecting, &ball,
                                         &cuboid_pos,            &cuboid,
                                         margin);
    let prox_within_margin = query::proximity(&ball_pos_within_margin, &ball,
                                          &cuboid_pos,             &cuboid,
                                          margin);
    let prox_disjoint = query::proximity(&ball_pos_disjoint, &ball,
                                     &cuboid_pos,        &cuboid,
                                     margin);


    new_vec
}

#[rustler::nif]
fn draw() {
    let mut window = Window::new("Kiss3d: custom_mesh");

    let mut c = window.add_cube(1.0, 1.0, 1.0);
    c.set_color(1.0, 0.0, 0.0);
    c.enable_backface_culling(false);

   
    window.set_light(Light::StickToCamera);

    while window.render(){
        for event in window.events().iter() {
            match event.value {
                WindowEvent::Close => {
                    println!("close event");
                }
                _ => {}
            }
        }
    }
}


rustler::init!("Elixir.Collision.Detector", [collision_detect, draw]);
