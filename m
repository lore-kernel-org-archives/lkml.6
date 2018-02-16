Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031694AbeBPNjR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:39:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031458AbeBPNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:39:15 -0500
Date: Fri, 16 Feb 2018 14:38:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 0/6] isolation: 1Hz residual tick offloading v6
Message-ID: <20180216133858.GD25201@hirez.programming.kicks-ass.net>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518655694-8057-1-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 01:48:08AM +0100, Frederic Weisbecker wrote:
> The version addresses the reviews from Ingo on v5:
> 
> * Start changelog titles with verbs.
> * Improve/reword several comments.
> * Improve/reword documentation.
> * Various cosmetic changes.
> * Use BUG_ON() on boot allocation failure.
> 

Thanks!
