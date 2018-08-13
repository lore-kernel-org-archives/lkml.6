Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7EA2177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7EA2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeHMVuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:50:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32836 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbeHMVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:50:53 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so12424698itj.0;
        Mon, 13 Aug 2018 12:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8A/G08U8OmrE9YoSKrCcBVbdxTFIlNYn7aUBWvcrco=;
        b=JeiQPfRl09+p6OmU7wvnHnzIa90tyyoNJWFz04TMxXKK9BnkVrgZQx0RRyp653HWWl
         mxkJvb6D9znPXg0D/mttesFW4RbCj/ZkRKmlG01Hwk3irM6G8s9JHwC+wv2ojLtjH09h
         mRXChLgQeXYWQCRYFjqs+heJ/+gSawOBqpBKh8yNig4gxXM9Sq7wB5vLOBADuzhaJZyt
         8qCpz30EvJj7AmdgShiljYjNDv0e0gHNGrpwO3Dq4U/IDUpm0zYkg7b+/vRpHd/DQ395
         lcaf0bfYIHB9kzX8dSRjKkJai/0QwsfAySu0KDm3aLuSCsMPr6KugPmTcb/OfE0q2dO+
         JWqg==
X-Gm-Message-State: AOUpUlG76KLA98YzIw3TMirvDZzcuSWA7l4ZjuOjO+OXw4sg9+vkuplE
        YmtUBR6pSyTqnkv3iiQLQQ==
X-Google-Smtp-Source: AA+uWPygAHpUYlf3/SCc/3E5jpHD33c5K/Xfmqs1DxK2vXL1NeAsSv6lV+MFKljguYpXBX540sOR8g==
X-Received: by 2002:a24:24c2:: with SMTP id f185-v6mr12013417ita.18.1534187242669;
        Mon, 13 Aug 2018 12:07:22 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id a14-v6sm3063583ioh.45.2018.08.13.12.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:07:22 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:07:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: amlogic: add meson-canvas
 documentation
Message-ID: <20180813190721.GA27621@rob-hp-laptop>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-3-maxi.jourdan@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807220011.24436-3-maxi.jourdan@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:00:09AM +0200, Maxime Jourdan wrote:
> DT bindings doc for amlogic,meson-canvas
> 
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  .../soc/amlogic/amlogic,meson-canvas.txt      | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> new file mode 100644
> index 000000000000..5f0351717bee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> @@ -0,0 +1,36 @@
> +Amlogic Canvas
> +================================
> +
> +A canvas is a collection of metadata that describes a pixel buffer.
> +Those metadata include: width, height, phyaddr, wrapping, block mode
> +and endianness.
> +
> +Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
> +rather than use the phy addresses directly. For instance, this is the case for
> +the video decoders and the display.
> +
> +Amlogic SoCs have 256 canvas.
> +
> +Device Tree Bindings:
> +---------------------
> +
> +Canvas Provider
> +--------------------------
> +
> +Required properties:
> +- compatible: "amlogic,canvas"
> +
> +Parent node should have the following properties :
> +- compatible: "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd"

Is this documented somewhere? One child function is not a reason for an 
MFD and child nodes. And child nodes like this with no resources are 
unnecessary.

> +- reg: base address and size of the DMC system control register space.
> +
> +Example:
> +
> +sysctrl_DMC: system-controller@0 {
> +	compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
> +	reg = <0x0 0x0 0x0 0x1000>;
> +
> +	canvas: canvas-provider@0 {
> +		compatible = "amlogic,canvas";
> +	};
> +};
> -- 
> 2.18.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
