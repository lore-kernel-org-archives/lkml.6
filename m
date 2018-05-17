Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeEQTRF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:17:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQTRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:17:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B92B6055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5AFDD52D.2000201@codeaurora.org>
Date: Thu, 17 May 2018 12:17:01 -0700
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Taniya Das <tdas@codeaurora.org>, robh@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: Re: [v0 1/2] dt-bindings: clock: Introduce QCOM CPUFREQ FW bindings
References: <1526549401-25666-1-git-send-email-tdas@codeaurora.org> <1526549401-25666-2-git-send-email-tdas@codeaurora.org> <20180517101438.du7xihojuhjxq77l@vireshk-i7>
In-Reply-To: <20180517101438.du7xihojuhjxq77l@vireshk-i7>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 03:14 AM, Viresh Kumar wrote:
> + Rob.
>
> On 17-05-18, 15:00, Taniya Das wrote:
>> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
>> SoCs. This is required for managing the cpu frequency transitions which are
>> controlled by firmware.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 68 ++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt

Isn't the prefix wrong? Shouldn't it be dt-bindings: cpufreq:?

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
