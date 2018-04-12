Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeDLQsB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:48:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeDLQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:48:00 -0400
Date: Thu, 12 Apr 2018 09:47:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joe Perches <joe@perches.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Message-Id: <20180412094758.dfef388d9be84fa41d2dcd5d@linux-foundation.org>
In-Reply-To: <20180412120832.GZ4082@hirez.programming.kicks-ass.net>
References: <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
        <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
        <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
        <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
        <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
        <20180411170049.GR4082@hirez.programming.kicks-ass.net>
        <20180412074719.pmcddramzyikppco@gmail.com>
        <20180412093521.GA6427@andrea>
        <20180412115022.GL4043@hirez.programming.kicks-ass.net>
        <a8677d8c351e4cb49907f9a8addcc261d810655a.camel@perches.com>
        <20180412120832.GZ4082@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 14:08:32 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> > It'd be _much_ nicer if vger.kernel.org stored every email
> > it sent and had a search mechanism available rather than
> > relying on external systems.
> 
> People are looking at that afaik.

I have linux-kernel mboxes going back to October 2000, which I can send
to whoever-that-is if needed for importation purposes...
