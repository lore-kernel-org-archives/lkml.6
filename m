Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeC0ODE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:03:04 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36174 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeC0ODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:03:02 -0400
X-Google-Smtp-Source: AG47ELvP9kVahMQtJ8p1qgQ4HRyg6Cc0o9sDdt9KQqc6cFCgWPSntFlihulxAA3ChQ+ull5os7z/Zw==
Date: Tue, 27 Mar 2018 07:02:59 -0700
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v6 2/2] cpuset: Add cpuset.sched_load_balance to v2
Message-ID: <20180327140259.GN1840639@devbig577.frc2.facebook.com>
References: <1521649309-26690-1-git-send-email-longman@redhat.com>
 <1521649309-26690-3-git-send-email-longman@redhat.com>
 <20180322084120.GE7231@localhost.localdomain>
 <e754e128-0a93-800e-e71b-2c8dc316ba8a@redhat.com>
 <20180323075952.GA4763@localhost.localdomain>
 <a8860a42-31b5-4620-7b23-b7515ee11d7d@redhat.com>
 <20180326124711.GE5942@localhost.localdomain>
 <bf79b45e-7716-65af-03ca-7112dc367371@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf79b45e-7716-65af-03ca-7112dc367371@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 26, 2018 at 04:28:49PM -0400, Waiman Long wrote:
> Maybe we can have a different root level flag, say,
> sched_partition_domain that is equivalent to !sched_load_balnace.
> However, I am still not sure if we should enforce that no task should be
> in the root cgroup when the flag is set.
> 
> Tejun and Peter, what are your thoughts on this?

I haven't looked into the other issues too much but we for sure cannot
empty the root cgroup.

Thanks.

-- 
tejun
