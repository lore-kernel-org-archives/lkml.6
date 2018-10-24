Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF600ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B09207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B09207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJYDRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:17:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37401 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJYDRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:17:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so4958703oib.4;
        Wed, 24 Oct 2018 11:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NkZzFYRgsDElNM8ngsz3f1bKhIZ4R18HX8fVURc9Ew=;
        b=cK3I8fl4Qa84ij7eG8JwxTrWthW4rUESf41QIg8iNn22Nyn4OcXyPKuFfNtqSzfKBv
         SwVWYpiHzLXMVnMNzIQ6cJv4fgq6yK4gkhLbWqaOriIcMXQ9PmYKttADuzpXYYQ/LR8y
         W6WhZn97AUYCCYCt1uB1tkxc6e6W0Aox028KK/Rh/BaRq8reTk/YXdjND3RvBcKhWcRb
         8y/+ywdpdjSVhyFWdhIqdQ6PG5I/3ztj2ZrN2g1x5Kvcy6NdDr24BwRo5485IWC2OLqx
         tsvee/MKj5reaAV4cxPKU2rPcMYthLN02jS7oGt5WUcf9TXd0rOO2NKadeShuF/ZH7Lf
         cuzg==
X-Gm-Message-State: AGRZ1gIUmMgfHbfZSwNbrr5lxUoZBaJ++NHYbVvRwK8IkgDYA6yGRxns
        /a3fiIrs3yLg3zO//KDQEg==
X-Google-Smtp-Source: AJdET5fux4XPLGuA8vGYCGLj5kkpNTZgVuD/Kj/M5cpcVy6/8qyvhcynoqfT+Iuc2GuaPQ99A/Fw2g==
X-Received: by 2002:aca:c743:: with SMTP id x64-v6mr1942668oif.139.1540406879532;
        Wed, 24 Oct 2018 11:47:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q16sm1677072otf.35.2018.10.24.11.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 11:47:58 -0700 (PDT)
Date:   Wed, 24 Oct 2018 13:47:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: clk: add documentation for the
 SiFive PRCI driver
Message-ID: <20181024184757.GA22367@bogus>
References: <20181020135024.28573-1-paul.walmsley@sifive.com>
 <20181020135024.28573-3-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020135024.28573-3-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 06:50:23AM -0700, Paul Walmsley wrote:
> Add DT binding documentation for the Linux driver for the SiFive
> PRCI clock & reset control IP block, as found on the SiFive
> FU540 chip.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> v2: remove out-of-date example, add documentation for the compatible
>     string and for the required PCB clock nodes
> 
> .../bindings/clock/sifive/fu540-prci.txt      | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> new file mode 100644
> index 000000000000..d7c1e83fa5ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> @@ -0,0 +1,43 @@
> +SiFive FU540 PRCI bindings
> +
> +On the FU540 family of SoCs, most system-wide clock and reset integration
> +is via the PRCI IP block.
> +
> +Required properties:
> +- compatible: Should be "sifive,<chip>-prci<version>".  As of the time this
> +              file was written, only one value is supported:
> +	      "sifive,fu540-c000-prci0"

What happens with this depends on the discussion on the other bindings.

Though here you are inconsistent without a fallback. Of course, I've 
never seen a clock controller be the same across SoCs.

> +- reg: Should describe the PRCI's register target physical address region
> +- clocks: Should point to the hfclk device tree node and the rtcclk
> +          device tree node.  The RTC clock here is not a time-of-day clock,
> +	  but is instead a high-stability clock source for system timers
> +	  and cycle counters.
> +- #clock-cells: Should be <1>
> +
> +The clock consumer should specify the desired clock via the clock ID
> +macros defined in include/linux/clk/sifive-fu540-prci.h.  These macros
> +begin with PRCI_CLK_.
> +
> +The hfclk and rtcclk nodes are required, and represent physical
> +crystals or resonators located on the PCB.
> +
> +Examples:
> +
> +hfclk: hfclk {
> +	#clock-cells = <0>;
> +	compatible = "fixed-clock";
> +	clock-frequency = <33333333>;
> +	clock-output-names = "hfclk";
> +};
> +rtcclk: rtcclk {
> +	#clock-cells = <0>;
> +	compatible = "fixed-clock";
> +	clock-frequency = <1000000>;
> +	clock-output-names = "rtcclk";
> +};
> +prci0: prci@10000000 {

clock-controller@...

> +	compatible = "sifive,fu540-c000-prci0";
> +	reg = <0x0 0x10000000 0x0 0x1000>;
> +	clocks = <&hfclk>, <&rtcclk>;
> +	#clock-cells = <1>;
> +};
> -- 
> 2.19.1
> 
