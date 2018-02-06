Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeBFTX0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:23:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39296 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbeBFTXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:23:22 -0500
X-Google-Smtp-Source: AH8x224eidexnqmm3tKWe7yxHKlm62vRG2UbMaEWKL4R4qqi2Kks+S4ong0XHkWwFw1KK6SF5eCx1A==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/3] Update blocked load
Date: Tue,  6 Feb 2018 20:23:04 +0100
Message-Id: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of Peter's sched/esting branch minus the last 2 commit:
56eb46798b33 ("sched: Clean up nohz enter/exit")

v2:
- minor naming updates

Vincent Guittot (3):
  sched: Stop nohz stats when decayed
  sched: reduce the periodic update duration
  sched: update blocked load when newly idle

 kernel/sched/fair.c  | 203 ++++++++++++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h |   1 +
 2 files changed, 169 insertions(+), 35 deletions(-)

-- 
2.7.4
