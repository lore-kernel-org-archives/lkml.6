Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeDKI6g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:58:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36668 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeDKI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:58:33 -0400
X-Google-Smtp-Source: AIpwx4+aQj0slxY45aSAOQJKaRZX/KwcmiPYWQz6L2FkrTorJOpVbyLLyW4nRCorZEth+iN1282Puw==
Subject: Re: [PATCH v3 4/7] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-5-git-send-email-daniel.lezcano@linaro.org>
 <20180411061851.GM7671@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8bee8335-43aa-f9ef-e0cb-a390440b2aec@linaro.org>
Date: Wed, 11 Apr 2018 10:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411061851.GM7671@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2018 08:18, Viresh Kumar wrote:
> On 05-04-18, 18:16, Daniel Lezcano wrote:
>> The next changes will add new way to cool down a CPU. In order to
>> sanitize and make the overall cpu cooling code consistent and robust
>> we must prevent the cpu cooling devices to co-exists with the same
>> purpose at the same time in the kernel.
>>
>> Make the CPU cooling device a choice in the Kconfig, so only one CPU
>> cooling strategy can be chosen.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig       | 20 +++++++++++++++++---
>>  drivers/thermal/cpu_cooling.c |  2 ++
>>  include/linux/cpu_cooling.h   |  6 +++---
>>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> I don't see my review comments from V2 being addressed for this patch.
> Can you please check that again ?

Right, I missed the end of the email :/

I will fix that.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
