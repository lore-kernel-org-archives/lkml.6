Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeEBH4r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:56:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeEBH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:56:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9C7B6019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
Subject: Re: [PATCH 2/2] clk: qcom: Add video clock controller driver for
 SDM845
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1524576771-31096-1-git-send-email-anischal@codeaurora.org>
 <1524576771-31096-3-git-send-email-anischal@codeaurora.org>
 <152521087780.138124.7623601052057968460@swboyd.mtv.corp.google.com>
From: "Nischal, Amit" <anischal@codeaurora.org>
Message-ID: <d311e4d7-7ba8-0b26-93c7-5ee06db466ef@codeaurora.org>
Date: Wed, 2 May 2018 13:26:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152521087780.138124.7623601052057968460@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2018 3:11 AM, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-04-24 06:32:51)
>> Add support for the video clock controller found on SDM845
>> based devices. This would allow video drivers to probe and
>> control their clocks.
>>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Driver looks small and good. Only concern is that there aren't resets
> defined, but the binding says there are resets. Will you add them?
Thanks for the review.
As of now, there are no resets defined for VIDEOCC. So I will move
the #reset-cells tooptional property in the dt-binding.
Same will be updated in the next patch series.
>
> I'm going to wait for the respin on the dts binding anyway.
Yes, I will send the next patch series soon.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
