Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE54ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FE9208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FE9208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbeGPIHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732177AbeGPIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AE29FCA4;
        Mon, 16 Jul 2018 07:41:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.14 38/54] kbuild: delete INSTALL_FW_PATH from kbuild documentation
Date:   Mon, 16 Jul 2018 09:35:35 +0200
Message-Id: <20180716073457.693057423@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 3f9cdee5929b7d035e86302dcf08fbf3e80b0739 upstream.

Removed Kbuild documentation for INSTALL_FW_PATH.

The kbuild symbol INSTALL_FW_PATH was removed from Kbuild tools in
September 2017 (for 4.14) but the symbol was not deleted from
the kbuild documentation, so do that now.

Fixes: 5620a0d1aacd ("firmware: delete in-kernel firmware")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org # 4.14+
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/kbuild/kbuild.txt |    9 ---------
 1 file changed, 9 deletions(-)

--- a/Documentation/kbuild/kbuild.txt
+++ b/Documentation/kbuild/kbuild.txt
@@ -152,15 +152,6 @@ stripped after they are installed.  If I
 the default option --strip-debug will be used.  Otherwise,
 INSTALL_MOD_STRIP value will be used as the options to the strip command.
 
-INSTALL_FW_PATH
---------------------------------------------------
-INSTALL_FW_PATH specifies where to install the firmware blobs.
-The default value is:
-
-    $(INSTALL_MOD_PATH)/lib/firmware
-
-The value can be overridden in which case the default value is ignored.
-
 INSTALL_HDR_PATH
 --------------------------------------------------
 INSTALL_HDR_PATH specifies where to install user space headers when


