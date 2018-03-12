Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeCLSkE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeCLSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:40:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76D9204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 12 Mar 2018 14:40:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180312144001.788380fa@vmware.local.home>
In-Reply-To: <20180312151017.GE23111@krava>
References: <20180310023442.791997138@goodmis.org>
        <20180310023907.798690563@goodmis.org>
        <20180312151017.GE23111@krava>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018 16:10:17 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> got it crashed when clearing the filter via 'echo > filter'

Awesome. I'll go and test this out. Thanks!

Hmm, could you pull my tree and test my branch: ftrace/core. I may have
already fixed this but haven't posted the latest (which I'll do before
pushing to next).

-- Steve
