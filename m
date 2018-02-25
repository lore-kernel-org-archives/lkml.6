Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeBYWDI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 17:03:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38183 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeBYWDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 17:03:07 -0500
X-Google-Smtp-Source: AG47ELuflqRoFqcOKqsS+dK/77WlubFLWyLYD1s9qRDy6dVA0B/2ju3zcu94omrhB8GCZSKshw+cH0uYcRIZAQ9wNdE=
MIME-Version: 1.0
In-Reply-To: <20180225144421.GB7144@yexl-desktop>
References: <20180225144421.GB7144@yexl-desktop>
From: Shakeel Butt <shakeelb@google.com>
Date: Sun, 25 Feb 2018 14:03:03 -0800
Message-ID: <CALvZod7=kgWDMPbrDUGXznoJgv47fq-PUa97onVhS8x73TR+6g@mail.gmail.com>
Subject: Re: [lkp-robot] [mm, mlock, vmscan] 9c4e6b1a70: stress-ng.hdd.ops_per_sec
 -7.9% regression
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 6:44 AM, kernel test robot
<xiaolong.ye@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -7.9% regression of stress-ng.hdd.ops_per_sec due to commit:
>
>
> commit: 9c4e6b1a7027f102990c0395296015a812525f4d ("mm, mlock, vmscan: no more skipping pagevecs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: stress-ng
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> with following parameters:
>

Hi Xiaolong,

Is there a way I can get the output of "perf record -a -g" running in
parallel to the actual test on this machine. As I have mentioned
before I am not able to reproduce this issue. However I am trying to
repro on a VM with 4 vcpus and 4 GiB memory and I don't see any
difference. I am suspecting that it may repro on a larger machine but
I don't have access to one.

thanks,
Shakeel
