Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CA6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BBF204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BBF204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbeGTPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:19:25 -0400
Received: from mout.perfora.net ([74.208.4.197]:58931 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbeGTPTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:19:25 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LrLdC-1g9zWd3I32-013AF2; Fri, 20 Jul 2018 16:30:24 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joel Stanley <joel@jms.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 1/6] ARM: config: multi_v5: enable dynamic debug
Date:   Fri, 20 Jul 2018 16:30:07 +0200
Message-Id: <20180720143012.7740-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:aSupTQBZIE6XTl2Vhzmlh1RZuntFieP7bSptLuFU4Ycr395Fu7Y
 BXOmvzFGP2FV0v4b+jiKZX8noSOCIuoLDNnkc4U5iLFjlZz8zyFZuEbI9AXQm4xP+C/4cak
 u7iD2y0tjjOTgE4K7tmm8QJIm5RzmzX0K3xIA0veEEzPdNMDVrGponjU6OlF4yhhS6zFy+S
 aP02SvhBmb5d/QixlJ38Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5+GlubKqSkw=:OwhHSehBbvBLJblDsQ5Ax/
 1kERq/7P4UBOdeBzQOeifqw4kQMT8Epgf00kInNn/GjLUT8jj4aG3me97V5+ono05GO/zZFq/
 f+SvmO/SI1RXdFXJS8jPBgSLCscptHGfJrQD1vjkUmEhrpBz1xNECBf4CptzKvzJQPFpxczTc
 KwyZFd87VZ+qaV0sD23BN+SPlzzKLrJUsvbsCAwja9cBCU3Rvb3mXXjNRgsiGqugK8u9K/L3X
 sfa6g60N0JtFv2T179yvcqZWkG6BF2ZAhPcurhchRO6MCherffT4UN/+SG8s9ZcALXI/oss81
 gpIxOk4u6gNnpLBT8mOboMu+dCqMTj69ix3uViA9JULv47rrwPSWZQzL4WgeUVf7j/Ow6UGez
 TChzwGIWn0yDDtSFsu/iECmag4Uz6PxE/DilL/wDktnXbFKX2gRtCRvYzv6SNStvhqdfpPG7F
 orYLqfdE0B5YxPfnyTz/HloJFrZrtvxBFAPllLN6j4W2EMdZ4E2Gk43bqKs59lZlAjRWYcDsi
 4nrvSH0BRxu3eVRULuL2kBGF+WfvMsgAG1d6+Bz2KkkVCD1NSlJHAepL3Rjd5WFf65jNsZm/s
 BoRYn29jcapvQThBzt+sNtEhHyzT4qS4Apo5tKKOt2EkI/+tszT3w7ILXKEgWDRzuw8K9oxc9
 BTBamUuMGYlzpzvwfEVMvXeaAdd5oZQ49ks0wbHHXfaq3jpbyVWXYzgZppPH574ee6rM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 318b76fa26d1..b302ac68d587 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -275,6 +275,7 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-- 
2.14.4

