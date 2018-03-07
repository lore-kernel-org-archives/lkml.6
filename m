Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934059AbeCGQV1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:21:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34544 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeCGQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:21:24 -0500
X-Google-Smtp-Source: AG47ELvQlzbDFNFk7SY0ZXin5TOqGfmV6WzBYPq4tJ5WAQZJASGby6xfX0l3q6vqfOJxgREIe/64bA==
Subject: Re: [GIT PULL 2/6] omap timer changes for v4.17
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc: arm-soc <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <pull-1520273005-304551@atomide.com>
 <pull-1520273005-304551@atomide.com-2>
 <CAK8P3a0YwGtE+UkA6+rQ_FQsGO5paL9ub_=oOq_SE3xPUiH1ww@mail.gmail.com>
 <20180307152842.GH5799@atomide.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3c0b7ce1-a34a-6f1a-ff70-dbe2706b5478@linaro.org>
Date: Wed, 7 Mar 2018 17:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307152842.GH5799@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 16:28, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [180307 15:22]:
>> On Mon, Mar 5, 2018 at 7:11 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> From: "Tony Lindgren" <tony@atomide.com>
>>>
>>> The following changes since commit 2fdc82776ac2ac49c5ee666d834718ac36420e49:
>>>
>>>   Merge branch 'omap-for-v.16/dmtimer-fix' into omap-for-v4.17/timer (2018-02-22 10:46:47 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/timer-signed
>>>
>>> for you to fetch changes up to 58a54f03e73d67432216931854363e4ba15839b9:
>>>
>>>   clocksource: timer-ti-dm: Check prescaler value (2018-02-28 13:41:30 -0800)
>>>
>>> ----------------------------------------------------------------
>>> Move omap timer to drivers for 4.17
>>>
>>> This series from Keerthy and Ladislav Michl move omap dmtimer code
>>> to drivers. As we don't want to export custom timer functions to
>>> random drivers, we also need to update the related PWM driver to
>>> pass the timer specific functions in platform data.
>>>
>>> Note that this series is based on a merge of omap1 specific timer
>>> fix and omap2+ platform data clean-up to keep things working and
>>> make the move a bit simpler.
>>
>> I was undecided whether this should be in next/drivers or next/soc,
>> ended up putting it into the latter.
>>
>> I don't see the clocksource maintainers involved in the patch series,
>> so I added them to Cc now to make sure they are aware of the move
>> of the driver.
> 
> OK thanks. We got some comments from Daniel for an earlier set of
> patches in December. No acks though, but hopefully it's good enough
> for further work to happen under drivers/clocksource :)

Yeah, I had a look at the series. There is still work to do but IMO it
is preferable to move it to drivers/clocksource and then continue the
cleanup from there. So I'm fine with it.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
