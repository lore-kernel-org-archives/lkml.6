Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeFDE07 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:26:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeFDE05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:26:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEE9D60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 2/2] tsens: Get rid of unused fields in structure
To: Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc: bjorn.andersson@linaro.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
 <40aa5b9760b09be0970dbe82997db71756927eb0.1527937396.git.amit.kucheria@linaro.org>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <7ccc0acb-b2e0-cb81-31f5-223d78e62966@codeaurora.org>
Date: Mon, 4 Jun 2018 09:56:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <40aa5b9760b09be0970dbe82997db71756927eb0.1527937396.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2018 04:41 PM, Amit Kucheria wrote:
> status_field and trdy are unused in any of the tsens drivers. Remove them.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Rajendra Nayak <rnayak@codeaurora.org>

> ---
>  drivers/thermal/qcom/tsens.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index f15660d..77ed8dc 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -77,9 +77,7 @@ struct tsens_device {
>  	struct device			*dev;
>  	u32				num_sensors;
>  	struct regmap			*map;
> -	struct regmap_field		*status_field;
>  	struct tsens_context		ctx;
> -	bool				trdy;
>  	const struct tsens_ops		*ops;
>  	struct tsens_sensor		sensor[0];
>  };
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
