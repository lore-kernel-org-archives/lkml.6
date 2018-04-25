Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755670AbeDYQ1F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:27:05 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45838 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755952AbeDYQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:26:53 -0400
X-Google-Smtp-Source: AIpwx4+FHL8ZCN2HnHyPVU3Yek8a6Fd0tYWIg4TyvJnnHyTU53pz4hAEu5ILc1xJib7D0+PgzkiEPw==
Date: Wed, 25 Apr 2018 09:26:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: andy.gross@linaro.org, mark.rutland@arm.com, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com,
        will.deacon@arm.com, catalin.marinas@arm.com
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: Add APSS shared binding for
 SDM845 SoCs
Message-ID: <20180425162650.GG18510@minitux>
References: <20180425143803.11260-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425143803.11260-1-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Apr 07:38 PDT 2018, Sibi Sankar wrote:

> Include SDM845 APSS shared to the list of possible bindings
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> index 16964f0c1773..8ea0f12b8d0b 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> @@ -10,6 +10,7 @@ platforms.
>  	Definition: must be one of:
>  		    "qcom,msm8916-apcs-kpss-global",
>  		    "qcom,msm8996-apcs-hmss-global"
> +		    "qcom,sdm845-apss-shared"
>  
>  - reg:
>  	Usage: required
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
