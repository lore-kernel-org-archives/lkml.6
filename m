Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeCILrL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:47:11 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeCILrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:47:09 -0500
Date: Fri, 9 Mar 2018 12:46:44 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Matheus Castello <matheus@castello.eng.br>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, eric@anholt.net,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <483687035.384686.1520596004410@email.1und1.de>
In-Reply-To: <1520568974-15547-4-git-send-email-matheus@castello.eng.br>
References: <5b3419be-12ca-75d7-6f5e-d3338ddd7f14@castello.eng.br>
 <1520568974-15547-1-git-send-email-matheus@castello.eng.br>
 <1520568974-15547-4-git-send-email-matheus@castello.eng.br>
Subject: Re: [PATCH v3 3/3] pinctrl: bcm2835: Update docs about generic
 pinctrl bindings support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:QXUhywzYW6C47gtkKwWLqDMEmo1iZYjYHow25vX7GTpWAo3+shn
 oSbayaIMlG3NXPtOcnRVe2ZEoDr5+YpvL2P9UhB9pjK2r+I2YSAyPiupIYZyPqcJpmHqmHr
 4voDsFPRAgN/nbv0dNYaYCW2N0KtD5lZoKDIeVgKF0xGf/QVJznZiFJEZULkYEoSjaRFmTJ
 hHfzks5N8rpsGj9paDchg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eXh8eSBu4JI=:XY0uv83JFDSHLzMgTUoTo3
 nBs2y8s7tAMpb0ksZYawtq6RSMRAe+3s5Jn8eCPVGBgDS7iCONa9JGHByfsf9I9gj7EPr5lb7
 sktG5rcvVXIzorF+H12i/7zsiDa5ydz+8xlGGCxgczPIkTID/FE+qs5SvBWXEKoZ1E4dv1n+H
 FxhXjBpebvU018NVpnfJ58llvQWG05diQVkA+woS9dD415krSCbCVtf790ubcCoe6+w6zKcCA
 +sCkz/hkUmAIw/YUxd8cyWUQ4lgZFZEn4nUxFoXxp6tb7ChbilJWQY4HPrnA9hfLBrOfNoOAL
 zr3u+6xZxqbs1TwzLeMygeukis9fS+cTDPSoqEZbFkIi2G7ir6C5j1qwry+W6WCgDzHQI502p
 fr4tBmV4h1Jc1nUUDrSSgCjgIZ6BmP2el0oOaoJDsb2HxTny+3gZCXrG2y5CxEexlzFhetjn4
 ELfcTAYqNmhn+rcjjSLTSwd2yq1UmRxBpJ/NNu8559JJrTvQvnCjMa9TWH8vxq9E73emoKDtj
 oDPQtxydBm4pGehe+rNwgDZEHrGZxsEjW3fF+77m1l79AqNpjsjzHrGENhF/aVJOcC2QiSTEx
 0k3V6bYLC2W4DEJm2ma5njom2ZjOPnFaC4RgcqqpVqThKYoB1mmnWummqVg+9phdMq/u1RmZE
 t82PwmmzRKbWsZ9w8L5EzKRU+fVbpwkkMi5jruWBM1sLUZYBOIhZMvgeLtV36zvyfJE28Hl1p
 DnpcvURsJ9OCNjgCzqpSt2YoNw9QpUWWdJXIlC3j6X5d0EJWZSQGqlNUFAI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

> Matheus Castello <matheus@castello.eng.br> hat am 9. März 2018 um 05:16 geschrieben:
> 
> 
> Now we have generic pin configuration and multiplexing support,
> ahd shoud be preferred than brcm legacy one.

i suspect this patch won't get noticed by the DT maintainer because of the wrong subject.

Please try something like this:

dt-bindings: pinctrl: bcm2835-gpio: Add generic pinctrl support

Even this sounds strange to you, but this patch must be the first patch of series (1/3).

Stefan

> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> index 2569866..58b4720 100644
> --- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> @@ -36,6 +36,25 @@ listed. In other words, a subnode that lists only a mux function implies no
>  information about any pull configuration. Similarly, a subnode that lists only
>  a pul parameter implies no information about the mux function.
>  
> +This driver supports the generic pin multiplexing and configuration
> +bindings. For details on each properties, you can refer to
> +./pinctrl-bindings.txt.
> +
> +Required sub-node properties:
> +  - pins
> +  - function
> +
> +Optional sub-node properties:
> +  - bias-disable
> +  - bias-pull-up
> +  - bias-pull-down
> +  - output-high
> +  - output-low
> +
> +Legacy pin configuration and multiplexing binding:
> +*** (Its use is deprecated, use generic multiplexing and configuration
> +bindings instead)
> +
>  Required subnode-properties:
>  - brcm,pins: An array of cells. Each cell contains the ID of a pin. Valid IDs
>    are the integer GPIO IDs; 0==GPIO0, 1==GPIO1, ... 53==GPIO53.
> -- 
> 2.7.4
>
