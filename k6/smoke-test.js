import http from 'k6/http';
import { check, group, sleep, fail } from 'k6';

export let options = {
  vus: 1, // 1 user looping for 1 minute
  duration: '1m',

  thresholds: {
    http_req_duration: ['p(99)<1500'], // 99% of requests must complete below 1.5s
  },
};

const BASE_URL = 'https://hcl-api-x4b6y6lhaa-lz.a.run.app';

export default () => {

  let data = `module "foo" {
    foo = <<EOF
    5
    EOF
    }
    module "x" {
    a = "b"
    abcde = "456"
    }`

  let res = http.post(`${BASE_URL}/format`, data);
  check(res, { 'status was 200': (r) => r.status == 200 });

  sleep(1);

}