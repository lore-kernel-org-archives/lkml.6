Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEVLIK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:08:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVLII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:08:08 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>
Subject: [PATCH v4 0/2] Fix and cleanup iowait boost
Date: Tue, 22 May 2018 12:07:52 +0100
Message-Id: <20180522110754.20832-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the (hopefully) final update of:

   https://lkml.org/lkml/2018/5/21/114
   20180521085120.7902-1-patrick.bellasi@arm.com

which just includes the small typo fixes suggested by Jeol and the ack
and review tags collected so far.

Cheers Patrick

Changes in v4:
 - fixed typos in changelog (Joel)
 - added Reviewed-by Joel Fernandes
 - added Acked-by Viresh and Peter

Changes in v3:
 - renamed the iowait boost functions (Peter)
 - moved boost reset into a dedicated function (Peter)
 - split the fix into a separated patch (Viresh)
 - added "Fixes" tag (Viresh)

Patrick Bellasi (2):
  cpufreq: schedutil: Fix iowait boost reset
  cpufreq: schedutil: Cleanup and document iowait boost

 kernel/sched/cpufreq_schedutil.c | 152 +++++++++++++++++++++++++++------------
 1 file changed, 108 insertions(+), 44 deletions(-)

-- 
2.15.1
