Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F40C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07252172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07252172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeHNQyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:54:40 -0400
Received: from mout.perfora.net ([74.208.4.194]:44855 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbeHNQyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:54:39 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MDwiX-1ffOww3byx-00HKP5; Tue, 14 Aug 2018 16:06:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Gilbert <benjamin.gilbert@coreos.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [RESEND PATCH 4/6] ARM: defconfig: tegra: enable dynamic debug
Date:   Tue, 14 Aug 2018 16:06:10 +0200
Message-Id: <20180814140612.12554-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180814140612.12554-1-marcel@ziswiler.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:C4URl36kUjINeouBkigNB5kbGrVwmTy7d7Kwzii/0CMI2ow9GPn
 6lamaUL1rHWuHoEUnWK5r7MWrUeawUMjNIwk2h/9Vxb+7ByyBUFH9ihil21sGD4wtCWpe/F
 5NHv2e8C0toGr7p6vik+1BXYfB8YL1RFCXCLFSOnU896UNSI416XNmAAyOSsOk1ANZM+82U
 TvFfg/FQtpKlTaD9++hLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:es46RHxMemg=:ZV3SJ0ur2Bu3xy6ee0yyr1
 a5TIMADXGpF2Sh9xjGmqt45XYs6/4xW0cI/Y4nYT6OTpffflS46N8f/sEBDTFjHoZZAA3CA+G
 VrCHevecgWY7EfyvI4r5wXZY7LqFQoD/hktFsmmruMebv6rHtw6OqDl258hFrj0Hl10/1pSbQ
 8h1oQwhdObrjmS1ME0MhfQV1gbDsNtO4flcqzR2dc1G7Zf1MZ8iWXn3K86rtqjlfkc5WrQU2V
 nTpwn1XuEQdeFibTpuXKQwCZKz8Q2fi8dnd7hpoHqtwbJm9Erq/TQixH1ZdE7skmiKa0RjU2I
 ZIQvkLiyL23JDLJ3eHRO379FHSdMFenaI5sjBOnD2AKpsYuhO3jEWEfjpnC6siUQ48oilyXIO
 VK+5tjXtvsoT63tToqoO6sqaWpT2ZzDj1qGGNXDg983Xs0m8ZUhoeN/9sz+7jHDqyZ6W8QDJX
 MCpRSpARRpPDQL1UtRTWI7FeML81AmVFYNXcw8hF0mUOz8KFWXrGsS0fOTbnlrfiixio8jGRU
 NJxeXtRh0hWWSpdghR0EPfzMncX3GcjFg3hCeHP+s/G1mrV5n6vG/OcJhuIcxG9PyvmElRazz
 nmIHzP4CoDH8sBDbJnn2X53eRsecAKQ/UG5eVu4N78LYbNvgqq/brH2RELi7NChKRgOXYeh4K
 lNeNcSrcE/fMFHNcgPRGi+hXxptOxbGN4uahLnw7aLwQ3GRMcj0RrPC7iMtg2/QlIKSg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index c7b99ebf5fcf..24e297659b55 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -289,6 +289,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
-- 
2.14.4

