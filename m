Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeC3LGI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:06:08 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40501 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3LGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:06:06 -0400
X-Google-Smtp-Source: AIpwx48bUPlj7K10Z06AvTJKsa4qDY3+uWrO8pMgDeTNyAh27t+rTMm+nawHqizBeb1crAJulzUIX6zZ2ku4P0o5JAk=
MIME-Version: 1.0
In-Reply-To: <20180326084629.100070-3-yixun.lan@amlogic.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com> <20180326084629.100070-3-yixun.lan@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 30 Mar 2018 13:05:45 +0200
Message-ID: <CAFBinCBQS779Cfu-=nmcA5CJLETy25bYbeN1XgACQpRk4Yw6sg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: document the Meson AXG support
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:46 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> Update the documentation to expicitly support the Meson-AXG SoC.
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> index 1e6ee3deb4fa..d1acd5ea2737 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> @@ -7,6 +7,7 @@ Required properties:
>                         - "amlogic,meson-gxbb-saradc" for GXBB
>                         - "amlogic,meson-gxl-saradc" for GXL
>                         - "amlogic,meson-gxm-saradc" for GXM
> +                       - "amlogic,meson-axg-saradc" for AXG
>                 along with the generic "amlogic,meson-saradc"
>  - reg:         the physical base address and length of the registers
>  - interrupts:  the interrupt indicating end of sampling
> --
> 2.15.1
>
