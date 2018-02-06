Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeBFEoz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:44:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeBFEoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:44:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FB7A60A00
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v6 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
 <1517890108-8140-16-git-send-email-sricharan@codeaurora.org>
 <20180206042729.GH28462@vireshk-i7>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <d21cf85e-def9-66d8-aed1-cd1407c36fdb@codeaurora.org>
Date: Tue, 6 Feb 2018 10:14:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206042729.GH28462@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2/6/2018 9:57 AM, Viresh Kumar wrote:
> On 06-02-18, 09:38, Sricharan R wrote:
>> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
>> that has KRAIT processors the voltage/current value of each OPP
>> varies based on the silicon variant in use.
>> operating-points-v2-krait-cpu specifies the phandle to nvmem efuse cells
>> and the operating-points-v2 table for each opp. The qcom-cpufreq driver
>> reads the efuse value from the SoC to provide the required information
>> that is used to determine the voltage and current value for each OPP of
>> operating-points-v2 table when it is parsed by the OPP framework.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++++
>>  1 file changed, 363 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
> 
> You can add my Ack if Rob also finds everything to be fine here.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

 Thanks !!

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
