Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-4187132-1520848076-2-1271304279947970093
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001,
  LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.192.196', Host='mail-pf0-f196.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520848075; b=F38+Xp807BWs35JVsspVWNP40AqgJ5QFG+xXE9BnFFoaU9C
    gnmFOq/tqOramC3unCrt6ZqIhylHpYRvs3rPWcehjYRBGOMGgL2MFgOu0oiobRAn
    ODIQE6O/Cu4H7I5yccY6aYIzmnYEBrkx4UKIWmBY6vAWbunI9/gYWbPRkF1u16VH
    XQnPaPzrcwMM64KEKlqQtrZDQ2reacpWnsOmW8MDcu+OMkVdb0rlDBUVkqL2YQss
    n04tOj7wYiFk0In3q0uzPk3XueJSSx7R6/mbyQm5x0jppHuD8aGcMLQtAtF+xqGq
    T3Py1NO5xF27qAfxFqE+QqdGVP4ByKQlYGmvy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1520848075; bh=NQ1SLZcgrWInY2U6Sa2d8Cc9fV8xadLvSScoND
    8ewvQ=; b=F7ntV9zKfbOVnsw092ipY8/1DrJ4XaNwTnwEkRbON0I1lTa+V6KQb+
    BiRgsEgr4DFAlh6WViXjFXDTd85i0Dha3Q5EJjkDqJrf3d3SBOWyb2iwZ3M76O75
    60eEteOWrpVqCouJfSXuRdlpq74UBPYkpTK4zY8EDsoEKov8soYuxv1Kk6RAjqks
    zNg6dT/uC7tqD/ITW5thX44ki8uGjginqK6p3NTcSeXA8HooF9p1zcmmiO+EiiLT
    J/kSTYOU3EOggOvyuCYQO18VqdOzXRV7+KJB15yhAdj4dP5+b0jR/CLr98ks1iRZ
    LArWHQUwBXNpWrSkvvRWr2ELradZnV3A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XGds8k/E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.196 (mail-pf0-f196.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f196.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hqa0ghVr;
    x-ptr=pass x-ptr-helo=mail-pf0-f196.google.com x-ptr-lookup=mail-pf0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XGds8k/E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.196 (mail-pf0-f196.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pf0-f196.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hqa0ghVr;
    x-ptr=pass x-ptr-helo=mail-pf0-f196.google.com x-ptr-lookup=mail-pf0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELs3WuOKLKZbdSuHI3/1k14K3NW5fRVvk8oeJMKS2Sg9OUgyrYJ4PlSx2qNL6EGICUgAFgW6wQ==
From: ShuFan Lee <leechu729@gmail.com>
To: heikki.krogerus@linux.intel.com,
	linux@roeck-us.net,
	greg@kroah.com
Cc: shufan_lee@richtek.com,
	cy_huang@richtek.com,
	jun.li@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] Fixes: 8f9439022648("staging: typec: modify parameter of tcpci_irq")
Date: Mon, 12 Mar 2018 17:46:42 +0800
Message-Id: <1520848002-3801-1-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ShuFan Lee <shufan_lee@richtek.com>

The parameter, dev_id, of tcpci_irq should be tcpci_chip.
Remove definition of TCPC_CC_STATUS_DRPRST in tcpci.h.

Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
Reviewed-by: Li Jun <jun.li@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>
---
 drivers/staging/typec/tcpci.c | 4 ++--
 drivers/staging/typec/tcpci.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
index 804374056a1e..076d97eaff6f 100644
--- a/drivers/staging/typec/tcpci.c
+++ b/drivers/staging/typec/tcpci.c
@@ -451,9 +451,9 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 
 static irqreturn_t _tcpci_irq(int irq, void *dev_id)
 {
-	struct tcpci *tcpci = dev_id;
+	struct tcpci_chip *chip = dev_id;
 
-	return tcpci_irq(tcpci);
+	return tcpci_irq(chip->tcpci);
 }
 
 static const struct regmap_config tcpci_regmap_config = {
diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h
index a2c1754ca222..34c865f0dcf6 100644
--- a/drivers/staging/typec/tcpci.h
+++ b/drivers/staging/typec/tcpci.h
@@ -59,7 +59,6 @@
 #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
 
 #define TCPC_CC_STATUS			0x1d
-#define TCPC_CC_STATUS_DRPRST		BIT(5)
 #define TCPC_CC_STATUS_TERM		BIT(4)
 #define TCPC_CC_STATUS_CC2_SHIFT	2
 #define TCPC_CC_STATUS_CC2_MASK		0x3
-- 
1.9.1
