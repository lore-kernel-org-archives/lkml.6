Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6177DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B65821711
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B65821711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeHNXKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:10:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:10:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so9736153pfo.12;
        Tue, 14 Aug 2018 13:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vv3uJtHWZ6icUiEY5c+kpuHTDQjtwvbbwg4BzjBzFVg=;
        b=SsMS4aArDw0FsUpNOJwKFitCR/o2RS9m9xgm3Vf4rspiPiY/Tdm4SuutGWszXGWYoJ
         KWWGcsqSwLXDxuCX7W1IWOK5pLbvZH5h4iAXcVmSM7GTjUvUh54ueUpSlhM4q2uMPfSf
         Jj1xmITD/cUV7GzbPyT4PttDil/KdOT1y+MtPCbdH5FLFhmEnDbi68hM3UXIeI425CsP
         TJaZ4zme/1gKh0/Yw4aezfnraf+KJ1z5ebGUKuByJn0KTB6ots8rOlbSFcgovoKf6JCu
         vaUEAf2+b4uIurJbGeMOYaUjs3ydEapUzfDAJPufi1Xn2isNbYESOuWYRJirh/2CxqvM
         /oUA==
X-Gm-Message-State: AOUpUlEdL0PAsADtEyfghWomK9XlPyTq8gqeMPA4qwnGbVtiiaSs+Mi3
        TGK++wOopShIc7wdqWh/bA==
X-Google-Smtp-Source: AA+uWPy4fG31fS/JdXVjAwLB0we4Jl/kG7TqAJpkf4a0R3OKcC3dBxC6uCr60n4e+eDT5HKKUWulDg==
X-Received: by 2002:a63:5d58:: with SMTP id o24-v6mr22607037pgm.349.1534278089287;
        Tue, 14 Aug 2018 13:21:29 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id e7-v6sm43695755pgc.55.2018.08.14.13.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:21:28 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:21:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     broonie@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Message-ID: <20180814202122.GA26606@rob-hp-laptop>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> 
> This patch adds the binding documentation for Spreadtrum SPI
> controller device.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-sprd.txt |   31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> new file mode 100644
> index 0000000..06ff746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> @@ -0,0 +1,31 @@
> +Spreadtrum SPI Controller
> +
> +Required properties:
> +- compatible: Should be "sprd,sc9860-spi".
> +- reg: Offset and length of SPI controller register space.
> +- interrupts: Should contain SPI interrupt.
> +- clock-names: Should contain following entries:
> +	"spi" for SPI clock,
> +	"source" for SPI source (parent) clock,

Do the h/w block actually get this clock or the driver needs it? In the 
latter case, it should not be in DT.

> +	"enable" for SPI module enable clock.
> +- clocks: List of clock input name strings sorted in the same order
> +	as the clock-names property.
> +- #address-cells: The number of cells required to define a chip select
> +	address on the SPI bus. Should be set to 1.
> +- #size-cells: Should be set to 0.
> +
> +Optional properties:
> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
> +	converted to the delay clock cycles = interval number * 4 + 10.

There are read and write delay properties you can use.

> +
> +Example:
> +spi0: spi@70a00000{
> +	compatible = "sprd,sc9860-spi";
> +	reg = <0 0x70a00000 0 0x1000>;
> +	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	clock-names = "spi", "source","enable";
> +	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> +	sprd,spi-interval = <9>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +};
> -- 
> 1.7.9.5
> 
