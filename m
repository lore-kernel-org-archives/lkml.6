Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48EUNdZBEUZ/brx75oylmWGBavq8Sn4kIARvBaocW1GmINe79xWgbxaAgNYNBYHDxXBVFW8
ARC-Seal: i=1; a=rsa-sha256; t=1522476626; cv=none;
        d=google.com; s=arc-20160816;
        b=TOEaFw4w3lE7H5EzmGVHnro5o5TYhING9Hw/07omT81OFLOGgb/Ha/QWGlxm45fxiC
         BfWiZJzhtYVEthkToLMNZ4pkwL/Ea7GnZYECeVui8RdpDcXDn7llnjJzwWLVtf56eMSr
         M4QDA4BF4q/zfdJ5shq5FvWOeaBdoNhveij33O4MfWYUK9tZq858A6fb1SSP0Q/8R5Nn
         6h/JimdK4cMsQ6lmaOq6IZUFsUXj45Bmk5LhFWWxja7JVrrbOTEg5OGHEAmDbvHTyNUe
         1qqZF7YDd3DAiq/zjy1PflJAZfafwoqKarO0aPbe0hZrj7rY65lNpZdLc1PJY/pWKh98
         RfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=toZsHcJ5V4Fb9J9FAQx56aAn4a5VxmvX4VFMjwp/Po4=;
        b=vu3CNgrpODYO0M/FS4IJx7/mRRoFXha/UNgu4GaBA8IHuLTUlXJkqsjPF4R9qeobjL
         a6ZPPfILepLzLmAYVeDeFOMnf3YkCq3ISrVPxXp4v07zHNg8vwboLBISh0+L1o0Al2CY
         nsvI3grEezrv9tNEMJHOqR9kH6vJnTZPRmOE9eBY6kBtq3uwqCCc5fDQzesmXJhLSJp1
         R2vQfHbImtTN2Go1PLixUiO/UXBcqtoEk2C8wdTt2mO289HGwWq/QjY3yt+er/RBO3b7
         UWXJ1wy/9XtxCSJyodx1K9+t+QcNgxH2UhWzgAKa3R0WojnMXGcQoH5kJvrBnAIHfeLd
         +CrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 71/75] staging: ks7010: Remove dummy address set.
Date: Fri, 30 Mar 2018 23:08:51 -0700
Message-Id: <20180331060855.9452-71-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:2RZxplgVOMXvPKWTfkh9ZXh3ZC+bp6b0Rg4BBcTfnVa25+MA5mK
 uVl+54QknTg0+2dYmRbrUDXWGRNUTg94XAkIgLpus3o8tSuRDjr12pEHB7X4KUpfYwi7dEn
 wtbVqWRY4HO/WJAg6u9deTF8rkxBWKKVTm1q/O8WTQ0vI2hQuTJQfx1SWM5CEPnAoNsdQlG
 JUCU0P4doATlqP+udJb3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lhEpFCQ+Iuw=:1UX8w/2eSSJGhxXhbgV4F/
 5xz/yQEvA3TaTS19xqEiO+mye9zBgaVWRBDJA4LENC5PohPbAq0IWNrZu+o4w41ugvzSE+7EC
 ngPufu0tlXkaote2iB/unB2D3mHDRzuzrADhv31iccLo6HBxYTG+x3cz4LAv/kXXemHC9BACd
 mjMe6aahtfbrJkNWVtY0BzGQ9vh3bne3AjQjlZ54R5xpMWwkifmJY8YpQL2XXhnM4GXwdAR2t
 183LDxQMgwTwWLimIWWplh9IAC/8xwJb2cFJtT8uYY9vykOhMjWA9wBq8vcNRWmGXsQfAc3xU
 miIHZdUB05IEmgmgEPQJC3HuyjgiwPrA6Zf6LrNdM6COWf5nSmeiRlh/Z6oRVN6fVy+KNcktk
 kfdGBX7DsY/EzkL1D8fkQ/4hcyz0k8z99smmvlIX2yF1a9vVSAIhxhOS9COiU14MEqZ9sEacr
 y0WrYjsduzd6pqnzxybr6YV28hxn1kxOeHpvltfG4s2Buhq1qOYDzjF4Zx9Dgv73nx13kP3vh
 80Ey5xEOwqyho2i2Az0qcO6rt7obhuTET0R2R6zWMjsEI2UJEThg40W5MQG/j541Qb9JEBK7r
 +46D12AYyXNARNnv/R+EDSaOmnqj9zxwYISY9BDUQ38TAE+aX79tW2d+yEsVxUXWKzAaxZ6Dy
 GwSj/mGfZWUsJxL5cEPWO0cU9rl5lOE7MsWnu9Qc4Z1Rf82BSLLHALzv+d6Dx4Rv7J63i3wJi
 MryqY4MRGheFLukAbstyOc5bYgv2peKG/0yz3Q==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432450752943078?=
X-GMAIL-MSGID: =?utf-8?q?1596432450752943078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Setting a dummy address during the driver probe is not necessary.
The dev_addr field is already zeroed out from alloc_etherdev().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 5c5569000fce..afbc472baa05 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2852,9 +2852,6 @@ int ks_wlan_close(struct net_device *dev)
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (3 * HZ)
-static const unsigned char dummy_addr[] = {
-	0x00, 0x0b, 0xe3, 0x00, 0x00, 0x00
-};
 
 static const struct net_device_ops ks_wlan_netdev_ops = {
 	.ndo_start_xmit = ks_wlan_start_xmit,
@@ -2882,9 +2879,6 @@ int ks_wlan_net_start(struct net_device *dev)
 	atomic_set(&update_phyinfo, 0);
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
 
-	/* dummy address set */
-	ether_addr_copy(dev->dev_addr, dummy_addr);
-
 	/* The ks_wlan-specific entries in the device structure. */
 	dev->netdev_ops = &ks_wlan_netdev_ops;
 	dev->wireless_handlers = &ks_wlan_handler_def;
-- 
2.16.3
