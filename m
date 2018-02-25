Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeBYMks (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 07:40:48 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43863 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeBYMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 07:40:47 -0500
X-Google-Smtp-Source: AG47ELuxL6/omadWpHCyLek41Jt+D7dNcMe6WI0W5IgM4Zmw5LylS8XJBiDzAJpW84v6rBC9I3P+XzHfxS3qzn8zu28=
MIME-Version: 1.0
In-Reply-To: <CANiq72mKWerHDO-TARJ3ixSmKghpt7E3tK6YW03XPB-mzXBpkA@mail.gmail.com>
References: <20171126025329.32044-1-dja@axtens.net> <CANiq72=dbgyFMqCg0MPihGgdtjZAmAMu-ZpNkaTu17W1o9rYRg@mail.gmail.com>
 <87r2pah1c2.fsf@linkitivity.dja.id.au> <CANiq72mKWerHDO-TARJ3ixSmKghpt7E3tK6YW03XPB-mzXBpkA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Feb 2018 13:40:26 +0100
Message-ID: <CANiq72mz3oHhKBHRG6jsOpoBFmgGkNZtp8UbVjSXNwesrUQBnQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: img-ascii-lcd: add MODULE_LICENSE("GPL")
To: Daniel Axtens <dja@axtens.net>
Cc: Paul Burton <paul.burton@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 1:25 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sat, Feb 24, 2018 at 4:08 PM, Daniel Axtens <dja@axtens.net> wrote:
>> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
>>
>>> Hi Daniel,
>>>
>>> On Sun, Nov 26, 2017 at 3:53 AM, Daniel Axtens <dja@axtens.net> wrote:
>>>> This matches the header at the top of the file and squashes:
>>>>
>>>> WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
>>>> see include/linux/module.h for more information
>>>>
>>>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>>>> ---
>>>>  drivers/auxdisplay/img-ascii-lcd.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
>>>> index db040b378224..7315ffa79537 100644
>>>> --- a/drivers/auxdisplay/img-ascii-lcd.c
>>>> +++ b/drivers/auxdisplay/img-ascii-lcd.c
>>>> @@ -441,3 +441,5 @@ static struct platform_driver img_ascii_lcd_driver = {
>>>>         .remove = img_ascii_lcd_remove,
>>>>  };
>>>>  module_platform_driver(img_ascii_lcd_driver);
>>>> +
>>>> +MODULE_LICENSE("GPL");
>>>
>>> This was submitted just a few days before yours, and now it is in at
>>> 09c479f7f1fbfaf848e5813996793966cd50be81
>>> ("auxdisplay: img-ascii-lcd: add missing
>>> MODULE_DESCRIPTION/AUTHOR/LICENSE").
>>>
>>> In any case, thanks for the patch! :-)
>>
>> Thanks!
>>
>> I was submitting the patches in part because I was considering
>> submitting a change that made the license warning a fatal error and I
>> wanted to make sure I had covered the obvious missing ones first.
>>
>> Would making the warning fatal impact on you?
>
> drivers/auxdisplay/arm-charlcd.c is missing MODULE_LICENSE. I will
> send the patch for that which should be in for 4.17.

Never mind that, it is builtin.

So all is good for drivers/auxdisplay already.

Cheers,
Miguel

>
> Apart from that one, the rest of drivers/auxdisplay is fine.
>
> Cheers,
> Miguel
>
>>
>> Regards,
>> Daniel
>>>
>>> Cheers,
>>> Miguel
>>>
>>>> --
>>>> 2.11.0
>>>>
