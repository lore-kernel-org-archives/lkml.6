Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933064AbeD0XAf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:00:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44569 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933017AbeD0XAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:00:30 -0400
X-Google-Smtp-Source: AB8JxZrG13kaz9IBtTBejq+opoCNdmb69M+Vg/Ve0od5S1xuERR1X/p79CMKQScw4ZjaSP3WsQipmw==
From: "Wesley W. Terpstra" <wesley@sifive.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 2/3] dt-bindings: Add "sifive" vendor prefix
Date: Fri, 27 Apr 2018 15:59:57 -0700
Message-Id: <1524869998-2805-3-git-send-email-wesley@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524869998-2805-1-git-send-email-wesley@sifive.com>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a vendor prefix "sifive" for SiFive, Inc.
We make chips.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae850d6..c98faf7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -315,6 +315,7 @@ sgx	SGX Sensortech
 sharp	Sharp Corporation
 shimafuji	Shimafuji Electric, Inc.
 si-en	Si-En Technology Ltd.
+sifive	SiFive, Inc.
 sigma	Sigma Designs, Inc.
 sii	Seiko Instruments, Inc.
 sil	Silicon Image
-- 
2.7.4
