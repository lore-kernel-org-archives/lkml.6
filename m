Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbeD3O03 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:26:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeD3O02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:26:28 -0400
Message-Id: <20180430141751.377491406@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 16:17:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, will.deacon@arm.com,
        mpe@ellerman.id.au, bigeasy@linutronix.de, gkohli@codeaurora.org,
        neeraju@codeaurora.org, peterz@infradead.org
Subject: [PATCH 0/2] sched,kthread: Fix TASK_PARKED and special sleep states
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first patch should fix the reported TASK_PARKED problem and the second
should fix any potential TASK_STOPPED, TASK_TRACED issues.
