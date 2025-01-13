NAME		= #NAME
TARGET		= $(BUILD_DIR)/$(NAME)
CC			= cc
CFLAGS		= -Wall -Wextra -Werror -g3

OBJ_DIR		= $(BUILD_DIR)/obj
BUILD_DIR	= build
#LIBFT_DIR	= ./lib/KML
#MLX_DIR		= ./lib/MLX42

HEADER		= -I ./include #-I $(LIBFT_DIR)/include -I $(MLX_DIR)/include
LIBS		= #$(LIBFT_DIR)/build/kml.a $(MLX_DIR)/build/libmlx42.a -ldl -lglfw -pthread -lm

SRC			= #src/main.c
OBJ			= $(SRC:.c=.o)

all: $(NAME)

$(NAME): lib $(TARGET)

$(TARGET): $(OBJ) | $(BUILD_DIR)
	@if [ -f $@ ] && [ "$(OBJ_DIR)/$(notdir $(word 1, $(OBJ)))" -nt "$(word 1, $(SRC))" ] && [ "$(OBJ_DIR)/$(notdir $(word 1, $(OBJ)))" -ot "$@" ]; then \
		echo "$(NAME) is up to date"; \
		rm -rf $(OBJ); \
	else \
		$(CC) $(CFLAGS) $(OBJ) $(LIBS) $(HEADER) -o $@ && mv $(OBJ) $(OBJ_DIR); \
		printf "\033[38;5;46m\033[1m⟪ Complete ⟫\033[0m\n"; \
	fi

lib:
	@make -C $(LIBFT_DIR)
	@cmake $(MLX_DIR) -B $(MLX_DIR)/build && make -C $(MLX_DIR)/build -j4

%.o: %.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@ $(HEADER)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

#clean_lib:
#	@rm -rf $(LIBFT_DIR)/obj
#	@rm -rf $(MLX_DIR)/build

#fclean_lib:
#	@rm -rf $(LIBFT_DIR)/build

clean: #clean_lib
	@rm -rf $(OBJ_DIR)

fclean: #clean fclean_lib
	@rm -rf $(BUILD_DIR)

re: fclean $(NAME)

.PHONY: all clean fclean re lib #clean_lib fclean_lib 
