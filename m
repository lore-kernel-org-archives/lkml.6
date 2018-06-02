Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeFBBR2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 21:17:28 -0400
Received: from mail.efficios.com ([167.114.142.138]:32894 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeFBBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 21:17:25 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5993F2262C8
Date: Fri, 1 Jun 2018 21:17:24 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Joel Fernandes, Google" <joel@joelfernandes.org>
Cc: Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, shuah <shuah@kernel.org>,
        rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Message-ID: <1349580221.4426.1527902244184.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180531175153.GA129415@joelaf.mtv.corp.google.com>
References: <20180530000500.257225-1-joel@joelfernandes.org> <20180530000500.257225-6-joel@joelfernandes.org> <214539705.3633.1527749441133.JavaMail.zimbra@efficios.com> <20180531175153.GA129415@joelaf.mtv.corp.google.com>
Subject: Re: [PATCH v8 5/8] tracepoint: Make rcuidle tracepoint callers use
 SRCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: tracepoint: Make rcuidle tracepoint callers use SRCU
Thread-Index: S3anSCqc8LuW6U6wpVQUjzDowSukxA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 31, 2018, at 1:51 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:

>> I find it odd to have a "return" in a macro that consists of a
>> do { } while (0). I'm tempted to replace "return" by "break" here,
>> to break the macro do/while (0) loop.
> 
> "return;" is also used from "if (!(cond))" above so I prefer be consistent
> and just use return than break as done above, but please let me know if you
> still object.

It's fine by me,

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
