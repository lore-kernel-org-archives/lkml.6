Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCOKW5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:22:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39987 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeCOKWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:22:52 -0400
X-Google-Smtp-Source: AG47ELu9jU2htKlqfoZOMbZxYXmQoj0CamhE5CqWj5H0T6tpwojwYl+cFdhH/0AD9yHsfi5znzQDxyRY+wrkx9F/YgE=
MIME-Version: 1.0
In-Reply-To: <20180223064138.18401-4-jh80.chung@samsung.com>
References: <CGME20180223064140epcas2p3804fe3b7d63e4b7975d94a178e94dffb@epcas2p3.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com> <20180223064138.18401-4-jh80.chung@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Mar 2018 11:22:51 +0100
Message-ID: <CAPDyKFp1oRhsfb_enyfaAaoNUY2Hm2GoC8fO-MXc0PYG=4VfLQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: stratix10: remove 'num-slots' property
 for dwmmc
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
>  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index a37c46112876..4e146b4e6487 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -88,7 +88,6 @@
>
>  &mmc {
>         status = "okay";
> -       num-slots = <1>;
>         cap-sd-highspeed;
>         broken-cd;
>         bus-width = <4>;
> --
> 2.15.1
>
