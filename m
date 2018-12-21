Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D74DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE0C21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405711;
	bh=e9yQnpsjtfmb0vJxeM4gZXAkKc1gn4t3DPP+hyxmKRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=tkUNJd9Kl+ZwvBHc+yyQX1RIwCAqWzdt0oP8yUqyugaU1mAe1XxZ5tfwZAX6CbOhh
	 dB1e12WWvgrxBap8t7Go1Eybm0aO0sTiT14dOFtWYkoF+u/vBuwrLEqMcsnjo/l4zy
	 oUqKClPc7W52GvsZPpcc1byNelvdLMLP5L7fssC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404236AbeLUPVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbeLUPVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:48 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5E72192B;
        Fri, 21 Dec 2018 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405707;
        bh=e9yQnpsjtfmb0vJxeM4gZXAkKc1gn4t3DPP+hyxmKRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OMZwyV3y5nJemGsb/4Sj3Bv0C/IYPChy2pD1Frsap7FwYC0tHF65tnjYk4VLaZUUv
         7Vvztej7b1DeGCvrzNehQxeEZq7Ohj+WR5zv7B4/IlYcPPjJoKhXwvwg8eCHsQ3dPz
         ZkkaJS34C4Oq2sGUXFTCr1rucglGbFri0Z2lUTBs=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 9/9] Linux 3.18.129-rt111-rc1
Date:   Fri, 21 Dec 2018 09:21:21 -0600
Message-Id: <db6cdcf529e30a3ee0f0720c92a71b3f1effd5d0.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Tom Zanussi <tom.zanussi@linux.intel.com>

---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index b3e668a8fb94..ff68eff1428c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt110
+-rt111-rc1
-- 
2.14.1

