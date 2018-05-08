Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755333AbeEHOE5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:04:57 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49824 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755074AbeEHOE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:04:56 -0400
Date: Tue, 8 May 2018 10:06:48 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180508140648.GB2900@cmpxchg.org>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
 <024fba07-eece-3878-0924-ea9fd601542d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024fba07-eece-3878-0924-ea9fd601542d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 05:42:36PM -0700, Randy Dunlap wrote:
> On 05/07/2018 02:01 PM, Johannes Weiner wrote:
> > + * The ratio is tracked in decaying time averages over 10s, 1m, 5m
> > + * windows. Cumluative stall times are tracked and exported as well to
> 
>                Cumulative
> 

> > +/**
> > + * psi_memstall_leave - mark the end of an memory stall section
> 
>                                     end of a memory

Thanks Randy, I'll get those fixed.
