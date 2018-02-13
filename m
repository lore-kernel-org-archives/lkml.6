Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeBMP60 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933730AbeBMP6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:58:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE0F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 13 Feb 2018 10:58:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] tracing: probeevent: Improve fetcharg features
Message-ID: <20180213105820.3e0581a0@gandalf.local.home>
In-Reply-To: <151853614489.31487.10683006682475678487.stgit@devbox>
References: <151853614489.31487.10683006682475678487.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018 00:35:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This series improves probeevent variable fetcharg framework,
> 
> - Rewrite fetcharg framework with fetch_insn, switch-case based
>   instead of function pointer. (maybe good for retpoline)
> - Add "symbol" type support, which shows symbol+offset instead of
>   address value.
> - Add "$argN" fetcharg, which fetches function parameters.
>   (currently only for x86-64)
> - Add array type support for basic types (except for string),
>   which enables to get fixed length array from probeevents.
> 
> All ideas came from Steve's function event tracer. Thanks Steve!

You're welcome ;-)

> 
> I'll add string (pointer) array support and testcases for these
> features in the next version.
> 

Just to let you know I'm trying to catch up with some internal work and
may not be able to look at these for a few days.

Hopefully others will be able to review them.

-- Steve
