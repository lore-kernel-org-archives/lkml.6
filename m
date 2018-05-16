Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeEPOGM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752205AbeEPOGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:06:10 -0400
Date: Wed, 16 May 2018 10:06:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Message-ID: <20180516100606.0ecf2e56@gandalf.local.home>
In-Reply-To: <20180516220716.60174e9edd8d9f970fcd37e1@kernel.org>
References: <20180514205845.017925650@goodmis.org>
        <20180514205959.230719465@goodmis.org>
        <20180516220716.60174e9edd8d9f970fcd37e1@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 22:07:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc  
> 
> But this test actually kicks histogram, maybe
> trigger-trace-marker-hist.tc will be better, since we may need to add
> a simpler testcase just for checking whether trace-marker works with
> some actions (e.g. enable/disable other events).

OK, will update that file. Thanks for reviewing.

-- Steve
