Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeESSaI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:30:08 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41657 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeESSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:30:06 -0400
X-Google-Smtp-Source: AB8JxZpQC3o8dv3wBJq+IdCpW5gK93S60UaSHdJSsGlqO2OPGb6f6yT1ddpUWUgK6TkMC6CG2DzKsEkE8qOrU1krTyU=
MIME-Version: 1.0
In-Reply-To: <20180518225817.GA134184@joelaf.mtv.corp.google.com>
References: <20180518015902.131427-1-joelaf@google.com> <20180518015902.131427-2-joelaf@google.com>
 <CAHp75Vf_zC9geRcdwD_WGLidg7Oq6rsKpL87Jhf4oQxz2=ctBw@mail.gmail.com> <20180518225817.GA134184@joelaf.mtv.corp.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 19 May 2018 21:30:05 +0300
Message-ID: <CAHp75Vf8bwUsMYYd1u1OSa=DGwJkOrZ4txqtFyRmX4OS4Qosrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: Add module to simulate atomic sections for
 testing {preempt,irqs}off tracers
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>, Julia Cartwright <julia@ni.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 1:58 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Sat, May 19, 2018 at 12:09:46AM +0300, Andy Shevchenko wrote:
>> On Fri, May 18, 2018 at 4:59 AM, Joel Fernandes <joelaf@google.com> wrote:

>> > +       default n
>>
>> n _is_ default default.
>
> I would rather be explicit, several other TEST configs also mention it. Is it
> a strong desire to drop off default n?

I guess so, it comes from Linus. See, for example, commit
0192f17529fa clean up x86 platform driver default values

-- 
With Best Regards,
Andy Shevchenko
