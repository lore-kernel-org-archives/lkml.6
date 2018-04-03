Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDCQkA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:40:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeDCQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:39:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24D2A6076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v4 13/14] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ilia Lin <ilialin@codeaurora.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, lgirdwood@gmail.com, broonie@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, amit.kucheria@linaro.org,
        nicolas.dechesne@linaro.org, celster@codeaurora.org,
        tfinkel@codeaurora.org
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-14-git-send-email-ilialin@codeaurora.org>
 <20180402093018.GC3572@vireshk-i7>
 <7ca35b7a-6078-620b-4772-091e53ef6790@codeaurora.org>
 <06308b25-14ea-8d8b-6f95-f05c101a617b@codeaurora.org>
 <20180403042341.GI3572@vireshk-i7>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <1dcbd33a-09e8-89fa-8cae-011e80b3ceb8@codeaurora.org>
Date: Tue, 3 Apr 2018 22:09:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403042341.GI3572@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 4/3/2018 9:53 AM, Viresh Kumar wrote:
> On 03-04-18, 08:11, Sricharan R wrote:
>>  Right, i was adding a similar one for krait cores [1]. There is code common in the
>>  init sequence across both (little). Do you suggest to make them common ?
> 
> It may make sense as we are talking about one SoC family here :)
> 
  ok. So either of us can merge, depending upon which one goes first.

Regards,
 Sricharan
-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
