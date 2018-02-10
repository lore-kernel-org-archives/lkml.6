Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeBJBjD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:39:03 -0500
Received: from mout.perfora.net ([74.208.4.196]:59981 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBJBjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:39:00 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/4] dt/bindings: fix binding examples for tegra gmi controller
Date: Sat, 10 Feb 2018 02:33:22 +0100
Message-Id: <20180210013326.27771-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013326.27771-1-marcel@ziswiler.com>
References: <20180210013326.27771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:lQAYfwbY7FHynhNAVCm7+CxINUkOkX/EB3O56fbDYCFEu3lx6ku
 rIDfNmw3BYXf2h2k+nBlOP46Bcx8vxm9Cca/OtWnWlm3X3R6B23FSIU/3sA6D7kcvseddzr
 49sFL+hWUZXKxWD9uqgT364r7knwGq7Qwad49+fXvNY6GQg5Myk1ybHO317ZQ3Lj6f1fgPV
 RO0eiS9D+dU69XpBMdSCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UUywKqT77zU=:uvyZADAuMNzlxS51BLaogh
 19FCWD5eHd3mlUyi7/K4mjigXS/RCqkwmYJvGcWKdaYnbrS/eLijuaOALNKeEtj6lKj4GtHnD
 CE8whZYNnicEdnQF8qMIBFUjGwUvnuELPXs71qWc248DVizSVlPdyVMErOGK8ym9NQA3xHT6X
 JFOnGdXnCySVC/u79UU9Zp9TMxxUwOXDq2Jmb4aS2iTw3ByIdmWofu2BIkcNdyhcOO/XAkDHJ
 2WUnZcnO8XMxySUO4oorBadWXv+YSfJ0KahghIwt/vuG4h9SYjuhpGY7gqU5UzPzlW0jsE6IT
 Iu8a1rQW5CZJ+V6D6IUIwmI8PhPOu2mVwVDlEef8xBC5qB5dzOyntOQ1U2KpKF4kVwjzIoHTc
 ksv42+2b/33awNOsZMbdnEqVvhxhcUtCxoLE5FbbRUpUKYieJkgy5YjQ3n5/JV4NBT0WDDs1s
 HUtYlgb9pWTXF4T6OfErerFJ3ZBnEk2rYr1WaiYlj4DLROqCow+lkKMEAR3sbdHc8/DFBMrby
 usK6W5RT9CAR88OcbD/yNIHq0DazFrDQD/lnBQ0oIroAT+18cVM6dKppY6tUra2O2qn8wAuk4
 ytpNndLcnY8zbD0iKPxafgRLNmWQHjcRpeyd+/rzA2maJvkeqdvd+QxtMaim0YELoTKsdmh4N
 9lCUhDt7rdz/5Ca6e9pfcLnYKxFu3s9FA5bAWuha/6g1P8bsxYHELTGSkUBsOy2y8/i3F0Nhl
 ILAML1a0EmU1FlMUc5DWYuiBwkfzVBEwOvsC9w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix devicetree binding examples for the Generic Memory Interface (GMI)
bus driver found on Tegra SOCs.

While at it also remove double new lines as a left over from Rob's
commit 4da722ca19f3 ("dt-bindings: Remove "status" from examples").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
index 3e21eb822811..c1e70621799b 100644
--- a/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
+++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
@@ -73,7 +73,7 @@ Example with two SJA1000 CAN controllers connected to the GMI bus. We wrap the
 controllers with a simple-bus node since they are all connected to the same
 chip-select (CS4), in this example external address decoding is provided:
 
-gmi@70090000 {
+gmi@70009000 {
 	compatible = "nvidia,tegra20-gmi";
 	reg = <0x70009000 0x1000>;
 	#address-cells = <2>;
@@ -84,7 +84,6 @@ gmi@70090000 {
 	reset-names = "gmi";
 	ranges = <4 0 0xd0000000 0xfffffff>;
 
-
 	bus@4,0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -109,7 +108,7 @@ gmi@70090000 {
 Example with one SJA1000 CAN controller connected to the GMI bus
 on CS4:
 
-gmi@70090000 {
+gmi@70009000 {
 	compatible = "nvidia,tegra20-gmi";
 	reg = <0x70009000 0x1000>;
 	#address-cells = <2>;
@@ -120,7 +119,6 @@ gmi@70090000 {
 	reset-names = "gmi";
 	ranges = <4 0 0xd0000000 0xfffffff>;
 
-
 	can@4,0 {
 		reg = <4 0 0x100>;
 		nvidia,snor-mux-mode;
-- 
2.14.3
