Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeBWJLk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:11:40 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:44118 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeBWJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:11:37 -0500
X-Google-Smtp-Source: AH8x22604/co+id3wiMyIDT2B6K6ceVp0PV9fo1sD+ay7vSVJf1qcVoOhEQ97D2VXbZTd41vO+xN2g==
Subject: Re: [PATCH V2 0/7] CPU cooling device new strategies
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, kevin.wangtao@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, amit.kachhap@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        javi.merino@kernel.org, Zhang Rui <rui.zhang@intel.com>,
        daniel.thompson@linaro.org, Linux PM list <linux-pm@vger.kernel.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <CAOh2x=mDbE=DpRc7Jseccc_VNuq8XOQcCE4xLbJXAuqR8k=+NA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <045f03ab-f7f1-c817-dda7-2b7c74e7a7e1@linaro.org>
Date: Fri, 23 Feb 2018 10:11:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOh2x=mDbE=DpRc7Jseccc_VNuq8XOQcCE4xLbJXAuqR8k=+NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2018 06:26, Viresh Kumar wrote:
> On Wed, Feb 21, 2018 at 8:59 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> Changelog:
>>   V2:
>>      - Dropped the cpu combo cooling device
>>      - Added the acked-by tags
>>      - Replaced task array by a percpu structure
>>      - Fixed the copyright dates
>>      - Fixed the extra lines
>>      - Fixed the compilation macros to be reused
>>      - Fixed the list node removal
>>      - Massaged a couple of function names
> 
> There are few patches in this series, including the cover-letter,
> where your script
> forgot to cc me and probably other cpu-cooling maintainers.
> 
> Maybe just explicitly cc us all next time :)

Ah, sorry for that. Will take care next time.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
