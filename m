Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeC0Thg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 15:37:36 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39418 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeC0The (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 15:37:34 -0400
From: Richard Weinberger <richard@nod.at>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: dwmw2@infradead.org, Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: Replace typedef with struct
Date: Tue, 27 Mar 2018 21:32:19 +0200
Message-ID: <2234121.GJlN6YpY6x@blindfold>
In-Reply-To: <20180318175122.GA15004@seema-Inspiron-15-3567>
References: <20180318175122.GA15004@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 18. März 2018, 18:51:23 CEST schrieb Arushi Singhal:
> Using typedef for a structure type is not suggested in Linux kernel
> coding style guidelines. Hence, occurrence of typedefs has been
> removed.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/mtd/ssfdc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
> index 95f0bf9..8bae672 100644
> --- a/drivers/mtd/ssfdc.c
> +++ b/drivers/mtd/ssfdc.c
> @@ -54,15 +54,15 @@ SumSector	2,000	4,000	8,000	16,000	32,000	64,000	128,000	256,000
>  SectorSize	512	512	512	512	512	512	512	512
>  **/
>  
> -typedef struct {
> +struct chs_entry {
>  	unsigned long size;
>  	unsigned short cyl;
>  	unsigned char head;
>  	unsigned char sec;
> -} chs_entry_t;
> +};
>  
>  /* Must be ordered by size */
> -static const chs_entry_t chs_table[] = {
> +static const struct chs_entry chs_table[] = {
>  	{ MiB(  1), 125,  4,  4 },
>  	{ MiB(  2), 125,  4,  8 },
>  	{ MiB(  4), 250,  4,  8 },
> 

Didn't we already talk about coding style fixes on existing code? ;-)

Thanks,
//richard
