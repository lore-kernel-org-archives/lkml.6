Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeBBPOI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:14:08 -0500
Received: from sinrega.org ([188.166.23.170]:34820 "EHLO sinrega.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeBBPOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:14:03 -0500
Message-ID: <1517584441.10356.21.camel@sinrega.org>
Subject: Re: [RFC PATCH] sched/fair: Optionally restrict SMT scheduling
 ("restrict_smt")
From: Sergio Lopez <slp@sinrega.org>
To: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org
Date: Fri, 02 Feb 2018 16:14:01 +0100
In-Reply-To: <1517495872.23787.20.camel@gmx.de>
References: <20180201123748.32596-1-slp@sinrega.org>
         <1517495872.23787.20.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 15:37 +0100, Mike Galbraith wrote:
> On Thu, 2018-02-01 at 13:37 +0100, Sergio Lopez wrote:
> > Compared against "isolcpus", "restrict_smt" presents the following
> > advantages:
> >  - Doesn't require prior knowledge of the CPU topology, making it
> > more friendly to both end users and automation tools.
> >  - Load balancing is still active for tasks pinned to multiple
> > secondary SMT threads.
> 
> This says that everybody and everything in the box is way smarter
> than the admin.

If that's an argument in favor of manual pinning and isolation, I have
to disagree with you. That's an unnecessary burden put on the shoulders
of the admin.

Sergio.
