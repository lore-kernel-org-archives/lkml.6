Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D516ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B90220673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B90220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeGPW4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:56:51 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41727 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbeGPW4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:56:51 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so77860263oiw.8;
        Mon, 16 Jul 2018 15:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QTfS7Hnu96Sb0fgLey+7oy3zz2B3eIhQgc4J/3skwh8=;
        b=iE1v8iqFndKf9OsH9WbsHkAmLHaTJ+1iiYljGJ8PLen0FIiGcNm6ShgXF0cVCNUYkY
         zmA91ePQ4SrREculpe7EjnTxWF/35sRK4FteW5t9pewIlPvbsBzbyRkk0hMqHs/CjsNN
         PU0S46w538yb3WxmImivsGrYAmobVbfbX8u24RserTOmxzj0gSup3CDPjCdDz1LumDRr
         0BzwX5EBbGnDTIXnUPGfLpuclBjI5aNPjnnqd+HfI1FoIZ7zChOypJrHsJS+Gr/rtOpw
         O1yMHrazrKtjUajavTw0Gt0q3oVFpXmqeF1oBFMGHH1oFlZKXcrWcY4P+oKO9bsM/4eB
         QncQ==
X-Gm-Message-State: AOUpUlEArgU2Miu0psX7jo+iI7dBxyR26g5UFLK9JK/PugfIdrGQAlSO
        5VDrxgvNX3zGWHSj+bnaNw==
X-Google-Smtp-Source: AAOMgpdEd5U0l0rdJpFLGp9ON7FSiESW3cQR8VIr+WYkZTN3dmmH/eU7EV90wuNhYbVwcfLfsZyvLg==
X-Received: by 2002:aca:dbc2:: with SMTP id s185-v6mr1187965oig.251.1531780043605;
        Mon, 16 Jul 2018 15:27:23 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i204-v6sm25743548oia.41.2018.07.16.15.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:27:22 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:27:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Girish Mahadevan <girishm@codeaurora.org>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Message-ID: <20180716222721.GA12854@rob-hp-laptop>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:46:41PM -0600, Girish Mahadevan wrote:
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ++++++++++++++++++++++
>  err.txt                                            | 27 ----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
>  delete mode 100644 err.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 0000000..3baa893
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +QTI [Qualcomm Technologies Inc] Quad Serial Peripheral Interface (QSPI)
> +
> +QSPI [Quad Serial Peripheral Interface] allows single dual and quad read/write
> +access to slaves. QTI's QSPI controller implements the QSPI protocol to interface
> +with slaves like NOR Flash devices.
> +
> +Required properties:
> +- compatible:	Should contain:
> +		"qcom,qspi-v1"

Needs an SoC specific compatible string.

> +- reg:		Contains the base register location and length
> +- interrupts:	Interrupt number used by the controller.
> +- clocks:	Contains the core and AHB clock names.
> +- clock-names:	"core" for core clock and "iface" for AHB clock.
> +- spi-max-frequency:	Maximum SPI core clock frequency in Hz.

This goes in the slave device nodes.

> +
> +SPI slave nodes must be children of the SPI master node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +	qspi: qspi@7418000 {
> +		compatible = "qcom,qspi-v1";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x7418000 0x600>;
> +		interrupts = <0 459 0>;
> +		clock-names = "iface", "core";
> +		clocks = <&clock_gcc clk_gcc_qspi_ahb_clk>,
> +			 <&clock_gcc clk_gcc_qspi_ser_clk>;
> +
> +		device@0 {
> +			compatible = "dummy_device";

Why don't you use an actual NOR flash chip here.

> +			reg = <x>; /* CS for the device */

It's an example, show a CS#.

> +			spi-max-frequency = <f>; /* Max supported frequency of the slave (Hz) */
> +		};
> +	};
