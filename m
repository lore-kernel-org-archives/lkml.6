Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbeCGKMx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:12:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754279AbeCGKMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:12:52 -0500
Date: Wed, 7 Mar 2018 11:12:49 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
Subject: Re: [PATCH V2 1/8] perf evlist: Store 'overwrite' in struct perf_mmap
Message-ID: <20180307101249.GB22848@krava>
References: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:36:00AM -0500, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> It has been determined that the map is for overwrite mode
> (evlist->overwrite_mmap) or non-overwrite mode (evlist->mmap) when
> calling perf_evlist__alloc_mmap().
> Store the information in struct perf_mmap, which will be used later to
> simpler the perf_mmap__read*() interfaces.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

nice cleanup! for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
