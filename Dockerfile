FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# the above will output an /app/build directory with the files we care about

FROM nginx
# copy over something from a different phase :pointup:
# copy to deafult nginx website directory
COPY --from=builder /app/build /usr/share/nginx/html
# COPY --from=0 /app/build /user/share/nginx/html
# - also works in case certain environments don't support the alias
