Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEPOEj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbeEPOEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:04:33 -0400
Date: Wed, 16 May 2018 10:04:30 -0400
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
Subject: Re: [PATCH v2 12/14] ftrace/selftest: Fix reset_trigger() to handle
 triggers with filters
Message-ID: <20180516100430.2830ac07@gandalf.local.home>
In-Reply-To: <20180516215612.e86701c1da81e9b9982a3c9f@kernel.org>
References: <20180514205845.017925650@goodmis.org>
        <20180514205959.080491350@goodmis.org>
        <20180516215612.e86701c1da81e9b9982a3c9f@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 21:56:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> This also looks good to me and needs to go into stable.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Masami!

-- Steve
