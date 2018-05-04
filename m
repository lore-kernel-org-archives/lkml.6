Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeEDRFE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:05:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeEDRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:05:01 -0400
Date: Fri, 4 May 2018 19:04:59 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
Message-ID: <20180504170459.624e7vkro5fn2bgw@linutronix.de>
References: <20180504144014.5378-1-bigeasy@linutronix.de>
 <87fu37e4rn.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87fu37e4rn.fsf@xmission.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 11:59:08 [-0500], Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
…
> > This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
> > wait_lock irq safe") for different reason.
> 
> Which tree has this change been made in?  I am not finding the commit
> you mention above in Linus's tree.

I'm sorry, it should have been commit b4abf91047cf ("rtmutex: Make
wait_lock irq safe").

> > Therefore revert commit a841796f11c9 ("signal: align >
> > __lock_task_sighand() irq disabling and RCU") as the interrupt disable
> > dance is not longer required.
> 
> Which tree is change aimed at?

tip -> Linus' tree

> Eric

Sebastian
