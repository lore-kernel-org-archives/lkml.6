Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeB1J2L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:28:11 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46007 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeB1J2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:28:08 -0500
X-Google-Smtp-Source: AG47ELvDtlBEQ5M5oUML3QJDAnsBt4x7bK8Jl/ZldIqsMvRKI9EWWVZwfQYUhWyukLr6UmuN7rF5dRoii3FYvK6E1ys=
MIME-Version: 1.0
In-Reply-To: <20180116160618.27859-2-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se> <20180116160618.27859-2-peda@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 28 Feb 2018 10:28:07 +0100
Message-ID: <CAMRc=Md4mBhHXn5_vR4rB5vzvx5_27e8ArvvVocWRWHVxGKLfw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
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
> Makes them easier to find.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 1812c848e369..abfae1beca2b 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -38,9 +38,9 @@ Required properties:
>
>                  "catalyst",
>                  "microchip",
> +                "nxp",
>                  "ramtron",
>                  "renesas",
> -                "nxp",
>                  "st",
>
>                  Some vendors use different model names for chips which are just
> --
> 2.11.0
>

Applied to for-current. Thanks.
