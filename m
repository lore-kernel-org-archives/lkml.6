Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeBWKzb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:55:31 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43431 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeBWKza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:55:30 -0500
X-Google-Smtp-Source: AG47ELs/e2dZ64PnuDU5Xv/W/P0Yk7LbcU5oOPaAzc7c0vxO+5zRmU3uUNYmIWMUnFd9TTgnKnJt7jkmop6/9kPHJDc=
MIME-Version: 1.0
In-Reply-To: <20171126025329.32044-1-dja@axtens.net>
References: <20171126025329.32044-1-dja@axtens.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2018 11:55:09 +0100
Message-ID: <CANiq72=dbgyFMqCg0MPihGgdtjZAmAMu-ZpNkaTu17W1o9rYRg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: img-ascii-lcd: add MODULE_LICENSE("GPL")
To: Daniel Axtens <dja@axtens.net>
Cc: Paul Burton <paul.burton@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Nov 26, 2017 at 3:53 AM, Daniel Axtens <dja@axtens.net> wrote:
> This matches the header at the top of the file and squashes:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
> see include/linux/module.h for more information
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/auxdisplay/img-ascii-lcd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
> index db040b378224..7315ffa79537 100644
> --- a/drivers/auxdisplay/img-ascii-lcd.c
> +++ b/drivers/auxdisplay/img-ascii-lcd.c
> @@ -441,3 +441,5 @@ static struct platform_driver img_ascii_lcd_driver = {
>         .remove = img_ascii_lcd_remove,
>  };
>  module_platform_driver(img_ascii_lcd_driver);
> +
> +MODULE_LICENSE("GPL");

This was submitted just a few days before yours, and now it is in at
09c479f7f1fbfaf848e5813996793966cd50be81
("auxdisplay: img-ascii-lcd: add missing
MODULE_DESCRIPTION/AUTHOR/LICENSE").

In any case, thanks for the patch! :-)

Cheers,
Miguel

> --
> 2.11.0
>
