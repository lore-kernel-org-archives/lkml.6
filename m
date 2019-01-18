Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1380020855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547798960;
	bh=Ymkt08u+uPAMzZTB30klUHuSMC217ujsc/sSu6eOS0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UiTtZJlkL/lUIMBCkULoHIem3a6jwiPTd62KfR0sEOQohOEnOC5ZNOxNxbXPxzx2m
	 bEmpO5TvHAXcF5l2HR9mL4Qw8wyctxgBh+h2cEeL0K2a06W48HM9AtKrJ5lJ1DcADx
	 RD0hsDcDGEX1ZmGzBDZnIqljBiskXpKe5lCUYW9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfARIJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfARIJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:09:17 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC28420855;
        Fri, 18 Jan 2019 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547798957;
        bh=Ymkt08u+uPAMzZTB30klUHuSMC217ujsc/sSu6eOS0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eT8fhYAVxhVdJVho+/9FnDDnurj1edQas2wiJ2yghF0AbZ3FaoC0T6eUAXMipWryr
         1PpWSufwmdevJZvy5YQ+SqfK6V8Yr9B0hXcbIuQkONQD1lGg260ihW1ojpJJGJvAi1
         GgkMDeSA/W+OXIFtZn7Sp3r1AntxwwygnyQwIacI=
Date:   Fri, 18 Jan 2019 09:09:08 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: memory: jz4780: Add compatible string
 for JZ4725B SoC
Message-ID: <20190118090908.3b6a584e@bbrezillon>
In-Reply-To: <20190117224550.18043-1-paul@crapouillou.net>
References: <20190117224550.18043-1-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 19:45:47 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Add a compatible string to support the memory controller built into the
> JZ4725B SoC from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  .../devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt b/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
> index f936b5589b19..7cce6d761f2d 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
> @@ -5,6 +5,7 @@ controller in Ingenic JZ4780
>  
>  Required properties:
>  - compatible: Should be set to one of:
> +    "ingenic,jz4725b-nemc" (JZ4725B)
>      "ingenic,jz4780-nemc" (JZ4780)
>  - reg: Should specify the NEMC controller registers location and length.
>  - clocks: Clock for the NEMC controller.

