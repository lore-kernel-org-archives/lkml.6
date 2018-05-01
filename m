Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755987AbeEAOYr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755316AbeEAOYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:24:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACACE23690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 1 May 2018 10:24:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH RFC v5 5/6] tracepoint: Make rcuidle tracepoint callers
 use SRCU
Message-ID: <20180501102440.3e7e0fe7@gandalf.local.home>
In-Reply-To: <CAJWu+oozGFeGq84JJ4HMkbM4HB702gUZ0=bx7qLG5DiqUAu67A@mail.gmail.com>
References: <20180501014204.67548-1-joelaf@google.com>
        <20180501014204.67548-6-joelaf@google.com>
        <CAJWu+oozGFeGq84JJ4HMkbM4HB702gUZ0=bx7qLG5DiqUAu67A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2018 01:56:01 +0000
Joel Fernandes <joelaf@google.com> wrote:

> This last bit is supposed to be srcu_dereference_notrace. The hunk to use
> that is actually in patch 6/6 , sorry about that. I've fixed it in my tree
> and it means patches 5/6 and 6/6 need an update. Steve, if you want me to
> repost  it right away I can do that, or can wait for additional comments
> and then repost.

Wait for additional comments.

-- Steve
