Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeEAHF2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 03:05:28 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56873 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751340AbeEAHF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 03:05:26 -0400
X-ME-Sender: <xms:tRHoWpegVXiBmFrY6FtsJpwHWgzQRMcntq1iJUKTeIzS7NJ92EauMw>
Date: Tue, 1 May 2018 17:05:21 +1000
From: tcharding <me@tobin.cc>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hashed pointer issues
Message-ID: <20180501070521.GA3791@eros>
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home>
 <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
 <1e0bc2e2-a0d8-16b7-b6a4-cf97ecd99cef@infradead.org>
 <CA+55aFzezp7OCpK7HFFQ7LeUZZyFACrhx6px_ZFq5zgoNTwEVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzezp7OCpK7HFFQ7LeUZZyFACrhx6px_ZFq5zgoNTwEVw@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:12:05PM +0000, Linus Torvalds wrote:
> On Mon, Apr 30, 2018 at 10:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 04/30/2018 10:01 AM, Linus Torvalds wrote:
> > >
> > > No kernel command line needed in practice any more. That's assuming any
> > > kernel developer will have an IvyBridge or newer.
> 
> > any paid kernel developer :)
> 
> I suspect a lot of hobbyists too - it's not like ivy bridge is particularly
> new.
> 
> But if not, we can burn that bridge when we get to it.
> 
> Also, if you're not paid to do it, I don't think you'll be working a lot of
> error trace buffers during bootup. There are definitely more interesting
> parts of the kernel to play with ;)

Turns out my desktop (dev) machine is pretty old. RDRAND is only
available on 'newer' Core i5  

	"Intel Secure Key was added in Broadwell, so you need that or any later
	generation. Broadwell generation means Intel Core i5 or i7 where the
	4-digit number appended to it starts with a "5"."

	https://superuser.com/questions/999515/what-instruction-set-architecture-isa-is-rdrand-and-rdseed-part-of


Lucky the laptop is newer, RDRAND is supported on core M5Y70.


	Tobin
