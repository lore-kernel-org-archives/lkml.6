Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCMPIq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:08:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44429 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeCMPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:08:43 -0400
X-Google-Smtp-Source: AG47ELsU8fJ6/k7YN12PKGB9ovdW6h0s60Dh0kTGgZN6N1Yq1BUsbtonzD0cgCqxzX6ilIqqr3ZDiw==
Date: Tue, 13 Mar 2018 16:08:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
Message-ID: <20180313150838.j6mfywse64o5ixhd@gmail.com>
References: <20180313120508.29327-1-acme@kernel.org>
 <20180313120508.29327-19-acme@kernel.org>
 <20180313142618.36je6syqg6ppwhbp@gmail.com>
 <6c485ee7-87d1-dc51-db34-94169b9ede08@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c485ee7-87d1-dc51-db34-94169b9ede08@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* John Garry <john.garry@huawei.com> wrote:

> On 13/03/2018 14:26, Ingo Molnar wrote:
> > 
> > * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > From: John Garry <john.garry@huawei.com>
> > > 
> > > Add JSON for ARMv8 IMPLEMENTATION DEFINED recommended events.
> > > 
> > > The JSON is copied from ARMv8 architecture reference manual, available
> > > here:
> > > 
> > > 	https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf
> > > 
> > > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: William Cohen <wcohen@redhat.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linuxarm@huawei.com
> > > Link: http://lkml.kernel.org/r/1520506716-197429-9-git-send-email-john.garry@huawei.com
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > That's not a valid SOB chain, author != first-Signed-off-by.
> > 
> 
> Right, so my SOB can go first.
> 
> Let me know how to help remedy.

Well, it depends on what role Shaokun Zhang had in the creation of the patch: if 
he co-authored the patch and you finished it then you can add him as:

  Originally-from: Shaokun Zhang <zhangshaokun@hisilicon.com>

or if he tested/reviewed the patch then his entry should be Reviewed-by/Acked-by 
or Tested-by.

Thanks,

	Ingo
