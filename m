Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvDXUTX95eLXTRo/Ev7il1OA2Wbqhh0rgpacSBNvEOjoilIcFAAzK0xqdi7rE/cpawFmbnu
ARC-Seal: i=1; a=rsa-sha256; t=1521799139; cv=none;
        d=google.com; s=arc-20160816;
        b=pQVaokmU+DZZvfwLEHWOUaGKn5+m5eDsYSueuGH7Rz7VOe+h7xtOSAZkneih0ZOQB8
         uNKPSfp/Jnao8PFJNXN4DFVCZsD05qC/Qx5IoJsKl9z2aWoL1/Gzxaf/j8mmuyowNuBT
         PbF6N3OQjiIEbJcbmmdR9qrf6IonrH4Mz+k6T6Zqy99qRgQES9NG6gZ4Pu4l4iS9QEme
         Touy6BJr0r0w8gVzvxCkwXKhUuC3F920txobwBUjCV2Jw1qZjsTtw635g2Ds8kuFP+8V
         s8f+lLjZJiEV8anlyoQSPIl5rO0yzlr2yg6lLMrrut0cSm/jRWeeDRzdQlwdxQH0AuV9
         agUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QVEhCEC7yEH1fcklKMLlvIhieqATSbUChD1DKdkMsqU=;
        b=NquNw5FNJRRulUz4igoRzcCZ9Cbvs6ueFNtwn6+flYIkEqza5OAtw9H7zu9RxalPUk
         aIvBvyd7ovQX1QVngx3DVfH53WZlge5yZBY4bjACWfuoNoJKC3cd/swi1IqCS5k1yhsr
         uk9OGF3c2f0eaE7OOWK+ORUTCe9vbAx10ZpKYP4OY+bIBY37MZRV/kvs7udhE65Rb4Li
         WYOjzQQrjv2VRk3y+MnJuclbyMGDerdIqOF0ZRJNOgU2iMfKTPLVL+lZgsx3KyzbBUuK
         LjtLIH8ZsTyOXCSlxy0wWp7KXJin9hqDAx1xyC+cO2l8v96+2xzKtBQBrGZDUtaolKA+
         xbmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 56/84] dt-bindings: display: panel: Fix compatible string for Toshiba LT089AC29000
Date: Fri, 23 Mar 2018 10:54:10 +0100
Message-Id: <20180323095420.434731826@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722053927214119?=
X-GMAIL-MSGID: =?utf-8?q?1595722053927214119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jonathan Neusch‰fer" <j.neuschaefer@gmx.net>


[ Upstream commit 81ee6f1ef9b1e93b2dc0a77211e9809ffbeb7ecb ]

The compatible string for this panel was specified as
toshiba,lt089ac29000.txt. I believe this is a mistake.

Fixes: 06e733e41f87 ("drm/panel: simple: add Toshiba LT089AC19000")
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Jonathan Neusch√§fer <j.neuschaefer@gmx.net>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/display/panel/toshiba,lt089ac29000.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/display/panel/toshiba,lt089ac29000.txt
+++ b/Documentation/devicetree/bindings/display/panel/toshiba,lt089ac29000.txt
@@ -1,7 +1,7 @@
 Toshiba 8.9" WXGA (1280x768) TFT LCD panel
 
 Required properties:
-- compatible: should be "toshiba,lt089ac29000.txt"
+- compatible: should be "toshiba,lt089ac29000"
 - power-supply: as specified in the base binding
 
 This binding is compatible with the simple-panel binding, which is specified
