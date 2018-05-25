Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966273AbeEYJyZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:54:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55193 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965596AbeEYJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:54:23 -0400
Date: Fri, 25 May 2018 11:54:07 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, man@keba.com, hpa@zytor.com
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched, tracing: Fix trace_sched_pi_setprio()
 for deboosting
Message-ID: <20180525095407.g4qvfjzchbq7jusx@linutronix.de>
References: <20180524132647.gg6ziuogczdmjjzu@linutronix.de>
 <tip-4ff648decf4712d39f184fc2df3163f43975575a@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <tip-4ff648decf4712d39f184fc2df3163f43975575a@git.kernel.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-25 02:47:20 [-0700], tip-bot for Sebastian Andrzej Siewior wrote:
> Commit-ID:  4ff648decf4712d39f184fc2df3163f43975575a
> Gitweb:     https://git.kernel.org/tip/4ff648decf4712d39f184fc2df3163f43975575a
> Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate: Thu, 24 May 2018 15:26:48 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri, 25 May 2018 08:04:01 +0200
> 
> sched, tracing: Fix trace_sched_pi_setprio() for deboosting
> 
> Since the following commit:
> 
>   b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")
> 
> the sched_pi_setprio trace point shows the "newprio" during a deboost:
> 
>   |futex sched_pi_setprio: comm=futex_requeue_p pid"34 oldprio newprio=3D98
>   |futex sched_switch: prev_comm=futex_requeue_p prev_pid"34 prev_prio=120

pid=2234 got turned into pid"34 the same for other fields.

Sebastian
