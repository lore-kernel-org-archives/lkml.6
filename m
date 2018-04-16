Return-Path: <jacopo+renesas@jmondi.org>
X-Google-Smtp-Source: AIpwx4885vHvTdxSVgsPDAkTwOJgcS7lUlz62NNsFmAqWQhyQyQO6tDVctT7psEUNG6gvTZ5KNVp
ARC-Seal: i=1; a=rsa-sha256; t=1523886939; cv=none;
        d=google.com; s=arc-20160816;
        b=vZPTjDgu3T0wWjWeWOGGeEFKMGw5imW/J+uyWMT/NrpJ+xd/XaWSMubzyMzPlCQIUE
         50tzn3q8j6B6WD/HhJMQ3QZao+hyTtXEAA6JTX3l9PeAmlGhud7JrOB85O/SsAqkr1el
         sgMlqTHp9fMUjUrpmB46a+jm8grlJw/QLhSmJeb9i+nqimQxBIxVhLkptqr+R2RNeoJx
         MJuHIZt/7p4VuL6ulBMAkB2lkV5x3x04mgopjoMGT/8IHMRoErulm8w3UwT+Zw1CWo/t
         Kjw/wg5dIHoocLkqt0AwBv1UlvHMwHqBjbBj4Km/pKxJEtXHVlwOKlHb2zWcljnV+CY0
         8Dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=BPSOMjs/6rP00ulaqaHOa/sZw3huhJgxwXq2Ffnou5w=;
        b=nBHAAfKMwm8C8mIe5eYNkbZuwgbwtRr4a3Xz5dWSX2GYmyAyxQPoxeajb6+OBwWClp
         zH4uDolwkf5iT8fo78enCWxpbBH4TvsyztXdNYcHFlcsNCIE980b7k74Gf8VgwvVHcTL
         o2X8yybY2PmpX3KQtZTdqDbo1qhp56jQ/qJpSjVkNRBZLpWgbUFm8prkW5cbmABZaNEA
         7D4pAjr/nLQ1UZS2qyiAz3uv2j5r135f/k5+mFjHm72ani/g819wUiLWbBDd06lCLxK7
         LzAYGxEQejtdMlbM2YjhOtU3A8CNEH0oNUriV984kaXFZzaPvhw+5XZRb4lG5mTDITk+
         sCJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.70.178.230 is neither permitted nor denied by best guess record for domain of jacopo+renesas@jmondi.org) smtp.mailfrom=jacopo+renesas@jmondi.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.70.178.230 is neither permitted nor denied by best guess record for domain of jacopo+renesas@jmondi.org) smtp.mailfrom=jacopo+renesas@jmondi.org
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
Date: Mon, 16 Apr 2018 15:55:28 +0200
Message-Id: <1523886928-14535-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597911271665078819?=
X-GMAIL-MSGID: =?utf-8?q?1597911271665078819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation for r8a77965 compatible string to Renesas sci-serial
device tree bindings documentation.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---

Renesas R-Car M3-N support has been merged for v4.17.
Document the missing device tree bindings.

---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index ad962f4..0cc5417 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -41,6 +41,8 @@ Required properties:
     - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
     - "renesas,scif-r8a7796" for R8A7796 (R-Car M3-W) SCIF compatible UART.
     - "renesas,hscif-r8a7796" for R8A7796 (R-Car M3-W) HSCIF compatible UART.
+    - "renesas,scif-r8a77965" for R8A77965 (R-Car M3-N) SCIF compatible UART.
+    - "renesas,hscif-r8a77965" for R8A77965 (R-Car M3-N) HSCIF compatible UART.
     - "renesas,scif-r8a77970" for R8A77970 (R-Car V3M) SCIF compatible UART.
     - "renesas,hscif-r8a77970" for R8A77970 (R-Car V3M) HSCIF compatible UART.
     - "renesas,scif-r8a77980" for R8A77980 (R-Car V3H) SCIF compatible UART.
--
2.7.4
