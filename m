Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB87CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969A6240E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969A6240E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeGELaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:30:14 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:35041 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753950AbeGELaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:30:12 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w65BRqLK013585;
        Thu, 5 Jul 2018 14:27:52 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id 5493662E6F; Thu,  5 Jul 2018 14:27:52 +0300 (IDT)
From:   avifishman70@gmail.com
To:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc:     rdunlap@infradead.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 0/1] MAINTAINERS: add subfolders for nuvoton *npcm*
Date:   Thu,  5 Jul 2018 14:27:49 +0300
Message-Id: <20180705112750.197458-1-avifishman70@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <avifishman70@gmail.com>


- Changes since version 2:
  Follow Andrew Morton, Joe Perches and Mauro Carvalho Chehab comment on
  the location of Documentation/devicetree/bindings

- Changes since version 1:
- Follow Greg KH comment to add changelog test in addition to the commit
  subject

 Add several subfolders to look for *npcm* files under
    ARM/NUVOTON NPCM ARCHITECTURE

Avi Fishman (1):
  MAINTAINERS: add subfolders for nuvoton *npcm*

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.14.1

