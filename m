Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934726AbeCHCKt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:10:49 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45888 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:10:47 -0500
X-Google-Smtp-Source: AG47ELt96vG6rrqlhvcsnrVe4BDw4qjsageUefePa8wOg+YdvOqvK5chhtaPyC6iRH8D0uDNEuneXQ==
Date: Wed, 7 Mar 2018 20:10:46 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: backlight: Add binding for RAVE SP
 backlight driver
Message-ID: <20180308021046.j2s7yyhjvsjnzesw@rob-hp-laptop>
References: <20180307024011.25033-1-andrew.smirnov@gmail.com>
 <20180307024011.25033-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307024011.25033-2-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 06:40:11PM -0800, Andrey Smirnov wrote:
> Add Device Tree bindings for RAVE SP backlihgt drvier - an MFD cell of
> parent RAVE SP driver (documented in
> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Aleksander Morgado <aleksander@aleksander.es>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../leds/backlight/zii,rave-sp-backlight.txt       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
> new file mode 100644
> index 000000000000..2eba8322fc28
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
> @@ -0,0 +1,23 @@
> +Zodiac Inflight Innovations RAVE Supervisory Processor Backlight Bindings
> +
> +RAVE SP backlight device is a "MFD cell" device corresponding to
> +backlight functionality of RAVE Supervisory Processor. It is expected
> +that its Device Tree node is specified as a child of the node
> +corresponding to the parent RAVE SP device (as documented in
> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
> +
> +Required properties:
> +
> +- compatible: Should be "zii,rave-sp-backlight"
> +
> +Example:
> +
> +	rave-sp {
> +		compatible = "zii,rave-sp-rdu1";
> +		current-speed = <38400>;
> +
> +		pwrbutton {

backlight {

> +			compatible = "zii,rave-sp-backlight";
> +		};
> +	}
> +
> -- 
> 2.14.3
> 
