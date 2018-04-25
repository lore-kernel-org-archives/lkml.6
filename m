Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeDYCvU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 22:51:20 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:44890 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDYCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 22:51:16 -0400
X-Google-Smtp-Source: AIpwx4+rawsxuHcHKABd0IaTyySXlzFvXjPO/87MnlHkcTjxzK8h54YUslhc7WJEoc6llaaHvJn38Q==
Date: Wed, 25 Apr 2018 08:21:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180425025111.zn6fwkr4o4d3y52c@vireshk-i7>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
 <20180424123523.GF4064@hirez.programming.kicks-ass.net>
 <CAEi0qN=qnej22F31jM2CMajee2h+ie0+AptFscwa5L8Arp8q3g@mail.gmail.com>
 <CAEi0qNmkkMEvbT+dJJqMwvRkQAw9xqKX65GKDZqtTAXUUxfs7Q@mail.gmail.com>
 <ea7b6d61-4af2-db82-16b8-ee6f25ccc69c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7b6d61-4af2-db82-16b8-ee6f25ccc69c@oracle.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-18, 15:34, Rohit Jain wrote:
> Including the "unlikely" suggestion and the original patch, as expected
> with a quick hackbench test on a 44 core 2 socket x86 machine causes no
> change in performance.

Want me to include your Tested-by in next version ?

-- 
viresh
