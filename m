Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933311AbeCPDAH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:00:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33106 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933188AbeCPC7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:59:35 -0400
X-Google-Smtp-Source: AG47ELuoX+uOXo1Uvj7ExNQ3+oW5w1l+mYmc9Yn1m6lQ0Y004O+QdhoaiCXZl6rcWWN1awlkfUmZiA==
From: Alexandru M Stan <amstan@chromium.org>
To: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        marcheu@chromium.org, hoegsberg@chromium.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 1/2] dt-bindings: analogix-dp: Add backlight-pwm-passthru
Date: Thu, 15 Mar 2018 19:56:58 -0700
Message-Id: <20180316025659.217423-2-amstan@chromium.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180316025659.217423-1-amstan@chromium.org>
References: <20180316025659.217423-1-amstan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for the optional backlight-pwm-passthru property.
Tells the EDP panel to folow the input pwm frequency instead
of generating its own.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---

 Documentation/devicetree/bindings/display/bridge/analogix_dp.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
index 0c7473dd0e51..3c15242f6ce3 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
+++ b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
@@ -23,6 +23,10 @@ Required properties for dp-controller:
 		from general PHY binding: Should be "dp".
 
 Optional properties for dp-controller:
+	-backlight-pwm-passthru:
+		Directly pass the PWM frequency applied to the BL_PWM_DIM
+		pin to the backlight current source. Done via
+		EDP_BACKLIGHT_MODE_SET_REGISTER on DPCD.
 	-force-hpd:
 		Indicate driver need force hpd when hpd detect failed, this
 		is used for some eDP screen which don't have hpd signal.
-- 
2.13.5
