Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBTHbt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:31:49 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36058 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeBTHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:31:47 -0500
X-Google-Smtp-Source: AH8x226zuE1aBsfN0SPzLLO3hHpo12s22VUSyQjU/oh6uZLONbvRWJP+n3BCpJ2/dSUlSeSclpN1OWKqCpatbzrNa1I=
MIME-Version: 1.0
In-Reply-To: <20180217161734.GA671@roeck-us.net>
References: <20180215234400.5022-5-jerry.hoemann@hpe.com> <20180217161734.GA671@roeck-us.net>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 20 Feb 2018 08:31:05 +0100
Message-ID: <CAOFm3uF-7mFPAzRGcGuwQ+tQDvVj_9w4x+xAZBEA4sufDauc4w@mail.gmail.com>
Subject: Re: [v3,04/11] watchdog/hpwdt: white space changes
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Ingo Molnar <mingo@kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry,

On Sat, Feb 17, 2018 at 5:17 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Feb 15, 2018 at 04:43:53PM -0700, Jerry Hoemann wrote:
>> Minor white space changes and some name clean up.
>>
>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>> ---
>>  drivers/watchdog/hpwdt.c | 49 +++++++++++++++++++++++-------------------------
>>  1 file changed, 23 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
>> index 07810caabf74..d5989acf3e37 100644
>> --- a/drivers/watchdog/hpwdt.c
>> +++ b/drivers/watchdog/hpwdt.c
>> @@ -1,11 +1,9 @@
>>  /*
>>   *   HPE WatchDog Driver
>> - *   based on
>>   *
>> - *   SoftDog 0.05:   A Software Watchdog Device
>> - *
>> - *   (c) Copyright 2015 Hewlett Packard Enterprise Development LP
>> + *   (c) Copyright 2018 Hewlett Packard Enterprise Development LP
>>   *   Thomas Mingarelli <thomas.mingarelli@hpe.com>
>> + *   Jerry Hoemann <jerry.hoemann@hpe.com>
>>   *
>>   *   This program is free software; you can redistribute it and/or
>>   *   modify it under the terms of the GNU General Public License

It would be awesome if you could adopt SPDX ids here and in all HPE
existing and future contributions [1] rather than this fine legalese.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
