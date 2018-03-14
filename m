Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeCNHSA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 03:18:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40858 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNHR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 03:17:58 -0400
X-Google-Smtp-Source: AG47ELsktB74r8riGpaXeqi4oqkb8GRKIFN61NqvDIZhzcmTfMs4Wv/qlRXH3bxeUNbJrNpydy+AhQ==
Date: Wed, 14 Mar 2018 08:17:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 18/31] perf vendor events arm64: Add
 armv8-recommended.json
Message-ID: <20180314071751.aglkde77apjjffku@gmail.com>
References: <20180313120508.29327-1-acme@kernel.org>
 <20180313120508.29327-19-acme@kernel.org>
 <20180313142618.36je6syqg6ppwhbp@gmail.com>
 <20180313182730.GA7987@kernel.org>
 <20180314015417.GB19781@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314015417.GB19781@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Mar 13, 2018 at 03:27:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Mar 13, 2018 at 03:26:18PM +0100, Ingo Molnar escreveu:
> > > That's not a valid SOB chain, author != first-Signed-off-by.
>  
> > I removed that cset for now, can you please check if the
> > perf-core-for-mingo-4.17-20180313-2 tag is allright?
> 
> So, since there is this problem with powerpc and jevents, Ingo, please
> hold on a bit more... Hopefully tomorrow things will be in a better
> shape.

Sure, no problem!

Thanks,

	Ingo
