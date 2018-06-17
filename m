Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6585C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE0D2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X2RZT5b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE0D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933917AbeFQCMS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:12:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933846AbeFQCBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MLScAEuK5LQwXVL8ayl66WZYDQJNv/NZDK6KmEnVNRY=; b=X2RZT5b4RqlqxNVagds5F2UuG
        F+PBquSCdj3ms+w0+Js50wBcrhx9sZCTJRWatKF/97qugOdZv9Dk+NpcsOPDonusRk9VkSSPozY4k
        smI1iv6PDq1s9JACIZ6OWfc0ijAlOcELJy+Ko2TFMtPsOmfH2q6uHj8RJQBK4EPRAQMYbCpC2Lz1g
        yiu+GjEHKnPiZ1BF+pfRpc9V/KC4jL/ZUtNWP1nHUCTaEfu689yB28dHmQVT+IUAvISXTqCj2/T18
        cxS3XJ+60mRJquf8fPewLbOqYAFEsa7FTMQUB9My6bfAu74wLS1Hz7cotHF03qZM4HGw2DtuAw3JH
        Q9xI3L9zw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUMzu-0001Fb-Jt; Sun, 17 Jun 2018 02:00:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 01/74] Update email address
Date:   Sat, 16 Jun 2018 18:59:39 -0700
Message-Id: <20180617020052.4759-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redirect some older email addresses that are in the git logs.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 .mailmap               | 7 +++++++
 MAINTAINERS            | 6 +++---
 include/linux/xarray.h | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 29ddeb1bf015..a80dca923d32 100644
--- a/.mailmap
+++ b/.mailmap
@@ -114,6 +114,13 @@ Mark Brown <broonie@sirena.org.uk>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
+Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
+Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
+Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>
+Matthew Wilcox <willy@infradead.org> <mawilcox@microsoft.com>
+Matthew Wilcox <willy@infradead.org> <willy@debian.org>
+Matthew Wilcox <willy@infradead.org> <willy@linux.intel.com>
+Matthew Wilcox <willy@infradead.org> <willy@parisc-linux.org>
 Matthieu CASTET <castet.matthieu@free.fr>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@brturbo.com.br>
 Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index f15bc83753f5..6dc2c9cb2d7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -529,7 +529,7 @@ F:	Documentation/hwmon/adt7475
 F:	drivers/hwmon/adt7475.c
 
 ADVANSYS SCSI DRIVER
-M:	Matthew Wilcox <matthew@wil.cx>
+M:	Matthew Wilcox <willy@infradead.org>
 M:	Hannes Reinecke <hare@suse.com>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
@@ -4268,7 +4268,7 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-diolan-u2c.c
 
 FILESYSTEM DIRECT ACCESS (DAX)
-M:	Matthew Wilcox <mawilcox@microsoft.com>
+M:	Matthew Wilcox <willy@infradead.org>
 M:	Ross Zwisler <ross.zwisler@linux.intel.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
@@ -8452,7 +8452,7 @@ F:	drivers/message/fusion/
 F:	drivers/scsi/mpt3sas/
 
 LSILOGIC/SYMBIOS/NCR 53C8XX and 53C1010 PCI-SCSI drivers
-M:	Matthew Wilcox <matthew@wil.cx>
+M:	Matthew Wilcox <willy@infradead.org>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/sym53c8xx_2/
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 2dfc8006fe64..9e4c86853fa4 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -4,7 +4,7 @@
 /*
  * eXtensible Arrays
  * Copyright (c) 2017 Microsoft Corporation
- * Author: Matthew Wilcox <mawilcox@microsoft.com>
+ * Author: Matthew Wilcox <willy@infradead.org>
  */
 
 #include <linux/spinlock.h>
-- 
2.17.1

