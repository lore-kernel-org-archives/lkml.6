Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B4C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA80214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn0vTaue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA80214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeGLQ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbeGLQ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:57:34 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2C021471;
        Thu, 12 Jul 2018 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531414034;
        bh=YQWVXpmOjMmOqxEvNVJI5NOpd+3/NH60eDkNFpJ9TcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jn0vTauetLfqCQ15NjfFcn+Zx9mMPGUfZ6c8WFmJLJ3est4z12h1PGzLPGlefq5+y
         /ovMseYMBxd15Xe74mZDgDiOZv4krKn72p8uWoKlLXB4u6UBChsAMFjuTRMSXtS4LC
         fhp7+mv4vc2VE1n/OLl6k3/Z+o3FCcinU+iFpSKU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/3] ARM: defconfig: Pull for v4.19
Date:   Thu, 12 Jul 2018 18:46:39 +0200
Message-Id: <20180712164641.19925-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180712164641.19925-1-krzk@kernel.org>
References: <20180712164641.19925-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rebased on v4.18-rc2.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.19

for you to fetch changes up to 24ede29d026a9f00aa3f4e7a5531803af4810734:

  ARM: s5pv210_defconfig: Enable options needed to boot typical Linux distro (2018-07-07 10:49:16 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v4.19

Enable options needed for booting full system on S5Pv210-based Samsung
Galaxy S mobile phones.

----------------------------------------------------------------
Paweł Chmiel (3):
      ARM: s5pv210_defconfig: Run make savedefconfig
      ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
      ARM: s5pv210_defconfig: Enable options needed to boot typical Linux distro

 arch/arm/configs/s5pv210_defconfig | 49 +++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)
