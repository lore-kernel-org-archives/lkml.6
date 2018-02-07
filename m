Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeBGKAw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:00:52 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35973 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbeBGKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:00:48 -0500
X-Google-Smtp-Source: AH8x224/OzQ2VcZ5PLMn47iksTl31+evX+3T/UzkbXWX9dQGqMXF6hcY2cgv46vE1t5mtPUz2tJ2+nDkHaNyO5ebfKU=
MIME-Version: 1.0
In-Reply-To: <20180205144651.5934-3-georgi.djakov@linaro.org>
References: <20180205144651.5934-1-georgi.djakov@linaro.org> <20180205144651.5934-3-georgi.djakov@linaro.org>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Wed, 7 Feb 2018 15:30:47 +0530
X-Google-Sender-Auth: OZOgFX88QCyNUHVUnKK94487DFc
Message-ID: <CAHLCerOSx+vMMHYj-1cCE8PPGFm=_523Qxeg__AzSjYbtA2FiA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8916: Add clock properties to
 the APCS node
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 8:16 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> There are clock controller registers in the APCS block, which purpose

If you respin this, s/which/whose

> is to control the main CPU mux and divider. Add the clock properties as
> part of the APCS device-tree node.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 5414f53a0fa1..4539571a36b2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -336,6 +336,8 @@
>                         compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                         reg = <0xb011000 0x1000>;
>                         #mbox-cells = <1>;
> +                       clocks = <&a53pll>;
> +                       #clock-cells = <0>;
>                 };
>
>                 blsp1_uart2: serial@78b0000 {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
