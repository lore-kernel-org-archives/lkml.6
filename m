Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeEWRjD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:39:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53586 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:39:02 -0400
X-Google-Smtp-Source: AB8JxZrtIKm5HulER+oEGU4rtpVLHIoL9vedAe774Y2i3CTth0QuuKutd2QNRTvBT8L/aXUjiq1L1RVhxfMT44zL7+8=
MIME-Version: 1.0
In-Reply-To: <1526661567-4578-8-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com> <1526661567-4578-8-git-send-email-suzuki.poulose@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 23 May 2018 11:39:00 -0600
Message-ID: <CANLsYkz8d_RrFojz=ZQwOBB6J3-W9+edaVWC6R7Arg5GvhwcOA@mail.gmail.com>
Subject: Re: [PATCH 07/11] dts: juno: Add scatter-gather support for all revisions
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, coresight@lists.linaro.org,
        Mark Rutland <mark.rutland@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2018 at 10:39, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Advertise that the scatter-gather is properly integrated on
> all revisions of Juno board.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index eb749c5..6ce9090 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -198,6 +198,7 @@
>                 clocks = <&soc_smc50mhz>;
>                 clock-names = "apb_pclk";
>                 power-domains = <&scpi_devpd 0>;
> +               arm,scatter-gather;
>                 port {
>                         etr_in_port: endpoint {
>                                 slave-mode;
> --
> 2.7.4
>
