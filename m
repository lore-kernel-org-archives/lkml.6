Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDFD2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhat5kcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDFD2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbeK3BeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733183AbeK3BeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196F9213A2;
        Thu, 29 Nov 2018 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501726;
        bh=YU+j7jjfNEXgGjkbH0butR9A+EaJOnAPv/jgXm3yERk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vhat5kcAknceam94PoScX7jmpQeYfBPZVAYpj9n39Z/GwmnIWc3AWfdAcpCrgDhv8
         fRHAi8W9qFsrCnVz4JsZ2mQTAI7g7EE20nUS9waLS8C7g00iURjbwGHH6JNmTM8rW3
         A4cfFVty5HEJPXpCsxqPpXVsZX+v0fjNdoZhGzYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/110] MAINTAINERS: Add Sasha as a stable branch maintainer
Date:   Thu, 29 Nov 2018 15:11:47 +0100
Message-Id: <20181129135921.898563255@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -13769,6 +13769,7 @@ F:	drivers/i2c/busses/i2c-stm32*
 
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+M:	Sasha Levin <sashal@kernel.org>
 L:	stable@vger.kernel.org
 S:	Supported
 F:	Documentation/process/stable-kernel-rules.rst


