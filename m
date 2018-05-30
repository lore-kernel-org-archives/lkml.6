Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935229AbeE3F4u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:56:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36693 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934206AbeE3F4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:56:44 -0400
X-Google-Smtp-Source: ADUXVKJw/YOsC6wj+qLE7195CYuDLwKzCnkrnlmI8fYVtIO2hnNOPILHiOWt+jQ7NKzLehKrDTAeEA==
Date: Wed, 30 May 2018 07:56:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, efault@gmx.de, peterz@infradead.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [GIT PULL rcu/next] Additional RCU commit for 4.18
Message-ID: <20180530055640.GA6463@gmail.com>
References: <20180529173518.GA6850@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529173518.GA6850@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Hello, Ingo,
> 
> This additional v4.18 pull request contains a single commit that fell
> through the cracks:
> 
> 1.	Provide early rcu_cpu_starting() callback for the benefit of the
> 	x86/mtrr code, which needs RCU to be available on incoming CPUs
> 	earlier than has been the case in the past.
> 
> 	http://lkml.kernel.org/r/20180525191802.GA7141@linux.vnet.ibm.com
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to f64c6013a2029316ea552f99823d116ee5f5f955:
> 
>   rcu/x86: Provide early rcu_cpu_starting() callback (2018-05-22 16:12:26 -0700)
> 
> ----------------------------------------------------------------
> Peter Zijlstra (1):
>       rcu/x86: Provide early rcu_cpu_starting() callback
> 
>  arch/x86/kernel/cpu/mtrr/main.c | 4 ++++
>  include/linux/rcupdate.h        | 1 -
>  include/linux/rcutiny.h         | 1 +
>  include/linux/rcutree.h         | 1 +
>  kernel/rcu/tree.c               | 9 +++++++++
>  5 files changed, 15 insertions(+), 1 deletion(-)

Pulled, thanks a lot Paul!

	Ingo
