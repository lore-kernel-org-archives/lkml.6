Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E020658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2E020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeHaUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:48:34 -0400
Received: from mout.perfora.net ([74.208.4.194]:57425 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbeHaUsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:48:33 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lz1vi-1frQu40cQC-014DMj; Fri, 31 Aug 2018 18:39:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 26/34] dt-bindings: add broadcom (formerly plx technology) vendor prefix
Date:   Fri, 31 Aug 2018 18:38:08 +0200
Message-Id: <20180831163817.23970-27-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:gwfN6U6Qb2FKPMA8ymtIvFlpz6lr9nZnZvsbMk5Kur+EUpLWP52
 +f/L7wGaWryPTN4pYhByiLSDVAVtWlhRTNXOlTZyn7E0FNLlBp/uvRbiWWySNYt3Gzb4OUF
 v8zbTLAUJVpx9444Pu5kuHBKv//C0IFMBg5D9gps1kEE9XLzjpg2phtIqglWSVy41MRkOv4
 QLNBMy2zl0wmuSA8j+7nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X+J5M0Aghn0=:UCVwa8mvgt/WX4n+ETyoxz
 IgpE/94Vs5UVbtcXaa+T8MgnyrDWHRe3t8tety7/XCsYWm7OU+m/SfSqitlM7dt1Q1AyiLZo0
 QmVLmOPgpcWml+2tzQtNjUp98pfhMAvOZ8W9YzJ9AetsPVUomblkPnck9G3SJ3Q7RalHGQb7t
 cekJj5vhUcLvN6U89qs6gB/ht34f+jVQrFbWHDX694C9CxxUwtziFjx98sUQKJVFVAQnpWdLh
 TLtEIWrc1z/lHz46oT9VtghQgccP+17FdblEqlNJIi7P9bidc0gHbjzhlqolNztNnGxQOHd9D
 L5Se2A8iQVmXjJG87BoA147eRt92eCtQEyV3EESAu4p+EUBhcXyHjQNfQPNQgqzsVNr+2kdOB
 wPJ0Ag4zbHU6YPuQORUxQ+zLxB91Mvg0gJkfyiffS+h1NFDQaq//zVA/m4DxlrB/S6inFhJw4
 R0OVc6lVk2n+cpYWiDeK17JFco+7p8c8E0HjoBRuVgyTi0yALV0ZiJGTOSlZFMFRPyaNGJQxQ
 lc1ZKIqnrClGINdiDt8hTHooMg51RJbFrYXBeHgNmCG0RQo7TEldm0HmWL4sVq3XJwedBma7L
 rKdGNy8WwIl1cVerC7MnRLCMGvmVq7vMuZLziegQRqFdl7Aomc+b2Z6VdwSiwvWW0LB4St5Q4
 b/RE3WdvOIvVEDjfmyxyPSHjDmr2QsGrlGp2U+ZQ9nB6uKTtO4eq4gvo7EUlnx+bvUxU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

PLX Technology meanwhile got bought by Broadcom Corporation but the
vendor prefix plx is still used in 8 current device trees. This silences
the following checkpatch.pl warning:

WARNING: DT compatible string vendor "plx" appears un-documented
 -- check ./Documentation/devicetree/bindings/vendor-prefixes.txt

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Replace "[PATCH 27/28] ARM: tegra: apalis_t30: fix pcie switch vendor
  compatible" with "[PATCH v2 26/34] dt-bindings: add broadcom (formerly
  plx technology) vendor prefix" as suggested by Stefan.

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..e40312dcba7d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -297,6 +297,7 @@ pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
+plx	Broadcom Corporation (formerly PLX Technology)
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.14.4

