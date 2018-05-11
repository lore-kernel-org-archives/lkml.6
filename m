Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEKQ3Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:29:25 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41607 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeEKQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:29:23 -0400
X-Google-Smtp-Source: AB8JxZoDRqR0nJ9fE8brJ7N4VaTa0MceQqZ2n4e1ufJz8nzdXHMXe3eT4VCI1j+ViM166oRzkouWCA==
Date: Fri, 11 May 2018 09:29:20 -0700
From: Tejun Heo <tj@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
Message-ID: <20180511162920.GV2368884@devbig577.frc2.facebook.com>
References: <20180510163701.28936-1-guro@fb.com>
 <20180510183224.GP2368884@devbig577.frc2.facebook.com>
 <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
 <20180511143228.GU2368884@devbig577.frc2.facebook.com>
 <ae4dc3f9-baa6-b492-7c43-0359734440b3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4dc3f9-baa6-b492-7c43-0359734440b3@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Shuah.

On Fri, May 11, 2018 at 08:55:28AM -0600, Shuah Khan wrote:
> I think we don't need to create a special branch and all. The following
> should work:
> 
> linux-next already has the skip work. What we can do is:
> 
> Do the cleanup and test it against linux-next. In linux-next SKIP isn't PASS. If test is
> compiled on linux-next, you will see that SKIP is SKIP. If it is compiled on the mainline,
> it will be reported PASS, which will be a temporary state.

Hah, why not just create a branch and make sure what we see in the
topic branch is what we'll push?  That's how these things are done
usually.

Thanks.

-- 
tejun
