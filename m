Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755300AbeDCJUo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:20:44 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:38661 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeDCJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:20:43 -0400
X-Google-Smtp-Source: AIpwx4+6+aNNY615sgzBWXTyOQCe4760RCLAXp0m4p+8L1/mzTjKOWrlWbjXt4ujjo92u58vSw7QKA==
From: SeongJae Park <sj38.park@gmail.com>
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 0/5] memory-barriers.txt: Applies upstream changes to the Korean version
Date: Tue,  3 Apr 2018 18:20:22 +0900
Message-Id: <20180403092027.13471-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies upstream changes for memory-barriers.txt to the Korean
version of it.

SeongJae Park (5):
  kokr/doc: READ_ONCE() now implies smp_barrier_depends()
  kokr/doc: De-emphasize smp_read_barrier_depends
  kokr/Documentation/memory-barriers.txt: Cross-reference
    "tools/memory-model/"
  kokr/memory-barriers: Fix description of data dependency barriers
  kokr/locking/memory-barriers: De-emphasize smp_read_barrier_depends()
    some more

 .../translations/ko_KR/memory-barriers.txt         | 50 +++++++++++++++-------
 1 file changed, 34 insertions(+), 16 deletions(-)

-- 
2.13.0
