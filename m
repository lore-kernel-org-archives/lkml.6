Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeDDNBj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeDDNBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:01:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F46C21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 09:01:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/4] tracing: Add action comparisons when testing
 matching hist triggers
Message-ID: <20180404090134.4db3de17@gandalf.local.home>
In-Reply-To: <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
        <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
        <20180403001025.6dfed9403d50d20104e54458@kernel.org>
        <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 21:33:38 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hmm, how can I undef ts0 and test it again?
> If I can not clean it, the testcase must fail on the 2nd time.

Tom,

I already pulled in your patches and almost completed my tests (which
obviously are not stress testing this code).

Any fixes you make to address Masami's concerns, can you please make as
separate patches on top of this. You can see my current tree that I'm
testing and base on top of that one.

 git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 branch: ftrace/core

(Note, that can rebase, but mostly to add acks)

Thanks!

-- Steve
