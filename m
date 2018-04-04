Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDDCDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:03:31 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42078 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeDDCDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:03:30 -0400
X-Google-Smtp-Source: AIpwx48lP5XZiTbjmO1rWTDEuZJcm4RwKcFBP3OH2zHJgPeyQvZ830CUYjR4eAz0IOb+f/qdtFVVphUUEurssHqZJg4=
MIME-Version: 1.0
In-Reply-To: <mhng-99170edc-de54-4394-aaae-555658220549@palmer-si-x1c4>
References: <CA+55aFynLQp=n0_e=AQfMpwsGpCLhgFsw3uGPfuVCS1wJD3v4w@mail.gmail.com>
 <mhng-99170edc-de54-4394-aaae-555658220549@palmer-si-x1c4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 19:03:28 -0700
X-Google-Sender-Auth: cMUWYSONXpkmduPQxXX3TvDA_lo
Message-ID: <CA+55aFxRZQgPwtjS0+eiCZvkEVFvOKktuiwG4TZ653Yso3E4bA@mail.gmail.com>
Subject: Re: [GIT pull] irq updates for 4.17
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 6:51 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> Thanks!  The linked patch set should be fully bisectable, while this one
> will fail on some ARM randconfigs.

If it's only some (not very realistic) randconfigs, I suspect an
incremental fix is probably the easier solution, rather than redoing
that whole branch.

So mind at least sending that incremental fix on top of the branch to
Thomas and making his life easier if he decides to go that way?

And if Thomas is busy doing something else (*), and I come back to
this tomorrow as-is, I'd want to pull his tree and just apply the
incremental fix anyway, so it makes sense to send it to me as well.

                    Linus

(*) I have long since accepted that some people have a life outside of
kernel development too, and don't always reply immediately. I may not
_understand_ it, but I am resigned to the fact.
