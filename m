Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031381AbeBNV3V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:29:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53554 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031127AbeBNV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:29:19 -0500
X-Google-Smtp-Source: AH8x224n33ZSWx81+7ui9g/pRx4wPISPf4dixssmNwKqU+NANaInOMOsZNa+/MssZqPVsalmjSK48ru4QbfXUeDcY4I=
MIME-Version: 1.0
In-Reply-To: <CAO-hwJKmrapd-VtbRgsM_zr6mHDvG8eyvdmo=56W_kmURjvX4g@mail.gmail.com>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com> <CAO-hwJKmrapd-VtbRgsM_zr6mHDvG8eyvdmo=56W_kmURjvX4g@mail.gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Wed, 14 Feb 2018 22:28:37 +0100
Message-ID: <CAOFm3uGsCU4eRn-1+DozBy2=OB2U7SurYn3rhmwJ=GWjQkG_1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: add driver for Valve Steam Controller
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin, Rodrigo,

On Wed, Feb 14, 2018 at 3:45 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Tue, Feb 13, 2018 at 1:03 PM, Rodrigo Rivas Costa <rodrigorivascosta@gmail.com> wrote:

<snip>
>> --- /dev/null
>> +++ b/drivers/hid/hid-steam.c
>> @@ -0,0 +1,480 @@
>> +// SPDX-License-Identifier: GPL-2.0
>
> Non standard header

Benjamin:
What do you mean by this?
This is following the proper style for this line as documented (and
discussed on list at great length) [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst


>> +/*
>> + * HID driver for Valve Steam Controller
>> + *
>> + * Supports both the wired and wireless interfaces.
>> + *
>> + * Copyright (c) 2018 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the Free
>> + * Software Foundation; either version 2 of the License, or (at your option)
>> + * any later version.
>> + */

Rodrigo,
Since you used the proper SPDX tag (in the proper style as explained
in the doc), you can remove this boilerplate alright as it does double
duty with the tag.

-- 
Cordially
Philippe Ombredanne
