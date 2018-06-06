Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E94D1606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeFFJVH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:21:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55158 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbeFFJVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:21:05 -0400
Subject: Re: [PATCH v2 6/8] pwm: cros-ec: Switch to SPDX identifier.
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-pwm@vger.kernel.org
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-7-enric.balletbo@collabora.com>
 <20180606090848.GF11810@ulmo>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <32b22e93-d8d3-d20a-f497-723c62d1bd2b@collabora.com>
Date: Wed, 6 Jun 2018 11:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606090848.GF11810@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 06/06/18 11:08, Thierry Reding wrote:
> On Tue, Jun 05, 2018 at 07:54:27PM +0200, Enric Balletbo i Serra wrote:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/pwm/pwm-cros-ec.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
>> index 9c13694eaa24..9bf4cde86765 100644
>> --- a/drivers/pwm/pwm-cros-ec.c
>> +++ b/drivers/pwm/pwm-cros-ec.c
>> @@ -1,12 +1,7 @@
>> -/*
>> - * Copyright (C) 2016 Google, Inc
>> - *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of the GNU General Public License version 2, as published by
>> - * the Free Software Foundation.
>> - *
>> - * Expose a PWM controlled by the ChromeOS EC to the host processor.
>> - */
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Expose a PWM controlled by the ChromeOS EC to the host processor.
>> +//
>> +// Copyright (C) 2016 Google, Inc.
> 
> This is odd. I understand that for some reason there is an exception for
> SPDX license identifies to use C++ style comments, but why would you
> make the whole comment C++ style? Why not just something like the below:
> 

Seems that there is some kind of controversy between different maintainers. I
did in that way because I was complained to use the c-style on other patches,
and seems, that putting everything as // is Linus Torvalds' preferred style:

https://lkml.org/lkml/2017/11/25/133

I don't mind to change if the c-style is preferred by the maintainer (others
prefer the c++ style) but I think that would be good get an agreement between
subsystems maintainers and document properly.

Best regards,
 Enric

> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2016 Google, Inc
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2, as published by
> - * the Free Software Foundation.
> - *
>   * Expose a PWM controlled by the ChromeOS EC to the host processor.
>   */
> 
> Thierry
> 
