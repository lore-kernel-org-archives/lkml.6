Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbeC1PK2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:10:28 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53518 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeC1PK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:10:26 -0400
X-Google-Smtp-Source: AIpwx4/2QeO5suc2rv8iIOmIp5IcjNbv/PRF0toNTPibNThlZLAIuM6iQzfrN3HLcsKgPl4J/Tx0gw==
Subject: Re: [PATCH v4 0/8] Ingenic JZ47xx Timer/Counter Unit drivers
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
 <aeb57b92-6932-9774-dc50-7563d30846bf@linaro.org>
 <2fb3344b4034385ed89bcdf7da2347d4@crapouillou.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6a0ac21b-1dbc-9821-0951-fe5e9ac34bd3@linaro.org>
Date: Wed, 28 Mar 2018 17:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2fb3344b4034385ed89bcdf7da2347d4@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2018 17:01, Paul Cercueil wrote:
> Le 2018-03-18 23:13, Daniel Lezcano a écrit :
>> On 18/03/2018 00:28, Paul Cercueil wrote:
>>> Hi,
>>>
>>> This is the 4th version of my TCU patchset.
>>>
>>> The major change is a greatly improved documentation, both in-code
>>> and as separate text files, to describe how the hardware works and
>>> how the devicetree bindings should be used.
>>>
>>> There are also cosmetic changes in the irqchip driver, and the
>>> clocksource driver will now use as timers all TCU channels not
>>> requested by the TCU PWM driver.
>>
>> Hi Paul,
>>
>> I don't know why but you series appears in reply to [PATCH v3 2/9]. Not
>> sure if it is my mailer or how you are sending the patches but if it is
>> the latter can you in the future, when resending a new version, not use
>> the in-reply-to option. It will be easier to follow the versions.
>>
>> Thanks.
>>
>>  -- Daniel
> 
> Hi Daniel,
> 
> I guess I did a mistake. I always reply to the first patch of the previous
> version of the patchset (is that correct?).

It depends, if you have a threaded view of emails, it is not easy to
review the patches when they are in several levels. Usually you can see
the patches is top posted without in-reply-to every version.

You can use in-reply-to to an email suggesting a change in order to give
context.

For the v4 series of these drivers, I'm lost :/


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
