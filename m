Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDLMnH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:43:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43222 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751881AbeDLMnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:43:06 -0400
From: Li Bin <huawei.libin@huawei.com>
To: <peterz@infradead.org>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [PATCH v2 0/2] sched: pick and check task if double_lock_balance() unlock the rq
Date: Thu, 12 Apr 2018 20:33:02 +0800
Message-ID: <1523536384-26781-1-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
* Only change the comment and coding style as suggested by Steve

Li Bin (1):
  sched/deadline.c: pick and check task if double_lock_balance() unlock
    the rq

Zhou Chengming (1):
  sched/rt.c: pick and check task if double_lock_balance() unlock the
    rq

 kernel/sched/deadline.c | 55 +++++++++++++++++++++++++++----------------------
 kernel/sched/rt.c       | 50 +++++++++++++++++++++-----------------------
 2 files changed, 54 insertions(+), 51 deletions(-)

-- 
1.7.12.4
