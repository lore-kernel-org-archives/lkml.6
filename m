Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeEGJhZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:37:25 -0400
Received: from osg.samsung.com ([64.30.133.232]:46721 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbeEGJgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:36:10 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH 18/18] w1: w1_io.c: fix a kernel-doc warning
Date: Mon,  7 May 2018 06:35:54 -0300
Message-Id: <cd5b6e6a8d51820ee158127cdd50e44645c44ee7.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line to avoid this Sphinx warning:
	./drivers/w1/w1_io.c:197: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/w1/w1_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index 075d120e7b88..0364d3329c52 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -194,6 +194,7 @@ static u8 w1_read_bit(struct w1_master *dev)
  *  bit 0 = id_bit
  *  bit 1 = comp_bit
  *  bit 2 = dir_taken
+ *
  * If both bits 0 & 1 are set, the search should be restarted.
  *
  * Return:        bit fields - see above
-- 
2.17.0
