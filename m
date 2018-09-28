Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3004C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747372173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b1Ng8vkr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nrU1JdPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747372173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeI1Mtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:49:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43844 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1Mtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:49:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 68782609A8; Fri, 28 Sep 2018 06:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538116045;
        bh=aG3MCBTwK0CKjeDhgOLoOv8qrB02DeqzWQQtovW7xNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b1Ng8vkrWMAdV1Zghyov3Rq3A66Tka+zsccivovpe+jIKc4KFuqC27MA5UFvbk7rm
         y/XV1R6/QPfqd8E9Z+BHbjXUfArGw9wMSA8detHR6hrJ6GtFp4Z7mSDhWkYUmvgmmR
         I/lJ0OL3YQVerTayLLYLxTCWQ0KfidrW7EOv5qW4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A4408607F4;
        Fri, 28 Sep 2018 06:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538116044;
        bh=aG3MCBTwK0CKjeDhgOLoOv8qrB02DeqzWQQtovW7xNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nrU1JdPzINxAhJxoPJ2IF+ORTxOA0U/jJmGMAkBPyNRDR/iEuTe+M/vVDfxe9nCh0
         5hRQ8bqtsOPMgvpURw0kId1w4SNWsYkBF7p4lK6mHNlCKc8AuPpid3MT1ufBtSyxQ3
         vFzYvAMWOnwam8N2gt7+29po/xk6r04LmHzfPDU8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Sep 2018 11:57:24 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: qcom: pas: Add QCS404 remoteprocs
In-Reply-To: <20180927190346.2984-1-bjorn.andersson@linaro.org>
References: <20180927190346.2984-1-bjorn.andersson@linaro.org>
Message-ID: <580f4c902aa18e86e5a2e78521d998ee@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-28 00:33, Bjorn Andersson wrote:
> Add compatibles for the three PAS based remote processors found in
> QCS404.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> Changes since v1:
> - Fixed incorrect sysmon_name, as pointed out by Sibi.
> 
>  .../devicetree/bindings/remoteproc/qcom,adsp.txt     |  3 +++
>  drivers/remoteproc/qcom_adsp_pil.c                   | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> index b7d058228185..9c0cff3a5ed8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> @@ -10,6 +10,9 @@ on the Qualcomm ADSP Hexagon core.
>  		    "qcom,msm8974-adsp-pil"
>  		    "qcom,msm8996-adsp-pil"
>  		    "qcom,msm8996-slpi-pil"
> +		    "qcom,qcs404-adsp-pas"
> +		    "qcom,qcs404-cdsp-pas"
> +		    "qcom,qcs404-wcss-pas"
>  		    "qcom,sdm845-adsp-pas"
>  		    "qcom,sdm845-cdsp-pas"
> 
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c
> b/drivers/remoteproc/qcom_adsp_pil.c
> index da2254ea1135..d5e58235e83a 100644
> --- a/drivers/remoteproc/qcom_adsp_pil.c
> +++ b/drivers/remoteproc/qcom_adsp_pil.c
> @@ -362,10 +362,22 @@ static const struct adsp_data slpi_resource_init 
> = {
>  		.ssctl_id = 0x16,
>  };
> 
> +static const struct adsp_data wcss_resource_init = {
> +	.crash_reason_smem = 421,
> +	.firmware_name = "wcnss.mdt",
> +	.pas_id = 6,
> +	.ssr_name = "mpss",
> +	.sysmon_name = "wcnss",
> +	.ssctl_id = 0x12,
> +};
> +
>  static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,msm8974-adsp-pil", .data = 
> &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-adsp-pil", .data = 
> &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-slpi-pil", .data = 
> &slpi_resource_init},
> +	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init 
> },
> +	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init 
> },
> +	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init 
> },
>  	{ .compatible = "qcom,sdm845-adsp-pas", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &cdsp_resource_init},
>  	{ },

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
