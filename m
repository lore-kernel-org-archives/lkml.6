Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeCLI1s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:27:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeCLI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:27:47 -0400
Date: Mon, 12 Mar 2018 09:27:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180312082741.GD4064@hirez.programming.kicks-ass.net>
References: <d109ixq7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d109ixq7.fsf@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 07:01:20AM +0000, Jason Vas Dias wrote:
>   Sometimes, particularly when correlating elapsed time to performance
>   counter values, 

So what actual problem are you tring to solve here? Perf can already
give you sample time in various clocks, including MONOTONIC_RAW.
