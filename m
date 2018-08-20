Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228920E20
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5228920E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHTXGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:06:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33578 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTXGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:06:03 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so28028933oip.0;
        Mon, 20 Aug 2018 12:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ODdrm8476AEsJXbeiqg6bR969sEmLCsdlMo3DAMZeU=;
        b=ESqH3MDiLD6SW7AAIMl1HF/aS2vGL05oRVygsskHJj63Emzjbh9y1VvZ1HnK6ZfcaL
         Gw7z2NB5oen8V6Y8CESmtHypC3ygUNqG5U2MSZpeauCFP606WteB5wmEn+JrVpzk+jgf
         h19fpV5zAY1ti8L8QFKgsf/85x98doZYSayUdYwCPpXL+FyJeWVFu8hYMSK2eTXNe2JS
         /lYjYjvUugK4mZxRgYynUcaPMCdUx0ZxhPhi5P6ZLCCrS1aMxIN1hpZ8aEVKyyzQIU9R
         de8yshi5ROgK/mk/jzXOedNsKsM3lbR5uYa8gmXYH2sGw0H+RPGxhtc2jI8iBaHiE5Y7
         sgOg==
X-Gm-Message-State: AOUpUlG+FYRb1NT9ltHJxynvw9Sh+OTanSOo6fboBbPihiAWb8Ln7OB/
        3foSeRZC94B65bBvJRvFCA==
X-Google-Smtp-Source: AA+uWPzTlYXCIiTlxr/3ABAtw+HS4vYSWLNYx9sUrPj5u1czNt3k0cBkza00k+gd+2XGATUHi7Stuw==
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr15313423oia.336.1534794547768;
        Mon, 20 Aug 2018 12:49:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11-v6sm16795014oif.27.2018.08.20.12.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:49:07 -0700 (PDT)
Date:   Mon, 20 Aug 2018 14:49:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com, mark.rutland@arm.com, rajanv@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Message-ID: <20180820194906.GB26783@bogus>
References: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
 <1534446483-12156-2-git-send-email-jollys@xilinx.com>
 <20180820194057.GA21738@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820194057.GA21738@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 02:40:57PM -0500, Rob Herring wrote:
> On Thu, Aug 16, 2018 at 12:08:01PM -0700, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> > 
> > Add documentation to describe Xilinx ZynqMP power management
> > bindings.
> > 
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 ++++++++++++++++

Also, this should be located in bindings/power/reset/

> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> > index d215d15..cb9a6b7 100644
> > --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> > @@ -64,6 +64,17 @@ Output clocks are registered based on clock information received
> >  from firmware. Output clocks indexes are mentioned in
> >  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> >  
> > +--------------------------------------------------------------------
> > +Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
> > +--------------------------------------------------------------------
> > +The zynqmp-power node describes the power management configurations.
> > +It will control remote suspend/shutdown interfaces.
> > +
> > +Required properties:
> > + - compatible:		Must contain:	"xlnx,zynqmp-power"
> > + - interrupt-parent:	Interrupt controller the interrupt is routed through
> 
> interrupt-parent is implied and could be in a parent node, so remove.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > + - interrupts:		Interrupt specifier
> > +
> >  -------
> >  Example
> >  -------
> > @@ -78,5 +89,10 @@ firmware {
> >  			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> >  			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> >  		};
> > +		zynqmp_power: zynqmp-power {
> > +			compatible = "xlnx,zynqmp-power";
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <0 35 4>;
> > +		};
> >  	};
> >  };
> > -- 
> > 2.7.4
> > 
