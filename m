Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeFEJeo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:34:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48056 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeFEJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:34:42 -0400
Subject: Re: [PATCH 8/9] extcon: usbc-cros-ec: Switch to SPDX identifier.
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <CGME20180605092225epcas5p3fd3b4614d8715ad6b5862a6d73beec15@epcas5p3.samsung.com>
 <20180605092209.22887-9-enric.balletbo@collabora.com>
 <5B165834.7000705@samsung.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <69b78abb-a057-025a-46ec-6c73bac2faff@collabora.com>
Date: Tue, 5 Jun 2018 11:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B165834.7000705@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/18 11:30, Chanwoo Choi wrote:
> On 2018년 06월 05일 18:22, Enric Balletbo i Serra wrote:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/extcon/extcon-usbc-cros-ec.c | 20 +++++---------------
>>  1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
>> index 6721ab01fe7d..1a4888f2fe40 100644
>> --- a/drivers/extcon/extcon-usbc-cros-ec.c
>> +++ b/drivers/extcon/extcon-usbc-cros-ec.c
>> @@ -1,18 +1,8 @@
>> -/**
>> - * drivers/extcon/extcon-usbc-cros-ec - ChromeOS Embedded Controller extcon> - *
>> - * Copyright (C) 2017 Google, Inc
>> - * Author: Benson Leung <bleung@chromium.org>
>> - *
>> - * This software is licensed under the terms of the GNU General Public
>> - * License version 2, as published by the Free Software Foundation, and
>> - * may be copied, distributed, and modified under those terms.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - */
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// ChromeOS Embedded Controller extcon
>> +//
>> +// Copyright (C) 2012 Google, Inc.
> 
> 2012 is right?

No, sorry, copy paste error.
> The original copyright has '2017' year information.
> 

Should be 2017.

>> +// Author: Benson Leung <bleung@chromium.org>
>>  
>>  #include <linux/extcon-provider.h>
>>  #include <linux/kernel.h>
>>
> 
> 
