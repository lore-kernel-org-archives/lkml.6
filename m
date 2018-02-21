Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeBUI3D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:29:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36389 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeBUI3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:29:02 -0500
Date: Wed, 21 Feb 2018 09:29:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Wanpeng Li <kernellwp@gmail.com>,
        Mike Galbraith <efault@gmx.de>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 2/7] nohz: Convert tick_nohz_tick_stopped() to bool
In-Reply-To: <1519186649-3242-3-git-send-email-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.1802210928570.24268@nanos.tec.linutronix.de>
References: <1519186649-3242-1-git-send-email-frederic@kernel.org> <1519186649-3242-3-git-send-email-frederic@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Feb 2018, Frederic Weisbecker wrote:

> It makes this function more self-explanatory about what it does and how
> to use it.
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
