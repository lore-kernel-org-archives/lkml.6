Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDFEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF9D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548869144;
	bh=2c0XT3l/QdixLhUgC6hLFl2q9n6ZZ3qCYZwNv41aJ2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nrFAGxlbxuIRwrDQpBljCuLeErlOhXfioyPUuXVIxaArb1bZ9drOoAhSA5s7qsC3L
	 eE3yJbLsLRYEk8zWtJMuHDcQ5HVgCgpYx7TnK+lLK6Lg6y8gqFw+OYwlb94UXt7FpL
	 yUglfoth0+hzvX9MlfJBuPR2+ffhL3BE6SIkaoa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbfA3RZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732111AbfA3RZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:25:41 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897462087F;
        Wed, 30 Jan 2019 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548869141;
        bh=2c0XT3l/QdixLhUgC6hLFl2q9n6ZZ3qCYZwNv41aJ2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=07LxU4WCW6m+otNDW5u/wHd7LXr5MgZMIH1qKskc2TQ9ypgENnOkL9ce1S6rEXBYq
         Us/NRYC77Ic2+Ngvf4QagTxTHYn9X2hrYw4hKAu0bNNW0OP1bvEwquq5bmSdQggoCb
         poiTwYl30u+rzcE09sbdaxL/d9cPCFMeOoOUjt9U=
Date:   Wed, 30 Jan 2019 18:25:30 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 7/9] dt-bindings: spi: atmel-quadspi: update example to
 new clock binding
Message-ID: <20190130182517.3d4c620b@bbrezillon>
In-Reply-To: <20190130150818.24902-8-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-8-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:43 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Introduced in:
> commit b60557876849 ("ARM: dts: at91: sama5d2: switch to new clock binding")
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index b93c1e2f25dd..e9dae6264d89 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -19,7 +19,7 @@ spi@f0020000 {
>  	reg = <0xf0020000 0x100>, <0xd0000000 0x8000000>;
>  	reg-names = "qspi_base", "qspi_mmap";
>  	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
> -	clocks = <&spi0_clk>;
> +	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  	pinctrl-names = "default";

