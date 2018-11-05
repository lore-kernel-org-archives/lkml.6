Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC037C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B1420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B1420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeKFHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:35:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44181 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeKFHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:35:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id z33so9472022otz.11;
        Mon, 05 Nov 2018 14:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qcjus+m7PDSt1f+0m7YXZQOa34vxEwbNXz+5lA9JOvM=;
        b=dZLz+cx+5BrUW9El+U7/mj7caXhC1m6yNurBoRu+Am5mjr3uUhCFAZoKyWSpCn/Nx2
         2JO5Zmk8zDu1YiAomWY758cttcc4te3JqxGFflrIcu9TJy2mAtOCdSvxuZXPBtVOi5V3
         cuetgkm+z4eJNf8WzfaBPxPwv7luWdIhB9nkw2475iL2cPUk+9h1wmI3dph7rQRthY4y
         1jqZ9bn0TCCEPexUUEhVZewarqCEHyP7EHxaYXXXr5xhCB085smUnjYzOVIuMvo+1+0S
         byJjkfXouIImimk4da2S3JVs1P/edQBVg1d4BvEFiy3/hDB1FYoaAqfczxeuDItwdSvM
         sFqw==
X-Gm-Message-State: AGRZ1gLYh7uDv+4Dr5hfAlTIIQ1wIg6Ug4dVSw8fctXeNaWKpaInrfLC
        sKTzfWAFtJMzs+Xyjdygjfc130o=
X-Google-Smtp-Source: AJdET5fBo7bg4D8WIEo0GwMoZz03pqyYaYd2Bc5yiggVJnkwxq/su2uzWGbiZ9iLo8JxVLmHMxMBnQ==
X-Received: by 2002:a9d:7d10:: with SMTP id v16mr9837982otn.114.1541456007672;
        Mon, 05 Nov 2018 14:13:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t135-v6sm3258890oie.16.2018.11.05.14.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:13:27 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:13:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 bus+gpio 2/4] dt-bindings: bus: Document moxtet bus
 binding
Message-ID: <20181105221326.GA27340@bogus>
References: <20181102103539.6077-1-marek.behun@nic.cz>
 <20181102103539.6077-2-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181102103539.6077-2-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:35:37AM +0100, Marek Behún wrote:
> This adds device tree binding documentation for the Moxtet bus, a bus
> via which the different modules connected to the Turris Mox router can
> be configured.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/bus/moxtet.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documentation/devicetree/bindings/bus/moxtet.txt
> new file mode 100644
> index 000000000000..19a1bab61e8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/moxtet.txt
> @@ -0,0 +1,34 @@
> +Turris Mox module configuration bus (over SPI)
> +
> +Required properties:
> + - compatible		: Should be "cznic,moxtet".
> + - #address-cells	: Has to be 1
> + - #size-cells		: Has to be 0
> +For other required and optional properties of SPI slave nodes please refer to
> +../spi/spi-bus.txt.

You need to list what's required. spi-cpol and spi-cpha are typically 
required or not.

> +
> +Required properties of subnodes:
> + - reg			: Should be position on the Moxtet bus
> +
> +The driver finds the devices connected to the bus by itself, but it may be
> +needed to reference some of them from other parts of the device tree. In that
> +case the devices can be defined as subnodes of the moxtet node.
> +
> +Example:
> +
> +	moxtet@1 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "cznic,moxtet";
> +		reg = <1>;
> +		spi-max-frequency = <10000000>;
> +		spi-cpol;
> +		spi-cpha;
> +
> +		moxtet_sfp: moxtet-sfp@0 {

gpio@0

> +			compatible = "cznic,moxtet-sfp";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			reg = <0>;
> +		}
> +	};
> -- 
> 2.18.1
> 
