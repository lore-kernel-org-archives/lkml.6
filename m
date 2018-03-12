Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeCLIKU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:10:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeCLIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:10:18 -0400
Date: Mon, 12 Mar 2018 09:10:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 1/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180312081007.GD4043@hirez.programming.kicks-ass.net>
References: <d109lwfe.fsf@gmail.com>
 <alpine.DEB.2.21.1803112350190.1485@nanos.tec.linutronix.de>
 <20180312072413.toyd5ztkgaah35xg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312072413.toyd5ztkgaah35xg@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 08:24:13AM +0100, Ingo Molnar wrote:

>  - Code quality of the submitted patches is atrocious, please run them through
>    scripts/checkpatch.pl (and make sure they pass) to at least enable the reading 
>    of them.

I'd suggest also reading: Documentation/CodingStyle
