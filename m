Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757447AbeEJSci (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:32:38 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34016 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757305AbeEJSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:32:28 -0400
X-Google-Smtp-Source: AB8JxZo7Ro/D7A2iRQAuoSc3+IL9M/6Sj8Y9aVqOL2j3U6/FXMR2FqTyOiSdMXo8Hj/s7k30n4iaSw==
Date: Thu, 10 May 2018 11:32:24 -0700
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
Message-ID: <20180510183224.GP2368884@devbig577.frc2.facebook.com>
References: <20180510163701.28936-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510163701.28936-1-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 05:37:01PM +0100, Roman Gushchin wrote:
> Cgroups are used for controlling the physical resource distribution
> (memory, CPU, io, etc) and often are used as basic building blocks
> for large distributed computing systems. Even small differences
> in the actual behavior may lead to significant incidents.
> 
> The codebase is under the active development, which will unlikely
> stop at any time soon. Also it's scattered over different
> kernel subsystems, which makes regressions more probable.
> 
> Given that, the lack of any tests is crying.
> 
> This patch implements some basic tests for the memory controller,
> as well as a minimal required framework.
> It doesn't pretend for a very good coverage, but pretends
> to be a starting point.
> 
> Hopefully, any following significant changes will
> include corresponding tests.
> 
> Tests for CPU and io controllers, as well as cgroup core
> are next in the todo list.

This is great.  Applying to cgroup/for-4.18.

Thanks a lot.

-- 
tejun
