Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeCLONo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:13:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44045 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932531AbeCLON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:13:28 -0400
X-Google-Smtp-Source: AG47ELuoQGwYXuNo/AEV8rym0PiY2gRwq1510+v+UbmsBFg7tL+ESWfXOLFSBuem2j6azVTyoQcPnw==
Date: Mon, 12 Mar 2018 14:13:24 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: backlight: Add binding for RAVE SP
 backlight driver
Message-ID: <20180312141324.p2duehrev5jd7mof@dell>
References: <20180308192046.27670-1-andrew.smirnov@gmail.com>
 <20180308192046.27670-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308192046.27670-2-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018, Andrey Smirnov wrote:

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

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
