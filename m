Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEULog (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:44:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:60143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeEULof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:44:35 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] checkpatch: chmod handling
Date: Mon, 21 May 2018 13:44:22 +0200
Message-Id: <20180521114422.3829-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.17.0
X-Provags-ID: V03:K1:83zRaow5j4YHg4yKM+SHH9cUpyP/DNVJ4aax6Q1CZaLcLyG24Xu
 SAxhV6as9C4sTRZin544PzWAEItxuA5brdInfIDWWj5L2K6gWUIIzW0W3S3PzC86VsrU/Lq
 w8UT+8xnROHOBPMKBgLA9QMV43GmA5A3wm1Q68R7m7fuN9e+Wd+YKpsdh2EKNftzS0zgp4s
 NHZlxE5BkRVZLDCaND9nQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SzPN/5oEGyI=:T/X10G0q/xHKENZPBPrBm9
 bR11rb8DzX3zoJP7b/w1/soUR+73n16zTfrE0PHFKgQRK4S+uAJCqdpr3HPGyLscQ5ijFRtMA
 DQu9B8JP4RtL0y1QWF6wHpTUuNnwM7gd2lBPIJEKZBkrGJp6m+3M+XkuxI9L/YbxQ4wA4TDUk
 yaS1OGD11ut1Ee8W/OuVAdp2x6cUd95tc6grfYO7vO9TrwB+KTD4IwEVrJBm3YYD5CUwTYXRE
 ni9hHo2tQHTHbZjeltKJbUgqFEz2nLDZgZ8P+MnQ61PQWStT1wHFqiSfdCoPGOdT1kd6OSBO0
 4R8pBvnoiTxr7DTjmpx/Ed6Ux/BsfYgesdDHuH2X8d5IQFT84N05NClLMWI521OzmF3KPgSu+
 G3iqVGpI03AgzA5F0nH2SWlhdsSrYBx41P8xm0gdzkCxQ4j5p8ceRYj2ewsE5vAVYkTySZ6pR
 eLIywV0FP1aq1pUiMazzxsbanKo6uC8AnRe80aCqhJVwHg/14skp5zJtZ2PVXNU/DjmPcUf9D
 b0fAhBPDYpP6fzinCzeu9+QrzoLpQtWRepcq9FL80462BZEmh3yPioLO5SPTDawC/oYGP4tvS
 88qDL1gwoSfs9sxc/dhLyr5ZCC9nxqeC6WUCaQgSA92iSp4ADXSsYM/tk4j3CSo7krPcxxiKm
 Hp2AoOAFzAw0Ay/2Th4iXjr49T7wNHbx04o5+iaV/G784lvYBhwQF0Yf1HEO0MAuzlFCeS11e
 a12Y45XhwryZBEHGV50Gnmny8agIEvBPBpuFR9XCrzjTBWx/5B/gmPaXulU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a false positive:
ERROR: Does not appear to be a unified-diff format patch

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 samples/mic/noned/none | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 samples/mic/noned/none

diff --git a/samples/mic/noned/none b/samples/mic/noned/none
old mode 100755
new mode 100644
-- 
2.17.0
