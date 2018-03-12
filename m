Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-219018-1520855777-2-5114221657870431719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520855776; b=HAAaystYcdjaf3IlQ36e8WxVb7YDJRclAKWYc+S0COlSo7x
    OEoz9H8UXZPYh4LFk3FdbnDWUR3wL16zIre00V1+Val8I5q4eBgX99xmb1ScV+3m
    4bn3qxLGX4hgmYHT2FtrEhrPq7Zgb37R15YlxBVza83VUHHb5kcNRWQkTnHlT4Xu
    QvcFvvP/rpTNUlYhvp8SUZrupZlwedXZIsapbOQg+zHfvW5oIOSU4uJfgHH2DTPZ
    xcQN7Enencs3/mn5X2Ppck269UFVX4RatroaoiT5xYYOzV8BMr93ffzPTBzAG5El
    ToNSbw8P2tVJzhMeAYRe43Aw3oaHvFaS4RHPNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1520855776; bh=P73RxEFvuRPNFn8+EOYiqCJOPR1Y097r+HkUdq
    6ea7M=; b=sWqYKzoJWxJ0EqbVqmVtLwlNWlEFPFmNYjZFwO9LqmUCRDMBidZlJj
    T/BTMJs40ByMXiWQahmYJhaV8hZjb/u8WPXBR0cEgJGUP5vHGCUKm/pBf2smMSU+
    NHK6y77TmnvS19cQ0SPiA2Q5Ma2CKUPNwfvrs5uCCfMLP1LL/DDKrAfczUX8M2tg
    dg419QmUtczAk92y8LJabmGmA/mJnEK3jh0a8Q3HSaS3++t9THM2izuRQGZGHsZ4
    9pcY7cjUEn4AgckGifRdzzRG0S/HgE3yaNkIvkETw+v8t47FO6XoSsrYWaSJnPSW
    s12PiYSPwkp6MExhY2D+ajHBWmulPl0Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NSxFxUSV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jPN7f5Pi;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NSxFxUSV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jPN7f5Pi;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELuc/nrfHoazO2YlbDf6LEtwABEVZ5DxNHdFsIHVFSO3oEI5I4doQ7IJVAdOmpmTYQBqjzuqPA==
From: ShuFan Lee <leechu729@gmail.com>
To: heikki.krogerus@linux.intel.com,
	linux@roeck-us.net,
	greg@kroah.com
Cc: shufan_lee@richtek.com,
	cy_huang@richtek.com,
	jun.li@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] staging: typec: modify parameter of tcpci_irq
Date: Mon, 12 Mar 2018 19:55:24 +0800
Message-Id: <1520855724-4956-1-git-send-email-leechu729@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ShuFan Lee <shufan_lee@richtek.com>

The parameter, dev_id, of tcpci_irq should be tcpci_chip.
Remove definition of TCPC_CC_STATUS_DRPRST in tcpci.h.

Fixes: 8f9439022648("staging: typec: handle vendor defined part and modify drp toggling flow")
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
