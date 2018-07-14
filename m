Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BF4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B91D20854
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsunix.de header.i=@tsunix.de header.b="JhFIDkJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B91D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=tsunix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbeGNW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:56:06 -0400
Received: from mail.tsunix.de ([45.77.140.229]:48311 "EHLO mail.tsunix.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731182AbeGNW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:56:06 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2018 18:56:05 EDT
Received: from railgun.de (i59F5AC05.versanet.de [89.245.172.5])
        by mail.tsunix.de (Postfix) with ESMTPSA id 886193E884;
        Sun, 15 Jul 2018 00:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tsunix.de 886193E884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsunix.de;
        s=default; t=1531607199;
        bh=YaCKNr6qtteSCa9/TclHM0bqxFv53LOSdfZ4WYnDTOI=;
        h=From:To:Cc:Subject:Date:From;
        b=JhFIDkJhMpTNhU5lUsiW9lygVtRgoOsB8S59WFiyaTZu92j3vCNBO8GgcjDpQu/A7
         eOFB212BFF3csq0GoVsWDKNFI2oD4Csy5z+oX+tWBXacyc0psHgS3R0ZlNlUXsc8Ao
         EQpPyJbbER8LugQsM4DaspCTva/wcrj/mAIaTrmw=
From:   Cristian Kubis <cristian.kubis@tsunix.de>
Cc:     jfrederich@gmail.com, dsd@laptop.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        cristian.kubis@tsunix.de
Subject: [PATCH 0/2] staging: olpc_dcon: fix style warnings
Date:   Sun, 15 Jul 2018 00:25:39 +0200
Message-Id: <20180714222541.2564-1-cristian.kubis@tsunix.de>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series of patches fixing two different kinds of style warnings in olpc_dcon
as reported by checkpatch.pl.

Cristian Kubis (2):
  staging: olpc_dcon: prefer 'help' in KConfig
  staging: olpc_dcon: add missing identifier names

 drivers/staging/olpc_dcon/Kconfig     | 6 +++---
 drivers/staging/olpc_dcon/olpc_dcon.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.18.0

