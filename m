Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeE1HP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:15:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753820AbeE1HP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:15:27 -0400
Date: Mon, 28 May 2018 09:15:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Joel Fernandes (Google)" <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Ramussen <morten.rasmussen@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, kernel-team@android.com
Subject: Re: [PATCH v2] sched: Remove obscure comment from select_task_rq_fair
Message-ID: <20180528071508.GS12180@hirez.programming.kicks-ass.net>
References: <20180528012447.115411-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528012447.115411-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 06:24:47PM -0700, Joel Fernandes (Google) wrote:
>  This patch removes the obscure comment which was
> saying this path can be entered only for wake-balance.

The comment was meant to ask if we want to always do
select_idle_siblings() and not only on wakeups.
