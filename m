Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1945923AbeCBKR1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:17:27 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46620 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426194AbeCBKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:17:18 -0500
X-Google-Smtp-Source: AG47ELt9yZ3H+1k5NIcF/IZ71mi/2OfBA+nHeDQe8bXcTyGpdV74TrY3cmN4YbgesslRVjdXef8GT8FO65YRlD50ork=
MIME-Version: 1.0
In-Reply-To: <20180116160618.27859-3-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se> <20180116160618.27859-3-peda@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Mar 2018 11:17:17 +0100
Message-ID: <CAMRc=MfcyxsupU9-9Bv+U-U6bcNVYx44ixnmXM8r=xn6b-7sVA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: at24: add compatible for nxp,se97b
To: Peter Rosin <peda@axentia.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-16 17:06 GMT+01:00 Peter Rosin <peda@axentia.se>:
> The datasheet talks about the chip being an spd, but the chip is writable
> so atmel,24c02 is more appropriate as fallback.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index abfae1beca2b..edf9247613f6 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -46,6 +46,7 @@ Required properties:
>                  Some vendors use different model names for chips which are just
>                  variants of the above. Known such exceptions are listed below:
>
> +                "nxp,se97b" - the fallback is "atmel,24c02",
>                  "renesas,r1ex24002" - the fallback is "atmel,24c02"
>
>    - reg: The I2C address of the EEPROM.
> --
> 2.11.0
>

Applied to for-next, thanks.

Bart
