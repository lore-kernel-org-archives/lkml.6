Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeBEIzs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:55:48 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:35609 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeBEIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:55:40 -0500
Date: Mon, 5 Feb 2018 09:55:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Ahmed <karahmed@amazon.de>, sironi@amazon.de,
        the arch/x86 maintainers <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] KVM: x86: Reduce retpoline performance impact in
 slot_handle_level_range()
Message-ID: <20180205085526.GG2249@hirez.programming.kicks-ass.net>
References: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk>
 <CA+55aFwg88mxuOiJSh+xLnAfqEwAC-ReB9rdNx+r8fy=FTSHJw@mail.gmail.com>
 <CA+55aFwqCc1UOkdBjEgiuL9fMkRj7RPrGFYQ376YhrqTUpLwrg@mail.gmail.com>
 <1517599033.31953.71.camel@infradead.org>
 <20180202212321.5186c13c@alans-desktop>
 <1517669207.31953.120.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517669207.31953.120.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 02:46:47PM +0000, David Woodhouse wrote:
> Yeah. I'm keen on being able to use something like alternatives to
> *change* 'usualfunction' at runtime though. I suspect it'll be a win
> for stuff like dma_ops.

That shouldn't be too hard to implement.
