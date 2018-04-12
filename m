Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeDLMXf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:23:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45453 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeDLMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:23:33 -0400
X-Google-Smtp-Source: AIpwx48/f1PJGQSVskCtfA7QgcBTxvwbJR0ZuElhqvZpOy4d4+38iwbhzMd44ws9hrSqsNS7uTWuMg==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 0/2] tools/memory-model: Model 'smp_store_mb()'
Date: Thu, 12 Apr 2018 14:22:48 +0200
Message-Id: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This (tiny) series adds 'smp_store_mb()' to the model (patch 1/2), and
it fixes a stylistic discrepancy in 'linux-kernel.def (patch 2/2).

Cheers,
  Andrea

Andrea Parri (2):
  tools/memory-model: Model 'smp_store_mb()'
  tools/memory-model: Fix coding style in 'linux-kernel.def'

 tools/memory-model/linux-kernel.def | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.7.4
