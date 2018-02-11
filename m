Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeBKMTE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 07:19:04 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42676 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753440AbeBKMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 07:19:00 -0500
X-Google-Smtp-Source: AH8x224GI92+1UtfZa9hmPR9D84CRsl80XsnkXKSS5ky0+nGphdRmzXoMstcmXd1aUp+mD6mYokOyfD5iDs49p8/gcI=
MIME-Version: 1.0
In-Reply-To: <1518298282.16865.28.camel@perches.com>
References: <20180210095651.y7kvf3oqp6pzvh33@gmail.com> <634edbaa-f877-8f61-b61c-79e060edf8b5@infradead.org>
 <1518298282.16865.28.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 Feb 2018 13:18:59 +0100
Message-ID: <CANiq72=LHVCob42HPqa453YD7kzX0dZyZxfscT=QS-xYh1u1Rw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: auxdisplay: remove obsolete webpages
To: Joe Perches <joe@perches.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:31 PM, Joe Perches <joe@perches.com> wrote:
> On Sat, 2018-02-10 at 09:32 -0800, Randy Dunlap wrote:
>> On 02/10/2018 01:56 AM, Miguel Ojeda wrote:
>> > Cc: Randy Dunlap <rdunlap@infradead.org>
>> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> Are you merging this directly to Linus?  or what?
>
> A generic negative of these removals, even for ancient
> drivers that may or may not work anymore, is that the
> old links may still be found on things like the
> wayback machine/archive.org.

That is actually a good point. I just tried to pick it up in the
wayback machine and sadly it only saved the error page from Apache
when it was already gone. :(

>
> Miguel, do you have a copy of this link source?
>
> If you do, should it be introduced as a .rst into
> Documentation/ somewhere?

IIRC I had only some example usages and some photos of the device
working with the driver, etc. The docs I wrote are in
Documentation/auxdisplay/ (in particular the wiring required for the
device), so that is fine.

I will see in any case if I have it in my ancient backups :)

Cheers,
Miguel

>
>> Thanks.
>>
>> > ---
>> >  MAINTAINERS | 8 --------
>> >  1 file changed, 8 deletions(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index e6c26cb47d02..01e302f7967e 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -2484,8 +2484,6 @@ F:    kernel/audit*
>> >
>> >  AUXILIARY DISPLAY DRIVERS
>> >  M: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>> > -W: http://miguelojeda.es/auxdisplay.htm
>> > -W: http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>> >  S: Maintained
>> >  F: drivers/auxdisplay/
>> >  F: include/linux/cfag12864b.h
>> > @@ -3373,16 +3371,12 @@ F:  include/linux/usb/wusb*
>> >
>> >  CFAG12864B LCD DRIVER
>> >  M: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>> > -W: http://miguelojeda.es/auxdisplay.htm
>> > -W: http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>> >  S: Maintained
>> >  F: drivers/auxdisplay/cfag12864b.c
>> >  F: include/linux/cfag12864b.h
>
> Another suggestion would be to move
> "include/linux/cfag12864b.h" into drivers/auxdisplay
>
>> >  CFAG12864BFB LCD FRAMEBUFFER DRIVER
>> >  M: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>> > -W: http://miguelojeda.es/auxdisplay.htm
>> > -W: http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>> >  S: Maintained
>> >  F: drivers/auxdisplay/cfag12864bfb.c
>> >  F: include/linux/cfag12864b.h
>> > @@ -7866,8 +7860,6 @@ F:    kernel/kprobes.c
>> >
>> >  KS0108 LCD CONTROLLER DRIVER
>> >  M: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>> > -W: http://miguelojeda.es/auxdisplay.htm
>> > -W: http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>> >  S: Maintained
>> >  F: Documentation/auxdisplay/ks0108
>> >  F: drivers/auxdisplay/ks0108.c
>> >
>>
>>
