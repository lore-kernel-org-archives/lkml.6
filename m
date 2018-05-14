Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeENIdC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:33:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36466 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbeENIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:33:01 -0400
X-Google-Smtp-Source: AB8JxZpi9CvxAcGbmWsK+jbgmTSi4nhlkgZAaMKi+VzwGZwo2xgl/J4UOavhtGiNOPACbP+AgfKOgg==
Date: Mon, 14 May 2018 10:32:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 10/19] perf tools: Create maps for x86_64 KPTI entry
 trampolines
Message-ID: <20180514083257.GA29509@gmail.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-11-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525866228-30321-11-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Hunter <adrian.hunter@intel.com> wrote:

> Create maps for x86_64 KPTI entry trampolines, based on symbols found in
> kallsyms. It is also necessary to keep track of whether the trampolines
> have been mapped particularly when the kernel dso is kcore.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/machine.c | 138 ++++++++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/machine.h |   1 +
>  tools/perf/util/symbol.c  |  17 ++++++
>  3 files changed, 150 insertions(+), 6 deletions(-)

Minor detail, please call it 'x86 PTI'.

Thanks,

	Ingo
