Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBIHAO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:00:14 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33918 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBIHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:00:10 -0500
X-Google-Smtp-Source: AH8x224M6Lc82m35QKGK34g9FHyp9tPxfJtbq5yt6qYPjTqLDW++mjQJRUchFvfrJVOL+WrEZRV8Gg==
Date: Fri, 9 Feb 2018 08:00:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 0/6] isolation: 1Hz residual tick offloading v5
Message-ID: <20180209070006.ndi57j2llrywo4yt@gmail.com>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518112779-30196-1-git-send-email-frederic@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

>       sched/isolation: Residual 1Hz scheduler tick offload
>       sched/isolation: Tick offload documentation

Please try to start each title with a verb.

[ ... and preferably not by prepending 'do' ;-) ]

Beyond making changelogs more consistent, this will actually also add real 
information to the title, because, for example, any of these possible variants:

       sched/isolation: Fix tick offload documentation
       sched/isolation: Update tick offload documentation
       sched/isolation: Add tick offload documentation
       sched/isolation: Remove tick offload documentation

       sched/isolation: Fix residual 1Hz scheduler tick offload
       sched/isolation: Update residual 1Hz scheduler tick offload
       sched/isolation: Introduce residual 1Hz scheduler tick offload
       sched/isolation: Remove residual 1Hz scheduler tick offload

will tell us _a lot more_ about the nature of the changes from the shortlog alone!

Thanks,

	Ingo
