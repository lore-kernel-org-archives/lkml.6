Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757308AbeEJMXq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:23:46 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35343 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756741AbeEJMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:23:43 -0400
X-Google-Smtp-Source: AB8JxZpt7McUxQKvXKsjOvyen4SQ5vtn2E6go/4Vw2ta6dzV72GGMrZBffLyPbtU8e2eJVioD7uNmA==
Date: Thu, 10 May 2018 14:23:35 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180510122335.GA7704@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
 <20180509084120.GF12217@hirez.programming.kicks-ass.net>
 <20180509084518.247650e2@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509084518.247650e2@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
> 
> It's a simple colon.  It goes along with the /** marker for kerneldoc
> comments and the @ markers found within them, both of which you seem to
> have found a way to live with.
> 
> The RST work was discussed for a year before we even started.  It has
> brought in the efforts of a large number of developers, all of whom see
> the value in actually caring about our documentation and making it
> accessible to a much larger group of readers.  And it has all happened
> while preserving the primacy of the plain-text documentation.
> 
> You're not the only consumer of the docs.  You may not appreciate the
> improvements that have come, but others certainly do.  I do hope that you
> can find it in youself to avoid vandalizing things for everybody else ...?

You wrote it:  the fact that some people (including its developers) see
a value in the RST work or the fact that such work made the kernel doc.
accessible to a larger group of readers are not in question here;  only
remember that other people (including some developers running into the
"disadventure" of opening an RST doc. from their preferred text editor
and being brought to conclude:  "WTH!  I need to open a web browser, I
guess...") _use_ such doc. and _do care_ about it, and that what might
be an improvement for some people might look as "vandalizing" to others.

We're talking about readability/accessibility here, but I think similar
considerations apply to other aspects of the doc. such as availability/
completeness (yes, I did hear developers arguing "I won't write such a
doc., because...") and consistency (w.r.t. the doc. itself and sources).

  Andrea


> 
> Thanks,
> 
> jon
