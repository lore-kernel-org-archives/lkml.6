Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeBLUcl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:32:41 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45337 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbeBLUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:32:39 -0500
X-Google-Smtp-Source: AH8x224n3eye79BWc8kX4a/Fi+paiqbsqAuq3500CSNb+ZSn0rxnblpoNgEB1gcfXgr6deNtP59d/w==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf tools: Miscellaneous fix from the previous cycle
Date: Mon, 12 Feb 2018 13:32:34 -0700
Message-Id: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Arnaldo,

Here are 3 patches that were sent late in the v4.15 cycle, too late for
you to pick up for the v4.16 cycle.  I don't know if they are on a backlog
of yours somewhere or if you've made a mental note of them - if so kindly
disregard this set.  Otherwise, here they are again, rebased to your latest
perf/core [1].

All 3 patches are required for proper functionning of the CoreSight
trace decoding integration that is in the current cycle.

Regards,
Mathieu

[1]. f13c88d836d8 perf report: Add support to display group output for non group events

Jin Yao (1):
  perf util: Use target->per_thread and target->system_wide flags

Mathieu Poirier (2):
  perf tools: Freeing allocated memory
  perf tools: Fixing uninitialised variable

 tools/perf/arch/arm/util/auxtrace.c |  2 +-
 tools/perf/util/cs-etm.c            |  6 ++++++
 tools/perf/util/evlist.c            | 21 ++++++++++++++++++++-
 tools/perf/util/thread_map.c        |  4 ++--
 tools/perf/util/thread_map.h        |  2 +-
 5 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.7.4
