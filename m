Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967972AbeEYTTi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967811AbeEYTTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:19:37 -0400
Date: Fri, 25 May 2018 15:19:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, peterz@infradead.org, bigeasy@linutronix.de,
        qianyue.zj@alibaba-inc.com, efault@gmx.de
Subject: Re: [PATCH RFC rcu/x86] Provide early rcu_cpu_starting() callback
Message-ID: <20180525151933.7fac5e81@gandalf.local.home>
In-Reply-To: <20180525191802.GA7141@linux.vnet.ibm.com>
References: <20180525191802.GA7141@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 12:18:02 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> [ paulmck: Add !SMP support, per 0day Test Robot report. ]

Somehow I read this as:

  [ paulmck: Add NR_CPUS=0 support ]

no idea why.

-- Steve
