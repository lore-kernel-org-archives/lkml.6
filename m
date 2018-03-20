Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeCTG2W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:28:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeCTG2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:28:20 -0400
Date: Mon, 19 Mar 2018 23:27:38 -0700
From: tip-bot for Ganapatrao Kulkarni <tipbot@zytor.com>
Message-ID: <tip-a8685f088819d21cd5aea5de4c184de427c3625d@git.kernel.org>
Cc: wcohen@redhat.com, ganapatrao.kulkarni@cavium.com,
        gpkulkarni@gklkml16.com, jolsa@redhat.com, peterz@infradead.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        john.garry@huawei.com, jnair@caviumnetworks.com, mingo@kernel.org,
        will.deacon@arm.com, tglx@linutronix.de, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, robert.richter@cavium.com
Reply-To: mingo@kernel.org, jnair@caviumnetworks.com, john.garry@huawei.com,
        hpa@zytor.com, will.deacon@arm.com, tglx@linutronix.de,
        robert.richter@cavium.com, alexander.shishkin@linux.intel.com,
        mark.rutland@arm.com, wcohen@redhat.com, gpkulkarni@gklkml16.com,
        ganapatrao.kulkarni@cavium.com, peterz@infradead.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
Git-Commit-ID: a8685f088819d21cd5aea5de4c184de427c3625d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a8685f088819d21cd5aea5de4c184de427c3625d
Gitweb:     https://git.kernel.org/tip/a8685f088819d21cd5aea5de4c184de427c3625d
Author:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
AuthorDate: Wed, 7 Mar 2018 16:38:03 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:55:41 -0300

perf vendor events arm64: Enable JSON events for ThunderX2 B0

There is MIDR change on ThunderX2 B0, adding an entry to mapfile to
enable JSON events for B0.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ganapatrao Kulkarni <gpkulkarni@gklkml16.com>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@cavium.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20180307110803.32418-1-ganapatrao.kulkarni@cavium.com
[ Fixup wrt recent patchset by John Garry ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 8f11aeb003a9..f03e26ecb658 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -14,4 +14,5 @@
 #Family-model,Version,Filename,EventType
 0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
+0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
