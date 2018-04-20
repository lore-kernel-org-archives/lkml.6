Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeDTKvd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:51:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754511AbeDTKvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:51:32 -0400
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, "Namhyung Kim" <namhyung@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
To: <brueckner@linux.vnet.ibm.com>, <tmricht@linux.vnet.ibm.com>
From: John Garry <john.garry@huawei.com>
Subject: s390 perf events JSONs query
Message-ID: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
Date: Fri, 20 Apr 2018 11:51:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hendrik, Thomas,

I noticed that in 4.17-rc1 support was included for s390 perf 
pmu-events. I also notice that the JSONs contain many common (identical 
actually) events between different chips for this arch.

Support was added for factoring out common arch events in 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/perf/pmu-events?h=next-20180420&id=e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac

ARM64 chips use this feature. I am not familiar with the s390 arch, but 
do you think you could also use this feature?

Thanks,
John
