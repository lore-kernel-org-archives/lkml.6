Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeCTMv0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:51:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35456 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeCTMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:51:19 -0400
Date: Tue, 20 Mar 2018 13:51:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mulix@mulix.org, thomas.lendacky@amd.com, dwmw2@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org, hch@lst.de, konrad.wilk@oracle.com,
        jdmason@kudzu.us, tglx@linutronix.de, hpa@zytor.com
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y quirk
Message-ID: <20180320125102.GT4043@hirez.programming.kicks-ass.net>
References: <20180319103826.12853-2-hch@lst.de>
 <tip-5927145efd5de71976e62e2822511b13014d7e56@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-5927145efd5de71976e62e2822511b13014d7e56@git.kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 04:04:49AM -0700, tip-bot for Christoph Hellwig wrote:

> x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y quirk
> 
> There were only a few Pentium Pro multiprocessors systems where this
> errata applied. They are more than 20 years old now, and we've slowly
> dropped places which put the workarounds in and discouraged anyone
> from enabling the workaround.
> 
> Get rid of it for good.

Hoorah!! x86 is back to pure TSO.
