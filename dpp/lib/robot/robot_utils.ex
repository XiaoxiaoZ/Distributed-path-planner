defmodule Robot.Utils do

    @moduledoc """
    Provide useful robotics functions
    """

    alias ELA.Matrix, as: Matrix
    alias ELA.Vector, as: Vector
    
    @doc """
    Convert axis angle to transform matrix
    """
    def matrixFromAxisAngle(axis_angle,translate) do
        angle = Enum.at(axis_angle, 3)
        x = Enum.at(axis_angle, 0)
        y = Enum.at(axis_angle, 1)
        z = Enum.at(axis_angle, 2)
        c = :math.cos(angle)
        s = :math.sin(angle)
        t = 1.0-c
        m00 = c + x*x*t
        m11 = c + y*y*t
        m22 = c + z*z*t
        tmp1 = x*y*t
        tmp2 = z*s
        m10 = tmp1 + tmp2
        m01 = tmp1 - tmp2
        tmp1 = x*z*t
        tmp2 = y*s
        m20 = tmp1 - tmp2
        m02 = tmp1 + tmp2   
        tmp1 = y*z*t
        tmp2 = x*s
        m21 = tmp1 + tmp2
        m12 = tmp1 - tmp2
        matrix = [[m00, m01, m02, Enum.at(translate,0)],
                  [m10, m11, m12, Enum.at(translate,1)],
                  [m20, m21, m22, Enum.at(translate,2)],
                  [0.0,   0.0,   0.0,   1.0]]
    end

    @doc """
    Convert transform matrix to axis angle
    """
    def axisAngleFromMatrix(matrix) do
        [[m00, m01, m02, m03],
         [m10, m11, m12, m13],
         [m20, m21, m22, m23],
         [m30, m31, m32, m33]] = matrix
        
        angle = :math.acos(( m00 + m11 + m22 - 1)/2.0)
        x_ = :math.sqrt(:math.pow(m21 - m12, 2.0)+:math.pow(m02 - m20,2.0)+:math.pow(m10 - m01,2.0))
        y_ = :math.sqrt(:math.pow(m21 - m12,2.0)+:math.pow(m02 - m20,2.0)+:math.pow(m10 - m01,2.0))
        z_ = :math.sqrt(:math.pow(m21 - m12,2.0)+:math.pow(m02 - m20,2.0)+:math.pow(m10 - m01,2.0))
        if x_==0 || y_==0 || z_==0 do
            x = 1.0
            y = 0.0
            z = 0.0
            angle = 0.0
            %{rot: [x, y, z, angle], trans: [m03,m13,m23]}
        else
            x = (m21 - m12)/x_
            y = (m02 - m20)/y_
            z = (m10 - m01)/z_
            %{rot: [x, y, z, angle], trans: [m03,m13,m23]}
        end

        
    end


end