Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbeBPJor (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:44:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeBPJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:44:45 -0500
Date: Fri, 16 Feb 2018 01:44:30 -0800
From: tip-bot for Hendrik Brueckner <tipbot@zytor.com>
Message-ID: <tip-hpw7vdjp7g92ivgpddrp5ydq@git.kernel.org>
Cc: tmricht@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mpetlan@redhat.com, hpa@zytor.com, mingo@kernel.org, jolsa@redhat.com,
        acme@redhat.com, tglx@linutronix.de, brueckner@linux.vnet.ibm.com
Reply-To: brueckner@linux.vnet.ibm.com, tglx@linutronix.de, acme@redhat.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, mpetlan@redhat.com, tmricht@linux.vnet.ibm.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf s390: Grab a copy of
 arch/s390/kernel/syscall/syscall.tbl
Git-Commit-ID: baa676103037e0dd145bb905eb51bc0b2f48fd49
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

Commit-ID:  baa676103037e0dd145bb905eb51bc0b2f48fd49
Gitweb:     https://git.kernel.org/tip/baa676103037e0dd145bb905eb51bc0b2f48fd49
Author:     Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
AuthorDate: Thu, 8 Feb 2018 12:47:49 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 10:06:00 -0300

perf s390: Grab a copy of arch/s390/kernel/syscall/syscall.tbl

Grab a copy of the s390 system call table file introduced with commit
857f46bfb07f53dc112d69bdfb137cc5ec3da7c5 "s390/syscalls: add system call
table".

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1518090470-2899-3-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-hpw7vdjp7g92ivgpddrp5ydq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {arch/s390/kernel => tools/perf/arch/s390/entry}/syscalls/syscall.tbl | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
similarity index 100%
copy from arch/s390/kernel/syscalls/syscall.tbl
copy to tools/perf/arch/s390/entry/syscalls/syscall.tbl
