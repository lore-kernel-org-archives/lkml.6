Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeCFFPO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:15:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeCFFPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:15:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60C45601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v8 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
To: Rob Herring <robh@kernel.org>
Cc: viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
 <1519740422-3835-16-git-send-email-sricharan@codeaurora.org>
 <20180305221936.yu2mlcjodlcumedx@rob-hp-laptop>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <a8d40af2-8a9e-8868-93fa-dbdec20a437e@codeaurora.org>
Date: Tue, 6 Mar 2018 10:45:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305221936.yu2mlcjodlcumedx@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2018 3:49 AM, Rob Herring wrote:
> On Tue, Feb 27, 2018 at 07:37:02PM +0530, Sricharan R wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob !!
Will post with all tags and the Makefile corrected.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
