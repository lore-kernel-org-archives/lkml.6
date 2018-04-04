Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeDDVWp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:22:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752249AbeDDVWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:22:38 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <91b57513-99be-7b77-ebe2-a7c2a121475f@infradead.org>
References: <91b57513-99be-7b77-ebe2-a7c2a121475f@infradead.org> <Pine.LNX.4.44L0.1804031557470.1399-100000@iolanthe.rowland.org> <7471.1522791794@warthog.procyon.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dhowells@redhat.com, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of spin_is_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13146.1522876954.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Wed, 04 Apr 2018 22:22:34 +0100
Message-ID: <13147.1522876954@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> >  * Note that the function only tells you that the CPU is seen to be locked,
> 
> the CPU is locked??
> 
> >  * not that it is locked on your CPU.

Sorry, yes: "... that the lock is seen to be locked, not that it is locked on
your CPU".
