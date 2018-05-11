Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeEKIjy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:39:54 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:60274 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752191AbeEKIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:39:53 -0400
Date: Fri, 11 May 2018 09:39:47 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, efault@gmx.de,
        linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
        ggherdovich@suse.cz, mpe@ellerman.id.au
Subject: Re: [PATCH] Revert "sched/numa: Delay retrying placement for
 automatic NUMA balance after wake_affine()"
Message-ID: <20180511083947.lklu2comrh4igcf6@techsingularity.net>
References: <20180509163115.6fnnyeg4vdm2ct4v@techsingularity.net>
 <20180510020451.GB41120@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180510020451.GB41120@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 07:04:51PM -0700, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2018-05-09 17:31:15]:
> 
> > This reverts commit 7347fc87dfe6b7315e74310ee1243dc222c68086.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> 

Thanks Srikar.

Can someone pick this up before rc5 please? I'd rather not go through
another rc week with this hanging around.

-- 
Mel Gorman
SUSE Labs
