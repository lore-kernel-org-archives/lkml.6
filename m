Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeCINZH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:25:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37383 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeCINZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:25:06 -0500
X-Google-Smtp-Source: AG47ELssOBlK9N+2SlNyG9G0QmwzmovzNtXTzJrqRcP2Kv0CRmyYaTUn6DTyPOfU97ssuZFCKeyMHg==
Subject: Re: [PATCH v5 2/2] clocksource/drivers/npcm: Add NPCM7xx timer driver
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, venture@google.com,
        Joel Stanley <joel@jms.id.au>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <1520522698-16153-1-git-send-email-tmaimon77@gmail.com>
 <1520522698-16153-3-git-send-email-tmaimon77@gmail.com>
 <2a83eb83-10a9-54f3-e0da-bd6cf32b5ac1@linaro.org>
 <CAP6Zq1gKE0xUGHuwXa7eLEsUisnaaz=QLgs=6uYnUYDGdX5ryw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e2560cb7-8710-88ec-ac94-3e53a8f4b7e8@linaro.org>
Date: Fri, 9 Mar 2018 14:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP6Zq1gKE0xUGHuwXa7eLEsUisnaaz=QLgs=6uYnUYDGdX5ryw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 23:37, Tomer Maimon wrote:
> On 8 March 2018 at 17:33, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 08/03/2018 16:24, Tomer Maimon wrote:
>>> Add Nuvoton BMC NPCM7xx timer driver.
>>>
>>> The clocksource Enable 24-bit TIMER0 and TIMER1 counters,
>>> while TIMER0 serve as clockevent and TIMER1 serve as clocksource.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Reviewed-by: Brendan Higgins <brendanhiggins@xxxxxxxxxx>
>>> ---
>>
>> [ ... ]
>>
>>> +
>>> +     pr_info("Enabling NPCM7xx clocksource timer base: 0x%x, IRQ: %d ",
>>> +             (int)timer_of_base(&npcm7xx_to), timer_of_irq(&npcm7xx_to));
>>
>> You can use '%p' instead of '0x%x' and remove the (int) cast.
> I think we need to use in the pr_info %px, if I use %p I get in the
> kernel boot print "(ptrval)" instead of the address.
> please refer: https://lwn.net/Articles/740249/

Ah yes, right.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
