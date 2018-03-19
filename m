Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970372AbeCSSgF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:36:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966821AbeCSSgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:36:03 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] small scheduler debug stat fixups
Date: Mon, 19 Mar 2018 14:35:53 -0400
Message-Id: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer noticed some misalignment issues in the scheduler debug stats
caused by line break/continuations.  While the kernel isn't responsible
for log rendering, these trivial changes can help clean up the stats
display with default settings for dmesg/rsyslog/etc.  

Note that /proc/sched_debug didn't suffer from these issues and its
output remains unchanged by this patchset.

Joe Lawrence (2):
  sched/debug: fix per-task line continuation for console
  sched/debug: adjust newlines for better alignment

 kernel/sched/debug.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

-- 
1.8.3.1
