Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeDNCDO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 22:03:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDNCDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 22:03:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A51D6081A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [[PATCH v2] 1/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
References: <1523183533-23171-1-git-send-email-tdas@codeaurora.org>
 <1523183533-23171-2-git-send-email-tdas@codeaurora.org>
 <20180413163705.io4xbukerjkzjmri@rob-hp-laptop>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <cba2a99f-fa6f-42d8-9063-8a642bea6f2c@codeaurora.org>
Date: Sat, 14 Apr 2018 07:32:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413163705.io4xbukerjkzjmri@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thank you for the review comments.

On 4/13/2018 10:07 PM, Rob Herring wrote:
> On Sun, Apr 08, 2018 at 04:02:12PM +0530, Taniya Das wrote:
>> From: Amit Nischal <anischal@codeaurora.org>
>>
>> Add the RPMh clock driver to control the RPMh managed clock resources on
>> some of the Qualcomm Technologies, Inc. SoCs.
>>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/clk/qcom/Kconfig              |   9 +
>>   drivers/clk/qcom/Makefile             |   1 +
>>   drivers/clk/qcom/clk-rpmh.c           | 394 ++++++++++++++++++++++++++++++++++
> 
>>   include/dt-bindings/clock/qcom,rpmh.h |  25 +++
> 
> This goes with the binding patch which should come first in the series.
> 

I would make the change in the next patch series.

>>   4 files changed, 429 insertions(+)
>>   create mode 100644 drivers/clk/qcom/clk-rpmh.c
>>   create mode 100644 include/dt-bindings/clock/qcom,rpmh.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
