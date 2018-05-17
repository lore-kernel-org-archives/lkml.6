Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1861431-1526547975-2-7058711296523987301
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526547974; b=OElmwnM3Rx5MKbLgDggnB1+wK8QtdrhHuEXgK5cv4NXIkXIO6P
    CN6yXlHuj9CBkR6poWMkW5Wh3x3qAusH0IsAk6BiLsrHakMTa9geX/rYzSXcwyXJ
    5Uy+a8yk53hVzwfzfUmN79+kjUPOwcd8L34sqcGEBRQMG02yJ3QSfhdBbhu+uIdS
    A82BJUNM/wU3xAFKp5tyov5IAN6SL4SMk0uh0zpa4CAplBj9O2aijrdETPN+XsXo
    kCWNugdAmnLh9fTELIThj/7wJbs0DMIT6HzPVr5wquZv5dfJzfH4EzG33CpQQmqv
    cuez7xwQNTBUrOh7/mMP0GNz5cosZqjtvGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526547974; bh=BQcHf2g0r3j4Amwhpk36DdL+BZSH1a
    XUCxfPYsxqF6U=; b=KaRjBpKzEiwN6bbMtylXwnFFi1wMdnAlmhKx9om43/FmNx
    fZgnnvJ1pAppis/F+sz22Q8qhIy4O1+qDyiXmOr4aYin/AxxDgNugKGNCjHv8vDJ
    R51v7C6oMywGgUPkqLpus2pl82NhLjvd6DST5hs3sCCKCvT0JBEetD7gvHfC8flX
    J9lcmnLQ5Zv7ra+/gjkX/JNDrKUChF6GbPziVdkcETjm8Mms3iPCB4KWZh99FDkr
    M93ItxQNk77Td5Rl9Zdchx0R3df6KIIN7g4qV9TTdkyopAEjwIAH5OAFdLffLAmR
    ZE9hwrPDYy/OaMQGI2a6g8QWrXHNGvYUKu4Gmsgg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=C2DO8A3K
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=C2DO8A3K
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFu0pvQeKLc7UGFpR7CTdit8UbgcE0WAbdgA6XcxzYmZdPWYRGRH4RV7zBMb5ARKFVdfvZ18WoaXgP47RzXPBuNWbkNuB/CxFJhPqEsWh3T1dR7141dR
    wGcZjyi0QFZ9Oxo7DOD/LGzzH8jpSOkn9KTia7bRT3TmUGpq+OfQcAw4PnxY/xK8LGFVbU7oqlLQ7dCfxMD413BrtPUDl2iJzSaXcbkaVZQCYVnG8KXZO89F
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=e5_t1XToJhP_PxCYL0oA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeEQJGL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:06:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54284 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEQJFl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 05:05:41 -0400
Date: Thu, 17 May 2018 11:05:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@arm.com, viresh.kumar@linaro.org,
        tglx@linutronix.de, efault@gmx.de, juri.lelli@redhat.com,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] sched/rt: fix call to cpufreq_update_util
Message-ID: <20180517090530.GO12217@hirez.programming.kicks-ass.net>
References: <1526541403-16380-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526541403-16380-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 09:16:43AM +0200, Vincent Guittot wrote:
> With commit
>
>  8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
>
> schedutil governor uses rq->rt.rt_nr_running to detect whether a RT task is
> currently running on the CPU and to set frequency to max if necessary.
>
> cpufreq_update_util() is called in enqueue/dequeue_top_rt_rq() but
> rq->rt.rt_nr_running as not been updated yet when dequeue_top_rt_rq() is
> called so schedutil still considers that a RT task is running when the
> last task is dequeued. The update of rq->rt.rt_nr_running happens later
> in dequeue_rt_stack()
> 
> Fixes: 8f111bc357aa ('cpufreq/schedutil: Rewrite CPUFREQ_RT support')
> Cc: <stable@vger.kernel.org> # v4.16+
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> - v2:
>   - remove blank line
> 
>  kernel/sched/rt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7aef6b4..a9f1119 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1000,9 +1000,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
>  
>  	sub_nr_running(rq, rt_rq->rt_nr_running);
>  	rt_rq->rt_queued = 0;
> -
> -	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	cpufreq_update_util(rq, 0);
>  }
>  
>  static void
> @@ -1288,6 +1285,9 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>  		if (on_rt_rq(rt_se))
>  			__dequeue_rt_entity(rt_se, flags);
>  	}
> +
> +	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> +	cpufreq_update_util(rq_of_rt_rq(rt_rq_of_se(back)), 0);
>  }

Hurm.. I think this is also wrong. See how dequeue_rt_stack() is also
called from the enqueue path. Also, nothing calls cpufreq_update_util()
on the throttle path now.

And talking about throttle; I think we wanted to check rt_queued in that
case.

How about the below?

---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/rt.c                | 24 ++++++++++++++----------
 kernel/sched/sched.h             |  5 +++++
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e13df951aca7..1751f9630e49 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -185,7 +185,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 	unsigned long util;
 
-	if (rq->rt.rt_nr_running) {
+	if (rt_rq_is_runnable(&rq->rt)) {
 		util = sg_cpu->max;
 	} else {
 		util = sg_cpu->util_dl;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4e885a..a1108a7da777 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -979,8 +979,14 @@ static void update_curr_rt(struct rq *rq)
 		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
-			if (sched_rt_runtime_exceeded(rt_rq))
+			if (sched_rt_runtime_exceeded(rt_rq)) {
+				struct rq *rq = rq_of_rt_rq(rt_rq);
+
+				if (&rq->rt == rt_rq)
+					cpufreq_update_util(rq, 0);
+
 				resched_curr(rq);
+			}
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
 		}
 	}
@@ -1000,9 +1006,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 
 	sub_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 0;
-
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1019,9 +1022,6 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 
 	add_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 1;
-
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 #if defined CONFIG_SMP
@@ -1330,6 +1330,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
+
+	cpufreq_update_util(rq, 0);
 }
 
 static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
@@ -1340,6 +1342,8 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_rt_entity(rt_se, flags);
 
 	dequeue_pushable_task(rq, p);
+
+	cpufreq_update_util(rq, 0);
 }
 
 /*
@@ -1533,6 +1537,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *p;
 	struct rt_rq *rt_rq = &rq->rt;
 
+	if (!rt_rq->rt_queued)
+		return NULL;
+
 	if (need_pull_rt_task(rq, prev)) {
 		/*
 		 * This is OK, because current is on_cpu, which avoids it being
@@ -1560,9 +1567,6 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (prev->sched_class == &rt_sched_class)
 		update_curr_rt(rq);
 
-	if (!rt_rq->rt_queued)
-		return NULL;
-
 	put_prev_task(rq, prev);
 
 	p = _pick_next_task_rt(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c9895d35c5f7..bec7f2eecaf3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -609,6 +609,11 @@ struct rt_rq {
 #endif
 };
 
+static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
+{
+	return rq_rq->rt_queued && rt_rq->rt_nr_running;
+}
+
 /* Deadline class' related fields in a runqueue */
 struct dl_rq {
 	/* runqueue is an rbtree, ordered by deadline */
