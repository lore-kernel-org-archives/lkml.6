Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeDYQ0p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:26:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38414 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755452AbeDYQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:26:36 -0400
X-Google-Smtp-Source: AIpwx48OzWBcK67dPyWw2AlpbAHAmp2jROYV7FKGp9dEM/GbK9g5T8vQ0BckS4K7AUs2kCA7Zqx9ew==
Date: Wed, 25 Apr 2018 09:26:32 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: andy.gross@linaro.org, mark.rutland@arm.com, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com,
        will.deacon@arm.com, catalin.marinas@arm.com
Subject: Re: [PATCH 2/3] mailbox: Add support for Qualcomm SDM845 SoCs
Message-ID: <20180425162632.GF18510@minitux>
References: <20180425143803.11260-1-sibis@codeaurora.org>
 <20180425143803.11260-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425143803.11260-2-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Apr 07:38 PDT 2018, Sibi Sankar wrote:

> Add the corresponding APSS shared offset for SDM845 SoC
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 57bde0dfd12f..75da44d25fac 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -125,6 +125,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = (void *)8 },
>  	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = (void *)16 },
> +	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
