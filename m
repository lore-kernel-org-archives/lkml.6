Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDCOHZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:07:25 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55627 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbeDCOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:07:24 -0400
X-Google-Smtp-Source: AIpwx49595+OSw6NMVpbFBaYcYJoTFmToIU6dzdpWohoz1lwqyVDf5LKr7hhIkRSEXMVVDV4c8WyfQ==
Date: Tue, 3 Apr 2018 16:07:15 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: David Howells <dhowells@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180403140715.GA5375@andrea>
References: <20180403133543.GA26653@andrea>
 <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
 <29562.1522759749@warthog.procyon.org.uk>
 <13191.1522763553@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13191.1522763553@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 02:52:33PM +0100, David Howells wrote:
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > > It's more complicated than that.  This function is dangerous and should be
> > > used with extreme care.  In the case where CONFIG_SMP=n the value is locked
> > > one way or the other and it might be the wrong way.
> > 
> > You mean "unlocked"? (aka, return 0)
> 
> No, I mean "fixed", sorry.  We've had problems stemming from this before on UP
> systems.

Sorry, but I don't understand your objection: are you suggesting to add
something like "Always return 0 on !SMP" to the comment?  what else?

  Andrea


> 
> David
