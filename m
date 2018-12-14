Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8892FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EC0206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeLNWMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:12:03 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbeLNWMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:12:02 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MrPyJ-1hBNIh32BT-00oa3u; Fri, 14 Dec 2018 23:11:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>
Cc:     stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: olpc_dcon: add a missing dependency
Date:   Fri, 14 Dec 2018 23:10:08 +0100
Message-Id: <20181214221023.3878670-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6NF59hTn5Qzuli2IiOA6knNRGZupLt4BS0OkWcb0EjIMLMnylec
 hxl46i/o+u2EImFAPr715x2QY7DUo7h+n24cvuLjHnlf6HxVayvURPS1SEL7KxFOZBJDTDd
 AIo7wwxP+B9bos8Ga2uun6zXWLNaqXMw8h5TyOHy2HfFqDv9hrWarx/OAZoCNBqSkhQhxgh
 ZPailpPvzzDS/YC3OHQxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sLcGHBNApXU=:wJgmVO4I8dQx631yOX7vIp
 IpGxspICmW5c59RyTybBjpsW6Zh4l3/urQv5Q2bWAEku/eFzaUW2Q1KfBZljikVcZr/9+XbMb
 MMe7RB5T63kwLIFDC+xqu9W+VyA2a2+ft9fO0NhNv7WQlwGV0epg6PXPPHoeNh7o6UkhUkudA
 BhleU0iG3tkPKZYkuDkg0wHzao3eUjIfKwfPirwezEcxSJkA46fP2Hb+UXzf8ZH9UpmYqW376
 WtWeQXtTdeG5pvOSHofxIFmJB+qGb0ifN3PHB4QGqJNyH/xucGkyfAsh6vz0y1yg+XtK5niof
 8TQ/XmMF/YAscPwvLQpGs0Kay2vS7vTiL3VgDdUu6CnWbrUH5Vw2ByfutTS4OeJKs8OSd3op2
 Y3G0H1BXc6zJ0zPyvNEkYKaQwYB469Goy+iga2TlSjgxIst/zQWGUtryKJmzwwcw7lgoshRHu
 TMG5o3UTt5w9smA/8qSOtMK3Cw3JQrF4v1ky6XcD/hng6+Z1+nBYhTdIsg1hTF20kIyW5Xtv8
 +NL7o3v4M8XmbivXaH9JYYKQdnp6guRQfYUrsdxRGVCcpriOqK8IASR4FEwZmTAco6AIcVjgJ
 aglhNMDfDblRL0AjG7wC1o/cDUSFt5/cYknjg9kynTJGEleRzVbUPvHufmfQMbnj8q7ZRI8tL
 BveHvBUm+/if7rlTsjmptkyrl1xnG4k45ijP+RTy9VJfHtbjnJWFZsTCd8Idi8NhAft1n8phw
 gtT/bQTj1l15CyVXALwsb177XGsmLEtQFmJK1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

Commit 33f49571d75024b1044cd02689ad2bdb4924cc80 upstream.

  WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
    Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
    Selected by [y]:
    - FB_OLPC_DCON [=y] && STAGING [=y] && X86 [=y] && OLPC [=y] && FB [=y]
                        && I2C [=y] && (GPIO_CS5535 [=n] || GPIO_CS5535 [=n]=n)

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/olpc_dcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index c91a56f77bcb..192cc8d0853f 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -2,6 +2,7 @@ config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
 	depends on OLPC && FB
 	depends on I2C
+	depends on BACKLIGHT_LCD_SUPPORT
 	depends on (GPIO_CS5535 || GPIO_CS5535=n)
 	select BACKLIGHT_CLASS_DEVICE
 	help
-- 
2.20.0

