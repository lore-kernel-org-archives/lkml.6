Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeEADqt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 23:46:49 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:38928 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeEADqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 23:46:48 -0400
X-Google-Smtp-Source: AB8JxZqaPvF3mmTHZCgMRcOJd1OewH/Bo/gw9ed6mo3kNHiPGDej9sahc6sVWFkdNsHNjnMdEIM/bBzDHhYbDJyjBKg=
MIME-Version: 1.0
References: <20180501014204.67548-1-joelaf@google.com> <20180501014204.67548-5-joelaf@google.com>
 <31312b91-fd30-5b1c-6a8e-39ff2b58b5a8@infradead.org>
In-Reply-To: <31312b91-fd30-5b1c-6a8e-39ff2b58b5a8@infradead.org>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 03:46:36 +0000
Message-ID: <CAJWu+oodZ_zGDraGebUszideko5wnfhGWn9jkMemWWmRbgJ13Q@mail.gmail.com>
Subject: Re: [kernel-team] Re: [PATCH RFC v5 4/6] trace/irqsoff: Split reset
 into seperate functions
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 8:46 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> On 04/30/2018 06:42 PM, Joel Fernandes wrote:
> > Split reset functions into seperate functions in preparation
> > of future patches that need to do tracer specific reset.
> >

> Hi,
> Since you are updating patches anyway, please
> s/seperate/separate/.

Thanks Randy, will do.

- Joel
