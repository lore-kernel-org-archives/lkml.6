Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeFESO3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:14:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50890 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFESO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:14:28 -0400
Subject: Re: [PATCH v2 5/8] Input: cros_ec_keyb - Switch to SPDX identifier.
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-6-enric.balletbo@collabora.com>
 <CAOMZO5ByhMV9_gRHLmGiSNJtCvKEOk==ZMz2O2=tokZh2ps4xg@mail.gmail.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7085d0bb-557c-0796-d3ae-756e000a7950@collabora.com>
Date: Tue, 5 Jun 2018 20:14:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5ByhMV9_gRHLmGiSNJtCvKEOk==ZMz2O2=tokZh2ps4xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 05/06/18 20:04, Fabio Estevam wrote:
> Hi Enric,
> 
> On Tue, Jun 5, 2018 at 2:54 PM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2:
>> - [6/9] Do not remove last paragraph.
>>
>>  drivers/input/keyboard/cros_ec_keyb.c | 34 ++++++++++-----------------
>>  1 file changed, 12 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
>> index 79eb29550c34..91b2839c12df 100644
>> --- a/drivers/input/keyboard/cros_ec_keyb.c
>> +++ b/drivers/input/keyboard/cros_ec_keyb.c
>> @@ -1,25 +1,15 @@
>> -/*
>> - * ChromeOS EC keyboard driver
>> - *
>> - * Copyright (C) 2012 Google, Inc
>> - *
>> - * This software is licensed under the terms of the GNU General Public
>> - * License version 2, as published by the Free Software Foundation, and
> 
> Original text says GPL-2.0...
> 
>> - * may be copied, distributed, and modified under those terms.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * This driver uses the Chrome OS EC byte-level message-based protocol for
>> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
>> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
>> - * but everything else (including deghosting) is done here.  The main
>> - * motivation for this is to keep the EC firmware as simple as possible, since
>> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
>> - * expensive.
>> - */
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> but here you add a GPL-2.0+ type.
> 

Right, but the module license is set to GPL which means GNU Public License v2 or
later, see [1]. So, there is a mismatch. In such cases I assumed GPL-2.0+ as the
default. These mismatches are common so I think that should be fine for the
authors, if someone is disagree just let me know and I will change.

Best regards,
 Enric

[1]
https://elixir.bootlin.com/linux/v4.17/source/drivers/input/keyboard/cros_ec_keyb.c#L677
