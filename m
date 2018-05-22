Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeEVGUk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:20:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42783 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEVGUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:20:36 -0400
X-Google-Smtp-Source: AB8JxZomgi0AuGeSAVX4G8USVi7jEF+PsFkbzIYTmcPtibOvmJk8L93kj7BV87nD2qLn826xv1K3Wg==
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ibobrik@gmail.com, Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 0/3] sched/fair: improve CFS throttle
Date: Mon, 21 May 2018 23:20:14 -0700
Message-Id: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cong Wang (3):
  sched/fair: make CFS bandwidth slice per cpu group
  sched/fair: accumulate unused cpu time for CFS throttle
  sched/fair: add tracepoints for cfs throttle

 Documentation/scheduler/sched-bwc.txt |  25 ++++++--
 include/trace/events/sched.h          |  42 +++++++++++++
 kernel/sched/core.c                   | 109 ++++++++++++++++++++++++++++++++--
 kernel/sched/fair.c                   |  76 +++++++++++++++---------
 kernel/sched/sched.h                  |   4 +-
 5 files changed, 216 insertions(+), 40 deletions(-)

-- 
2.13.0
