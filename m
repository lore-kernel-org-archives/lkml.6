Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD5C10F07
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355C421916
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfBQO2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:28:22 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60931 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfBQO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:28:19 -0500
X-Originating-IP: 91.192.165.7
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D46721BF203;
        Sun, 17 Feb 2019 14:28:15 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 3/7] dt-bindings: power: supply: Add voltage-max-design-microvolt property
Date:   Sun, 17 Feb 2019 15:29:12 +0100
Message-Id: <20190217142914.17433-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217142914.17433-1-contact@artur-rojek.eu>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the "voltage-max-design-microvolt" property.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 89871ab8c704..5c913d4cf36c 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -16,6 +16,7 @@ Required Properties:
 
 Optional Properties:
  - voltage-min-design-microvolt: drained battery voltage
+ - voltage-max-design-microvolt: fully charged battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
  - precharge-current-microamp: current for pre-charge phase
@@ -48,6 +49,7 @@ Example:
 	bat: battery {
 		compatible = "simple-battery";
 		voltage-min-design-microvolt = <3200000>;
+		voltage-max-design-microvolt = <4200000>;
 		energy-full-design-microwatt-hours = <5290000>;
 		charge-full-design-microamp-hours = <1430000>;
 		precharge-current-microamp = <256000>;
-- 
2.20.1

