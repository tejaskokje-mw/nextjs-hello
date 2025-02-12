// @ts-ignore
import tracker from '@middleware.io/agent-apm-nextjs';

export function register() {
  tracker.track({
      serviceName: "nextjs-hello",
      accessToken: process.env.MW_API_KEY,
      target: process.env.MW_TARGET,
  });
}
