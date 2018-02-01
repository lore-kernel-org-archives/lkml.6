Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBANdu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:33:50 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:51919 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeBANdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:33:49 -0500
Date: Thu, 1 Feb 2018 14:33:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: subhra mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        steven.sistare@oracle.com, dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180201133343.GJ2295@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201123335.GV2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 01:33:35PM +0100, Peter Zijlstra wrote:
> I think you want to go allocate sched_domain_shared for the MC level and
> use that, much like sd_llc_shared.

Also, you'd want to try and get performance numbers for something like
Power8, which has SMT8 and fairly expensive atomic ops.
