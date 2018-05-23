Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbeEWMcc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:32:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35313 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeEWMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:32:26 -0400
X-Google-Smtp-Source: AB8JxZpYXITwDOMgJs8G3/R34bLpkX6QiazMZ2N/TnXW6LJCPTpgberIhwz6PQgX8LVzYavjuGPYZw==
Subject: Re: [PATCH 2/4] clocksource: timer-imx-gpt: Switch to SPDX identifier
To: Fabio Estevam <festevam@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
References: <1527030306-3791-1-git-send-email-festevam@gmail.com>
 <1527030306-3791-2-git-send-email-festevam@gmail.com>
 <2775439f-a37a-3118-3532-a4c2260db53e@linaro.org>
 <CAOMZO5AWv__WYuFTUrnAZBWemC92HEAxjPycSWS48Q9sRhJTTQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <679e1707-fe52-78ad-9923-3a5e4d1af872@linaro.org>
Date: Wed, 23 May 2018 14:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5AWv__WYuFTUrnAZBWemC92HEAxjPycSWS48Q9sRhJTTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2018 13:46, Fabio Estevam wrote:
> Hi Daniel,
> 
> On Wed, May 23, 2018 at 5:06 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 23/05/2018 01:05, Fabio Estevam wrote:
>>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>>
>>> Adopt the SPDX license identifier headers to ease license compliance
>>> management.
>>>
>>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>>> ---
>>>  drivers/clocksource/timer-imx-gpt.c | 26 ++++++--------------------
>>>  1 file changed, 6 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
>>> index b63b834..165fbbb 100644
>>> --- a/drivers/clocksource/timer-imx-gpt.c
>>> +++ b/drivers/clocksource/timer-imx-gpt.c
>>> @@ -1,23 +1,9 @@
>>> -/*
>>> - *  Copyright (C) 2000-2001 Deep Blue Solutions
>>> - *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
>>> - *  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
>>> - *  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
>>> - *
>>> - * This program is free software; you can redistribute it and/or
>>> - * modify it under the terms of the GNU General Public License
>>> - * as published by the Free Software Foundation; either version 2
>>> - * of the License, or (at your option) any later version.
>>> - * This program is distributed in the hope that it will be useful,
>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> - * GNU General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU General Public License
>>> - * along with this program; if not, write to the Free Software
>>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
>>> - * MA 02110-1301, USA.
>>> - */
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +//
>>> +//  Copyright (C) 2000-2001 Deep Blue Solutions
>>> +//  Copyright (C) 2002 Shane Nay (shane@minirl.com)
>>> +//  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
>>> +//  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
>>
>> Hi Philippe,
>>
>> I went through the code and didn't find any information about the format
>> of the lines following the SPDX, it seems it is relatively free.
>>
>> Can you confirm the above changes are ok ?
> 
> Putting everything as // is Linus' preferred style:
> https://lkml.org/lkml/2017/11/25/133

Ok, good. Thanks for the pointer.

I've applied the patches for 4.18.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
