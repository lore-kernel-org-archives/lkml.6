Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755668AbeCSWrq convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:47:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53232 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755360AbeCSWrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:47:42 -0400
Date: Mon, 19 Mar 2018 23:47:29 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@free-electrons.com,
        alexandre.belloni@free-electrons.com, wens@csie.org,
        cyrille.pitchen@wedev4u.fr
Subject: Re: [PATCH v2 2/2] mtd: nand: Remove print after allocation failure
Message-ID: <20180319234729.73fb800d@xps13>
In-Reply-To: <1521390796-13715-2-git-send-email-arushisinghal19971997@gmail.com>
References: <1521390796-13715-1-git-send-email-arushisinghal19971997@gmail.com>
        <1521390796-13715-2-git-send-email-arushisinghal19971997@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arushi,

On Sun, 18 Mar 2018 22:03:16 +0530, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:

> The prints after [k|v][m|z|c]alloc() etc. functions are not needed, because
> in case of failure, allocator will print their internal error prints
> anyway.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *done the similar changes in other files.
> 
>  drivers/mtd/nand/ams-delta.c             |  1 -
>  drivers/mtd/nand/atmel/nand-controller.c | 13 +++---------
>  drivers/mtd/nand/marvell_nand.c          |  8 ++------
>  drivers/mtd/nand/nandsim.c               | 35 ++++++++------------------------
>  drivers/mtd/nand/ndfc.c                  |  4 +---
>  drivers/mtd/nand/sunxi_nand.c            |  4 +---
>  6 files changed, 15 insertions(+), 50 deletions(-)
> 


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
