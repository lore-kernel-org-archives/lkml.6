Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeC0LYX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:24:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54377 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeC0LYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:24:21 -0400
X-Google-Smtp-Source: AG47ELsJlF9gDki5OFBR0VWVKr1Ggpa+ZjmcWmF8xbjRYvZ7VVS3RY7jEyt3WM2rLTAczdSUaXeDKJDgqJuAFEjIiek=
MIME-Version: 1.0
In-Reply-To: <20180312235940.6coamzh4qhckaohh@gmail.com>
References: <20180312235940.6coamzh4qhckaohh@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 13:24:20 +0200
Message-ID: <CACRpkdb38=qXh7to0pL4=Qon8t-AW+AeaBmhiY-a4b3mWqcE_w@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: arm-charlcd: Fix struct charlcd doc line
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Walleij <triad@df.lth.se>, Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 12:59 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:

> There was a missing first line and a missing member,
> which gave a warning under W=1:
>
>     CC      drivers/auxdisplay/arm-charlcd.o
>   drivers/auxdisplay/arm-charlcd.c:57: warning: Cannot understand
>    * @dev: a pointer back to containing device on line 57 - I thought
>   it was a doc line
>
> Cc: Linus Walleij <triad@df.lth.se>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
