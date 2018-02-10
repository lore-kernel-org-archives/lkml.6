Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBJBjd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:39:33 -0500
Received: from mout.perfora.net ([74.208.4.196]:53969 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeBJBjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:39:31 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: dts: tegra: venice2: remove duplicate pcie-1 node
Date: Sat, 10 Feb 2018 02:33:25 +0100
Message-Id: <20180210013326.27771-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013326.27771-1-marcel@ziswiler.com>
References: <20180210013326.27771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:a3smbqBfDzgGe6SRy/GrJHb4Fsacr9bQay8JjiO/eU8zmlPfdJG
 wWbSEMarIDYk1Q+hWoMpK54z2vBp63zLx5s1ir6zfYzqbwIAh5dDbfUEMsJ6MtuMYUQAkKk
 Q5EnKL4VoPAId0r86XSxL5RKF2uW+7LwdefO4nueLU/I/guh99cMWtt2v0+kpy+vGNdA4+S
 1ErinJwZbCDWcHzA45t3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gmEUAFBkTyk=:HV6lyfibMDI25zBGwYqLQO
 cQqxuqASv+NzT9zba4rkCUVl6fmF7rBF5NQn9kvtJX2WZpwij7S2s4k/gas3KvVyGy22XTZV3
 mma4Axa9cFQGfXTPCiyLBtChhPO89AOcO33Fbsd0MUrxhTdkz6YUbnw+ll5iUWyho4WBgoQsF
 O8JyrGejcF/m9MIkOB1QS8DB3lWIDhQkTJkDsr5vLAUSXgni9xrGDFMIBpM/CbrYsSavY+f8l
 SJKZkl53r6Etzq8Yd2s2y0Rbwk51PGwItgJJL5phZryRLXGritROukWeJV/NcWjx9LTeK+UYI
 zwo37xIExFy9BSg6HHpnWghE77LxAlx7ADAYWQYszG+gnI5k+B4M6V/sdBCI6c8Wag6VMzFPC
 hKp2BvQ3QEEiymRpMc4QXKK2Gf2sx3bivnbta8p4LS62MJlUbMYuuWnq9/j30GI2+z11zDFTy
 szKgvbvLIbMgckNuF3+c/nQV5RpoSqIlDfYoPPNvplDn4KoJClh2puLXSn+U/qPNiBrwWVw33
 QfEWjuSMU7T+yNxNK4ETMd23QXz12BH+LEGcWQE0B1yLP9Zk9LyAy87Rer3HBxIKzAnaUeTdz
 BiJ5nA2qBei2AblqkhiqdzetdfpmtF82tAgx1PaPwe36n5X6SgGzF1fP2NghrU/DuFR2b8uHU
 jIyW4qr+RFU5AWreIkqmq+McFGqIu4P6cLFLoFgkZ4yJZgh6dmTRNad70KtVXK0/3pAGZV4et
 jZNFpfHs6bbZf/v9UEmf4JFHsc3U/JAZxwqveg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Get rid of duplicate pcie-1 node.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-venice2.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c0469ea149d2..89bcc178994d 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -956,11 +956,6 @@
 						nvidia,function = "usb3-ss";
 						status = "okay";
 					};
-
-					pcie-1 {
-						nvidia,function = "usb3-ss";
-						status = "okay";
-					};
 				};
 			};
 		};
-- 
2.14.3
