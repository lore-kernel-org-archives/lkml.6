Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932371AbeCIX6B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:58:01 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32945 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCIX6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:58:00 -0500
X-Google-Smtp-Source: AG47ELvNHPf+qVO4I72zhO/BF7MrOYAXtQvcIdOByTl7N77PzkVRxothh0OC4jkG/tE0cM61tsPqTA==
Date: Fri, 9 Mar 2018 17:57:57 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: backlight: Add binding for RAVE SP
 backlight driver
Message-ID: <20180309235757.mulnqtrbewtrfdce@rob-hp-laptop>
References: <20180308192046.27670-1-andrew.smirnov@gmail.com>
 <20180308192046.27670-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308192046.27670-2-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 11:20:46AM -0800, Andrey Smirnov wrote:
> Add Device Tree bindings for RAVE SP backlight driver - an MFD cell of
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
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since [v1]:
> 
>  - Fixed typos in commit message and incorrect node name in example section
> 
> [v1] https://lkml.kernel.org/r/20180307024011.25033-2-andrew.smirnov@gmail.com
> 
>  .../leds/backlight/zii,rave-sp-backlight.txt       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt

Reviewed-by: Rob Herring <robh@kernel.org>
