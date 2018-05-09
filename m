Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935558AbeEISfp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:35:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:43084 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933577AbeEISfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:35:43 -0400
Date: Wed, 9 May 2018 12:35:40 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180509123540.083b61d2@lwn.net>
In-Reply-To: <20180509152026.GA12198@hirez.programming.kicks-ass.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
        <20180509084120.GF12217@hirez.programming.kicks-ass.net>
        <20180509084518.247650e2@lwn.net>
        <20180509152026.GA12198@hirez.programming.kicks-ass.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 17:20:26 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> The whole rst wankery is detrimental to that interface in order to
> pander to something else.. I don't see the value. I've objected before,
> and I suppose I'll object again.

One person's wankery is another's integrated, browsable, and searchable
documentation that shows some signs of having actually been thought about,
I guess.

> > It's a simple colon.  It goes along with the /** marker for kerneldoc
> > comments and the @ markers found within them, both of which you seem to
> > have found a way to live with.  
> 
> Barely, and personally I tend to not bother with kerneldoc much. Most of
> the comments I write lack the extra *, and I note that the other fix to
> this problem it to drop that spurious * here as well.

Perhaps you'd like to post a patch removing the kerneldoc mechanism?  It
would make my life a lot easier...:)

> The @arg thing is okay, it clearly distinguishes arguments/variable
> names from regular text. But "::" is the C++ class member syntax, not
> the start of an English enumeration or the like.

Not sure what C++ has to do with anything, unless we want to bring in
$LANGUAGE_WE_DISRESPECT spuriously.  I'm sure it's the Perl
do-five-different-things-magically syntax too.  It's probably an entire
natural-language processing system in Haskell.  It also happens to be the
Sphinx "start literal block" syntax.

> > You're not the only consumer of the docs.  You may not appreciate the
> > improvements that have come, but others certainly do.  I do hope that you
> > can find it in youself to avoid vandalizing things for everybody else ...?  
> 
> Why should I care for people not using text editors to write code?

The set of "people using text editors to write code" is a superset
of the set containing only Peter Zijlstra.  Many of the people who have
used text editors to write the very code we all work on find a minimally
structured documentation system to be useful.  Out of respect for them, if
nothing else, I'll ask again, please, that you suffer the substantial
cognitive drain of skipping over an extra colon.

Thanks,

jon
