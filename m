Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeDPJpn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:45:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41455 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754803AbeDPJpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:45:40 -0400
X-Google-Smtp-Source: AIpwx4/nEn4YJfDjem7Z2bDwjn3lWvI4kVfsxUGg7w6hPDenhIVnAedzopeASUEbwRuc6JMKNoGLhg==
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
 <20180416093747.GB4244@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
Date: Mon, 16 Apr 2018 11:45:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416093747.GB4244@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 11:37, Viresh Kumar wrote:
> On 16-04-18, 09:44, Daniel Lezcano wrote:
>> Because we rely on the number to identify the cluster and flag it
>> 'processed'. The number itself is not important.
> 
> It is, because you are creating multiple groups (like cpufreq
> policies) right now based on cluster id. Which will be zero for all
> the CPUs. So in a big little system we will have two cpufreq cooling
> devices and one cpuidle cooling device.

Can you elaborate a bit ? I'm not sure to get the point.

BTW, Am I asked to change my code to stick to something which is not
merged ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
