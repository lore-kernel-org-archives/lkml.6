Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeEWLqn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:46:43 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35539 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932716AbeEWLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:46:36 -0400
X-Google-Smtp-Source: AB8JxZrvGp1G9AjPQ7VDyGmXcgPS84RVsuZhqgKBNe2nNv4rn7L5vQtklx+7alGiHApWnFDmvHGkx6AQzKO4IOfGdYY=
MIME-Version: 1.0
In-Reply-To: <2775439f-a37a-3118-3532-a4c2260db53e@linaro.org>
References: <1527030306-3791-1-git-send-email-festevam@gmail.com>
 <1527030306-3791-2-git-send-email-festevam@gmail.com> <2775439f-a37a-3118-3532-a4c2260db53e@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 May 2018 08:46:35 -0300
Message-ID: <CAOMZO5AWv__WYuFTUrnAZBWemC92HEAxjPycSWS48Q9sRhJTTQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] clocksource: timer-imx-gpt: Switch to SPDX identifier
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, May 23, 2018 at 5:06 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 23/05/2018 01:05, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>> ---
>>  drivers/clocksource/timer-imx-gpt.c | 26 ++++++--------------------
>>  1 file changed, 6 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
>> index b63b834..165fbbb 100644
>> --- a/drivers/clocksource/timer-imx-gpt.c
>> +++ b/drivers/clocksource/timer-imx-gpt.c
>> @@ -1,23 +1,9 @@
>> -/*
>> - *  Copyright (C) 2000-2001 Deep Blue Solutions
>> - *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
>> - *  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
>> - *  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License
>> - * as published by the Free Software Foundation; either version 2
>> - * of the License, or (at your option) any later version.
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
>> - * MA 02110-1301, USA.
>> - */
>> +// SPDX-License-Identifier: GPL-2.0+
>> +//
>> +//  Copyright (C) 2000-2001 Deep Blue Solutions
>> +//  Copyright (C) 2002 Shane Nay (shane@minirl.com)
>> +//  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
>> +//  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
>
> Hi Philippe,
>
> I went through the code and didn't find any information about the format
> of the lines following the SPDX, it seems it is relatively free.
>
> Can you confirm the above changes are ok ?

Putting everything as // is Linus' preferred style:
https://lkml.org/lkml/2017/11/25/133

Regards,

Fabio Estevam
