Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161086AbeCASui (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161054AbeCASu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:50:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370CF21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 1 Mar 2018 13:50:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and
 clock BOOTTIME
Message-ID: <20180301135025.2cc4ba4b@vmware.local.home>
In-Reply-To: <alpine.DEB.2.21.1803011936200.1391@nanos.tec.linutronix.de>
References: <20180301163331.987775783@linutronix.de>
        <CA+55aFzV8Q20vL83xa+1UKzeQ0w-SAksCDxJD4szALRDCSUZ2w@mail.gmail.com>
        <alpine.DEB.2.21.1803011936200.1391@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 19:41:35 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> I'm old enough to have learned that conflate means unify or combine, but
> I'm still not old enough to be stubborn about it :)

You need to watch more American Cable News channels to know what
"conflate" means today.

-- Steve
