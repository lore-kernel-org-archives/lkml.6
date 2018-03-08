Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936041AbeCHQ7K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:59:10 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37252 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeCHQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:59:05 -0500
X-Google-Smtp-Source: AG47ELt9V4wvFcIZraoSxhUR5yVQA92m0/OG9rC/sIzJJHsDuQVDqNo4PKXEAqKqA6w9F27ECAPntg==
Subject: Re: [PATCH 2/2] dt-bindings: backlight: Add binding for RAVE SP
 backlight driver
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
References: <20180307024011.25033-1-andrew.smirnov@gmail.com>
 <20180307024011.25033-2-andrew.smirnov@gmail.com>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <f9650ab5-4d6a-a710-6af7-c6f2e4c9c686@linaro.org>
Date: Thu, 8 Mar 2018 16:59:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307024011.25033-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 02:40, Andrey Smirnov wrote:
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

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>   .../leds/backlight/zii,rave-sp-backlight.txt       | 23 ++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
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
> +			compatible = "zii,rave-sp-backlight";
> +		};
> +	}
> +
> 
