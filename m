Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeFDNo7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbeFDNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:44:58 -0400
Date: Mon, 4 Jun 2018 10:44:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf tools: Fix symbol and object code resolution
 for vdso32 and vdsox32
Message-ID: <20180604134455.GC3397@kernel.org>
References: <1528117014-30032-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528117014-30032-1-git-send-email-adrian.hunter@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 04, 2018 at 03:56:52PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are a couple of small fixes for tracing 32-bit binaries on a 64-bit
> kernel.

Thanks, applied both to both perf/urgent and perf/core.

- Arnaldo
 
> 
> Adrian Hunter (2):
>       perf tests kmod-path: Add tests for vdso32 and vdsox32
>       perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
> 
>  tools/perf/tests/kmod-path.c | 16 ++++++++++++++++
>  tools/perf/util/dso.c        |  2 ++
>  2 files changed, 18 insertions(+)
> 
> 
> Regards
> Adrian
