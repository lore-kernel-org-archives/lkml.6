Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeAaHDs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:03:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34759 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeAaHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:03:46 -0500
X-Google-Smtp-Source: AH8x227Smmb3gQfa+sEUHWB1xBL5C2Avhl2T1ApJdm09yCxHbRjXLI5kBFxHXkMWvC2JnF7xBVqAug==
Subject: Re: [PATCH 1/8] thermal/drivers/cpu_cooling: Fixup the header and
 copyright
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-2-git-send-email-daniel.lezcano@linaro.org>
 <20180131051739.GG13395@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9591e879-0d88-4d93-7a4c-f0dc7147f5c2@linaro.org>
Date: Wed, 31 Jan 2018 08:03:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180131051739.GG13395@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2018 06:17, Viresh Kumar wrote:
> On 23-01-18, 16:34, Daniel Lezcano wrote:
>> The copyright format does not conform to the format requested by
>> Linaro: https://wiki.linaro.org/Copyright
>>
>> Fix it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/cpu_cooling.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index dc63aba..988fc55 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -2,9 +2,11 @@
>>   *  linux/drivers/thermal/cpu_cooling.c
>>   *
>>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
>> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>>   *
>> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
>> + *  Copyright (C) 2018 Linaro Limited.
>> + *
> 
> Shouldn't this be 2012-2018 ?

Yes, you are right.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
