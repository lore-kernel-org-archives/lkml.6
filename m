Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B7520874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B7520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756462AbeFSJFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:05:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756178AbeFSJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:05:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 83D512610D8
Subject: Re: [PATCH v2 3/8] mfd: cros_ec: Add or fix SPDX-License-Identifier
 in all files.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-4-enric.balletbo@collabora.com>
 <20180618063750.GH31141@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0ab6b76e-11b3-dc1e-bd14-af69d7dd6a8d@collabora.com>
Date:   Tue, 19 Jun 2018 11:05:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618063750.GH31141@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 18/06/18 08:37, Lee Jones wrote:
> On Tue, 05 Jun 2018, Enric Balletbo i Serra wrote:
> 
>> And get rid of the license text that is no longer necessary. Also fix
>> the license as sometimes doesn't match what the header with the value in
>> the MODULE_LICENSE macro. Assuming that the desired license is GPL-2.0+,
>> all the files are updated to this license version.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/mfd/cros_ec.c                | 26 ++++++++------------------
>>  drivers/mfd/cros_ec_dev.c            | 23 +++++------------------
>>  drivers/mfd/cros_ec_dev.h            | 16 ++--------------
>>  drivers/mfd/cros_ec_i2c.c            | 18 ++++--------------
>>  drivers/mfd/cros_ec_spi.c            | 20 +++++---------------
>>  include/linux/mfd/cros_ec.h          | 10 +---------
>>  include/linux/mfd/cros_ec_commands.h | 10 +---------
>>  include/linux/mfd/cros_ec_lpc_mec.h  | 14 +++-----------
>>  include/linux/mfd/cros_ec_lpc_reg.h  | 14 +++-----------
>>  9 files changed, 32 insertions(+), 119 deletions(-)
>>
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index 58e05069163e..5b6a1c541543 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -1,21 +1,11 @@
>> -/*
>> - * ChromeOS EC multi-function device
>> - *
>> - * Copyright (C) 2012 Google, Inc
>> - *
>> - * This software is licensed under the terms of the GNU General Public
>> - * License version 2, as published by the Free Software Foundation, and
>> - * may be copied, distributed, and modified under those terms.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * The ChromeOS EC multi function device is used to mux all the requests
>> - * to the EC device for its multiple features: keyboard controller,
>> - * battery charging and regulator control, firmware update.
>> - */
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// ChromeOS EC multi-function device.
>> +//
>> +// Copyright (C) 2012 Google, Inc
>> +//
>> +// The ChromeOS EC multi function device is used to mux all the requests
>> +// to the EC device for its multiple features: keyboard controller,
>> +// battery charging and regulator control, firmware update.
> 
> I must admit I haven't seen a great many patches like this.  Is C++
> comments for the SPDX header *and* the Copyright text the done thing
> now then?
> 

There is a bit of mess here, as per documentation, it is clear that the SPDX tag
for .c files should go in C++ style, but for the copyright notice is not clear
and there are differences between subsystems.

Seems that putting everything as // is Linus Torvalds' preferred style [1] but
other maintainers want the copyright in c-style. If you see current status in
the kernel both styles are present.

[1] https://lkml.org/lkml/2017/11/25/133

Best regards,
 Enric








