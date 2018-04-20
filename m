Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754960AbeDTNTO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:19:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbeDTNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:19:11 -0400
Message-Id: <20180420131407.721875616@infradead.org>
User-Agent: quilt/0.63-1
Date: Fri, 20 Apr 2018 15:14:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: tglx@linutronix.de, dan.j.williams@intel.com,
        torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: [PATCH 0/7] Various Spectre-v1 fixes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fix a number of perf, x86 and sched cases where we have user controlled
array dereferences.  All were found by Dan's recent Smatch update.
