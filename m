Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeBRT5L (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:57:11 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42996 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeBRT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:57:10 -0500
X-Google-Smtp-Source: AH8x225y60sbWmVJAXOJsF+Spe0flVaObZXMauZfmDimil4NlxzIYcaiuOd34xf3MLPd/T14R8AH4k7tRhHVc6CuEcY=
MIME-Version: 1.0
In-Reply-To: <CAOFm3uHHzfV3R3Q9AyhzDLp0uKNHpSTp2MsY3uSL+YsBL6w+dg@mail.gmail.com>
References: <20180217193955.shfhvp3afwiurzfm@gmail.com> <CAOFm3uHHzfV3R3Q9AyhzDLp0uKNHpSTp2MsY3uSL+YsBL6w+dg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Feb 2018 20:56:49 +0100
Message-ID: <CANiq72m_jEyf9SBAOZEpCQ2gHptZVS4nQFhUxcOUdsuMWkC_Ww@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Replace licenses with SPDX identifiers
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <triad@df.lth.se>, robin@protonic.nl,
        Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 8:04 PM, Philippe Ombredanne
<pombredanne@nexb.com> wrote:
> Miguel,
>
> On Sat, Feb 17, 2018 at 8:39 PM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> Cc: Willy Tarreau <w@1wt.eu>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Linus Walleij <triad@df.lth.se>
>> Cc: Robin van der Gracht <robin@protonic.nl>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> ---
>
> <snip>
>
>> diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
>> index b454dfce60d9..aa960efc32f6 100644
>> --- a/include/linux/cfag12864b.h
>> +++ b/include/linux/cfag12864b.h
>> @@ -1,25 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0
>
> Per the doc [1] you should be using instead this in a .h:
> /* SPDX-License-Identifier: GPL-2.0 */
>
> I know this can be surprising. This has been discussed on list quite
> lot and the doc has some rationale.

Thanks for taking the time to check the patch. It was a mistake on my
side -- I had actually read the docs but I recalled Linus talking
about moving to // at some point (and somehow my brain recorded that
the discussion was about the headers :-), so I thought I was actually
doing the right thing by using // already. Don't worry, I will fix it
when I put it in the queue.

Cheers,
Miguel

>
> <snip>
>
>> diff --git a/include/linux/ks0108.h b/include/linux/ks0108.h
>> index cb311798e0bc..2a1c985fedea 100644
>> --- a/include/linux/ks0108.h
>> +++ b/include/linux/ks0108.h
>> @@ -1,25 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0
>
> Same comment as above.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
>
> --
> Cordially
> Philippe Ombredanne
