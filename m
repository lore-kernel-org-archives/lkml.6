Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbeBVQcl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:32:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933152AbeBVQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:32:39 -0500
Date: Thu, 22 Feb 2018 17:32:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180222163235.GP25181@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
 <20180222151210.jwxjchywk4jfecyf@tardis>
 <20180222160811.GT25201@hirez.programming.kicks-ass.net>
 <20180222163426.fcfq6ubq25ipxhfb@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222163426.fcfq6ubq25ipxhfb@tardis>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:34:26AM +0800, Boqun Feng wrote:
> OK, so I have some 'proof' in patch #16. I could move that proof in the
> commit log or merge that patch with this one?

Hehe, I'm not yet that far with reading patches.. I'll get to it,
eventually ;-)
