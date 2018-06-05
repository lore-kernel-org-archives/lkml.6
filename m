Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeFELFc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:05:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeFELFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:05:31 -0400
Subject: Re: [PATCH] drm/bridge: analogix-anx78xx: Switch to SPDX identifier.
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
References: <20180605100051.4023-1-enric.balletbo@collabora.com>
 <1896069.8N7yzJMC7C@avalon>
 <f7f92ca9-adee-42c3-f822-0ce5ce85a69a@collabora.com>
 <4268268.FVg14MziXp@avalon>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fa5df3cc-e10e-fc3a-3fd1-f5cf74f5cc9c@collabora.com>
Date: Tue, 5 Jun 2018 13:05:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4268268.FVg14MziXp@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 05/06/18 12:33, Laurent Pinchart wrote:
> Hi Enric,
> 
> On Tuesday, 5 June 2018 13:27:06 EEST Enric Balletbo i Serra wrote:
>> On 05/06/18 12:11, Laurent Pinchart wrote:
>>> On Tuesday, 5 June 2018 13:00:50 EEST Enric Balletbo i Serra wrote:
>>>> Adopt the SPDX license identifier headers to ease license compliance
>>>> management.
>>>>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>>  drivers/gpu/drm/bridge/analogix-anx78xx.c | 24 ++++++++---------------
>>>>  1 file changed, 8 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c
>>>> b/drivers/gpu/drm/bridge/analogix-anx78xx.c index
>>>> b49043866be6..54d7e7981bed 100644
>>>> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
>>>> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
>>>> @@ -1,19 +1,11 @@
>>>> -/*
>>>> - * Copyright(c) 2016, Analogix Semiconductor.
>>>> - *
>>>> - * This program is free software; you can redistribute it and/or modify
>>>> - * it under the terms of the GNU General Public License version 2 and
>>>> - * only version 2 as published by the Free Software Foundation.
>>>> - *
>>>> - * This program is distributed in the hope that it will be useful,
>>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> - * GNU General Public License for more details.
>>>> - *
>>>> - * Based on anx7808 driver obtained from chromeos with copyright:
>>>> - * Copyright(c) 2013, Google Inc.
>>>> - *
>>>> - */
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>
>>> This looks good to m.
>>>
>>>> +// Driver for ANX78xx SlimPort transmitter.
>>>> +//
>>>> +// Copyright (C) 2016 Analogix Semiconductor.
>>>> +// Copyright (C) 2016 Google, Inc.
>>>
>>> Should the last line be 2013, not 2016 ?
>>
>> Yes, my bad.
>>
>>>> +//
>>>> +// Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>
>>> I don't think there's a need to convert the whole comment block to
>>> C++-style.
>>
>> Seems that putting everything as // is Linus Torvalds' preferred style:
>> https://lkml.org/lkml/2017/11/25/133
>>
>> But if you want I change, I don't mind to use the c style instead, just let
>> me know.
> 
> As usual with coding styles, it's a matter of preferences, feelings, and 
> getting used to changes. I personally dislike C++-style comments in kernel 
> sources. The fact that we have few of them makes them seem out of place, and 
> thus disturb code reading. My preferences might change if the style becomes 
> more prominent and I get used to it. Or maybe not :-)
> 
> This being said, I'd personally keep changes minimal here, and give the last 
> word to the driver maintainer(s) as for any coding style matter.
> 

Thanks to share your opinion. For coherence I'd personally use the // style, for
two reasons. The first one is because I already sent some similar patches for
other drivers/files I am maintaining and I used this format. The second one, is
because I have received some complaints (on other subsystem) when I used the
c-style format.

But again, I'll let the final decision to Archit and Andrzej as drm/bridge
maintainers and send a v2 after know his opinion.

Best regards,
 Enric

>>>>  #include <linux/delay.h>
>>>>  #include <linux/err.h>
>>>>  #include <linux/interrupt.h>
> 
