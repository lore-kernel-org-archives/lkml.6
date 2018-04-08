Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeDHKLo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 06:11:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDHKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 06:11:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 498D260274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 2/2] dt-bindings: clock: Introduce QCOM RPMh clock
 bindings
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
 <1522304274-18989-3-git-send-email-tdas@codeaurora.org>
 <152297042791.143116.12493897848354753009@swboyd.mtv.corp.google.com>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <98232fda-7952-b19f-7dcd-b22c45e5041a@codeaurora.org>
Date: Sun, 8 Apr 2018 15:41:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152297042791.143116.12493897848354753009@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for the review.

On 4/6/2018 4:50 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-03-28 23:17:53)
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh.txt
>> new file mode 100644
>> index 0000000..8222c88
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmh.txt
> 
> Can the file name be qcom,rpmh-clk?
> 

Sure will update the file name.

>> @@ -0,0 +1,22 @@
>> +Qualcomm Technologies, Inc. RPMh Clocks
>> +-------------------------------------------------------
>> +
>> +Resource Power Manager Hardened (RPMh) manages shared resources on
>> +some Qualcomm Technologies Inc. SoCs. It accepts clock requests from
>> +other hardware subsystems via RSC to control clocks.
>> +
>> +Required properties :
>> +- compatible : shall contain "qcom,rpmh-clk-sdm845"
>> +
>> +- #clock-cells : must contain 1
>> +
>> +Example :
>> +
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +
>> +       &apps_rsc {
> 
>> +               clock_rpmh: qcom,rpmhclk {
> 
> Should say clock-controller for node name.
>

Would fix it in the next patch.

>> +               compatible = "qcom,rpmh-clk-sdm845";
>> +               #clock-cells = <1>;
> 
> Is this tabbed out correctly?
> 

Will fix the tabs in the next patch.

>> +               };
>> +       };

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
