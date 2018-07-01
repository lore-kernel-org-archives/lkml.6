Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A20C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973BF21722
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973BF21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuvoton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeGAJbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:31:50 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34718 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751139AbeGAJbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:31:49 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w619UWmI032429;
        Sun, 1 Jul 2018 12:30:33 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id 817E162E70; Sun,  1 Jul 2018 12:30:32 +0300 (IDT)
From:   avi.fishman@nuvoton.com
To:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc:     rdunlap@infradead.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v2 0/1] MAINTAINERS: add subfolders for nuvoton *npcm*
Date:   Sun,  1 Jul 2018 12:30:27 +0300
Message-Id: <20180701093028.10174-1-avi.fishman@nuvoton.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <avifishman70@gmail.com>


Changes since version 1:
- Follow Greg KH comment to add changelog test in addition to the commit
  subject

 Add several subfolders to look for *npcm* files under
    ARM/NUVOTON NPCM ARCHITECTURE

Avi Fishman (1):
  MAINTAINERS: add subfolders for nuvoton *npcm*

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.14.1

