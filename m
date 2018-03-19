Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933673AbeCSPeW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:34:22 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:35485 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeCSPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:34:17 -0400
X-Google-Smtp-Source: AG47ELsJcaD5gvJuCUS9PhhnIVQu0l9unNizNRkQ6SGJCWcCchyYRzNiXZdgikE51bDXUN2uPlmE5w==
Date: Mon, 19 Mar 2018 08:34:13 -0700
From: Tejun Heo <tj@kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
Message-ID: <20180319153413.GO2943022@devbig577.frc2.facebook.com>
References: <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
 <1520619426.27998.18.camel@gmx.de>
 <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
 <1520624424.27998.76.camel@gmx.de>
 <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
 <20180309221736.GB5926@hirez.programming.kicks-ass.net>
 <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
 <1520653648.12749.20.camel@gmx.de>
 <20180314195711.GD2943022@devbig577.frc2.facebook.com>
 <1521082141.7100.1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521082141.7100.1.camel@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mike.

On Thu, Mar 15, 2018 at 03:49:01AM +0100, Mike Galbraith wrote:
> Under the hood v2 details are entirely up to you.  My input ends at
> please don't leave dynamic partitioning standing at the dock when v2
> sails.

So, this isn't about implementation details but about what the
interface achieves - ie, what's the actual function?  The only thing I
can see is blocking the entity which is configuring the hierarchy from
making certain configs.  While that might be useful in some specific
use cases, it seems to miss the bar for becoming its own kernel
feature.  After all, nothing prevents the same entity from clearing
the exlusive bit and making the said changes.

Thanks.

-- 
tejun
