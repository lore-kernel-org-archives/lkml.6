Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeBWKQ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:16:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:28937 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751576AbeBWKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:54 -0500
X-UUID: ac977b8dba4e475992fcdb5093069bd4-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v1 02/19] dt-bindings: cpufreq: mediatek: use - instead of _ in examples
Date: Fri, 23 Feb 2018 18:16:22 +0800
Message-ID: <fd1fc4c6760ab8fcbf7518df1cecf3837ab18d2c.1519378871.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It should be good that no use "_" is in examples. Consequently,
those nodes in certain files which have an inappropriate name containing
"_" are all being replaced with "-".

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index d36f07e..38cfbb5 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -26,7 +26,7 @@ Optional properties:
 
 Example 1 (MT7623 SoC):
 
-	cpu_opp_table: opp_table {
+	cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -86,7 +86,7 @@ Example 1 (MT7623 SoC):
 	};
 
 Example 2 (MT8173 SoC):
-	cpu_opp_table_a: opp_table_a {
+	cpu_opp_table_a: opp-table-a {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -131,7 +131,7 @@ Example 2 (MT8173 SoC):
 		};
 	};
 
-	cpu_opp_table_b: opp_table_b {
+	cpu_opp_table_b: opp-table-b {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.7.4
