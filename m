Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbeCRWp2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:45:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41422 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeCRWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:45:24 -0400
X-Google-Smtp-Source: AG47ELt1qjt4JiuXvuI/E3WF7ygdqlkP1sMRY/PfatEKhuHnc4rsyNSj0DewhuWewXzP5OltcKRgLA==
Date: Sun, 18 Mar 2018 15:45:24 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi S <sibis@codeaurora.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 3/7] dt-bindings: mailbox: Add APCS global binding for
 SDM845 SoCs
Message-ID: <20180318224524.GE5626@tuxbook-pro>
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-4-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521019283-32212-4-git-send-email-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:

> Include SDM845 APCS binding to the list of possible bindings
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Sibi S <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> index 16964f0..6a7e5d8 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> @@ -10,6 +10,7 @@ platforms.
>  	Definition: must be one of:
>  		    "qcom,msm8916-apcs-kpss-global",
>  		    "qcom,msm8996-apcs-hmss-global"
> +		    "qcom,sdm845-apcs-hmss-global"
>  
>  - reg:
>  	Usage: required
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
