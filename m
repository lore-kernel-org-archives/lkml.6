Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeDQJkx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:40:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44666 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeDQJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:40:51 -0400
X-Google-Smtp-Source: AIpwx49pkB2lNdtluLyuz8GaHiiTdqJfRr0ezn5mS3LTQvp8UjrLWUOiE5lJ3b+nkrgBLC+PrP+iaA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        Holger Brunck <holger.brunck@keymile.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 1/3] powerpc: dts: use 'atmel' as at24 anufacturer for pdm360ng
Date: Tue, 17 Apr 2018 11:40:28 +0200
Message-Id: <20180417094030.7224-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'at' as the <manufacturer> part of the compatible string is now
deprecated. Use a correct string: 'atmel,<model>'.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/pdm360ng.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 445b88114009..df1283b63d9b 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -98,7 +98,7 @@
 			fsl,preserve-clocking;
 
 			eeprom@50 {
-				compatible = "at,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x50>;
 			};
 
-- 
2.17.0
