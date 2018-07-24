Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D484C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2043D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2043D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbeGYAow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:44:52 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51293 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388408AbeGYAow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:44:52 -0400
Received: by mail-it0-f68.google.com with SMTP id g14-v6so6231448iti.1;
        Tue, 24 Jul 2018 16:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iw3euw7oC9bkeiUxYufiNbsATI3ldXyqCpm7dffnnL8=;
        b=arWMNlUIeSluiYDXtBoagZqyXaCx6GdFe6fO10tJBPzip9iZMCZInKc0wm435B0IsF
         iOqMpgBIo79IAD46sjNMB4Eh3JacXhwRPJO+9khuqN05avar/eZbCBt/NzGwIQRV5C3X
         IXPcRIQyQUXUx1zRFE5GrD4U8gNF+ptzpZtAfm0qxxx/euBRahceGFcXAPnh2gushY4V
         seODCXXuEGkT31w2L2BELphg1p3dV2nbO8Iw7N0R8dOl2n/xkWUbvjLVrXZlAajdM3zL
         gjNSLohWbwK72uX9P7oXAcgga057KE4jMIMaVO6WUHNdncSR3geRVynP3tpHUzzAdgL9
         xi+A==
X-Gm-Message-State: AOUpUlFTZnGweypqhiKm3eO9eUByAdshU7eij51pd2Az7OPzAw6O6rg7
        KbqxTTAspfDhWYgdjnRiVw==
X-Google-Smtp-Source: AAOMgpe5zr/4tWtXINC/Eb4w/q3ntKLTWr0JjGY7kTHPUkRcj1VEfw8WMBohjRKKwkRtwd7iAN++/g==
X-Received: by 2002:a02:5952:: with SMTP id p79-v6mr16945367jab.129.1532475360345;
        Tue, 24 Jul 2018 16:36:00 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id i3-v6sm1624849iti.40.2018.07.24.16.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 16:35:59 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:35:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 01/18] doc: dt-bindings: jz4780-dma: Update bindings
 to reflect driver changes
Message-ID: <20180724233558.GA30764@rob-hp-laptop>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721110643.19624-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 01:06:26PM +0200, Paul Cercueil wrote:
> The driver is now compatible with four SoCs: JZ4780, JZ4770, JZ4725B and
> JZ4740.

What the driver supports is irrelevant to the binding.
>
> Besides, it now expects the devicetree to supply a second memory
> resource. This resource is mandatory on the newly supported SoCs.
> For the JZ4780, new devicetree code must also provide it, although the
> driver is still compatible with older devicetree binaries.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>  Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
>  v2: New patch in this series; regroups the changes made to the
>  jz4780-dma.txt doc file in the previous version of the patchset.
> 
>  v3: Updated example to comply with devicetree specification
> 
> diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> index f25feee62b15..14f33305e194 100644
> --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> @@ -2,8 +2,13 @@
>  
>  Required properties:
>  
> -- compatible: Should be "ingenic,jz4780-dma"
> -- reg: Should contain the DMA controller registers location and length.
> +- compatible: Should be one of:
> +  * ingenic,jz4740-dma
> +  * ingenic,jz4725b-dma
> +  * ingenic,jz4770-dma
> +  * ingenic,jz4780-dma

So none of these are compatible with each other? It should be one valid 
combination per line.

> +- reg: Should contain the DMA channel registers location and length, followed
> +  by the DMA controller registers location and length.
>  - interrupts: Should contain the interrupt specifier of the DMA controller.
>  - interrupt-parent: Should be the phandle of the interrupt controller that
>  - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
> @@ -20,9 +25,10 @@ Optional properties:
>  
>  Example:
>  
> -dma: dma@13420000 {
> +dma: dma-controller@13420000 {
>  	compatible = "ingenic,jz4780-dma";
> -	reg = <0x13420000 0x10000>;
> +	reg = <0x13420000 0x400
> +	       0x13421000 0x40>;
>  
>  	interrupt-parent = <&intc>;
>  	interrupts = <10>;
> -- 
> 2.11.0
> 
