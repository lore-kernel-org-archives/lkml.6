Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeDLH5l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:57:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:29451 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbeDLH5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:57:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,440,1517904000";
   d="scan'208";a="50163537"
Date: Thu, 12 Apr 2018 15:57:01 +0800
From: "Liu, Changcheng" <changcheng.liu@intel.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] timers: remove tvec_base struct declaration
Message-ID: <20180412075701.GA38952@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timer wheel is implemented by timer_base. tvec_base is obsoleted,
so remove the type declaration.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 2448f9c..7b066fd 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -8,8 +8,6 @@
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
 
-struct tvec_base;
-
 struct timer_list {
 	/*
 	 * All fields that change during normal runtime grouped to the
-- 
2.7.4
