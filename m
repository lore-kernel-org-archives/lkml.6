Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeBFTZJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeBFTZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:25:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594EE21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Feb 2018 16:16:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 17/17] perf tools: Fix comment for sort__* compare
 functions
Message-ID: <20180206191620.GI3451@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
 <20180206181813.10943-18-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206181813.10943-18-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 06, 2018 at 07:18:13PM +0100, Jiri Olsa escreveu:
> In commit 2f15bd8c6c6e ("perf tools: Fix "Command" sort_entry's cmp and collapse function")
> we switched from pointer to string comparison.
> 
> But failed to remove related comments. Removing them and adding
> another one to warn before pointer comparison in here.

Applied.

Pushing perf/core out, please take a look at the others and rebase,

- Arnaldo
