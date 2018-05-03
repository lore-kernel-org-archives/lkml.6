Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeECKgG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:36:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeECKgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:36:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 03 May 2018 16:06:01 +0530
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: Add video clock controller driver for
 SDM845
In-Reply-To: <152528682776.138124.2183943878215041610@swboyd.mtv.corp.google.com>
References: <1524576771-31096-1-git-send-email-anischal@codeaurora.org>
 <1524576771-31096-3-git-send-email-anischal@codeaurora.org>
 <152521087780.138124.7623601052057968460@swboyd.mtv.corp.google.com>
 <d311e4d7-7ba8-0b26-93c7-5ee06db466ef@codeaurora.org>
 <152528682776.138124.2183943878215041610@swboyd.mtv.corp.google.com>
Message-ID: <fef9e787926f4e72bcadb3d87ea888d2@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-03 00:17, Stephen Boyd wrote:
> Quoting Nischal, Amit (2018-05-02 00:56:35)
>> 
>> 
>> Thanks for the review.
>> As of now, there are no resets defined for VIDEOCC. So I will move
>> the #reset-cells tooptional property in the dt-binding.
>> Same will be updated in the next patch series.
> 
> Please don't make it optional. It should be required in the binding,
> because there are resets in the hardware. If you don't want to add them
> into the driver, that's ok, but it isn't really that hard to add them 
> so
> why not add them?

There is no reset client for VideoCC so that's why we have not
added them in the driver file. However, I will make "#reset-cells"
as required property in the dt-binding.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
