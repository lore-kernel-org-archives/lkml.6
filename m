Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeCFHxG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:53:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750838AbeCFHxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:53:05 -0500
Date: Tue, 6 Mar 2018 08:53:02 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: changbin.du@intel.com
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf sched map: re-annotate shortname if thread
 comm changed
Message-ID: <20180306075302.GA19895@krava>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 11:37:35AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> v2:
>   o add a patch to move thread::shortname to thread_runtime
>   o add function perf_sched__process_comm() to process PERF_RECORD_COMM event.
> 
> Changbin Du (2):
>   perf sched: move thread::shortname to thread_runtime
>   perf sched map: re-annotate shortname if thread comm changed

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/perf/builtin-sched.c | 132 ++++++++++++++++++++++++++++++---------------
>  tools/perf/util/thread.h   |   1 -
>  2 files changed, 90 insertions(+), 43 deletions(-)
> 
> -- 
> 2.7.4
> 
