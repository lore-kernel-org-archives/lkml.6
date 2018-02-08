Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeBHNzq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:55:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeBHNzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:55:44 -0500
Date: Thu, 8 Feb 2018 14:55:41 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/9] perf vendor events: drop incomplete multiple mapfile
 support
Message-ID: <20180208135541.GJ10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517939104-230881-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 01:44:56AM +0800, John Garry wrote:
> Currently jevents supports multiple mapfiles, but this
> is only in the form where mapfile basename starts with
> 'mapfile.csv'
> 
> At the moment, no architectures actually use multiple mapfiles,
> so drop the support for now.
> 
> This patch also solves a nuisance where, when the mapfile is
> edited and the text editor may create a backup, jevents may
> use the backup, as shown:
> jevents: Many mapfiles? Using pmu-events/arch/arm64/mapfile.csv~, ignoring pmu-events/arch/arm64/mapfile.csv
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
