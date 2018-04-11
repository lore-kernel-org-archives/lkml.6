Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeDKEGk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:06:40 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44500 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeDKEGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:06:39 -0400
X-Google-Smtp-Source: AIpwx4+gMIKUyszkRb78+k1Siku/WcqsoQcBiy4HTdpeBA17xh+gPOwQycCsbh+xIayec/JEOrdDQxUhBGL6wOUXHOQ=
MIME-Version: 1.0
In-Reply-To: <20180222050324.21531-1-joel@jms.id.au>
References: <20180222050324.21531-1-joel@jms.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Apr 2018 13:36:17 +0930
X-Google-Sender-Auth: atjWpuMmrOPX34lxhbE66qtN6Tg
Message-ID: <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update ASPEED entry with details
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnd,

On 22 February 2018 at 15:33, Joel Stanley <joel@jms.id.au> wrote:
> I am interested in all ASPEED drivers, and the previous match wasn't
> grabbing files in nested directories. Use N instead.
>
> Add the arm kernel mailing list so that patches get reviewed there, and
> the linux-aspeed list which exists only so I can use patchwork to track
> patches.
>
> Add Andrew as a reviewer, because he is involved in reviewing ASPEED
> stuff.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

can you please pick this one up? It would be great to get it into
fixes as Andrew and I have been missing being cc'd on stuff we would
have like to review.

Cheers,

Joel

> ---
>  MAINTAINERS | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a7f76eadae9..1ebf49797175 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1226,10 +1226,15 @@ F:      Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>
>  ARM/ASPEED MACHINE SUPPORT
>  M:     Joel Stanley <joel@jms.id.au>
> -S:     Maintained
> +R:     Andrew Jeffery <andrew@aj.id.au>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +Q:     https://patchwork.ozlabs.org/project/linux-aspeed/list/
> +S:     Supported
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
>  F:     arch/arm/mach-aspeed/
>  F:     arch/arm/boot/dts/aspeed-*
> -F:     drivers/*/*aspeed*
> +N:     aspeed
>
>  ARM/ATMEL AT91 Clock Support
>  M:     Boris Brezillon <boris.brezillon@free-electrons.com>
> --
> 2.15.1
>
