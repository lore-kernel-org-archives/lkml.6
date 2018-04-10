Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeDJSly (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:41:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37205 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDJSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:41:52 -0400
X-Google-Smtp-Source: AIpwx48MpoufG03WOGbmmZGUjr6yiqBCFGhnac4DBJQyYRySpJiiRliwOQQN0uUoWbZqUNUJAilUJQ==
Date: Tue, 10 Apr 2018 11:42:31 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: apq8096-db820c: Add micro sd card supplies
Message-ID: <20180410184231.GA23948@tuxbook-pro>
References: <20180410135426.15508-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410135426.15508-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Apr 06:54 PDT 2018, Srinivas Kandagatla wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds missing microSD card supplies, without this uSD
> card will not be detected.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 1c8f1b86472d..f8191f64eb84 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -87,6 +87,8 @@
>  			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  			cd-gpios = <&msmgpio 38 0x1>;
> +			vmmc-supply = <&pm8994_l21>;
> +			vqmmc-supply = <&pm8994_l13>;
>  			status = "okay";
>  		};
>  
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
