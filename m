Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeFENbQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:31:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeFENbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:31:14 -0400
Date: Tue, 5 Jun 2018 15:31:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 0/7] atomics: generate atomic headers
Message-ID: <20180605133101.GM12258@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <CACT4Y+Y_p1x-gZW7V3hm9jvC2k7pKUNh37_b8KBTywxkd0OKqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y_p1x-gZW7V3hm9jvC2k7pKUNh37_b8KBTywxkd0OKqg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 06:21:22PM +0200, Dmitry Vyukov wrote:
> On Tue, May 29, 2018 at 8:07 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > While the diff stat looks like a huge addition, the scripting comes in
> > at ~800 lines in total, including the fallback definitions, so we're
> > removing ~1000 lines of hand-written code. At the same time, we fill in
> > gaps in the atomic_long API, and the instrumented atomic wrappers.

> Wow! Nice work!

Indeed, looking good Mark, thanks!
