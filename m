Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935819AbeEXI1A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:27:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935502AbeEXI04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:26:56 -0400
Date: Thu, 24 May 2018 09:26:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 02/13] atomics/treewide: remove redundant
 atomic_inc_not_zero() definitions
Message-ID: <20180524082646.rvf3pi2htdeuwvel@salmiak>
References: <20180523133533.1076-1-mark.rutland@arm.com>
 <20180523133533.1076-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523133533.1076-3-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 02:35:22PM +0100, Mark Rutland wrote:
> vWhen atomic_inc_not_zero(v) isn't defined, <linux/atomic.h> will define
> it as falling back to atomic_add_unless((v), 1, 0), so there's no need
> for arch code to do so.

Typo: s/vWhen/When/

I've fixed that up in the git branch.

Mark.
