Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCLSyU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:54:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeCLSyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:54:19 -0400
Date: Mon, 12 Mar 2018 19:54:14 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180312185414.GA13138@krava>
References: <20180310023442.791997138@goodmis.org>
 <20180310023907.798690563@goodmis.org>
 <20180312151017.GE23111@krava>
 <20180312144001.788380fa@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312144001.788380fa@vmware.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 02:40:01PM -0400, Steven Rostedt wrote:
> On Mon, 12 Mar 2018 16:10:17 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > got it crashed when clearing the filter via 'echo > filter'
> 
> Awesome. I'll go and test this out. Thanks!
> 
> Hmm, could you pull my tree and test my branch: ftrace/core. I may have
> already fixed this but haven't posted the latest (which I'll do before
> pushing to next).

I couldn't apply your patches from mailbox so I used your ftrace/core already

jirka
