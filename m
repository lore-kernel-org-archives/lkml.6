Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934127AbeE1Uy5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:54:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37078 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeE1Uy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:54:56 -0400
X-Google-Smtp-Source: AB8JxZpLHIA7kY2Q4afRjZ7lhhEMEr6n1QLJTvZatJxgSDRD6LL69C+3DpsfgL8qfayqkqKhSXukXw==
Date: Mon, 28 May 2018 13:54:54 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Joel Fernandes (Google)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Ramussen <morten.rasmussen@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, kernel-team@android.com
Subject: Re: [PATCH v2] sched: Remove obscure comment from select_task_rq_fair
Message-ID: <20180528205454.GB189841@joelaf.mtv.corp.google.com>
References: <20180528012447.115411-1-joel@joelfernandes.org>
 <20180528071508.GS12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528071508.GS12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 09:15:08AM +0200, Peter Zijlstra wrote:
> On Sun, May 27, 2018 at 06:24:47PM -0700, Joel Fernandes (Google) wrote:
> >  This patch removes the obscure comment which was
> > saying this path can be entered only for wake-balance.
> 
> The comment was meant to ask if we want to always do
> select_idle_siblings() and not only on wakeups.

Ok, thanks for the clarification. Makes sense, and sorry for the noise.

thanks,

 - Joel
