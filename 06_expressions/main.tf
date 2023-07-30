terraform {

}

variable "hello" {
  type = string
}

variable "worlds_map" {
  type = map(any)
}

variable "worlds_splat" {
  type = list(any)
}
