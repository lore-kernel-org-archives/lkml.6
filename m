Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D58213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="toflKEny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D58213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbeK3Bbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbeK3Bbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1A7213A2;
        Thu, 29 Nov 2018 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501562;
        bh=BPdNMd/ol3CWTAGHpITaWchrv6YKh90v3233Tdf9fnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toflKEnyIVWon5FHx6BPIzaiqET1MmtZFUB5sxWrtUEAWi7hmXyR09fvV1ot+pJ1n
         VKzqFxYsZ432EZv2mJOwjYogNMDCTl4DyHmrKghSzgXzDEhXduDOObCc0+xRc7zFy1
         9sDUYyejDb/9IioUC4MsHK0HqNUGnpgTqu6n0SZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 013/100] MAINTAINERS: Add Sasha as a stable branch maintainer
Date:   Thu, 29 Nov 2018 15:11:43 +0100
Message-Id: <20181129140100.085052988@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -12662,6 +12662,7 @@ F:	arch/alpha/kernel/srm_env.c
 
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+M:	Sasha Levin <sashal@kernel.org>
 L:	stable@vger.kernel.org
 S:	Supported
 F:	Documentation/process/stable-kernel-rules.rst


