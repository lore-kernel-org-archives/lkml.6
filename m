Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeEHEuK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:50:10 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61262 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEHEuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:50:08 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180508045006epoutp039f421e15535fa45ccd95da5a421327d4~skhg2B9kg2781527815epoutp03Q
X-AuditID: b6c32a36-b6dff70000001027-46-5af12c6fd97c
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AF12C6F.4040903@samsung.com>
Date: Tue, 08 May 2018 13:49:51 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Drop custom MIN/MAX macros
In-reply-to: <20180424194639.22804-1-bjorn.andersson@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmvm6+zscog+VztS1O73/HYnG26Q27
        xeVdc9gsPvceYbS43biCzYHV4861PWwefVtWMXp83iQXwByVapORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM1Zs5y34y1/R1bGOpYGxk7eLkZNDQsBEYuKh
        x6xdjFwcQgI7GCV23lvNBuF8Z5T4swDEgai6u/4SC0RiA6PEpU/3mEESvAKCEj8m3wNKcHAw
        C8hLHLmUDRJmFtCU2Lp7PTtE/V1GiXOHFrNA1GtJvJ7ewwRiswioSjw4O5MRxGYDiu9/cQNs
        Gb+AosTVH4/B4qICERI7538DGyQi0MYo0fTpDiPEBiuJ1x+72UFsYQFbiT2tLWBDOQUcJFa+
        Xwj2goTABjaJic+vsUK84CJx5MdaZghbWOLV8S3sIFdLCEhLXDpqC1HfzijRvnceM4QzBejs
        6/eYIBqMJZ4t7GKC2Mwn8e5rDytEM69ER5sQRImHxOvbr1ggbEeJZ5cXQ70/mVFiQeNq9gmM
        crOQQmwWIsRmIYXYAkbmVYxiqQXFuempxYYFRnrFibnFpXnpesn5uZsYwalMy2wH46JzPocY
        BTgYlXh4A4o/RAmxJpYVV+YeYpTgYFYS4VWW/RglxJuSWFmVWpQfX1Sak1p8iNEUGOATmaVE
        k/OBaTavJN7Q1MjY2NjCxNDM1NBQSZz3qc+ZKCGB9MSS1OzU1ILUIpg+Jg5OqQZGtk0To1/c
        dNJ6ItD05dBerhNR65ccimHw8i0S5xA2qW/ofpVRH6urbsmncvRzyBSVt6l7Zj34fdqo/Fi9
        4se0K0t7pK6IHK1/xNCXbNMeGukfPffnxX2/uvZsP7fn2YRElhYxbdHFX44cSHnrbHlXo/u8
        jO/eG9zsbZ7z+kyf3PV4wc/9uDxBiaU4I9FQi7moOBEAIOani3sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd18nY9RBi8ni1uc3v+OxeJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrx51re9g8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2PFdt6C
        v/wVXR3rWBoYO3m7GDk5JARMJO6uv8TSxcjFISSwjlFi1bsVzCAJXgFBiR+T7wElODiYBeQl
        jlzKBgkzC6hLTJq3iBmi/j6jxLuvk9gh6rUkXk/vYQKxWQRUJR6cnckIYrMBxfe/uMEGYvML
        KEpc/fGYEWSmqECERPeJSpA5IgIdjBK7z11hgVhgJfH6YzfYTGEBW4k9rS1MEMumMkrMeX0L
        bCingIPEyvcL2SYwCsxCcusshFtnIbl1ASPzKkbJ1ILi3PTcYqMCw7zUcr3ixNzi0rx0veT8
        3E2MwBDedlirbwfj/SXxhxgFOBiVeHh/FHyIEmJNLCuuzD3EKMHBrCTCqyz7MUqINyWxsiq1
        KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGRtNj+1S+Ty9OtF0tdMvy
        DQODxNazC1sYZHqeLVq7wUV2YoMeL3ObT161tEc1R3mc1T/vvc3fz1wtWrDmTcDJiNqgzfkS
        uru/9v2LSnrxebNMjeYhtWNfS66xqaUzHU2ZvFKpq+2X2Y9VLZxcJq9tnLamuC88eCZ5ajDT
        zX3KtglnC5OvPfokq8RSnJFoqMVcVJwIAD4vYSBdAgAA
X-CMS-MailID: 20180508044951epcas1p180f733c59c3f490356af4ddf7702ef1f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180424194654epcas2p23f29bc7de4118f84c7888a7966b90b88
X-RootMTR: 20180424194654epcas2p23f29bc7de4118f84c7888a7966b90b88
References: <CGME20180424194654epcas2p23f29bc7de4118f84c7888a7966b90b88@epcas2p2.samsung.com>
        <20180424194639.22804-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 25일 04:46, Bjorn Andersson wrote:
> Drop the custom MIN/MAX macros in favour of the standard min/max from
> kernel.h
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/devfreq/devfreq.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..2067cd229ce3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -28,9 +28,6 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> -#define MAX(a,b)	((a > b) ? a : b)
> -#define MIN(a,b)	((a < b) ? a : b)
> -
>  static struct class *devfreq_class;
>  
>  /*
> @@ -280,8 +277,8 @@ int update_devfreq(struct devfreq *devfreq)
>  	 * max_freq
>  	 * min_freq
>  	 */
> -	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> -	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
> +	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> +	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
>  
>  	if (min_freq && freq < min_freq) {
>  		freq = min_freq;
> @@ -1149,7 +1146,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  
> -	return sprintf(buf, "%lu\n", MAX(df->scaling_min_freq, df->min_freq));
> +	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
> @@ -1185,7 +1182,7 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  
> -	return sprintf(buf, "%lu\n", MIN(df->scaling_max_freq, df->max_freq));
> +	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
>  }
>  static DEVICE_ATTR_RW(max_freq);
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
