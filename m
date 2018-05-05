Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeEEBoW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:44:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36642 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeEEBoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:44:21 -0400
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100: Make the node name generic" to the regulator tree
In-Reply-To: 
Message-Id: <20180505014416.5E76544007C@finisterre.ee.mobilebroadband>
Date: Sat,  5 May 2018 02:44:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100: Make the node name generic

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 60891ceb8075e02cbf841ac1e7f7437d711ffc5f Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Fri, 4 May 2018 22:17:13 -0300
Subject: [PATCH] regulator: pfuze100: Make the node name generic

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the binding example.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/pfuze100.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index c6dd3f5e485b..f0ada3b14d70 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -21,7 +21,7 @@ Each regulator is defined using the standard binding for regulators.
 
 Example 1: PFUZE100
 
-	pmic: pfuze100@8 {
+	pfuze100: pmic@8 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
 
@@ -122,7 +122,7 @@ Example 1: PFUZE100
 
 Example 2: PFUZE200
 
-	pmic: pfuze200@8 {
+	pfuze200: pmic@8 {
 		compatible = "fsl,pfuze200";
 		reg = <0x08>;
 
@@ -216,7 +216,7 @@ Example 2: PFUZE200
 
 Example 3: PFUZE3000
 
-	pmic: pfuze3000@8 {
+	pfuze3000: pmic@8 {
 		compatible = "fsl,pfuze3000";
 		reg = <0x08>;
 
-- 
2.17.0
