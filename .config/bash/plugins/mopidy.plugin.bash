cite about-plugin
about-plugin 'mopidy players management'

# print container log from remote machine
function print-mopidy-log () {
    ssh $1 'docker logs $(docker ps -f name=mopidy | cut -d " " -f1 | tail -n 1)'
}

# update image at remote machine
function update-mopidy () {
    case $1 in
        # hall is managed by kubernetes
        #hall)
            #kubectl rollout restart deployment mopidy-hall -n mopidy
            #;;
            ## other players aren't part of cluster (for now)
        *)
            # Archive current image
            ssh $1 "docker stop mopidy;\
            docker stop mopidy-prev;\
            docker rm -v mopidy-prev;\
            docker rename mopidy mopidy-prev"
            # Run mopidy with new image
            run-mopidy $1
            ;;
    esac
}

# run mopidy at remote machine
function run-mopidy () {
    ssh $1 "docker run --detach --restart=always \
                -p 6680:6680 -p 6600:6600 \
                --device /dev/snd \
                --mount type=bind,source=/var/local/docker/mopidy/config,target=/app/config,readonly \
                --mount type=bind,source=/var/local/docker/mopidy/media,target=/var/lib/mopidy/media,readonly \
                --mount type=bind,source=/var/local/docker/mopidy/local,target=/var/lib/mopidy/local \
                --mount type=bind,source=/var/local/docker/mopidy/playlists,target=/var/lib/mopidy/playlists \
                --name mopidy buvis/mopidy"
}
