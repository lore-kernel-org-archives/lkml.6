Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934816AbeEJIdE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:33:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40436 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeEJIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:33:02 -0400
Date: Thu, 10 May 2018 10:32:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] lockdep:  Change __lock_acquire to __lock_acquire_lockdep
Message-ID: <20180510083252.GX12217@hirez.programming.kicks-ass.net>
References: <1525900482-31661-1-git-send-email-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525900482-31661-1-git-send-email-greearb@candelatech.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 02:14:42PM -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This should make it easier to notice one is using lockdep when
> looking at 'perf top' and related output.

But you know now.. also, teach your benchmark scripts to complain if
/proc/lockdep exists.
