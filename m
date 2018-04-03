Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDCPXL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:23:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751432AbeDCPXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:23:10 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180403140715.GA5375@andrea>
References: <20180403140715.GA5375@andrea> <20180403133543.GA26653@andrea> <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com> <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com> <29562.1522759749@warthog.procyon.org.uk> <13191.1522763553@warthog.procyon.org.uk>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: dhowells@redhat.com, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of spin_is_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3765.1522768987.1@warthog.procyon.org.uk>
Date: Tue, 03 Apr 2018 16:23:07 +0100
Message-ID: <3766.1522768987@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> Sorry, but I don't understand your objection: are you suggesting to add
> something like "Always return 0 on !SMP" to the comment?  what else?

Something like that, possibly along with a warning that this might not be what
you want.  You might actually want it to return true on !SMP, it depends on
what you're using it for.

David
