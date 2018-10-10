Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C71BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBE52150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukK1Ytbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBE52150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeJKBte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJKBte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:49:34 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0402150D;
        Wed, 10 Oct 2018 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539195974;
        bh=6QT5erRHd8rypCE6x5ZcpKEjy5+8VAOg4y7d7z5S/Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukK1YtbmhkQi7xLiXLF//Y27TeW5/vy3EVkO3pUL0moXOCWjO/T8rN691FFlSYhkr
         NMxptsqTVxXoacV55aJg4OmBqLxQesSE79Pbs+ulpQUNjTCeu5nNIPrTc0SeDDnqWb
         /qrlyfJx4FBAluIRb5wurguGFBFsdYHd9/no5Pf0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] arm64: dts: exynos: Stuff for v4.20
Date:   Wed, 10 Oct 2018 20:25:56 +0200
Message-Id: <20181010182558.7034-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010182558.7034-1-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.20

for you to fetch changes up to 2352ae1306974528d11fb9c7dbf2cf91e0dd2c31:

  arm64: ARM: dts: exynos: Remove double SD card detect pin inversion on TM2 (2018-09-24 19:30:54 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.20

1. Use graph between USB-PHY and MUIC.
2. Cleanup of SD card detect pin level.

----------------------------------------------------------------
Andrzej Hajda (1):
      arm64: dts: exynos: Add OF graph between USB-PHY and MUIC

Krzysztof Kozlowski (1):
      arm64: ARM: dts: exynos: Remove double SD card detect pin inversion on TM2

 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)
