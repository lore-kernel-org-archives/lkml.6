Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeC2Tw2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:52:28 -0400
Received: from mout.web.de ([212.227.17.11]:47121 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbeC2TwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:52:25 -0400
Subject: Re: [0/9] UML vector network driver: Adjustments for three function
 implementations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <4286effd-df51-78c7-3e65-b8a90e1733f0@users.sourceforge.net>
Date: Thu, 29 Mar 2018 21:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:6iZjYzb4Ese+JReaILOik42Iwp/csLbvMCA4TaTiNQcTlPXiCN/
 qL+zzmI7LhZH7bHpmOo8p8V3djUT8D8wPzxvGjZfSJ52yMHyvq4ozbR1z01BxBV+tArArZt
 LLFiLGTEeEyUmWR6hgDfHk9Pesrpi8fl5RMhCQp9wX5ycuuqv1JRyTUEtGzqBxq8aaKN5IW
 vC6Uwg1GyEuaiGTc2UAQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pV78Ag/F26Y=:j73tnON8BUam6w2SVzr6+A
 G/axRsmmGnKvMRVoeS6isZk4W+ZUFbSpNKOToflNS78YoPlr0AmcYViMDmdLyk9xcHhM4+zTN
 s4gvcdka0rE34F2C/2dyT83FmPDhow7WjBzYUYBiQimqIINRj8fGjLd/1ilRI6URnajH3DpB+
 wH8+bafcNn+fj3RpnYUo6JNednVy8ydz8ijfiBPbrwL8oQOkiQDbwi9Jgw3+LMBjBYpK9oAJk
 1ToPMuh842CC02yov5x2Bs87iQKuSVoZRBu8z4lRoVsPo5Wa3JN+lsroxe58yJ/OQJ2Gf0mln
 t6GYsj3c5BHx6VZhWzzkf1Sz6c2ZnU+5Rl5FjszIcvUfpjOh9EkAmzVEWtCUAGkx7o1VJzrLI
 fcWMPi53ZaVCBJnV4LM6tN/I65WCELv7+YQ8MoGuqbFXojYWhiFJa1M4HLq6Rv9+fRRTMIGlx
 uJMh8zKqNRoygEnnqNE/n3gOwQ83/a62DM1/M+Cymtd9u9+dTWUZXmlW2Z++H2JmjVCXbTW83
 ahJ8Scq6DNMbIMUfZvRcjZqVjwOxWGb7rXou4M1pCjmCIx+GTzzberDr6bZVtkb5voNedCZ0g
 bC3O0Y5MaW9mzLEMK5y3j9026tKJ5Qhb2g0vjal5kQvfQ/Oy6TMfNQeZuuRIs0M/Krf1WsOfR
 Mq1d51qPdD/tDPWqo0mBMpZ689Ea6BeX4/1ea7H11zr1movOUnEx9UoOdH3M5qFdX30IwA147
 p/7GZ2XboZFPeJL0gByYcM9P7ColwgWgWOK53f5gFu/eVN1lcmjfcVtD3KrE2cogJhM2z2jAQ
 cqOu0Q2JsbTlPInouPrObUZcNgyPnjJt6lgkXgbQw++grHnyEU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 11 Mar 2018 16:06:16 +0100
> 
> Some update suggestions were taken into account
> from static source code analysis.
…
>   Delete unnecessary code in user_init_raw_fds()
>   Less checks in user_init_raw_fds() after error detection
>   Adjust an error message in user_init_socket_fds()
>   Delete an unnecessary check before kfree() in user_init_socket_fds()
>   Delete two unnecessary checks before freeaddrinfo() in user_init_socket_fds()
>   Less checks in user_init_socket_fds() after error detection
>   Adjust an error message in user_init_tap_fds()
>   Less checks in user_init_tap_fds() after error detection
>   Delete an unnecessary variable initialisation in user_init_tap_fds()
…

Would you like to pick any idea up from this patch series?
	
Regards,
Markus
