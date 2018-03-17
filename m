Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeCQXsI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:48:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46358 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeCQXsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:48:05 -0400
X-Google-Smtp-Source: AG47ELt6aR5Wx9wueIv/TrvaQNKWOdnl1NsaR3qH/hyhP3tGyI+PyXnzlCbVKJ+pJKjEToqgzPo8tQ==
Subject: Re: [PATCH] MAINTAINERS: update maintainers for MTD and SPI NOR
 subsystems
To: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        computersforpeace@gmail.com, dwmw2@infradead.org, richard@nod.at,
        boris.brezillon@free-electrons.com, linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20180315190438.4832-1-cyrille.pitchen@wedev4u.fr>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c7722fa4-992e-717d-2b46-51f906a8978f@gmail.com>
Date: Sun, 18 Mar 2018 00:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315190438.4832-1-cyrille.pitchen@wedev4u.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 08:04 PM, Cyrille Pitchen wrote:
> remove myself as MTD and SPI NOR maintainer.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>

What happened ?

> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bdc260e36b7..7892db9a9494 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9037,7 +9037,6 @@ M:	Brian Norris <computersforpeace@gmail.com>
>  M:	Boris Brezillon <boris.brezillon@free-electrons.com>
>  M:	Marek Vasut <marek.vasut@gmail.com>
>  M:	Richard Weinberger <richard@nod.at>
> -M:	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
>  L:	linux-mtd@lists.infradead.org
>  W:	http://www.linux-mtd.infradead.org/
>  Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
> @@ -13006,7 +13005,6 @@ F:	arch/arm/boot/dts/spear*
>  F:	arch/arm/mach-spear/
>  
>  SPI NOR SUBSYSTEM
> -M:	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
>  M:	Marek Vasut <marek.vasut@gmail.com>
>  L:	linux-mtd@lists.infradead.org
>  W:	http://www.linux-mtd.infradead.org/
> 


-- 
Best regards,
Marek Vasut
