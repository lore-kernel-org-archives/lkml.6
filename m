Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCOKXA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:23:00 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39494 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeCOKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:22:57 -0400
X-Google-Smtp-Source: AG47ELtmg/mwHqpsmainBHgijzsancSAGOfaK6y+yzCFmM32JZS0sdoOzNgTezIket0gn2h9j91MoMv3sy83tDCN+NE=
MIME-Version: 1.0
In-Reply-To: <20180223064138.18401-5-jh80.chung@samsung.com>
References: <CGME20180223064140epcas2p1bf475ebcbfa8a0c46e92402e31590891@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com> <20180223064138.18401-5-jh80.chung@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Mar 2018 11:22:56 +0100
Message-ID: <CAPDyKFpYgVUwaWYyvRoGkX=m5kLi=L15_D4KZpgwW6iC2-WF4A@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: lpc18xx: remove 'num-slots' property for dwmmc
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org,
        Will Deacon <will.deacon@arm.com>, Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 February 2018 at 07:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Since 'num-slots' had already deprecated, remove the property in
> device-tree file.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  arch/arm/boot/dts/lpc18xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
> index 7cae9c5e27db..10b8249b8ab6 100644
> --- a/arch/arm/boot/dts/lpc18xx.dtsi
> +++ b/arch/arm/boot/dts/lpc18xx.dtsi
> @@ -115,7 +115,6 @@
>                         compatible = "snps,dw-mshc";
>                         reg = <0x40004000 0x1000>;
>                         interrupts = <6>;
> -                       num-slots = <1>;
>                         clocks = <&ccu2 CLK_SDIO>, <&ccu1 CLK_CPU_SDIO>;
>                         clock-names = "ciu", "biu";
>                         resets = <&rgu 20>;
> --
> 2.15.1
>
