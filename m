Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935374AbeEISPU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:15:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:40272 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755415AbeEISPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:15:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AFE221B74F8
Date: Wed, 9 May 2018 14:15:18 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1944310744.230.1525889718516.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.9 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Index: QeelOCWtiXmBN00fPNQ2+pvgv3anZQ==
Thread-Topic: LTTng-modules 2.9.9 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bugfix update of the stable-2.9 series of the LTTng modules
project. It updates support to kernel 4.17-rc4 as well.

Thanks,

Mathieu

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2018-05-09 (Lost Sock Memorial Day) LTTng modules 2.9.9
        * Fix: update RCU instrumentation for 4.17
        * Fix: sunrpc instrumentation for 4.17
        * Fix: use struct reclaim_stat in mm_vmscan_lru_shrink_inactive for 4.17
        * Fix: Add gfp_flags arg to mm_vmscan_kswapd_wake for 4.17
        * Update: kvm instrumentation for ubuntu 4.13.0-38
        * Fix: update kvm instrumentation for Ubuntu 3.13.0-144
        * Fix: btrfs instrumentation namespacing
        * Cleanup: comment about CONFIG_HOTPLUG_CPU ifdef
        * Fix: do not use CONFIG_HOTPLUG_CPU for the new hotplug API
        * Fix: update kvm instrumentation for 4.1.50+
        * Use the memory pool instead of kmalloc
        * Create a memory pool for temporary tracepoint probes storage
        * Fix: use proper pid_ns in the process statedump
        * Fix: add variable quoting to shell scripts
        * Update: kvm instrumentation for fedora 4.14.13-300
        * Fix: Add Fedora version macros
        * Fix: update btrfs instrumentation for SuSE 4.4.114-92
        * Fix: update block instrumentation for SuSE 4.4.114-92
        * Fix: update rcu instrumentation for v4.16
        * Fix: update vmscan instrumentation for v4.16
        * Fix: update timer instrumentation on 4.16 and 4.14-rt
        * Update kvm instrumentation for debian kernel 4.14.0-3

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
