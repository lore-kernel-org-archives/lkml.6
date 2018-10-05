Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79662208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79662208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeJFDdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:33:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37752 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:33:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id o13-v6so13952114otl.4;
        Fri, 05 Oct 2018 13:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f1wpvtKTUCTBT+HmamF3OxnOhQKrPfOJPCqe96DoL30=;
        b=NLxsLAbirEi3YUQmJq7mfMIz5vBKS/Gux7KdPGzMoFjaRNkf4Tvb0xDoN72kCJ8PXn
         6XGI4Cez3sjpoggBy3FbRHd4jbE0vqGb8fbRa7xK0oggl1Q/2Xwfq0RcT+OZqK8Kd4KH
         H/sgWwKo4P5K4nx0BLlm9AMMJfk+Qs4/uSfea3zVPO29vb64wKRsAgIB8mA0tGyLplZ3
         9MLX0yYXL4Sqx2Eqtv8NAXW/lljHUWAEYjZXRnjug0cCesAorUL26hfsjeEXzSJkhzl8
         DDo/a0wVedNz+wT3yb4hRlsSxWBcDaWquz2dCIwHXrJCJyCHKY37dP1Vcj6R6dFzzfp4
         YwhA==
X-Gm-Message-State: ABuFfohrwlEwtPNuVGJ51MOqnJ1zcmiK5zdD1E5EYVBxqOSZzsOX/sB4
        DglIkrL+NvB5z+Q9CqY+qw==
X-Google-Smtp-Source: ACcGV624NNPAD8Q/g4edzImvnmTiVczKeIiC06Gyd8JSvsaVGM28C/tzVKp6V5DtoVozY3RO/K3QXQ==
X-Received: by 2002:a9d:29f2:: with SMTP id g47mr7164768otd.21.1538771567680;
        Fri, 05 Oct 2018 13:32:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r83-v6sm2790595oia.55.2018.10.05.13.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:32:47 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:32:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/3] [media] imx214: device tree binding
Message-ID: <20181005203246.GA28765@bogus>
References: <20181005124940.15539-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005124940.15539-1-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 02:49:37PM +0200, Ricardo Ribalda Delgado wrote:
> From: Ricardo Ribalda <ricardo.ribalda@gmail.com>
> 
> Document bindings for imx214 camera sensor
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

checkpatch.pl complains that the author and S-o-b don't match.

> ---
>  .../devicetree/bindings/media/i2c/imx214.txt  | 53 +++++++++++++++++++

sony,imx214.txt is preferred.

>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> new file mode 100644
> index 000000000000..421a019ab7f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> @@ -0,0 +1,53 @@
> +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> +
> +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
> +an active array size of 4224H x 3200V. It is programmable through an I2C
> +interface. The I2C address can be configured to 0x1a or 0x10, depending on
> +how the hardware is wired.

Move the addresses to reg description.

> +Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
> +throughput of 1.2Gbps/lane.
> +
> +
> +Required Properties:
> +- compatible: value should be "sony,imx214" for imx214 sensor
> +- reg: I2C bus address of the device
> +- enable-gpios: GPIO descriptor for the enable pin.
> +- vdddo-supply: Chip digital IO regulator (1.8V).
> +- vdda-supply: Chip analog regulator (2.7V).
> +- vddd-supply: Chip digital core regulator (1.12V).
> +- clocks: Reference to the xclk clock.
> +- clock-names:  Shall be "xclk".
> +
> +Optional Properties:
> +- flash-leds: See ../video-interfaces.txt
> +- lens-focus: See ../video-interfaces.txt
> +
> +The imx214 device node shall contain one 'port' child node with
> +an 'endpoint' subnode. For further reading on port node refer to
> +Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +Required Properties on endpoint:
> +- data-lanes: check ../video-interfaces.txt
> +- link-frequencies: check ../video-interfaces.txt
> +- remote-endpoint: check ../video-interfaces.txt
> +
> +Example:
> +
> +	camera_rear@1a {

camera-sensor@1a

If you need location, then perhaps use 'label'.

> +		compatible = "sony,imx214";
> +		reg = <0x1a>;
> +		vdddo-supply = <&pm8994_lvs1>;
> +		vddd-supply = <&camera_vddd_1v12>;
> +		vdda-supply = <&pm8994_l17>;
> +		lens-focus = <&ad5820>;
> +		enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
> +		clocks = <&mmcc CAMSS_MCLK0_CLK>;
> +		clock-names = "xclk";
> +		port {
> +			imx214_ep: endpoint {
> +				data-lanes = <1 2 3 4>;
> +				link-frequencies = /bits/ 64 <480000000>;
> +				remote-endpoint = <&csiphy0_ep>;
> +			};
> +		};
> +	};
> -- 
> 2.19.0
> 
