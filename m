Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeBRTiB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:38:01 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37048 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBRTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:38:00 -0500
X-Google-Smtp-Source: AH8x227XVveMlh0WVmXrD92sN+DW9L1o5Pt/pgiQBMFh2M0VfRQSy4NPSVpEMv4vuXzR9yjCZRajNmd5zAvhxDH12Eg=
MIME-Version: 1.0
In-Reply-To: <CAOFm3uHHzfV3R3Q9AyhzDLp0uKNHpSTp2MsY3uSL+YsBL6w+dg@mail.gmail.com>
References: <20180217193955.shfhvp3afwiurzfm@gmail.com> <CAOFm3uHHzfV3R3Q9AyhzDLp0uKNHpSTp2MsY3uSL+YsBL6w+dg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 18 Feb 2018 20:37:59 +0100
X-Google-Sender-Auth: uFagyqXGF0AMZ_vg0m-H-LG_afk
Message-ID: <CAMuHMdUpRpa7HtbvMxv3yThMb54-aEiVtvD3QFpdnmVi-uBLfQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Replace licenses with SPDX identifiers
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Linus Walleij <triad@df.lth.se>,
        robin@protonic.nl, Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Sun, Feb 18, 2018 at 8:04 PM, Philippe Ombredanne
<pombredanne@nexb.com> wrote:
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

Obviously we need a check in scripts/checkpatch.pl, to catch this
before submission...

Care to send a patch?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
