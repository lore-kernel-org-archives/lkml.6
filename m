Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968254AbeEYThz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:37:55 -0400
Received: from vern.gendns.com ([206.190.152.46]:48884 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968031AbeEYThA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:37:00 -0400
From: David Lechner <david@lechnology.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: Add vendor prefix for Adafruit
Date: Fri, 25 May 2018 14:36:21 -0500
Message-Id: <20180525193623.15533-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525193623.15533-1-david@lechnology.com>
References: <20180525193623.15533-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a device tree vendor prefix for Adafruit Industries, LLC.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b5f978a4cac6..4d2ba7f52059 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -8,6 +8,7 @@ abracon	Abracon Corporation
 actions	Actions Semiconductor Co., Ltd.
 active-semi	Active-Semi International Inc
 ad	Avionic Design GmbH
+adafruit	Adafruit Industries, LLC
 adapteva	Adapteva, Inc.
 adaptrum	Adaptrum, Inc.
 adh	AD Holdings Plc.
-- 
2.17.0
