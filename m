Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156F621730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156F621730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbeHNUPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:15:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbeHNUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:15:31 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2A8FC5C;
        Tue, 14 Aug 2018 17:27:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.18 69/79] Documentation/l1tf: Remove Yonah processors from not vulnerable list
Date:   Tue, 14 Aug 2018 19:17:28 +0200
Message-Id: <20180814171340.771764224@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Dave reported, that it's not confirmed that Yonah processors are
unaffected. Remove them from the list.

Reported-by: ave Hansen <dave.hansen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/l1tf.rst |    2 --
 1 file changed, 2 deletions(-)

--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -19,8 +19,6 @@ vulnerability is not present on:
    - A range of Intel ATOM processors (Cedarview, Cloverview, Lincroft,
      Penwell, Pineview, Silvermont, Airmont, Merrifield)
 
-   - The Intel Core Duo Yonah variants (2006 - 2008)
-
    - The Intel XEON PHI family
 
    - Intel processors which have the ARCH_CAP_RDCL_NO bit set in the


