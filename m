Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeDQJkz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:40:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33898 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeDQJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:40:53 -0400
X-Google-Smtp-Source: AIpwx48kWXl58yOim+svrGQCIfYOtQ6dO2N/rMSdvk5viwBCE32Eq22gxmPPn+EsQt0u/gG1NPRdYg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        Holger Brunck <holger.brunck@keymile.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 2/3] powerpc: dts: use 'atmel' as at24 manufacturer for kmcent2
Date: Tue, 17 Apr 2018 11:40:29 +0200
Message-Id: <20180417094030.7224-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417094030.7224-1-brgl@bgdev.pl>
References: <20180417094030.7224-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using compatible strings without the <manufacturer> part for at24 is
now deprecated. Use a correct 'atmel,<model>' value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/fsl/kmcent2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dts/fsl/kmcent2.dts
index 5922c1ea0e96..3094df05f5ea 100644
--- a/arch/powerpc/boot/dts/fsl/kmcent2.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
@@ -130,7 +130,7 @@
 					#size-cells = <0>;
 
 					eeprom@54 {
-						compatible = "24c02";
+						compatible = "atmel,24c02";
 						reg = <0x54>;
 						pagesize = <2>;
 						read-only;
-- 
2.17.0
