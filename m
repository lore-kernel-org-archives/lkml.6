Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeDENSs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:18:48 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35389 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDENSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:18:46 -0400
X-Google-Smtp-Source: AIpwx49DucoE9eoQpGJtd4WXtFERIukax65hMH6hebQPNcuKp56NRMpBmKFgap7j9JPf6R9CQNcX6w==
Date: Thu, 5 Apr 2018 08:18:44 -0500
From: Rob Herring <robh@kernel.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v4 04/14] clk: qcom: Add DT bindings for CPU clock driver
 for msm8996
Message-ID: <20180405131844.sfhta7qjdsmxpa4d@rob-hp-laptop>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-5-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522358807-10413-5-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 12:26:37AM +0300, Ilia Lin wrote:

Needs a commit message.

> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>

Add acks/reviewed-bys when posting new versions.

> ---
>  Documentation/devicetree/bindings/clock/qcom,kryocc.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,kryocc.txt b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> new file mode 100644
> index 0000000..8458783
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> @@ -0,0 +1,17 @@
> +Qualcomm CPUSS clock controller for Kryo CPUs
> +----------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +
> +			"qcom,msm8996-apcc"
> +
> +- reg : shall contain base register location and length
> +- #clock-cells : shall contain 1
> +
> +Example:
> +	kryocc: clock-controller@6400000 {
> +		compatible = "qcom,msm8996-apcc";
> +		reg = <0x6400000 0x90000>;
> +		#clock-cells = <1>;
> +	};
> -- 
> 1.9.1
> 
