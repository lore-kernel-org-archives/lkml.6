Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163356AbeE1N2b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163221AbeE1KrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Shyam Saini <shyam@amarulasolutions.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 137/496] ARM: dts: imx6dl: Include correct dtsi file for Engicam i.CoreM6 DualLite/Solo RQS
Date: Mon, 28 May 2018 11:58:42 +0200
Message-Id: <20180528100325.709568222@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Saini <shyam@amarulasolutions.com>

[ Upstream commit c0c6bb2322964bd264b4ddedaa5776f40c709f0c ]

This patch fixes the wrongly included dtsi file which
was breaking mainline support for Engicam i.CoreM6 DualLite/Solo RQS.

As per the board name, the correct file should be imx6dl.dtsi instead
of imx6q.dtsi

Reported-by: Michael Trimarchi <michael@amarulasolutions.com>
Suggested-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Shyam Saini <shyam@amarulasolutions.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Fixes: 7a9caba55a61 ("ARM: dts: imx6dl: Add Engicam i.CoreM6 DualLite/Solo RQS initial support")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx6dl-icore-rqs.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6dl-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
@@ -42,7 +42,7 @@
 
 /dts-v1/;
 
-#include "imx6q.dtsi"
+#include "imx6dl.dtsi"
 #include "imx6qdl-icore-rqs.dtsi"
 
 / {
