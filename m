Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeDXMsP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:48:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38354 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757332AbeDXMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:48:07 -0400
Date: Tue, 24 Apr 2018 14:48:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: subhra mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 3/3] sched: limit cpu search and rotate search window for
 scalability
Message-ID: <20180424124801.GS4082@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-4-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424004116.28151-4-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:41:16PM -0700, subhra mazumdar wrote:
> +	if (per_cpu(next_cpu, target) != -1)
> +		target_tmp = per_cpu(next_cpu, target);
> +	else
> +		target_tmp = target;
> +

This one; what's the point here?
