Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDDKT6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:19:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeDDKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:19:57 -0400
Date: Wed, 4 Apr 2018 12:19:54 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT pull] irq updates for 4.17
In-Reply-To: <CA+55aFxRZQgPwtjS0+eiCZvkEVFvOKktuiwG4TZ653Yso3E4bA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804041215180.2056@nanos.tec.linutronix.de>
References: <CA+55aFynLQp=n0_e=AQfMpwsGpCLhgFsw3uGPfuVCS1wJD3v4w@mail.gmail.com> <mhng-99170edc-de54-4394-aaae-555658220549@palmer-si-x1c4> <CA+55aFxRZQgPwtjS0+eiCZvkEVFvOKktuiwG4TZ653Yso3E4bA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018, Linus Torvalds wrote:
> On Tue, Apr 3, 2018 at 6:51 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > Thanks!  The linked patch set should be fully bisectable, while this one
> > will fail on some ARM randconfigs.
> 
> If it's only some (not very realistic) randconfigs, I suspect an
> incremental fix is probably the easier solution, rather than redoing
> that whole branch.
> 
> So mind at least sending that incremental fix on top of the branch to
> Thomas and making his life easier if he decides to go that way?
> 
> And if Thomas is busy doing something else (*), and I come back to
> this tomorrow as-is, I'd want to pull his tree and just apply the
> incremental fix anyway, so it makes sense to send it to me as well.
> 
>                     Linus
> 
> (*) I have long since accepted that some people have a life outside of
> kernel development too, and don't always reply immediately. I may not
> _understand_ it, but I am resigned to the fact.

I briefly returned from that other life and applied the 3 patches on top
after massaging the changelogs a bit and pushed everything out for you to
pull.

Thanks,

	tglx
