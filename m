Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA8AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D272087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547799761;
	bh=vY5Lm687NkyEh250tn/+nfIT0119zwGMwYtUt9ENryg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tMVjKkJFsT8Zjsl4SMSEwTDEySAcwzceRsdy5+EYjE2dxdKWSDroFdkKS/UQTfFKY
	 VJjK0dm+OCwMr5VE2utyLx3e2tATG6NpC18s98TZ9ApkmBrtkPwvq3Mofk7cWKAbl1
	 3vEfTkpfkop0AJh4vn7vAq5B+XxBLhyt/dD31+WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfARIWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfARIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:22:38 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73E920883;
        Fri, 18 Jan 2019 08:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547799757;
        bh=vY5Lm687NkyEh250tn/+nfIT0119zwGMwYtUt9ENryg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sZdgV4ar3yhJw74YOXlvUaAFyFwqprRsoDmnUQbAQedZPWoCOzjcaMiAICrKyReL1
         S7Tj1Lw+UEOINX62MZTTDnID3KGuo8QOmOF1rTVDzmIR2l7RmyBvVGJReK+q0ME5B+
         bcT6AsWFj27mfDurgsYzsSRgsaIbMh8RtOkOtRdw=
Date:   Fri, 18 Jan 2019 09:22:25 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/8] mtd: rawnand: jz4780: Use SPDX license notifiers
Message-ID: <20190118092225.440f0e6a@bbrezillon>
In-Reply-To: <20190118010634.27399-3-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
        <20190118010634.27399-3-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 22:06:29 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Use SPDX license notifiers instead of GPLv2 license text in the headers.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/mtd/nand/raw/jz4780_bch.c  | 5 +----
>  drivers/mtd/nand/raw/jz4780_bch.h  | 5 +----
>  drivers/mtd/nand/raw/jz4780_nand.c | 5 +----
>  3 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
> index 7201827809e9..7e4e5e627603 100644
> --- a/drivers/mtd/nand/raw/jz4780_bch.c
> +++ b/drivers/mtd/nand/raw/jz4780_bch.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * JZ4780 BCH controller
>   *
>   * Copyright (c) 2015 Imagination Technologies
>   * Author: Alex Smith <alex.smith@imgtec.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published
> - * by the Free Software Foundation.
>   */
>  
>  #include <linux/bitops.h>
> diff --git a/drivers/mtd/nand/raw/jz4780_bch.h b/drivers/mtd/nand/raw/jz4780_bch.h
> index bf4718088a3a..451e0c770160 100644
> --- a/drivers/mtd/nand/raw/jz4780_bch.h
> +++ b/drivers/mtd/nand/raw/jz4780_bch.h
> @@ -1,12 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * JZ4780 BCH controller
>   *
>   * Copyright (c) 2015 Imagination Technologies
>   * Author: Alex Smith <alex.smith@imgtec.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published
> - * by the Free Software Foundation.
>   */
>  
>  #ifndef __DRIVERS_MTD_NAND_JZ4780_BCH_H__
> diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
> index 22e58975f0d5..7f55358b860f 100644
> --- a/drivers/mtd/nand/raw/jz4780_nand.c
> +++ b/drivers/mtd/nand/raw/jz4780_nand.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * JZ4780 NAND driver
>   *
>   * Copyright (c) 2015 Imagination Technologies
>   * Author: Alex Smith <alex.smith@imgtec.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published
> - * by the Free Software Foundation.
>   */
>  
>  #include <linux/delay.h>

