Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeDLLI6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:08:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44617 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751889AbeDLLI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:08:57 -0400
From: Li Bin <huawei.libin@huawei.com>
To: <peterz@infradead.org>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [PATCH 0/2] sched: pick and check task if double_lock_balance() unlock the rq
Date: Thu, 12 Apr 2018 18:58:53 +0800
Message-ID: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Bin (1):
  sched/deadline.c: pick and check task if double_lock_balance() unlock
    the rq

Zhou Chengming (1):
  sched/rt.c: pick and check task if double_lock_balance() unlock the
    rq

 kernel/sched/deadline.c | 48 +++++++++++++++++++++++-------------------------
 kernel/sched/rt.c       | 49 +++++++++++++++++++++++--------------------------
 2 files changed, 46 insertions(+), 51 deletions(-)

-- 
1.7.12.4
