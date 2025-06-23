/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   echo.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brunogue <brunogue@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/04 17:48:17 by brunogue          #+#    #+#             */
/*   Updated: 2025/06/23 15:12:58 by brunogue         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"

char *ambient_var(t_env *env)
{
	
}

int ft_echo(char **args)
{
    int i = 1;
    int n_flag = 0;

    if (args[1] && !ft_strcmp(args[1], "-n"))
    {
        n_flag = 1;
        i++;
    }
    while (args[i])
    {
        if (args[i][0] == '$')
            ambient_var(args[i], recreate_env(get_shell()->env));
        ft_putstr_fd(args[i], 1);
        if (args[i + 1])
            ft_putstr_fd(" ", 1);
        i++;
    }
    if (!n_flag)
        ft_putstr_fd("\n", 1);
    return (0);
}
