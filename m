Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE106C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1E3208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+K44qsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1E3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbeK3BXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeK3BXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF2AA208E7;
        Thu, 29 Nov 2018 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501070;
        bh=SEP4G5fiblwnvBeDvxR1FtiUUoFT5W7lyD1cQM6iU+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+K44qslOdccY7D3vzv5L/p3bRwWkNn/FpkGk2dAEfZHld8iAMEwrpNb1hXHEd598
         ctryDnZte1SNkc0Pil5SI9r5QnyOPcSf9CpWo7QiEh2lf847ulvt1aIIj8daWtkKJr
         2e8wLrnT3jYbsLpME8YK2WQ7MRn/kfcRVCC/AoTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 03/86] MAINTAINERS: Add Sasha as a stable branch maintainer
Date:   Thu, 29 Nov 2018 15:11:28 +0100
Message-Id: <20181129140110.209299163@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit cb5d21946d2a2f4687c482ab4604af1d29dac35a upstream.

Sasha has somehow been convinced into helping me with the stable kernel
maintenance.  Codify this slip in good judgement before he realizes what
he really signed up for :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10135,6 +10135,7 @@ F:	arch/alpha/kernel/srm_env.c
 
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+M:	Sasha Levin <sashal@kernel.org>
 L:	stable@vger.kernel.org
 S:	Supported
 F:	Documentation/stable_kernel_rules.txt


