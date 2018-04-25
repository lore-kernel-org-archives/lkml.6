Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeDYQbB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:31:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43572 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755176AbeDYQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:30:57 -0400
X-Google-Smtp-Source: AIpwx4/cd+FtaTItsRSlCUyGpS5UBNi12qeG8qhdp7KqTxVqoDxz7wjAHmpq5uCEOmSamGTbSWco/A==
Date: Wed, 25 Apr 2018 09:30:54 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: andy.gross@linaro.org, mark.rutland@arm.com, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com,
        will.deacon@arm.com, catalin.marinas@arm.com
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add APSS shared mailbox node to
 SDM845
Message-ID: <20180425163054.GH18510@minitux>
References: <20180425143803.11260-1-sibis@codeaurora.org>
 <20180425143803.11260-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425143803.11260-3-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Apr 07:38 PDT 2018, Sibi Sankar wrote:

> This patch add the node to support APSS shared
> mailbox on SDM845
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> This patch depends on https://patchwork.kernel.org/patch/10276419/
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 486ace9a9e8b..9be763da0664 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -338,5 +338,11 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		apss_shared: mailbox@17990000 {
> +			compatible = "qcom,sdm845-apss-shared";
> +			reg = <0x17990000 0x1000>;
> +			#mbox-cells = <1>;
> +		};
>  	};
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
