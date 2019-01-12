Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C2EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7CB20836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfALR11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:27:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:37937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfALR10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:27:26 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmwpk-1hCElM05pk-00h8ep; Sat, 12
 Jan 2019 18:27:24 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-m68k@lists.linux-m68k.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/apollo: Fix comment in Makefile
Date:   Sat, 12 Jan 2019 18:26:16 +0100
Message-Id: <20190112172618.13073-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UGH7fRhUuB3RZhCifW51/2BLFN+LUgKOMLv7rgw7XEKdlmaUE4L
 pb3Plndbh9y1CCWNjKWwwOScrQiflwKPFoeZuzFI+aZ7sfdE/P67Mh3wVbA1BVCGcmiRf93
 o7iwTFQs37y5NHvij+n2nZ8v3i8AnSobYofBICL0YtM/IvZy3t1ZgGF5szaV56p9rSBWKtq
 SeznqL2nGX2ZTgGcmkACA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKpbH9wpXLs=:kZq6y4d3rW8Vp8jweIdMod
 3Skpkqpa3sXELri1cAjV/scIKPQ/UShrQpIFpbALLlzCY7egk3fN31cfcIeaiyy7Al7B0wcCw
 Rpo0BBO0L9uft3K3a72wzSi7O2dvA4t3ilaaOm3AtMcpqp+gR44E6JGjd5PSiv09ulOAvm/Ny
 iKlKMXSyqFHgY6I605bJ4arCHpLBu8yLZCHuJnYFfQUtFD/wSnQScXZ+QBUNvRBEBaXxr6b3a
 mVzH4q8raQogFd85GreJ2RV9e3FIuKt9S7wnQ98Pts6N83Dcda2cghKdA0+lO1Cx08v0EPCap
 tEt7VJr44Lboq8c/thmlmhQMlAxqJiR3wdtJXtutnt60M5urwXzkgVyh4TD1DaqLvB7+KMpma
 lSf3I/2n5P87PjNEwedyiGhw/XdCqrnkt2LMKQuslaeRfYqtGPFTQUUuqcQ7AfchORC0iloEE
 o1tIm+uCYKpBd71E8qVbMvJhXthtNoEfOdE1WLce+3OUtrtJrc2/yfSrhD0rG3cAHNAiAM/hf
 GM7ldmCoyT7rvudUz+aWQI+xfdpiHxkcwC2z1zm/2L6rg7m+uBRe1maPRPBoplbsJXR6j7Z2/
 RYaeOAp77De75gQYcxOBYXxf4V0rUu3zRbF8SyOBfbOkSCsEHZRcq6rsQjgsTJ3+ttEkNZ5Zi
 O5LFYk36VG5UGefIT8BIu1e/LzSqs0pa8cxnRv/2iJ98NrmFSgdRAN1SEMPauVXJpkQriK/oz
 O16GSExo35Y+N37o3592iUlnBILqH1eWMT/VHKZMqDzWGC5spqiQAKjz5X3cyodDYxxd1mp8B
 VokAuc4aAvrU4hqIZkrysABpfB06kzX7tZqDVxvFTEVzub99WG3OttxXRVkto3XnmN74sa7Ms
 YLk5/A4ctgfGa9P5UdmgkVZQlp+S8OEDMNYzG+JSUkL9PFLkqsyaVUGSeltrQWoLp3PMoiR60
 YRhEMXP5tpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment has been wrong since before git.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/m68k/apollo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/apollo/Makefile b/arch/m68k/apollo/Makefile
index 76a057962c38..01856a858fda 100644
--- a/arch/m68k/apollo/Makefile
+++ b/arch/m68k/apollo/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for Linux arch/m68k/amiga source directory
+# Makefile for Linux arch/m68k/apollo source directory
 #
 
 obj-y		:= config.o dn_ints.o
-- 
2.20.1

