Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4AEECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C6120878
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C6120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbeGVRr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:58 -0400
Received: from mout.perfora.net ([74.208.4.196]:53723 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:57 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MejCI-1fNXkY3YG8-00OIrP; Sun, 22 Jul 2018 18:50:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 25/28] ARM: tegra: apalis_t30: rename clk to clock
Date:   Sun, 22 Jul 2018 18:49:33 +0200
Message-Id: <20180722164936.20581-26-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:KX4ve0BLkjBmVX1HV2vYZCmVibMuhoGVmUOYwaMxMEi/e6cj1Vu
 qKgt2pye/dL/CIZT5KVv7oSBVfxMX3l0emkKbkGSaIuKaeseHMfhDguwK6m9aRyCQnfqREr
 dxCmzFFiECt4MQf86A3agFZvY7aOYuB10Rp1EhnH4vC6kyXc6/1z0fBNmL+5x10BiWcvdUa
 fiqRcSP5Qpm1aOU8Tscpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M/TiBHSD9oY=:RMjC6UTWCe4zrhZdYuGQUW
 lQQWpJqfmwulvquwbIpyYULe/J39Omk7MJHIHRXN5SJR/uejUHdE367U/6j1kTPHaWLt0iOHR
 Cu4HHhV9ecjmB6HnuqgKhC/hkqyz62rs2PU/9ndCa3brpGsAhm/eIBhN3KOWtjxT9mQ4R1MCm
 Dl22QyNgNYOZae9QlU41ywO6qAnxvht/Rt8tUhnSCZa7nsXVPhc8YEa/632Mw7nEg8LrbAHgl
 MDFgevjDifogrHEWwD0GC8a1adVEO8/+Nhjq2y8HSRLDRhb5dglCDqYeZxYQXfDq/+1cvqooI
 P+GHiiN229s/j5U4d7BiH1ObrZ0YWcj5nibXVAO9A8Og91EDSzlsfST5BEF4QFFkomTQ78xQ+
 fYKnphqIiXBdyH8pDAGQjqMh6xF/zk/+P3HddKzWNfQVCCKtGQOGZ5V/n/U6DZYrDg5kxMi0X
 1mQ0LvXdIIkMis94phJQWvdwS45H730QoFN2KesuoAtC5FFY6LcgU52ppOLeSvqlfA+E/6O0g
 B6tHEURCA7VKAexCGi00qEZaWya//ybviF0+CnyhRyD5upysdBc1tNFI+aMrokHuGxVWZ3WbO
 842Vmcr3P08HJp0/vjVh3C0R7u9FU8x3x3jcI9mmTVhPrBlETxNoUtZw0OnHp+78OUY3JrGnV
 cj1njTFv52ZXoyi4tqTIRUXhdDWtlXDxbGbeXPWfZLIyz8mcNyKLDDi/fRxhN/wkgVAk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename clk to clock.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 5f5a287eb535..ee6750247c57 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1094,14 +1094,14 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clk@0 {
+		clk32k_in: clock@0 {
 			compatible = "fixed-clock";
 			reg = <0>;
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
-		clk16m: clk@1 {
+		clk16m: clock@1 {
 			compatible = "fixed-clock";
 			reg = <1>;
 			#clock-cells = <0>;
-- 
2.14.4

