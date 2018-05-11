Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeEKUC4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:02:56 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:45432 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeEKUCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:02:54 -0400
X-Google-Smtp-Source: AB8JxZpBbKz3MtsRZAojyGEd1m55MlWU7EdOfWNQC4oqVwx61cJxDk09nTNBm8F64BbfqqR8kJ39hg==
Date: Fri, 11 May 2018 13:02:50 -0700
From: Tejun Heo <tj@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
Message-ID: <20180511200250.GW2368884@devbig577.frc2.facebook.com>
References: <20180510163701.28936-1-guro@fb.com>
 <20180510183224.GP2368884@devbig577.frc2.facebook.com>
 <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
 <20180511143228.GU2368884@devbig577.frc2.facebook.com>
 <ae4dc3f9-baa6-b492-7c43-0359734440b3@kernel.org>
 <20180511162920.GV2368884@devbig577.frc2.facebook.com>
 <957d089f-7a88-9ff4-733a-8e082339720c@kernel.org>
 <20180511180342.GA20683@castle>
 <fb835740-cee8-83f8-880c-ea6eea8c7c63@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb835740-cee8-83f8-880c-ea6eea8c7c63@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 01:33:26PM -0600, Shuah Khan wrote:
> Yeah. I see that. You have a switch for the KSFT_ values. Since there is no
> dependency on the cgroup tree, I would recommend having this patch go through
> kselftest tree which is the normal process for tests anyway.
> 
> This version is good and I can apply this to linux-kselftest next. I ran a
> quick test and the Skip case looks good.
> 
> TAP version 13
> selftests: cgroup: test_memcontrol
> ========================================
> 1..0 # Skipped: memory controller isn't available
> not ok 1..1 selftests: cgroup: test_memcontrol [SKIP]
> 
> 
> Tejun! Please send me your Ack.

Sure, please feel free to add my ack.  I'll revert the original patch
from cgroup tree.

Thanks.

-- 
tejun
