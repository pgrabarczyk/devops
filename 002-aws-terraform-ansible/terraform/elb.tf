resource "aws_elb" "elb" {
    name = "${var.appname}-elb"
    subnets = [  "${aws_subnet.public.id}", "${aws_subnet.private.id}" ]
    security_groups = [ "${aws_security_group.elb.id}" ]

    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    listener {
      instance_port = 8080
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = "http"
    }

    health_check {
      healthy_threshold = "${var.elb_healthy_threshold}"
      unhealthy_threshold =  "${var.elb_unhealthy_threshold}"
      timeout = "${var.elb_timeout}"
      target = "HTTP:8080/health"
      interval = "${var.elb_interval}"
    }

    instances = [
      "${aws_instance.backend_service1.id}",
      "${aws_instance.backend_service2.id}",
      "${aws_instance.backend_service3.id}" ]


    tags {
      Name = "${var.appname}-elb"
    }
}
