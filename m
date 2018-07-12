Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196C9C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA49D2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="feTN7RjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA49D2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbeGLQ5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbeGLQ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:57:39 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205DF214AB;
        Thu, 12 Jul 2018 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531414038;
        bh=H39lx/gAC8Zbl5kAhS1rDBIiDzJlN34/59mp8kM+/XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feTN7RjDdEOTyRgMEsro/ireWh/tmpDCaX27Hvm/2M0OPbrwXLt/t0VquNSTOyJgk
         SojR3Ygaqm563rXeyKzWr9L7IQBl5/zr9XsJUBvS+CPoCQItKafYweISJiM7CxXBFB
         pPG7LmLAoqoJhjSLiN1t56qMSOfZn1g23EXbi6n8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/3] arm64: dts: exynos: Pull for v4.19
Date:   Thu, 12 Jul 2018 18:46:41 +0200
Message-Id: <20180712164641.19925-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180712164641.19925-1-krzk@kernel.org>
References: <20180712164641.19925-1-krzk@kernel.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.19

for you to fetch changes up to 17aa1530f1ff89ca4e21765e5f4d9e6bcd464eb2:

  arm64: dts: exynos: Remove leading 0x from unit addresses in Exynos5433 (2018-06-25 18:38:49 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.19

Cleanup from old properties and code-style warnings.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      arm64: dts: exynos: Remove no longer needed samsung thermal properties

Krzysztof Kozlowski (1):
      arm64: dts: exynos: Remove leading 0x from unit addresses in Exynos5433

 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
 .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 14 +++++++-------
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
 5 files changed, 8 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
