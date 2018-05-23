Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933046AbeEWNMP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:12:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42692 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932950AbeEWNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:12:10 -0400
Date: Wed, 23 May 2018 15:11:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] perf/core: fix bad use of igrab in
 kernel/event/core.c
Message-ID: <20180523131159.GC12217@hirez.programming.kicks-ass.net>
References: <20180418062907.3210386-1-songliubraving@fb.com>
 <20180418062907.3210386-2-songliubraving@fb.com>
 <20180419061710.l6sdq3kvricpyjdu@um.fi.intel.com>
 <7815A35E-6506-477D-8E57-3960F7C1FE62@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7815A35E-6506-477D-8E57-3960F7C1FE62@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 09:56:18PM +0000, Song Liu wrote:
> Did this patch ever make into tip/perf/XX trees? If not, what shall I do 
> to move it ahead?

Got it now, thanks for the reminder.
