Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AH8x225wd+tPiIFOt/tzg4RNl9ScGdcVcd1t1mpCOvMPpVidyK6n9iGK1Tksf04NzXOY8aeJ9TAm
ARC-Seal: i=1; a=rsa-sha256; t=1519380920; cv=none;
        d=google.com; s=arc-20160816;
        b=1J3DlkHDVJr24CVLZHv1b8xWteaVJgx/1ZDFucnellgstzOIYc4d/2H9jqFLPgxH/M
         LYbv14mHCG/L1WMSgLFrGj+xOCJw4Xk0k3bHMS7O0CpYNbBHC4IotOGOpYro6J8uSo14
         wHfFAG7m5yvJblTz382ITXenirton3Df9rgtX8xoPS1zvNY8ISw10hetl33csBsShPox
         ByeWgw5+BgqSjwVFz08Ad3w17ndLmCMVMWkXLMxOj9wNs1X+x564Nw3FqZGMTQh9AV/s
         2WuixKsX2CiN8j1Dv0Hjz1URwt63KFRMeakuvWefQgz+1bmlZNjvlgFMLnO3RNTjB7d3
         3b8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=0wYJIxxbYUOV5VymUcCeox3y2hkyB9w/rel0MApziO4=;
        b=r5oFqG+ohCaSOPzq2Y9iu0E2tKC7LnN5NiHIuLMsjOcYz+pZ72ZdswSUQx3mUR4Oay
         EGL21PfPW9OByPhQay+CXQKNlv8Clg5ZI1Vm3L4bRqamSaIZg34myM6/dj0XGtXUGgKe
         2CZpM/IuxW2rqE77NiYx8BfOVH/Q3CpD4gSHtKFV3aYleuz4k6gISUBn6im4P5hWMl+3
         icbEvF7c8Aks1RQVnTNLuurjRVPXRk9bShnbpFFZOMpkk5GdwIG2SX2eNJKCKX0gyqK/
         fOO9mzwSAPB6BX5YFb8zu7AsnuT74Zm7CGZNcgZlECRu84QXitVQaToQUjNZKUwAeXxU
         l/6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.12 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.12 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: eballetbo@gmail.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <62133c5df4b7c55c51e2190d9582dc4b>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A8FE9A9.8070007@rock-chips.com>
Date: Fri, 23 Feb 2018 18:15:05 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Enric Balletbo Serra <eballetbo@gmail.com>,
 Brian Norris <briannorris@chromium.org>
CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Brian Norris <briannorris@google.com>, dtor@google.com,
 Doug Anderson <dianders@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>,
 stephen lu <lumotuwe@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 linux-input@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com> <20180210110907.5504-2-jeffy.chen@rock-chips.com> <20180212221309.GA66974@ban.mtv.corp.google.com> <059e2aa9-bf94-517d-a132-abe851ec69f7@collabora.com> <20180213182521.GA51247@rodete-desktop-imager.corp.google.com> <CAFqH_52iUc3HQmTSoFQ5FOf5gJECf3nuPY2_ks6NrwFC4oudug@mail.gmail.com>
In-Reply-To: <CAFqH_52iUc3HQmTSoFQ5FOf5gJECf3nuPY2_ks6NrwFC4oudug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1593186367663880674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Enric,

Thanks for your reply.

On 02/14/2018 06:25 AM, Enric Balletbo Serra wrote:
> Hi,
>
> 2018-02-13 19:25 GMT+01:00 Brian Norris <briannorris@chromium.org>:
>> Hi Enric,
>>
>> On Tue, Feb 13, 2018 at 11:40:44AM +0100, Enric Balletbo i Serra wrote:
>>> On 12/02/18 23:13, Brian Norris wrote:
>>>> On Sat, Feb 10, 2018 at 07:09:05PM +0800, Jeffy Chen wrote:
>>>>> Add support for specifying event actions to trigger wakeup when using
>>>>> the gpio-keys input device as a wakeup source.
>>>>>
>>>>> This would allow the device to configure when to wakeup the system. For
>>>>> example a gpio-keys input device for pen insert, may only want to wakeup
>>>>> the system when ejecting the pen.
>>>>>
>>>>> Suggested-by: Brian Norris <briannorris@chromium.org>
>>>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> Specify wakeup event action instead of irq trigger type as Brian
>>>>> suggested.
>> [...]
>>> Not sure if you were aware but there is also some discussion related to this,
>>> maybe we can join the efforts?
>>>
>>> v1: https://patchwork.kernel.org/patch/10208261/
>>> v2: https://patchwork.kernel.org/patch/10211147/
>>
>> Thanks for the pointers. IIUC, that's talking about a different problem:
>> how to utilize a GPIO key in level-triggered mode. That touches similar
>> code, but it doesn't really have anything to do with configuring a
>> different wakeup trigger type.
>>
>
> Right, sorry. I see now what you are doing.
>
>> The two patches would need to be reconciled, if they both are going to
>> be merged. But otherwise, I think they're perfectly fine to be separate.
>>
>
> Yes, that's why I got confused, I had those patches applied on my tree
> and when I tried to apply these failed and I wrongly assumed that were
> doing the same. Waiting to test the third version ;)
right, they are not related, and i should add the level irq case after 
that series merged :)

>
> Thanks,
>   Enric
>
>> Brian
>
>
>
