Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758995AbeD0Thf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:37:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56174 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758565AbeD0Thd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:37:33 -0400
Date: Fri, 27 Apr 2018 21:37:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [RFD] x86: The future of MPX
Message-ID: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

I've got the following MPX related information:

 .... But they [Intel] certainly haven't maintained the whole MPX support
 in GCC at all since two or three years (e.g. bootstrap with MPX was broken
 since forever), so now it's gone from GCC. ....

and I know that GCC is discussing MPX removal since May last year at least.
To the best of my knowledge clang does not support it either.

So what's the state of this stuff? If we don't have a compiler supporting
it how on earth is that useful or even testable for anyone who does not
have access to some magic Intel internal compiler version?

If that's the sad state of affairs, then we just should move the whole
stuff into staging or simply queue it for removal in 4.18.

Thanks,

	tglx
