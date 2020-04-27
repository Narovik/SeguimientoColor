function representa_esfera(Centro, Radio, Color)
    
    [R,G,B] = sphere(100);
    Rc = Centro(1);
    Gc = Centro(2);
    Bc = Centro(3);

    x = Radio*R(:)+Rc; 
    y = Radio*G(:)+Gc;
    z = Radio*B(:)+Bc;
    
    plot3(x,y,z, Color);

end

