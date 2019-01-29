Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA413C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B171320989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfA2OqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:46:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:51931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfA2OqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:46:10 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc8Pz-1gYk9L1G4N-00JaSs; Tue, 29
 Jan 2019 15:46:04 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: omap3-gta04a5: Replace LXR reference with a local one
Date:   Tue, 29 Jan 2019 15:45:18 +0100
Message-Id: <20190129144518.9744-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8WYZxlIRtUGI16cZDe9ScB+pAm7iAjdpMRGBvVnbyPb52mTfeZz
 oE4cI2lORFfDxnP1AGkYFOCySnmpf3QqLEbvEA1KbPmkdSsmx3ESsYpYjWAnYnfCvF+k51q
 /FjKJfM9dDYO0ZwPPJn8JJond1MgHIyKmfVlVWE5BSlxvq7/IN6m3YoDC0WyUhS81h6Ip1b
 xEGif3TewVH4iBGaTkcTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0r1lp3sWZL0=:cNbekuHxXkHcJf9M6wwU4y
 dktE6lUUZysfD0hUx10xK7jr6BEHZkGua9LIP4fYwA5lbLDadftDznf0uHoW48hYITBmru2He
 zXjUQ4QOeMWWGe2Imilv2x8iZHMcd+UsZT9rxPJvGRF7b1fe6Kt700jWnRwUPZOasWStTUwCp
 lQ0nfOIo9azDNHX3Ou9FBGopUj+2CSRGAVyIZEleZ5Wyixf7eakVeRBLbbvY9ZO+oLiZud67T
 q5RYyR7G0jOaLWBFkZ/reZCQ0GxaMpOIJWpp9ohCdEIOix9f9nI5ve1eoOw0JA2V+MWJC5g00
 eoCZ0JcAk6Df8x+rwy599TYqxvkmhuN1UdaUBSpqZeRFJSD1r01aXscOCmhup/ciTWzcC81Te
 Wda6mxG25Pre6rrQN0ywA4Vr5nIfm6WkydvgJpgyEtlma/XE9LHga/J9W6fIh3GMGc7+Jp9JC
 IWfwu8DWSX0zc5gHC8sAMF5FScbnef9eAZsx/MtvHhDtQoE2OeoF+I18cPZeHzh6ZGlfe695T
 lwWU9mQnjm9YSP78eMbuZ61P5USQEPEDD+EAaV8RuGRhrgQhYruGbPqZPf8UKvEbkzHhwXpi2
 Iaeuxys3Z1b1dG2SBUallbyvHGSCqHn4YkVwwPVaVXb8BulfIaZKKYx4d4K9MhmzSOw0cgr2q
 Shkf/mxF8AYXC4QFoIBWEvGtv1YLV5rMCAF6sQd3fFQI1KKnLPbSCr80hxw6ir6e8DX/u2fR5
 Dun4p+cl0dITb5UOaExbczjsxiYnJao79t2tiY4sd3DvNfdmLYPqsiT6YKNc1MmDXnqFICgvb
 5FhZx3W/Q+0HQh3owaE19uCFImrcrIOVhbG1AzB9sDsUfEH2gc4m3bdSGRZCDDMLxVZaggB8n
 ibNCx7ht7qJkoBmKdYc0hDdV6WRQ3N5wjTB995nU1hVHXGlJ0BdCL95hd7xf2+FEYBuymb3xX
 FYzvdsJ8iiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to use an external link when the file is already here.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Alternatively, I could change the link to https://elixir.bootlin.com
(the successor of lxr.free-electrons.com), but this solution seemed
simpler.
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index bd232b1b24cb..223b47ac596e 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -82,7 +82,7 @@
 
 /*
  * for WL183x module see
- * http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
+ * Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
  */
 
 &wifi_pwrseq {
-- 
2.20.1

