Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeA3VBq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:01:46 -0500
Received: from mail.efficios.com ([167.114.142.141]:40645 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeA3VBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:01:44 -0500
Date: Tue, 30 Jan 2018 21:02:17 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1016989198.12891.1517346137739.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.8 and 2.10.5 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Index: fAK6C91RSiTUWKSXUdSFQWLXrUE80Q==
Thread-Topic: LTTng-modules 2.9.8 and 2.10.5 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stable releases 2.9.8 and 2.10.5 of the LTTng-modules kernel tracer
introduces support for the 4.15 Linux kernel, updates support for currently
maintained Linux kernel stable branches, and contains bugfixes.

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2018-01-30 (National Croissant Day) LTTng modules 2.9.8
        * Fix: network instrumentation protocol enum
        * Fix: update btrfs instrumentation for SuSE 4.4.103-6
        * Fix: update block instrumentation for SuSE 4.4.73-5
        * Fix: global_dirty_limit for kernel v4.2 and up
        * Fix: network instrumentation handling of corrupted TCP headers
        * Fix: add missing uaccess.h include from kstrtox.h wrapper
        * Update: kvm instrumentation for 4.14.14+, 4.9.77+, 4.4.112+
        * Fix: btrfs_delayed_ref_head was unwired since v3.12
        * Update kvm instrumentation for debian kernel 4.9.65-3
        * Fix: debian kernel version parsing
        * Fix: block instrumentation 4.14+ NULL pointer dereference
        * Update: kvm instrumentation for 3.16.52 and 3.2.97
        * Fix: kvm instrumentation for 4.15
        * Update sock instrumentation for 4.15
        * Update kvm instrumentation for 4.15
        * Fix: ACCESS_ONCE() removed in kernel 4.15
        * Fix: sched instrumentation on stable RT kernels
        * timer API transition for kernel 4.15
        * Fix: Don't nest get online cpus
        * Fix: lttng_channel_syscall_mask() bool use in bitfield
        * Fix: update kmem instrumentation for kernel 4.15

2018-01-30 (National Croissant Day) LTTng modules 2.10.5
        * Fix: network instrumentation protocol enum
        * Fix: update btrfs instrumentation for SuSE 4.4.103-6
        * Fix: update block instrumentation for SuSE 4.4.73-5
        * Fix: global_dirty_limit for kernel v4.2 and up
        * Fix: network instrumentation handling of corrupted TCP headers
        * Fix: add missing uaccess.h include from kstrtox.h wrapper
        * Update: kvm instrumentation for 4.14.14+, 4.9.77+, 4.4.112+
        * Fix: btrfs_delayed_ref_head was unwired since v3.12
        * Update kvm instrumentation for debian kernel 4.9.65-3
        * Fix: debian kernel version parsing
        * Fix: block instrumentation 4.14+ NULL pointer dereference
        * Update: kvm instrumentation for 3.16.52 and 3.2.97
        * Fix: kvm instrumentation for 4.15
        * Update sock instrumentation for 4.15
        * Update kvm instrumentation for 4.15
        * Fix: ACCESS_ONCE() removed in kernel 4.15
        * Fix: sched instrumentation on stable RT kernels
        * timer API transition for kernel 4.15
        * Fix: Don't nest get online cpus
        * Fix: lttng_channel_syscall_mask() bool use in bitfield
        * Fix: update kmem instrumentation for kernel 4.15

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
