Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CE5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43AC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43AC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbeGWNjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:39:08 -0400
Received: from mout.perfora.net ([74.208.4.196]:48085 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388323AbeGWNjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:39:07 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M71s3-1ftDKk0g0j-00wmJk; Mon, 23 Jul 2018 14:37:59 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 26/26] ARM: tegra: colibri_t30: update compatibility comment
Date:   Mon, 23 Jul 2018 14:36:57 +0200
Message-Id: <20180723123658.980-27-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Xg+1iKrLiubOuRwK1GRZeOKfNWeeXK+K9kgI3vaF2SpCkZpD0vD
 SD/Q/xVRhUmtyM0TN+gJcIVEVrgIsCNNArxuJMXrAG8qtxHZuDkUQI86kJXWH/YsCFoUI6b
 tsncKR4FvQvY+h53YZ1UWzV6XV80yYYpH5Z8+QyduZboxxwE3vjhz0A9Y53uAr8mZwG3/aw
 A1khJ3FRAeJ+0O5lBbAEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N8kfLxzpfVs=:X4/7jOR0k3X0BLf5QAjAmH
 sVQ6HSbtt0Zz5UNdUpeFlx/8shvn0fkWcoYeYGtKWecefkyjFZr3c90o9CH9f0QHkJ8m+KGJw
 +LiDs4feIWNfIL/cBNvtO6NEFtXlj1luxpq1l1ryEN1GENDDuXUd3uEbLUSEsEXRCEWn76nsS
 JrxcbRw8vkylKG5CligixCLB2S/NFsm9UEfQ+5+lpUt6F1W1RMZGD8QTd2fAtW9wRr//WOlWB
 0gyayqt55+/zq/lNvPrrbBs4p7pfyxu3360WJvPCahcduihAho62WsP86G/9dQBKb0xcKgbZQ
 LRojlRsifP33Scwd51DlJWfKDOtuuQjArES5sDow5mAcotjPCXfrdlYKa8bWq2FctssX3vw6a
 uiffysPzwp49b/aIap0kd8YBcVV457PfU5s1D/mlWG/2N5jgCDnQ8VWmAbfo2eKveHzNLk8GQ
 /K1qwkLWAUWS9lFuMBbVqkRpn3ZrcazV9jHQoj8M4AASJZf4Pjo8fIZrcU3n8HBoCnA2jFgrK
 FDqjg/f0Nc+IvvovpnA63CWI+ScySruq9NyGEenq3DZ1QPBNDRdrzk4WIvaZLHz7OQGhma8r0
 vWfEIpteOekP3VJfGkbBtxlGxe5Qa9z29Vt2eh/xBeG1zJtIwdB0Sl8j1yoTV9wTvn/pL1pLu
 LwymGtVj1lYnasucyGVp124IvTEALb5FzDuu5vQIlIHd/boUzEzDFfmiEshcp+w/zD8Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Update compatibility comment.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index e10e0f2b6034..cf7637cfb47d 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -3,7 +3,7 @@
 
 /*
  * Toradex Colibri T30 Module Device Tree
- * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E; IT: V1.1A
+ * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E, V1.1F; IT: V1.1A, V1.1B
  */
 / {
 	model = "Toradex Colibri T30";
-- 
2.14.4

