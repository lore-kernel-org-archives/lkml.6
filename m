Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeBTHmM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:42:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36816 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBTHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:42:11 -0500
X-Google-Smtp-Source: AH8x224+J7hVy4A+bkuYUoJadkK3yWANxE2zeKGpBqj1DiwZ3IKNIJQSPyFJYhlJJDeqZQ9RPPTGsIagRKGlQBWbnNk=
MIME-Version: 1.0
In-Reply-To: <1518985080.1894.40.camel@perches.com>
References: <20180217193955.shfhvp3afwiurzfm@gmail.com> <CAOFm3uHHzfV3R3Q9AyhzDLp0uKNHpSTp2MsY3uSL+YsBL6w+dg@mail.gmail.com>
 <CAMuHMdUpRpa7HtbvMxv3yThMb54-aEiVtvD3QFpdnmVi-uBLfQ@mail.gmail.com> <1518985080.1894.40.camel@perches.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 20 Feb 2018 08:41:29 +0100
Message-ID: <CAOFm3uEEfonZnYWEO+T53+JkpkfBwgHQZv6upWGeJm1QNH0nZA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Replace licenses with SPDX identifiers
To: Joe Perches <joe@perches.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Linus Walleij <triad@df.lth.se>,
        robin@protonic.nl, Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 9:18 PM, Joe Perches <joe@perches.com> wrote:
> On Sun, 2018-02-18 at 20:37 +0100, Geert Uytterhoeven wrote:
>> Hi Philippe,
>>
>> On Sun, Feb 18, 2018 at 8:04 PM, Philippe Ombredanne
>> <pombredanne@nexb.com> wrote:
>> > On Sat, Feb 17, 2018 at 8:39 PM, Miguel Ojeda
>> > <miguel.ojeda.sandonis@gmail.com> wrote:
>> > > Cc: Willy Tarreau <w@1wt.eu>
>> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> > > Cc: Linus Walleij <triad@df.lth.se>
>> > > Cc: Robin van der Gracht <robin@protonic.nl>
>> > > Cc: Paul Burton <paul.burton@mips.com>
>> > > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> > > ---
>> >
>> > <snip>
>> >
>> > > diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
>> > > index b454dfce60d9..aa960efc32f6 100644
>> > > --- a/include/linux/cfag12864b.h
>> > > +++ b/include/linux/cfag12864b.h
>> > > @@ -1,25 +1,11 @@
>> > > +// SPDX-License-Identifier: GPL-2.0
>> >
>> > Per the doc [1] you should be using instead this in a .h:
>> > /* SPDX-License-Identifier: GPL-2.0 */
>> >
>> > I know this can be surprising. This has been discussed on list quite
>> > lot and the doc has some rationale.
>> >
>> > <snip>
>> >
>> > > diff --git a/include/linux/ks0108.h b/include/linux/ks0108.h
>> > > index cb311798e0bc..2a1c985fedea 100644
>> > > --- a/include/linux/ks0108.h
>> > > +++ b/include/linux/ks0108.h
>> > > @@ -1,25 +1,11 @@
>> > > +// SPDX-License-Identifier: GPL-2.0
>> >
>> > Same comment as above.
>> >
>> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
>> >
>>
>> Obviously we need a check in scripts/checkpatch.pl, to catch this
>> before submission...
>>
>> Care to send a patch?
>
> There's one already in progress.
> https://lkml.org/lkml/2018/2/8/712
>


And I will try to help there as much as I can. Time to dust off my Perl!
-- 
Cordially
Philippe Ombredanne
