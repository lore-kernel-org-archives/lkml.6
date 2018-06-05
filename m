Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeFESoC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:44:02 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43039 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeFESoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:44:00 -0400
X-Google-Smtp-Source: ADUXVKLEk+dm859FweHmlsjDn4c55D9tauTBOFbb4h8vUggG1sEQbaOdTLcsT1i3mvunsi0HMs0uqN32RPtVWiO/zFQ=
MIME-Version: 1.0
In-Reply-To: <20180605181526.GA214655@decatoncale.mtv.corp.google.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-8-enric.balletbo@collabora.com> <20180605181526.GA214655@decatoncale.mtv.corp.google.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 5 Jun 2018 11:43:58 -0700
Message-ID: <CAKdAkRT44w1-pEndznkJpvA5L4fweq1NSAeBrSu6LFLw6L3eHQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] extcon: usbc-cros-ec: Switch to SPDX identifier.
To: Benson Leung <bleung@google.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:15 AM, Benson Leung <bleung@google.com> wrote:
> On Tue, Jun 05, 2018 at 07:54:28PM +0200, Enric Balletbo i Serra wrote:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Reviewed-by: Benson Leung <bleung@chromium.org>

It has wrong license tag, I think all ChromeOS drivers as GPL v2 only.

>
>> ---
>>
>> Changes in v2:
>> - [8/9] Fixed wrong copyright year.
>>
>>  drivers/extcon/extcon-usbc-cros-ec.c | 20 +++++---------------
>>  1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
>> index 6721ab01fe7d..ef5a23e46e71 100644
>> --- a/drivers/extcon/extcon-usbc-cros-ec.c
>> +++ b/drivers/extcon/extcon-usbc-cros-ec.c
>> @@ -1,18 +1,8 @@
>> -/**
>> - * drivers/extcon/extcon-usbc-cros-ec - ChromeOS Embedded Controller extcon
>> - *
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
>> +// Copyright (C) 2017 Google, Inc.
>> +// Author: Benson Leung <bleung@chromium.org>
>>
>>  #include <linux/extcon-provider.h>
>>  #include <linux/kernel.h>
>> --
>> 2.17.1
>>
>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org



-- 
Dmitry
