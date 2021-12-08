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

fn elixir_list_to_ncollide3d_points(list: Vec<f32>) -> Vec<Point3<f32>> {
    let mut points = Vec::new();
    let mut k = 0;
    let mut x = 0.0;
    let mut y = 0.0;
    let mut z = 0.0;
    for i in 0..list.len() {
        //println!("{}", list[i]);
        if k==0 {
            x=list[i] as f32;
            //println!("x: {}", x);
            k=k+1;
        } else if k==1 {
            y=list[i] as f32;
            //println!("y: {}", y);
            k=k+1;
        } else {
            z = list[i] as f32;
            //println!("z: {}", z);
            k=0;
            points.push(Point3::new(x, y, z));
        }
        
    }
    points
}

fn elixir_list_to_ncollide3d_indices(list: Vec<usize>) -> Vec<Point3<usize>> {
    let mut indices = Vec::new();
    let mut k = 0;
    let mut x = 0;
    let mut y = 0;
    let mut z = 0;
    for i in 0..list.len() {
        //println!("{}", list[i]);
        if k==0 {
            x=list[i] as usize;
            k=k+1;
        } else if k==1 {
            y=list[i] as usize;
            k=k+1;
        } else if k==2 {
            z = list[i] as usize;
            k=0;
            indices.push(Point3::new(x, y, z));
        }
    }
    indices
}

fn elixir_list_to_kiss3d_points(list: Vec<f32>) -> Vec<kiss3d::nalgebra::Point3<f32>> {
    let mut points = Vec::new();
    let mut k = 0;
    let mut x = 0.0;
    let mut y = 0.0;
    let mut z = 0.0;
    for i in 0..list.len() {
        //println!("{}", list[i] as f32);
        if k==0 {
            x=list[i] as f32;
            k=k+1;
        } else if k==1 {
            y=list[i] as f32;
            k=k+1;
        } else if k==2 {
            z = list[i] as f32;
            k=0;
            points.push(kiss3d::nalgebra::Point3::new(x, y, z));
        }
    }
    points
}

fn elixir_list_to_kiss3d_indices(list: Vec<usize>) -> Vec<kiss3d::nalgebra::Point3<u16>> {
    let mut indices = Vec::new();
    let mut k = 0;
    let mut x = 0 as u16;
    let mut y = 0 as u16;
    let mut z = 0 as u16;
    for i in 0..list.len() {
        //println!("{}", list[i] as u16);
        if k==0 {
            x=list[i] as u16;
            k=k+1;
        } else if k==1 {
            y=list[i] as u16;
            k=k+1;
        } else if k==2 {
            z = list[i] as u16;
            k=0;
            indices.push(kiss3d::nalgebra::Point3::new(x, y, z));

        }
    }
    indices
}

#[rustler::nif]
fn collision_detect(points1: Vec<f32>, indices1: Vec<usize>) -> i32 {

    let points_1 = elixir_list_to_ncollide3d_points(points1);

    let indices_1 = elixir_list_to_ncollide3d_indices(indices1);
    
    // Build the mesh.
    let mesh = TriMesh::new(points_1, indices_1, None);
    let mesh_pos  = Isometry3::new(Vector3::new(1.0, 1.0, 1.0), na::zero());
    
    let cuboid = Cuboid::new(Vector3::new(1.0, 1.0, 1.0));
    let ball   = Ball::new(1.0);
    let margin = 0.001;

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

    let prox = query::proximity(&mesh_pos, &mesh,
                                &ball_pos_intersecting, &ball,
                                margin);

    prox as i32
}

#[rustler::nif]
fn draw(points_in: Vec<f32>, indices_in: Vec<usize>) {
    let mut window = Window::new("Kiss3d: custom_mesh");

    let points = elixir_list_to_kiss3d_points(points_in);
    let indices = elixir_list_to_kiss3d_indices(indices_in);

    let mesh = Rc::new(RefCell::new(Mesh::new(
        points, indices, None, None, false,
    )));


    let mut c = window.add_mesh(mesh, kiss3d::nalgebra::Vector3::new(1.0, 1.0, 1.0));
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
