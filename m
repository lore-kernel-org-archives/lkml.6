Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F3CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E299721477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNz9lrFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E299721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeJQBE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA3320866;
        Tue, 16 Oct 2018 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710012;
        bh=ohTmvfU3w9cPrjswDB5KtIxU4nv/5CFVnbj7rXgwVqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNz9lrFriLP6JYVmMJ8MYPBwGhonDDBBX0ctSwUeKWFJ1lAD3avwIm8QO29o2MSAr
         q8G6N0mNuTRSSsHJSLEPsEr3L52y6/KWv83QoMBGklFPiSPVtJ7ojApsxV6DmXZ1W8
         Fua0B9cRMxYktVlYrVROHYTF+umIItlRO5lPAidc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lei Yang <Lei.Yang@windriver.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 073/135] selftests/efivarfs: add required kernel configs
Date:   Tue, 16 Oct 2018 19:05:03 +0200
Message-Id: <20181016170520.102494669@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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


