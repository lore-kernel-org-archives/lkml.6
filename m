Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeBQKvc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:51:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeBQKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:51:31 -0500
Date: Sat, 17 Feb 2018 11:51:39 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 5/6] sched/nohz: Remove the 1 Hz tick code
In-Reply-To: <1518655694-8057-6-git-send-email-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.1802171151200.2087@nanos.tec.linutronix.de>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org> <1518655694-8057-6-git-send-email-frederic@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Frederic Weisbecker wrote:

> Now that the 1Hz tick is offloaded to workqueues, we can safely remove
> the residual code that used to handle it locally.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
 
