Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDXPBE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:01:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36218 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDXPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:01:01 -0400
Date: Tue, 24 Apr 2018 17:00:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Genki Sky <sky@genki.is>
cc: John Stultz <john.stultz@linaro.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
In-Reply-To: <24d89dd95ab246e98562a14be05a602e@genki.is>
Message-ID: <alpine.DEB.2.21.1804241659340.1679@nanos.tec.linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com> <2580c734d38041e984215ccc522a4f2d@genki.is> <cef78d739d29410cb73072e9792598a7@genki.is> <CALAqxLWmcmiOgbH1Ri+Ki-OGFvgzRzRDzX3FZdUhcqu1OoCWiA@mail.gmail.com>
 <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de> <24d89dd95ab246e98562a14be05a602e@genki.is>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Genki Sky wrote:
> Sorry to have been the bearer of bad news :(.

No problem. We're not shooting the messengers

> Again, I just have my user hat on here. It does seem like this unifying
> would have been nice to have. And even, more compliant with the POSIX
> definition of MONOTONIC...

Yes, that was the idea

> On that note, maybe it is still worth introducing MONOTONIC_ACTIVE,
> but just as an alias for MONOTONIC for now. It's also more
> self-documenting. Then sometime in the future, if people switch over,
> remove BOOTTIME and make MONOTONIC like BOOTTIME. Though this doesn't
> help simplify the code, I know.

It doesn't and it does not make applications magically make use of
MONOTONIC_ACTIVE. We're in a trap here.....

Thanks,

	tglx
