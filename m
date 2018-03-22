Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCVRaN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:30:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeCVRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:30:11 -0400
Date: Thu, 22 Mar 2018 18:29:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 23/45] sched: add do_sched_yield() helper; remove
 in-kernel call to sched_yield()
Message-ID: <20180322172959.GX4043@hirez.programming.kicks-ass.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-24-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322090059.19361-24-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:00:37AM +0100, Dominik Brodowski wrote:
> Using the sched-internal do_sched_yield() helper allows us to get rid of
> the sched-internal call to the sys_sched_yield() syscall.
> 
> This patch is part of a series which tries to remove in-kernel calls to
> syscalls. On this basis, the syscall entry path can be streamlined.

But why !? Either Cc me on more of the series such that the whole makes
sense, or better yet, write a proper Changelog.
