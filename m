Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933722AbeEIGeY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:34:24 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:40235 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeEIGeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:34:23 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date: Wed, 9 May 2018 15:33:22 +0900
From: Byungchul Park <byungchul.park@lge.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        raistlin@linux.it, linux-kernel@vger.kernel.org, juri.lelli@gmail.com,
        bristot@redhat.com, kernel-team@lge.com
Subject: Re: [RESEND PATCH v3 1/2] sched/deadline: Add cpudl_maximum_dl() for
 clean-up
Message-ID: <20180509063322.GA29160@X58A-UD3R>
References: <1515392081-32320-1-git-send-email-byungchul.park@lge.com>
 <20180111090716.GV6176@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111090716.GV6176@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2018 at 10:07:16AM +0100, Peter Zijlstra wrote:
> 
> 
> Sorry for the huge delay on this, but I'll have to postpone further.
> Still busy with meltdown/spectre stuff.

Please consider this. Even though it's not a big bug, anyway leading
mis-behavior in certain situaions.
