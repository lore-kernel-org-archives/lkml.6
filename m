Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935408AbeEIPUf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:20:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935065AbeEIPUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:20:33 -0400
Date: Wed, 9 May 2018 17:20:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180509152026.GA12198@hirez.programming.kicks-ass.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
 <20180509084120.GF12217@hirez.programming.kicks-ass.net>
 <20180509084518.247650e2@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509084518.247650e2@lwn.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 08:45:18AM -0600, Jonathan Corbet wrote:
> On Wed, 9 May 2018 10:41:20 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > This is easily done by using "::" instead of just ":".  
> > 
> > And I'll voice my objection once again. This makes a regular comment
> > worse. This rst stuff is utter shit for making normal text files less
> > readable in your favourite text editor.
> > 
> > If this gets merged, I'll simply remove that spurious ':' the next time
> > I'm near that comment.
> 
> Seriously, Peter?

Yep... it makes for pointlessly ugly text. And seeing that the only way
to write code is using text editors, the text editor is the primary
interface to our code.

The whole rst wankery is detrimental to that interface in order to
pander to something else.. I don't see the value. I've objected before,
and I suppose I'll object again.

> It's a simple colon.  It goes along with the /** marker for kerneldoc
> comments and the @ markers found within them, both of which you seem to
> have found a way to live with.

Barely, and personally I tend to not bother with kerneldoc much. Most of
the comments I write lack the extra *, and I note that the other fix to
this problem it to drop that spurious * here as well.

The @arg thing is okay, it clearly distinguishes arguments/variable
names from regular text. But "::" is the C++ class member syntax, not
the start of an English enumeration or the like.

> The RST work was discussed for a year before we even started.  It has
> brought in the efforts of a large number of developers, all of whom see
> the value in actually caring about our documentation and making it
> accessible to a much larger group of readers.  And it has all happened
> while preserving the primacy of the plain-text documentation.

Clearly I don't agree. It reads like crap. I suspect many of the other
options, which I suppose there were, were even worse. Doesn't mean rst
is any good.

> You're not the only consumer of the docs.  You may not appreciate the
> improvements that have come, but others certainly do.  I do hope that you
> can find it in youself to avoid vandalizing things for everybody else ...?

Why should I care for people not using text editors to write code?
