Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeCPN53 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:57:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41186 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeCPN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:57:27 -0400
Date: Fri, 16 Mar 2018 14:57:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, tj@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] Improve mutex documentation
Message-ID: <20180316135716.GG4064@hirez.programming.kicks-ass.net>
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180315115812.GA9949@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315115812.GA9949@bombadil.infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:58:12AM -0700, Matthew Wilcox wrote:
> On Wed, Mar 14, 2018 at 01:56:31PM -0700, Andrew Morton wrote:
> > My memory is weak and our documentation is awful.  What does
> > mutex_lock_killable() actually do and how does it differ from
> > mutex_lock_interruptible()?
> 
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Add kernel-doc for mutex_lock_killable() and mutex_lock_io().  Reword the
> kernel-doc for mutex_lock_interruptible().
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Thanks Matthew!
