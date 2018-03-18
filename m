Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeCRWqU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:46:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39204 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbeCRWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:46:16 -0400
X-Google-Smtp-Source: AG47ELsJTP1db9WLFRYCaVIKEDEZbSO1gAKfS8ljWvJuDFwUr9sNCypWw/h4FIXTRDbF3i1/q2NwIw==
Date: Sun, 18 Mar 2018 15:46:15 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi S <sibis@codeaurora.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 5/7] dt-bindings: remoteproc: Add Q6v5 Modem PIL
 binding for SDM845
Message-ID: <20180318224615.GG5626@tuxbook-pro>
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-6-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521019283-32212-6-git-send-email-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:

> Add new compatible string for Qualcomm SDM845 SoCs
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Sibi S <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 00d3d58..d901824 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -11,6 +11,7 @@ on the Qualcomm Hexagon core.
>  		    "qcom,msm8916-mss-pil",
>  		    "qcom,msm8974-mss-pil"
>  		    "qcom,msm8996-mss-pil"
> +		    "qcom,sdm845-mss-pil"
>  
>  - reg:
>  	Usage: required
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
