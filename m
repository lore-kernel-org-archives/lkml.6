Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeBLWsR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:17 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37512 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeBLWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:16 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 01/45] rtc: documentation: correct nvmem date and version
Date: Mon, 12 Feb 2018 23:47:15 +0100
Message-Id: <20180212224759.15999-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvmem interface appaeared in linux 4.13

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/ABI/testing/sysfs-class-rtc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rtc b/Documentation/ABI/testing/sysfs-class-rtc
index cf60412882f0..65270d95873c 100644
--- a/Documentation/ABI/testing/sysfs-class-rtc
+++ b/Documentation/ABI/testing/sysfs-class-rtc
@@ -58,8 +58,8 @@ Description:
 		(RO) RTC-provided time in 24-hour notation (hh:mm:ss)
 
 What:		/sys/class/rtc/rtcX/*/nvmem
-Date:		February 2016
-KernelVersion:	4.6
+Date:		July 2017
+KernelVersion:	4.13
 Contact:	linux-rtc@vger.kernel.org
 Description:
 		(RW) The non volatile storage exported as a raw file, as
-- 
2.16.1
