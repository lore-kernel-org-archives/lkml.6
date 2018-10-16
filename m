Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D14C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C6321477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="otHWJieE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C6321477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeJQBOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbeJQBOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4732089E;
        Tue, 16 Oct 2018 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710564;
        bh=wlKy3t2Z2qSUuCcFWyYSKoXDW0hBp1xgff6HZlNnDOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otHWJieEQF6nTSjNPmvuIizTapwpFjD5qBTltlWCgJY3nmFYz6IPXEoN6mqVb9jAA
         tjWktZMcxWuYbf2YqCNMYuyKmeVrv4zs2HhuiDNEWWk2BvVc6FuDf47f/erW5lda6Z
         NTuuAthMSM1iik8ZeuoS2YB6XQ2GeJGL0FTjB1Xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lei Yang <Lei.Yang@windriver.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 03/71] selftests/efivarfs: add required kernel configs
Date:   Tue, 16 Oct 2018 19:09:00 +0200
Message-Id: <20181016170539.493467300@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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


