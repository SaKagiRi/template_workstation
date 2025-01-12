NAME		= NAME # TODO: creat your name target
TARGET		= $(BUILD_DIR)/$(NAME)
CC			= cc
CFLAGS		= -Wall -Wextra -Werror -g3

OBJ_DIR		= obj
BUILD_DIR	= build

# TODO: add other lib here
# NOTE::LIBFT_DIR	= ./lib/KML

			 #  TODO: -I (include_path) lib what you add in here
HEADER		=#  NOTE: -I ./include -I $(LIBFT_DIR)/include

			 #  TODO: file target lib here
LIBS		=#  NOTE: $(LIBFT_DIR)/build/libft.a 

#(dir) for get path form filename and sort to mkdir
#PATH_OBJ	= $(sort $(dir $(SRC)))

			 #  TODO: add srcfile
SRC			=#  NOTE: src/main.c

# delete pathfile(notdie) and delete.c(basname) and add.o(addsuffix) and add obj/(addprefix)
OBJ			= $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(basename $(notdir $(SRC)))))

all: $(NAME)

$(NAME): $(LIBS) $(TARGET)

$(TARGET): $(OBJ) | $(BUILD_DIR)
	@$(CC) $(CFLAGS) $(OBJ) $(LIBS) $(HEADER) -o $@ && printf "\033[38;5;46m\033[1m⟪ Complete ⟫\033[0m\n" 

$(LIBS):
@#  TODO: add libdir here
@#  NOTE:	@make -C $(LIBFT_DIR)

$(OBJ): $(SRC) | $(OBJ_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@ $(HEADER)


$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

clean_lib:
@#  TODO: add clean obj lib here
@#  NOTE: @rm -rf $(LIBFT_DIR)/obj

fclean_lib:
@#  TODO: add clean target lib here
@#  NOTE: @rm -rf $(LIBFT_DIR)/build

clean: clean_lib
	@rm -rf $(OBJ_DIR)

fclean: clean fclean_lib
	@rm -rf $(BUILD_DIR)

re: fclean all

.PHONY: all clean fclean re
