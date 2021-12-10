extern crate ncollide3d;
extern crate nalgebra as na;
extern crate kiss3d;
extern crate rand;

use kiss3d::light::Light;
use kiss3d::resource::Mesh;
use kiss3d::window::Window;
use kiss3d::event::{Action, WindowEvent};
use na::{Point3, UnitQuaternion, Vector3, Isometry3};
use std::cell::RefCell;
use std::rc::Rc;
use ncollide3d::query;
use ncollide3d::shape::{Ball, Cuboid, TriMesh};
use rand::random;

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

fn elixir_list_to_kiss3d_isometry(translate_in: Vec<f32>, rotate_in: Vec<f32>) -> kiss3d::nalgebra::Isometry3<f32>{
    kiss3d::nalgebra::Isometry3::new(kiss3d::nalgebra::Vector3::new(translate_in[0], translate_in[1], translate_in[2]), kiss3d::nalgebra::Vector3::new(rotate_in[0], rotate_in[1], rotate_in[2]))
}

#[rustler::nif]
fn collision_detect(points1: Vec<f32>, indices1: Vec<usize>, translate1: Vec<f32>, rotate1: Vec<f32>, points2: Vec<f32>, indices2: Vec<usize>, translate2: Vec<f32>, rotate2: Vec<f32>, margin: f32) -> u16 {

    let points_1 = elixir_list_to_ncollide3d_points(points1);
    let indices_1 = elixir_list_to_ncollide3d_indices(indices1);
    let points_2 = elixir_list_to_ncollide3d_points(points2);
    let indices_2 = elixir_list_to_ncollide3d_indices(indices2);
    
    // Build the mesh.
    let mesh1 = TriMesh::new(points_1, indices_1, None);
    let mesh_pos1  = Isometry3::new(Vector3::new(translate1[0], translate1[1], translate1[2]), Vector3::new(rotate1[0], rotate1[1], rotate1[2]));
    let mesh2 = TriMesh::new(points_2, indices_2, None);
    let mesh_pos2  = Isometry3::new(Vector3::new(translate2[0], translate2[1], translate2[2]), Vector3::new(rotate2[0], rotate2[1], rotate2[2]));

    let prox = query::proximity(&mesh_pos1, &mesh1,
                                &mesh_pos2, &mesh2,
                                margin);

    //0: Intersecting,
    //1: WithinMargin,
    //2: Disjoint,
    prox as u16
}

#[rustler::nif]
fn draw(points_in: Vec<Vec<f32>>, indices_in: Vec<Vec<usize>>, translate_in: Vec<Vec<f32>>, rotate_in: Vec<Vec<f32>>) {
    let mut window = Window::new("Kiss3d: custom_mesh");
    let mut scenes = Vec::new();

    for x in 0..points_in.len() {
        let points = elixir_list_to_kiss3d_points(points_in[x].clone());
        let indices = elixir_list_to_kiss3d_indices(indices_in[x].clone());

        let mesh = Rc::new(RefCell::new(Mesh::new(
            points, indices, None, None, false,
        )));

        scenes.push(window.add_mesh(mesh, kiss3d::nalgebra::Vector3::new(1.0, 1.0, 1.0)));
    
        scenes[x].set_color(random(), random(), random());

        let mesh_pos = elixir_list_to_kiss3d_isometry(translate_in[x].clone(), rotate_in[x].clone());

        scenes[x].append_transformation(&mesh_pos);
    
        //let rot = kiss3d::nalgebra::UnitQuaternion::from_axis_angle(&kiss3d::nalgebra::Vector3::y_axis(), 0.014);

        scenes[x].enable_backface_culling(false);
    }

    

   


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
