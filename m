Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F1C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBAF20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfBHOUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:20:48 -0500
Received: from foss.arm.com ([217.140.101.70]:52052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfBHOUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:20:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF1DEA78;
        Fri,  8 Feb 2019 06:20:47 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300513F557;
        Fri,  8 Feb 2019 06:20:43 -0800 (PST)
Subject: Re: [PATCHv7 1/6] arm64: dts: qcom: sdm845: Add Coresight support
To:     saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        tingwei@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <81dc97e6-2640-d600-9373-30518ed59792@arm.com>
Date:   Fri, 8 Feb 2019 14:20:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2019 00:53, Sai Prakash Ranjan wrote:
> Add coresight components found on Qualcomm SDM845 SoC.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> For testing, all dependent patches are in below tree:
>   * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
> 
> - Depends on AOSS QMP side channel patches by Bjorn Andersson [1] - [4].
> - AMBA bus pclk change [5].
> - Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>    and size cells for soc") [6].
> 
> [1] https://lore.kernel.org/lkml/20190131003933.11436-5-bjorn.andersson@linaro.org/
> [2] https://lore.kernel.org/lkml/20190131003933.11436-6-bjorn.andersson@linaro.org/
> [3] https://lore.kernel.org/lkml/20190131003933.11436-7-bjorn.andersson@linaro.org/
> [4] https://lore.kernel.org/lkml/20190131003933.11436-10-bjorn.andersson@linaro.org/
> [5] https://lore.kernel.org/lkml/20190131020141.28352-1-bjorn.andersson@linaro.org/
> [6] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 434 +++++++++++++++++++++++++++
>   1 file changed, 434 insertions(+)
> 

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
