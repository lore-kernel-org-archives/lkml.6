Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeEOMiB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:38:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39935 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeEOMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:37:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180515123757euoutp02a148d8295d9296af99caecbb328640bb~u0a-7IU562145521455euoutp02V
X-AuditID: cbfec7f5-b5fff700000028a9-11-5afad4a4a5d9
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: exynos: fix type of thermal trip points for
 Exynos7
Date: Tue, 15 May 2018 14:37:54 +0200
Message-id: <1702366.qL959G52Hi@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7djPc7pLrvyKMvh0W87iwbxtbBbnz29g
        t9j0+BqrxeVdc9gsPvceYbSYcX4fkwObx6ZVnWwem5fUe/RtWcXo8XmTXABLFJdNSmpOZllq
        kb5dAlfGsWvTmQr+CFQsuxrewHiJt4uRk0NCwETiz9fVLF2MXBxCAisYJab2XWaFcD4zSsxe
        cIAVpurIxaVQiWWMEn+2nwZLCAn8ZpTYOTkNxGYTsJKY2L6KEcQWEdCUuP73O1gDs8A6RomJ
        /UuYQRLCAkESjaeOM4HYLAKqEsu7DoLFeUEaGg6ygdiiAl4SW/a1M0HEBSV+TL7HAmIzC8hL
        7Ns/lRXC1pE4e2wdI8gCCYEeNokVd6ZBneoicXhrNxuELSzx6vgWdghbRuLy5G4WiIZmRolv
        O/YwQyQmMErsWS8EYVtLHD5+EWoDn8SkbdOBajiA4rwSHW1QJR4Slxe/gtrlKDH9+UZmSEjE
        Sjxv3sY2gVFmFpK7ZyG5exaSuxcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQIjPzT
        /45/3cG470/SIUYBDkYlHt4dM35GCbEmlhVX5h5ilOBgVhLh3W0EFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCUamBUu5+wszgyd47AmU/PD66QXfRmeYZE
        Sn1aSqnD9oetpxK2BBl+ZTI73FrZ6/pKvPNglfx3y5fTXrMvZXK46Ct1NKehzUJN9U3Qbeaf
        U+9d2/4t+sgtnjuPXH5Pvun/kO25gN/S01sMjjmoMb7sLWGo4v5mOvWYRf2N8o27s2bL5bN3
        6646qHRUiaU4I9FQi7moOBEAwFtc3/gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xy7qLr/yKMuifamDxYN42Novz5zew
        W2x6fI3V4vKuOWwWn3uPMFrMOL+PyYHNY9OqTjaPzUvqPfq2rGL0+LxJLoAlissmJTUnsyy1
        SN8ugSvj2LXpTAV/BCqWXQ1vYLzE28XIySEhYCJx5OJS1i5GLg4hgSWMEr+e72QGSQgJ/GWU
        2NRaDWKzCVhJTGxfxQhiiwhoSlz/+50VxGYWWMcoceuHJYgtLBAgsaLtHguIzSKgKrG86yDY
        HF6Q+oaDbCC2qICXxJZ97UwQcUGJH5Mh6pkF5CX27Z8KNVNLYv3O40wTGHlnISmbhaRsFpKy
        BYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJDcNuxn1t2MHa9Cz7EKMDBqMTDu2PGzygh
        1sSy4srcQ4wSHMxKIry7jYBCvCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YW
        pBbBZJk4OKUaGA/4OF8Org9V/Vg38/WPiwv5dqYKXWbNX81865Gfm/2PVOYD19Q+rC+6ULV5
        q3+o8rbfbTxbPpyadytq1p9lu+777daxSq7VVPL49+NOfbJzQXl956FKjY+fdm86yGjOuS17
        4s38XxK/nrY03j57+kbnnxyLpTd4rp5IOZbxQZux5yj7bcOPt+8osRRnJBpqMRcVJwIAnQul
        ij0CAAA=
X-CMS-MailID: 20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1
X-RootMTR: 20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1
References: <CGME20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Exynos thermal driver treats as "active" all specified
trip points before reaching maximum number of hardware supported
trip points. Moreover polling-delay-passive is specified as "0"
in exynos7.dtsi (IOW passive polling is disabled). Therefore fix
type of cpu-alert-0 to cpu-alert6 trip points to be "active"
instead of "passive" (cpu-alert-7 type is "critical" so it
doesn't need a fixup).

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
===================================================================
--- a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi	2018-05-15 13:57:55.822172496 +0200
+++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi	2018-05-15 14:23:12.594016481 +0200
@@ -10,37 +10,37 @@ trips {
 	cpu-alert-0 {
 		temperature = <75000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-1 {
 		temperature = <80000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-2 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-3 {
 		temperature = <90000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-4 {
 		temperature = <95000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-5 {
 		temperature = <100000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-6 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-crit-0 {
 		temperature = <115000>; /* millicelsius */
