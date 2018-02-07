Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeBGKFS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:05:18 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37941 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753419AbeBGKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:05:16 -0500
X-Google-Smtp-Source: AH8x227eQewUhTVJoJ0sBsM6Xg8WHkTA//pgdlRP729usWKopVvUCUa4CDcrwMIJEMCz5+B+scWa1w==
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        daniel.thompson@linaro.org
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
 <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
 <20180205041734.GD28462@vireshk-i7>
 <911804cd-2f1d-a1f7-61a2-6c8b95a88d6b@linaro.org>
 <20180206042853.GI28462@vireshk-i7>
 <54081703-c48f-3e07-b79d-3a2831bc28d7@linaro.org>
 <20180207072606.GO28462@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <93e62f8b-bba6-96e6-0011-84504041930a@linaro.org>
Date: Wed, 7 Feb 2018 11:05:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207072606.GO28462@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 08:26, Viresh Kumar wrote:
> On 06-02-18, 11:48, Daniel Lezcano wrote:
>> On 06/02/2018 05:28, Viresh Kumar wrote:
> 
>>> Surely we can do one thing at a time if that's the way we choose to do it.
>>
>> Easy to say :)
>>
>> The current code is to introduce the feature without impacting the DT
>> bindings in order to keep focused on the thermal mitigation aspect.
>>
>> There are still a lot of improvements to do after that. You are
>> basically asking me to implement the copy-on-write before the memory
>> management is complete.
> 
> Perhaps I wasn't clear. What I was trying to say is that we can do "one thing at
> a time" if we choose to create a "combo device" (the way you proposed). I am not
> trying to force you to solve all the problems in one go :)

Oh, ok :)

>> Can you give an example? Or your understanding is incorrect or I missed
>> the point.
> 
> So I tried to write it down and realized I was assuming that different
> cooling-maps can be provided for different cooling strategies
> (cpufreq/cpuidle) and obviously that's not the case as its per device.
> Not sure if it would be correct to explore the possibility of doing
> that.
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
