Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC08C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E87A20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547799622;
	bh=yEimTCZEK6aNYjqPcmB/h0Z+F3CHTqoBGFr+UEAvb78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bpyU0JF7w+QBwAqn+GYpNNtQe13azvpBKXUC5+j/U5ngPBjuugClIEzE5OaAO8VcN
	 wegR+WXpZvtu08iI7JgeMv9kySqWkJ7/gdBA0SgU7n/5xaYUOeQjYonvsgcsHpdP7L
	 gGR/1+/DSWlDRyBzLOFNw68Z/Ct/YtP5w5G480iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfARIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfARIUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:20:20 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5E12086D;
        Fri, 18 Jan 2019 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547799619;
        bh=yEimTCZEK6aNYjqPcmB/h0Z+F3CHTqoBGFr+UEAvb78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DXBGW6jTotGsMp+odRSlkp4yqxTdXvqY+j2UZglk8+m7fedjwBrAMueVaPYsfI/5D
         Z/rBZsWTFDmR3PG+zWQ3BouGxLQA87/GZvuNsfS0t2YEL9v3eqMGRc7EFhEt1fx1fF
         99qUhV0xnBZJ/1MlKcR5CD8p9qexMKmyUDPw8aDs=
Date:   Fri, 18 Jan 2019 09:20:06 +0100
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
Subject: Re: [PATCH 2/8] dt-bindings: mtd: ingenic: Add compatible strings
 for the JZ4725B
Message-ID: <20190118092006.79857045@bbrezillon>
In-Reply-To: <20190118010634.27399-2-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
        <20190118010634.27399-2-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 22:06:28 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Add compatible strings to probe the jz4780-nand and jz4780-bch drivers
> from devicetree on the JZ4725B SoC from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> index 29ea5853ca91..8ebed442ac55 100644
> --- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> @@ -6,7 +6,9 @@ memory-controllers/ingenic,jz4780-nemc.txt), and thus NAND device nodes must
>  be children of the NEMC node.
>  
>  Required NAND controller device properties:
> -- compatible: Should be set to "ingenic,jz4780-nand".
> +- compatible: Should be one of:
> +  * ingenic,jz4725b-nand
> +  * ingenic,jz4780-nand
>  - reg: For each bank with a NAND chip attached, should specify a bank number,
>    an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC bank).
>  
> @@ -72,7 +74,9 @@ NAND devices. The following is a description of the device properties for a
>  BCH controller.
>  
>  Required BCH properties:
> -- compatible: Should be set to "ingenic,jz4780-bch".
> +- compatible: Should be one of:
> +  * ingenic,jz4725b-bch
> +  * ingenic,jz4780-bch
>  - reg: Should specify the BCH controller registers location and length.
>  - clocks: Clock for the BCH controller.
>  

