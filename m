Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935226AbeEIOpX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:45:23 -0400
Received: from ms.lwn.net ([45.79.88.28]:42080 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934770AbeEIOpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:45:22 -0400
Date: Wed, 9 May 2018 08:45:18 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180509084518.247650e2@lwn.net>
In-Reply-To: <20180509084120.GF12217@hirez.programming.kicks-ass.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
        <20180509084120.GF12217@hirez.programming.kicks-ass.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 10:41:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > This is easily done by using "::" instead of just ":".  
> 
> And I'll voice my objection once again. This makes a regular comment
> worse. This rst stuff is utter shit for making normal text files less
> readable in your favourite text editor.
> 
> If this gets merged, I'll simply remove that spurious ':' the next time
> I'm near that comment.

Seriously, Peter?

It's a simple colon.  It goes along with the /** marker for kerneldoc
comments and the @ markers found within them, both of which you seem to
have found a way to live with.

The RST work was discussed for a year before we even started.  It has
brought in the efforts of a large number of developers, all of whom see
the value in actually caring about our documentation and making it
accessible to a much larger group of readers.  And it has all happened
while preserving the primacy of the plain-text documentation.

You're not the only consumer of the docs.  You may not appreciate the
improvements that have come, but others certainly do.  I do hope that you
can find it in youself to avoid vandalizing things for everybody else ...?

Thanks,

jon
