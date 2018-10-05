Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D25C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4D3214C2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG5bT/gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4D3214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeJEXRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbeJEXRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16616214C3;
        Fri,  5 Oct 2018 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756261;
        bh=mREfsZig+VL81srNjz9zMXi8F6TgzFKbqZO5WmfCyww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YG5bT/gzmh6SviS4x6gwdFAqjBL3x18LwV+zFj1NikJfJkvFQGCnTk6PAlNoa3B3O
         focvi7pLYh+BBkOA0NxmT0gFsst5Ig927nfdorDlXcek66M4jvnRy2QbaowyEcU9oX
         dLh5fTJnBhSuAns4vrkPuUe6FBkXx9+Eoi6n4g1c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lei Yang <Lei.Yang@windriver.com>, Shuah Khan <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 03/11] selftests/efivarfs: add required kernel configs
Date:   Fri,  5 Oct 2018 12:17:28 -0400
Message-Id: <20181005161736.20765-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161736.20765-1-sashal@kernel.org>
References: <20181005161736.20765-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lei Yang <Lei.Yang@windriver.com>

[ Upstream commit 53cf59d6c0ad3edc4f4449098706a8f8986258b6 ]

add config file

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/efivarfs/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/efivarfs/config

diff --git a/tools/testing/selftests/efivarfs/config b/tools/testing/selftests/efivarfs/config
new file mode 100644
index 000000000000..4e151f1005b2
--- /dev/null
+++ b/tools/testing/selftests/efivarfs/config
@@ -0,0 +1 @@
+CONFIG_EFIVAR_FS=y
-- 
2.17.1

