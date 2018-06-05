Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeFEOWJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:22:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeFEOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:22:05 -0400
Date: Tue, 5 Jun 2018 16:21:54 +0200 (CEST)
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
In-Reply-To: <20180531145253.02daa5d4@vmware.local.home>
Message-ID: <alpine.DEB.2.20.1806051621070.2789@hypnos.tec.linutronix.de>
References: <1527472002-11571-1-git-send-email-me@tobin.cc> <20180531145253.02daa5d4@vmware.local.home>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018, Steven Rostedt wrote:

> On Mon, 28 May 2018 11:46:38 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Steve,
> 
> Hi Tobin,
> 
> Sorry for the late reply, I'm currently at a conference and have had
> little time to read email.
> 
> > 
> > Could you please take a quick squiz at the final 2 patches if you get a
> > chance.  I assumed we are in preemptible context during early_init based
> > on your code (and code comment) and called static_branch_disable()
> > directly if hw RNG returned keying material.  It's a pretty simple
> > change but I'd love to get someone else to check I've not noob'ed it.
> 
> I can take a look, and perhaps do some tests. But it was Anna-Maria
> that originally triggered the issue. She's on Cc, perhaps she can try
> this and see if it works.

I'll test it today - sorry for the delay.

Anna-Maria
