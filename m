Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeEKL5x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:57:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeEKL5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:57:52 -0400
Date: Fri, 11 May 2018 12:57:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Li <pku.leo@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, lorenzo.pieralisi@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        lkml <linux-kernel@vger.kernel.org>, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] arm64: updates for 4.17
Message-ID: <20180511115747.hpryaxa2q357lwki@armageddon.cambridge.arm.com>
References: <20180404143239.GA18238@arm.com>
 <CADRPPNQhoXSGr4hpHaomcyamW51wT_F4fRTqZi4qtAD-jBHjxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNQhoXSGr4hpHaomcyamW51wT_F4fRTqZi4qtAD-jBHjxA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 11:03:18PM -0500, Yang Li wrote:
> On Wed, Apr 4, 2018 at 9:32 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Please pull these arm64 updates for 4.17. Note that I've pulled in a
> > stable branch from Eric Biederman here to fulfil some siginfo dependencies,
> > so the diffstat strays slightly out of arm64 due to his changes.
> {snip}
> >
> > Catalin Marinas (1):
> >       arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)
> 
> I'm wondering if we are changing the L1_CACHE_SHIFT to 6 in 4.17?
> This is causing big performance differences for us now.

We pushed it initially but there were some conflicts with the generic
dma work and we had to revert the above commit (so we are back to 7). I
plan to post it again, hopefully in time for 4.18.

-- 
Catalin
