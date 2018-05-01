Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756125AbeEAPeL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:34:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755877AbeEAPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:34:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4E5F601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [v5 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
 <1525164093-16645-3-git-send-email-tdas@codeaurora.org>
 <20180501124333.GA32660@rob-hp-laptop>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <cbd9d87c-93ed-a004-487d-4014ac7a93b2@codeaurora.org>
Date: Tue, 1 May 2018 21:03:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501124333.GA32660@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2018 6:13 PM, Rob Herring wrote:
> On Tue, May 01, 2018 at 02:11:33PM +0530, Taniya Das wrote:
>> Add the RPMh clock driver to control the RPMh managed clock resources on
>> some of the Qualcomm Technologies, Inc. SoCs.
>>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/clk/qcom/Kconfig              |   9 +
>>   drivers/clk/qcom/Makefile             |   1 +
>>   drivers/clk/qcom/clk-rpmh.c           | 387 ++++++++++++++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,rpmh.h |   2 -
>>   4 files changed, 397 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/clk/qcom/clk-rpmh.c
> 
>> diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
>> index 36caab2..f48fbd6 100644
>> --- a/include/dt-bindings/clock/qcom,rpmh.h
>> +++ b/include/dt-bindings/clock/qcom,rpmh.h
>> @@ -18,7 +18,5 @@
>>   #define RPMH_RF_CLK2_A				9
>>   #define RPMH_RF_CLK3				10
>>   #define RPMH_RF_CLK3_A				11
>> -#define RPMH_RF_CLK4				12
>> -#define RPMH_RF_CLK4_A				13
> 
> Did you mean to have this or squash into previous patch?
> 

Thanks, my mistake. It was meant to be squashed in the previous patch. I 
would take care of it in the next series.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
