Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6981C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B4B21749
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B4B21749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbeHNRbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:31:11 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36064 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbeHNRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:31:10 -0400
Received: by mail-io0-f195.google.com with SMTP id m4-v6so17387943iop.3;
        Tue, 14 Aug 2018 07:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i6q+7ErmA1RIg7okzoZIQrzDNyL1DGTcQm2HhZ2X9/8=;
        b=J9yjAwuA5mOCa4DUZ/PPv8O/sItiSJK1/H2zctgaRHnLfPoqXNvGsgKBUxrbqLMptt
         uhwxQ8B2hLSFoXOya1xA5k1qUlGDxgLoENgDKvEKV+WnkBShKfawa8GLG1C/ZrbjgIe8
         K2aJtoK6vcYJUfJ7EM6nSlMt42MwMjpLReIew8IDlnMTieGYEbIrd+SkmY9ZKvLPjjY4
         R0yD4wCKsaqiU9YpcqEGXAMym9B/BVZ4FCU9JIFx6pcMpsYKVG7MXhfkFGAP+qSiPPuV
         aKDGwEEW7WUWFvzrjejZ76dmiJVrAG5rkim9v0H3Jee99zYgyBsOZdR+m2ojvlViw/GN
         J7mg==
X-Gm-Message-State: AOUpUlEa6R0Vw2T8rRks/FgXw5mdSHT3o4zcCSk0cmt/YiMFysF0j9r9
        gb2+T2ErwopZ8VPEAd52bg==
X-Google-Smtp-Source: AA+uWPyTdVXjt+mzXSBVpCjAaCj92VM91dk8yLy6QqhlqD+wabCmCEnHGG0rUrLIj1TnwmuYK6bfeg==
X-Received: by 2002:a6b:3347:: with SMTP id z68-v6mr18055996ioz.231.1534257822047;
        Tue, 14 Aug 2018 07:43:42 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v13-v6sm8165108ita.38.2018.08.14.07.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 07:43:41 -0700 (PDT)
Date:   Tue, 14 Aug 2018 08:43:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Hean-Loong, Ong" <hean.loong.ong@intel.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, yves.vandervennet@intel.com,
        chin.liang.see@intel.com, Ong@rob-hp-laptop
Subject: Re: [PATCH10 1/3] ARM:dt-bindings:display Intel FPGA Video and Image
 Processing Suite
Message-ID: <20180814144340.GA29519@rob-hp-laptop>
References: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
 <1534237029-2648-2-git-send-email-hean.loong.ong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534237029-2648-2-git-send-email-hean.loong.ong@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 04:57:07PM +0800, Hean-Loong, Ong wrote:
> From: Ong, Hean Loong <hean.loong.ong@intel.com>
> 
> Device tree binding for Intel FPGA Video and Image Processing Suite. The binding involved would be generated from the Altera (Intel) Qsys system. The bindings would set the max width, max height, buts per pixel and memory port width. The device tree binding only supports the Intel
> Arria10 devkit and its variants. Vendor name retained as altr.

Again, wrap your lines.

> 
> V8:
> *Add port to Display port decoder
> 
> V7:
> *Fix OF graph for better description
> *Add description for encoder
> 
> V6:
> *Description have not describe DT device in general
> 
> V5:
> *remove bindings for bits per symbol as it has only one value which is 8
> 
> V4:
> *fix properties that does not describe the values
> 
> V3:
> *OF graph not in accordance to graph.txt
> 
> V2:
> *Remove Linux driver description
> 
> V1:
> *Missing vendor prefix
> 
> Signed-off-by: Ong, Hean Loong <hean.loong.ong@intel.com>
> ---
>  .../devicetree/bindings/display/altr,vip-fb2.txt   |   63 ++++++++++++++++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/altr,vip-fb2.txt b/Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> new file mode 100644
> index 0000000..89a3b9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> @@ -0,0 +1,63 @@
> +Intel Video and Image Processing(VIP) Frame Buffer II bindings
> +
> +Supported hardware: Intel FPGA SoC Arria10 and above with display port IP
> +
> +The Video Frame Buffer II in Video Image Processing (VIP) suite is an IP core
> +that interfaces between system memory and Avalon-ST video ports. The IP core
> +can be configured to support the memory reader (from memory to Avalon-ST)
> +and/or memory writer (from Avalon-ST to memory) interfaces.
> +
> +More information the FPGA video IP component can be acquired from
> +https://www.altera.com/content/dam/altera-www/global/en_US/pdfs\
> +/literature/ug/ug_vip.pdf
> +
> +DT-Bindings:
> +=============
> +Required properties:
> +----------------------------
> +- compatible: "altr,vip-frame-buffer-2.0"
> +- reg: Physical base address and length of the framebuffer controller's
> +	registers.
> +- altr,max-width: The maximum width of the framebuffer in pixels.
> +- altr,max-height: The maximum height of the framebuffer in pixels.
> +- altr,mem-port-width = the bus width of the avalon master port
> +	on the frame reader
> +
> +Optional sub-nodes:
> +- ports: The connection to the encoder
> +
> +Connections between the Frame Buffer II and other video IP cores in the system
> +are modelled using the OF graph DT bindings. The Frame Buffer II node has up
> +to two OF graph ports. When the memory writer interface is enabled, port 0
> +maps to the Avalon-ST Input (din) port. When the memory reader interface is
> +enabled, port 1 maps to the Avalon-ST Output (dout) port.
> +
> +The encoder is built into the FPGA HW design and therefore would not
> +be accessible from the DDR.
> +
> +		Port 0				Port1
> +---------------------------------------------------------
> +ARRIA10 AVALON_ST (DIN)		AVALON_ST (DOUT)
> +
> +Required Properties Example:
> +----------------------------
> +
> +framebuffer@100000280 {
> +		compatible = "altr,vip-frame-buffer-2.0";
> +		reg = <0x00000001 0x00000280 0x00000040>;
> +		altr,max-width = <1280>;
> +		altr,max-height = <720>;
> +		altr,mem-port-width = <128>;
> +
> +		ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +			port@1 {
> +				reg = <1>;
> +					fb_output: endpoint {
> +						remote-endpoint = <&dp_encoder_input>;
> +					};
> +			};
> +		};
> +};
> -- 
> 1.7.1
> 
