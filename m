Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeFEIlv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:41:51 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:58669 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751685AbeFEIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:41:49 -0400
Date: Tue, 5 Jun 2018 09:41:47 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/19] sched/numa: Remove redundant field.
Message-ID: <20180605084147.wqjdj7hvoudfzxjp@techsingularity.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-2-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1528106428-19992-2-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:10PM +0530, Srikar Dronamraju wrote:
> numa_entry is a list_head defined in task_struct, but never used.
> 
> No functional change
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
