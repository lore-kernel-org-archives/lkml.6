Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeCEIPb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:15:31 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43513 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeCEIP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:15:28 -0500
X-Google-Smtp-Source: AG47ELvhMqHhnYNmQVa3Y1u3ap+Uqgek8GiVK80eSv4S37LUS/oLV/uMXbhtqhU7re4okGkW6qmjGpvjsCLQp3Y3bRs=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ9WKj5Uz=A2QKctM9H8WFErfo_J_rGSn7B5jig+4gv_w@mail.gmail.com>
References: <CA+55aFz_ww8ohU68Jz34pg_x7gpGpJ+FC-dmS_Rm_VvY01GGpg@mail.gmail.com>
 <20180228191805.20094-1-linux@rasmusvillemoes.dk> <20180228191805.20094-3-linux@rasmusvillemoes.dk>
 <CAK7LNAQ9WKj5Uz=A2QKctM9H8WFErfo_J_rGSn7B5jig+4gv_w@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Mon, 5 Mar 2018 09:15:26 +0100
Message-ID: <CAKwiHFjv7a=+RstT8up7aSctUW5=y0A3nz_FvG=5Jd1DHC07Tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fixdep: do not ignore kconfig.h
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 March 2018 at 05:52, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 2018-03-01 4:17 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
>> kconfig.h was excluded from consideration by fixdep by
>> 6a5be57f0f00 (fixdep: fix extraneous dependencies) to avoid some false
>> positive hits
[...]
>> We've already had one case [2] where the lack of include/linux/kconfig.h in
>> the .o.cmd file caused a missing rebuild,
[...]
>> [2] https://lkml.org/lkml/2018/2/22/838
>
>
> Sorry, I missed to include this series in the Kbuild fixes PR
> I sent two days ago.
>
> I was not tracking the randomize-struct thread.
> I read [2] and I noticed the background of this series just now.
>
> Hopefully, I will have another opportunity of PR
> if this series is necessary for v4.16  (seems so)

I should probably have put 3/3 first, if that is 4.16 material, the
other two can obviously wait for 4.17. They don't really depend on
each other apart from overlapping context, and the above commit
message would need slight rewording if put before the others. I can do
that reordering and resend if you wish.

Rasmus
