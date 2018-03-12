Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCLOYa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbeCLOY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:24:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EA8205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 11:24:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 02/13] perf tools: Display ebpf compiling command in
 debug output
Message-ID: <20180312142425.GE4882@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312094313.18738-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312094313.18738-3-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 10:43:02AM +0100, Jiri Olsa escreveu:
> In addition to template, display also the real compile
> command line with all the variables substituted.
> 
> llvm compiling command template: $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS ...
> llvm compiling command : /usr/bin/clang -D__KERNEL__ -D__NR_CPUS__=24 -DLINUX_VERSION_CODE=0x41000 ...

Useful, applied.

- Arnaldo
