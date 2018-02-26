Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeBZC7D (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:59:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:7891 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751945AbeBZC7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:59:02 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,395,1515484800";
   d="scan'208";a="206919856"
Date: Mon, 26 Feb 2018 10:57:28 +0800
From: Ye Xiaolong <xiaolong.ye@intel.com>
To: Shakeel Butt <shakeelb@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Balbir Singh <bsingharora@gmail.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Jan Kara <jack@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Mel Gorman <mgorman@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [lkp-robot] [mm, mlock, vmscan] 9c4e6b1a70:
 stress-ng.hdd.ops_per_sec -7.9% regression
Message-ID: <20180226025728.GA8942@yexl-desktop>
References: <20180225144421.GB7144@yexl-desktop>
 <CALvZod7=kgWDMPbrDUGXznoJgv47fq-PUa97onVhS8x73TR+6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7=kgWDMPbrDUGXznoJgv47fq-PUa97onVhS8x73TR+6g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shakeel 

On 02/25, Shakeel Butt wrote:
>On Sun, Feb 25, 2018 at 6:44 AM, kernel test robot
><xiaolong.ye@intel.com> wrote:
>>
>> Greeting,
>>
>> FYI, we noticed a -7.9% regression of stress-ng.hdd.ops_per_sec due to commit:
>>
>>
>> commit: 9c4e6b1a7027f102990c0395296015a812525f4d ("mm, mlock, vmscan: no more skipping pagevecs")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: stress-ng
>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
>> with following parameters:
>>
>
>Hi Xiaolong,
>
>Is there a way I can get the output of "perf record -a -g" running in
>parallel to the actual test on this machine. As I have mentioned
>before I am not able to reproduce this issue. However I am trying to
>repro on a VM with 4 vcpus and 4 GiB memory and I don't see any
>difference. I am suspecting that it may repro on a larger machine but
>I don't have access to one.
>

perf.data attached. It was generated via `perf record -q -ag --realtime=1 -m 256`

Thanks,
Xiaolong

>thanks,
>Shakeel
