Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeEAWqf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:46:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36675 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:46:32 -0400
X-Google-Smtp-Source: AB8JxZo7bhOTiQBRX4p180UKT95j/nED0ZZmEfTnrvSZLwzEH/su2gAf6iUGDeHlxpLBf/+yLKWK6Q==
Date: Tue, 1 May 2018 15:46:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: use canonical compatible for
 touchpad/touchscreen
Message-ID: <20180501224628.GA150745@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"atmel,atmel_mxt_tp" and "atmel,atmel_mxt_ts" are ChromeOS inventions,
let's replace them with canonical compatible string "atmel,maxtouch".

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 191a6bcb17040..82179125bfb7c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -255,7 +255,7 @@ ap_i2c_dig: &i2c2 {
 
 &ap_i2c_tp {
 	trackpad@4a {
-		compatible = "atmel,atmel_mxt_tp";
+		compatible = "atmel,maxtouch";
 		reg = <0x4a>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&trackpad_int_l>;
@@ -271,7 +271,7 @@ ap_i2c_dig: &i2c2 {
 
 &ap_i2c_ts {
 	touchscreen@4b {
-		compatible = "atmel,atmel_mxt_ts";
+		compatible = "atmel,maxtouch";
 		reg = <0x4b>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&touch_int_l>;
-- 
2.17.0.441.gb46fe60e1d-goog


-- 
Dmitry
