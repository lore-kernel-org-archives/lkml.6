Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A61C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA0D21735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA0D21735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeHTXKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:10:40 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38246 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:10:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so27999664oie.5;
        Mon, 20 Aug 2018 12:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXEs4rmRXLDVUF6FD4YS7mdruMwW55Nuhl4XpR23dDI=;
        b=umw4yQJiGkQ++onNLqYLzEkTj+eiC2+5XnGNJy6uOG/pk+nQAaYvxgetc91D6KHTkL
         eF6DKI8bcWQIKJ/JK9ft9OWWhLJa70nVtazrctjDRfovKEJAYDK3MNdewYDWZ8SUA/6l
         bNqJRnccT2ZJSkGaANAe+S6gTzMRgTbXwk5drcz0zrrcYELq5hR5C5oSCECkhPDlrhf9
         IC/5URVEmhsvsc5qiNYjkaTsMa6PSBl/eQA8pzQB6zjmQbzX9EFHQOcG8I1junz4zODi
         4rXdNbHkukCdfwbltqXQqV3KxVFd5mLtLVozaINRVdxJsa6MSP6Pc8XTUvhFCml9qgeW
         1Xmw==
X-Gm-Message-State: AOUpUlEo/RcifD2DXIxYvt+MScfkUDeaIdIoAmngKvUz++qCmWnMC7l7
        N0betw8d2IQ+n7o/yHwt4g==
X-Google-Smtp-Source: AA+uWPwlBC0yerISfHphbkspVN5+CBNbX+zjPGhAhnoDWczkwh3CsV8BjIHezVBAC9PCA3ehr9gXxw==
X-Received: by 2002:aca:3f41:: with SMTP id m62-v6mr16189324oia.18.1534794822696;
        Mon, 20 Aug 2018 12:53:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 16-v6sm7099681oin.5.2018.08.20.12.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:53:42 -0700 (PDT)
Date:   Mon, 20 Aug 2018 14:53:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        rishabhb@codeaurora.org, bp@alien8.de, evgreen@chromium.org
Subject: Re: [PATCH v2 4/4] dt-bindigs: msm: Update documentation of qcom,llcc
Message-ID: <20180820195341.GA3358@bogus>
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-5-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534550915-18230-5-git-send-email-vnkgutta@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 05:08:35PM -0700, Venkata Narendra Kumar Gutta wrote:
> Add reg-names and interrupts for LLCC documentation and the usage
> examples. llcc broadcast base is added in addition to llcc base,
> which is used for llcc broadcast writes.

Typo in the subject.

This binding just landed recently and it's already being updated? Sigh.
Bindings should be complete from the start. Technically, you can't add 
new required properties.

> 
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> index 5e85749..b4b1c86 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -18,9 +18,22 @@ Properties:
>  	Value Type: <prop-encoded-array>
>  	Definition: Start address and the the size of the register region.
>  
> +- reg-names:
> +        Usage: required
> +        Value Type: <stringlist>
> +        Definition: Register region names. Must be "llcc_base", "llcc_bcast_base".

reg needs to be updated that there are 2 entries.

> +
> +- interrupts:
> +	Usage: required
> +	Definition: The interrupt is associated with the llcc edac device.
> +			It's used for llcc cache single and double bit error detection
> +			and reporting.
> +
>  Example:
>  
>  	cache-controller@1100000 {
>  		compatible = "qcom,sdm845-llcc";
> -		reg = <0x1100000 0x250000>;
> +		reg = <0x1100000 0x200000>, <0x1300000 0x50000> ;
> +		reg-names = "llcc_base", "llcc_bcast_base";
> +		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
