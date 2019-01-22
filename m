Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F08C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9A320861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cmY6FkHc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="laiPv48w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAVGnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:43:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfAVGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:43:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2194608CD; Tue, 22 Jan 2019 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548139409;
        bh=9i79PqIDU3zI548RYDaZ460Wrk5M+XFzLzr1uScN/eE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cmY6FkHc44ChReVYED8NfR0xzCOKrRCChLnF+9L/n04O0b3QAGvviChXnpgedBN7d
         T0pxxqaEzGwXEA2nPTPO5r4DzCnvyjUCKFlG49Lm5ikEq3O9v9lJCeaM++O4ZwAVga
         CyjTRuI4B/ofnRETq20tJlQJkc5z4FdMixxWLjho=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B5AFA608CD;
        Tue, 22 Jan 2019 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548139407;
        bh=9i79PqIDU3zI548RYDaZ460Wrk5M+XFzLzr1uScN/eE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=laiPv48wETHrrote88pFE8XxsVki3RAGdeq8eUJy39Wq7Hz7eJucmVwScQU0+hFQr
         pdjTq2hsK02uZk0pnN1l481hgYYVW/TCln///0IS0ukPd2v2wsZMucbUQl3ThNpqMh
         0amBjtpMnmDJFyaH9UGxme6JoQqK2+Q4b9zAz0BY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 12:13:26 +0530
From:   alokc@codeaurora.org
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
In-Reply-To: <1548069703-26595-2-git-send-email-alokc@codeaurora.org>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
 <1548069703-26595-2-git-send-email-alokc@codeaurora.org>
Message-ID: <91aa93df80b560ea86520a4773b67d51@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't review this patch. I've resend patches after adding all the 
mailing list.
Sorry for inconvenience.

On 2019-01-21 16:51, Alok Chauhan wrote:
> Add documentation for the interconnect and interconnect-names bindings
> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 
> ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> index dab7ca9..44d7e02 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -17,6 +17,12 @@ Required properties if child node exists:
>  - #address-cells: 	Must be <1> for Serial Engine Address
>  - #size-cells: 		Must be <1> for Serial Engine Address Size
>  - ranges: 		Must be present
> +- interconnects:	phandle to a interconnect provider. Please refer
> +			../interconnect/interconnect.txt for details.
> +			Must be 2 paths corresponding to 2 AXI ports.
> +- interconnect-names:	Port names to differentiate between the
> +			2 interconnect paths defined with interconnect
> +			specifier.
> 
>  Properties for children:
> 
> @@ -67,6 +73,10 @@ Example:
>  		#size-cells = <1>;
>  		ranges;
> 
> +		interconnects = <&qnoc 11 &qnoc 512>,
> +				<&qnoc 0 &qnoc 543>;
> +		interconnect-names = "qup-memory", "qup-config";
> +
>  		i2c0: i2c@a94000 {
>  			compatible = "qcom,geni-i2c";
>  			reg = <0xa94000 0x4000>;

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
