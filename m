Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeEKOcg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:32:36 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46484 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeEKOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:32:32 -0400
X-Google-Smtp-Source: AB8JxZpARKKoOF2NjOG+IBOzSqSA8AHOVUtVDPjdJPFjiPiW1vkdwQKCHufe4qnl6VoBv9NiA3aJ/g==
Date: Fri, 11 May 2018 07:32:28 -0700
From: Tejun Heo <tj@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
Message-ID: <20180511143228.GU2368884@devbig577.frc2.facebook.com>
References: <20180510163701.28936-1-guro@fb.com>
 <20180510183224.GP2368884@devbig577.frc2.facebook.com>
 <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Shuah.

On Thu, May 10, 2018 at 01:29:07PM -0600, Shuah Khan wrote:
> Don't pull them yet. If Roman can redo the patches on linux-kselftest next,
> he can pick up the SKIP changes.

So, what we can do is either fix that up during / after the merge
window or creating a separate branch which pulls from both cgroup and
kselftest.  Please let me know which way you wanna go and if the
latter which branch I should pull (it gotta be a stable branch).

Thanks.

-- 
tejun
