Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756274AbeEASEF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:04:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756060AbeEASED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:04:03 -0400
Date: Tue, 1 May 2018 20:03:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
Message-ID: <20180501180348.GI12217@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
 <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
 <20180425174909.GB4043@hirez.programming.kicks-ass.net>
 <e2011797-382b-0ac9-79eb-e17109ef4c96@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2011797-382b-0ac9-79eb-e17109ef4c96@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 04:38:42PM -0700, Subhra Mazumdar wrote:
> I also noticed a possible bug later in the merge code. Shouldn't it be:
> 
> if (busy < best_busy) {
>         best_busy = busy;
>         best_cpu = first_idle;
> }

Uhh, quite. I did say it was completely untested, but yes.. /me dons the
brown paper bag.
