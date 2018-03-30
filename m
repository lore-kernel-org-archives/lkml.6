Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeC3JwE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:52:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57256 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeC3JwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:52:02 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Do not include debugfs.h
Date: Fri, 30 Mar 2018 11:52:19 +0200
Message-ID: <1679361.0Gr8UWkMAK@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The intel_pstate driver doesn't use debugfs any more, so drop
linux/debugfs.h from the list of included headers in it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -26,7 +26,6 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/fs.h>
-#include <linux/debugfs.h>
 #include <linux/acpi.h>
 #include <linux/vmalloc.h>
 #include <trace/events/power.h>
