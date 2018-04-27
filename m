Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757204AbeD0Bke (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbeD0Bkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:40:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4BF2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 26 Apr 2018 21:40:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/3] A few hist trigger fixes
Message-ID: <20180426214029.6d36fa7a@gandalf.local.home>
In-Reply-To: <cover.1524790601.git.tom.zanussi@linux.intel.com>
References: <cover.1524790601.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018 20:04:46 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steve,
> 
> Here are a few patches that fix some problems found when testing the
> hist trigger inter-event (e.g. latency) support patches.
> 
> The first fixes a problem I noticed when printing flags.
> 
> The remaining two add some hist_err() calls for fields, the first
> reported by Masami, the second something I noticed when fixing the
> first.
> 

They look good and I queued them up.

Thanks!

-- Steve
