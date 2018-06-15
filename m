Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B695208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B695208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966326AbeFOQdv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:33:51 -0400
Received: from osg.samsung.com ([64.30.133.232]:62492 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966152AbeFOQbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:31:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 35F7422C1D;
        Fri, 15 Jun 2018 09:31:21 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gW5Hq0qQmMJ3; Fri, 15 Jun 2018 09:31:20 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id BCAB922B61;
        Fri, 15 Jun 2018 09:30:58 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTrcm-00084y-Nh; Fri, 15 Jun 2018 13:30:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH v4 25/26] Documentation: rstFlatTable.py: fix a broken reference
Date:   Fri, 15 Jun 2018 13:30:53 -0300
Message-Id: <414900e97b79d3bb57c454532f7cd8ae9a6103cd.1529079120.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old HOWTO was removed a long time ago. The flat table
version is not metioned elsewhere, so just get rid of the
text.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/rstFlatTable.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/sphinx/rstFlatTable.py b/Documentation/sphinx/rstFlatTable.py
index 25feb0d35e7a..2019a55f6b18 100755
--- a/Documentation/sphinx/rstFlatTable.py
+++ b/Documentation/sphinx/rstFlatTable.py
@@ -53,8 +53,6 @@ from docutils.utils import SystemMessagePropagation
 # common globals
 # ==============================================================================
 
-# The version numbering follows numbering of the specification
-# (Documentation/books/kernel-doc-HOWTO).
 __version__  = '1.0'
 
 PY3 = sys.version_info[0] == 3
-- 
2.17.1

