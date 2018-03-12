Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCLQjb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:39:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44230 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCLQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:39:30 -0400
Date: Mon, 12 Mar 2018 17:39:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH] perf/x86/uncore: Add missing filter constraint for SKX
 CHA event
Message-ID: <20180312163914.GG4043@hirez.programming.kicks-ass.net>
References: <1520869294-14176-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520869294-14176-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 08:41:34AM -0700, Kan Liang wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> Adding a filter constraint for Intel Skylake CHA event
> UNC_CHA_UPI_CREDITS_ACQUIRED (0x38).
> The event supports core-id/thread-id and link filtering.

Could you also comment on the other CHA patch?

 https://lkml.kernel.org/r/CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM
