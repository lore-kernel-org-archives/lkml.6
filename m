Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeEURfC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:35:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44613 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeEURfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:35:00 -0400
X-Google-Smtp-Source: AB8JxZr3gI0JIq96blYtGy0f5zQbnb1cD2s3yIQJHxHINXLkIq51X5eZ0mD0QlWEKNDVDw7hdjrb4A==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, jsimmons@infradead.org,
        andreas.dilger@intel.com, oleg.drokin@intel.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 1/4] staging: lustre: Fix "from from"->"from"
Date: Mon, 21 May 2018 19:34:27 +0200
Message-Id: <20180521173430.9759-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520124408.GA10692@kroah.com>
References: <20180520124408.GA10692@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in README.txt

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/lustre/README.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/README.txt b/drivers/staging/lustre/README.txt
index 0676243eea9e..783959240490 100644
--- a/drivers/staging/lustre/README.txt
+++ b/drivers/staging/lustre/README.txt
@@ -4,7 +4,7 @@ Lustre Parallel Filesystem Client
 The Lustre file system is an open-source, parallel file system
 that supports many requirements of leadership class HPC simulation
 environments.
-Born from from a research project at Carnegie Mellon University,
+Born from a research project at Carnegie Mellon University,
 the Lustre file system is a widely-used option in HPC.
 The Lustre file system provides a POSIX compliant file system interface,
 can scale to thousands of clients, petabytes of storage and
-- 
2.17.0
