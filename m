Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBXPIw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 10:08:52 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37079 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBXPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 10:08:50 -0500
X-Google-Smtp-Source: AH8x227D/dRXGFrEICmkaeqEk9J3yxuHalxmOLm5iluYV28MpIKNP08/9SjVIq+PJjyvOPXzTNukFg==
From: Daniel Axtens <dja@axtens.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Paul Burton <paul.burton@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] auxdisplay: img-ascii-lcd: add MODULE_LICENSE("GPL")
In-Reply-To: <CANiq72=dbgyFMqCg0MPihGgdtjZAmAMu-ZpNkaTu17W1o9rYRg@mail.gmail.com>
References: <20171126025329.32044-1-dja@axtens.net> <CANiq72=dbgyFMqCg0MPihGgdtjZAmAMu-ZpNkaTu17W1o9rYRg@mail.gmail.com>
Date: Sun, 25 Feb 2018 02:08:45 +1100
Message-ID: <87r2pah1c2.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> Hi Daniel,
>
> On Sun, Nov 26, 2017 at 3:53 AM, Daniel Axtens <dja@axtens.net> wrote:
>> This matches the header at the top of the file and squashes:
>>
>> WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
>> see include/linux/module.h for more information
>>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  drivers/auxdisplay/img-ascii-lcd.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
>> index db040b378224..7315ffa79537 100644
>> --- a/drivers/auxdisplay/img-ascii-lcd.c
>> +++ b/drivers/auxdisplay/img-ascii-lcd.c
>> @@ -441,3 +441,5 @@ static struct platform_driver img_ascii_lcd_driver = {
>>         .remove = img_ascii_lcd_remove,
>>  };
>>  module_platform_driver(img_ascii_lcd_driver);
>> +
>> +MODULE_LICENSE("GPL");
>
> This was submitted just a few days before yours, and now it is in at
> 09c479f7f1fbfaf848e5813996793966cd50be81
> ("auxdisplay: img-ascii-lcd: add missing
> MODULE_DESCRIPTION/AUTHOR/LICENSE").
>
> In any case, thanks for the patch! :-)

Thanks!

I was submitting the patches in part because I was considering
submitting a change that made the license warning a fatal error and I
wanted to make sure I had covered the obvious missing ones first.

Would making the warning fatal impact on you?

Regards,
Daniel
>
> Cheers,
> Miguel
>
>> --
>> 2.11.0
>>
