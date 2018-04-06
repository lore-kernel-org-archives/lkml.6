Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeDFQI6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:08:58 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50386 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbeDFQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:08:56 -0400
Date: Fri, 6 Apr 2018 12:10:19 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm/vmscan: remove redundant
 current_may_throttle() check
Message-ID: <20180406161019.GC20806@cmpxchg.org>
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
 <20180323152029.11084-3-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323152029.11084-3-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 06:20:27PM +0300, Andrey Ryabinin wrote:
> Only kswapd can have non-zero nr_immediate, and current_may_throttle() is
> always true for kswapd (PF_LESS_THROTTLE bit is never set) thus it's
> enough to check stat.nr_immediate only.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
