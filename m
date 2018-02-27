Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeB0Jue (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:50:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752210AbeB0Juc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:50:32 -0500
Date: Tue, 27 Feb 2018 10:50:28 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: ak@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v2 00/11] perf events patches for improved ARM64 support
Message-ID: <20180227095028.GG21033@krava>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 12:05:21AM +0800, John Garry wrote:
> This patchset adds support for some perf events features,
> targeted at ARM64, implemented in a generic fashion.
> 
> The two main features are as follows:
> - support for arch/vendor/platform pmu events directory structure
>    - to support this, topic subdirectory support needs to be dropped
> - support for parsing standard architecture pmu events
> 
> On the back of these, the Cavium ThunderX2, ARM Cortex-A53,
> and HiSilicon hip08 JSONs are relocated/added/updated.
> 
> In addition, there is a patch to drop mutli-mapfile.csv support and
> also a bugfix in jevents.c for an error code value.
> 
> Differences to v1:
> - Address coding issues from Jiri Olsa in adding arch std event
>    support (https://lkml.org/lkml/2018/2/6/501)
> - add patch to drop topic subdirectory support
> - add patch for bug fix in json_events() 
> - add review tags from Jiri Olsa

can't tell if those json file changes are ok, but for all the code changes:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
