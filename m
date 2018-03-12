Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeCLPwM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:52:12 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39542 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932326AbeCLPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:52:10 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v5 2/2] mfd: arizona: Update DT doc to support more standard reset binding
Date: Mon, 12 Mar 2018 15:52:01 +0000
Message-ID: <20180312155201.30108-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180312155201.30108-1-ckeepax@opensource.cirrus.com>
References: <20180312155201.30108-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803120180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

No changes since v4.

 Documentation/devicetree/bindings/mfd/arizona.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index bdd017686ea5a..a014afb079023 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -50,7 +50,7 @@ Required properties:
 
 Optional properties:
 
-  - wlf,reset : GPIO specifier for the GPIO controlling /RESET
+  - reset-gpios : GPIO specifier for the GPIO controlling /RESET
 
   - clocks: Should reference the clocks supplied on MCLK1 and MCLK2
   - clock-names: Should contains two strings:
@@ -70,6 +70,10 @@ Optional properties:
     Documentation/devicetree/bindings/regulator/regulator.txt
     (wm5102, wm5110, wm8280, wm8997, wm8998, wm1814)
 
+Deprecated properties:
+
+  - wlf,reset : GPIO specifier for the GPIO controlling /RESET
+
 Also see child specific device properties:
   Regulator - ../regulator/arizona-regulator.txt
   Extcon    - ../extcon/extcon-arizona.txt
-- 
2.11.0
