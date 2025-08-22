# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: brunogue <brunogue@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/21 20:04:53 by pvitor-l          #+#    #+#              #
#    Updated: 2025/08/22 18:13:42 by brunogue         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = minishell
CC = cc
FLAGS = -Wall -Wextra -Werror -g3
SRC_DIR = srcs
OBJ_DIR = obj
INCLUDES_DIR = includes
LIBFT_DIR = libft

LIBFT = $(LIBFT_DIR)/libft.a
INCLUDES = -I$(INCLUDES_DIR)

SRCS = main.c \
	free.c \
	parser/parser.c \
	parser/parse_utils.c \
	token/token.c \
	token/token_utils.c \
	built-in/exec_builtin.c \
	built-in/pwd.c \
	built-in/cd.c \
	built-in/echo.c \
	built-in/env.c \
	built-in/exit.c \
	built-in/unset.c \
	built-in/export/export.c \
	built-in/export/export_utils.c \
	built-in/export/valid_export.c \
	expand/environment.c \
	execution/execution.c \
	execution/global_execute.c \
	execution/command.c \
	utils.c \
	utils2.c \
	execution/pipe.c \
	execution/smart_execute.c \
	redirect/valid_all.c \
	redirect/redirect.c \
	redirect/redirect_utils.c \
	expand/expand.c \
	expand/expand_utils.c \
	expand/expand_ternary.c \
	signals.c \
	heredoc.c \
	heredoc_utils.c

OBJ = $(patsubst %.c,$(OBJ_DIR)/%.o,$(SRCS))

vpath %.c $(SRC_DIR) $(SRC_DIR)/parser $(SRC_DIR)/token $(SRC_DIR)/built-in \
	$(SRC_DIR)/built-in/export $(SRC_DIR)/expand $(SRC_DIR)/execution $(SRC_DIR)/redirect

VALGRIND = valgrind --leak-check=full \
	--show-leak-kinds=all \
	--track-origins=yes \
	--track-fds=yes \
	--trace-children=yes \
	--trace-children-skip='*/bin/*,*/sbin/*,/usr/bin/*' \
	--suppressions=supress.supp

all: $(LIBFT) $(NAME)

$(LIBFT):
	@make -C $(LIBFT_DIR)

$(NAME): $(OBJ) $(LIBFT)
	$(CC) $(FLAGS) $(OBJ) $(LIBFT) -lreadline -o $(NAME) $(INCLUDES)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(FLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)
	@make -C $(LIBFT_DIR) clean

fclean: clean
	rm -f $(NAME)
	@make -C $(LIBFT_DIR) fclean

valgrind:
	-$(VALGRIND) ./$(NAME)

re: fclean all 

.PHONY: all clean fclean re
