Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeEURfN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:35:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43911 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeEURfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:35:10 -0400
X-Google-Smtp-Source: AB8JxZoRIQ5MBeMJpB9EHvAVNB+/M9158c/i4WpX2dxl0WsqtFNDTYihJTZnoyk1Fk/MrHeA+ERLjg==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, jsimmons@infradead.org,
        andreas.dilger@intel.com, oleg.drokin@intel.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 2/4] staging: lustre: Fix "Possible intergrate"->"Possibly integrate"
Date: Mon, 21 May 2018 19:34:28 +0200
Message-Id: <20180521173430.9759-2-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520124408.GA10692@kroah.com>
References: <20180520124408.GA10692@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in TODO file.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/lustre/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/TODO b/drivers/staging/lustre/TODO
index 94446487748a..5332cdb19bfa 100644
--- a/drivers/staging/lustre/TODO
+++ b/drivers/staging/lustre/TODO
@@ -12,7 +12,7 @@ addressed:
 * https://jira.hpdd.intel.com/browse/LU-9859
 *
 * Track all the cleanups and simplification of the libcfs module. Remove
-* functions the kernel provides. Possible intergrate some of the functionality
+* functions the kernel provides. Possibly integrate some of the functionality
 * into the kernel proper.
 *
 ******************************************************************************
-- 
2.17.0
