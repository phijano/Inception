all:
	docker compose -f ./srcs/docker-compose.yml up --build -d

clean:
	docker compose -f ./srcs/docker-compose.yml down -v

fclean: clean
	docker system prune -af
	sudo rm -rf /home/phijano-/data/mariadb/*
	sudo rm -rf /home/phijano-/data/wordpress/*

re: fclean all

.PHONY: all bonus clean fclean re
