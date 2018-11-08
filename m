Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9562081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSXjE72J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9562081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeKIHam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeKIHam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:30:42 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A532081C;
        Thu,  8 Nov 2018 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541713995;
        bh=8ouKYu6iFxoPfS73s5irfElmsrneRho3SNMDLo+sI4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sSXjE72JSVQHR2LOwnHpR8ETY5j0dR6rFDqiIqCXUekR44qvjhjb+Ty28OKwelKK6
         jdmZFlzTjnUTPjHZC11f5ga5gYAr2rxeaySkt4X3Tr0xEJv5OeUqNacoc2hEPm5myn
         3217yBGCjL2DSK/GOBNOyKlK9fZC7XlPsdzCGFHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lei Yang <Lei.Yang@windriver.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 001/144] selftests/efivarfs: add required kernel configs
Date:   Thu,  8 Nov 2018 13:49:32 -0800
Message-Id: <20181108215054.896370713@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lei Yang <Lei.Yang@windriver.com>

[ Upstream commit 53cf59d6c0ad3edc4f4449098706a8f8986258b6 ]

add config file

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/efivarfs/config |    1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/efivarfs/config

--- /dev/null
+++ b/tools/testing/selftests/efivarfs/config
@@ -0,0 +1 @@
+CONFIG_EFIVAR_FS=y


