Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48wl8smEsZrNwxuH/bSME3HFkxfPurO13HBNe/+46hmN5YCl/bwKiXkRcz3Td+ly0KjBo2A
ARC-Seal: i=1; a=rsa-sha256; t=1522393801; cv=none;
        d=google.com; s=arc-20160816;
        b=olKvGU78ELAq11MBnX13j5mxoE9LpbvZoIsUox2B0T8iF3TQzM+5gtRLP5BfTnK/+1
         pJ3LOfwJzjON3G/EXmMDXsTPSnSx1xS2bLL/+mA9A02oSfNnV/pFwBQEm4dIDXop88Sv
         1Sk5T0WNfG0cIwZuqonL+BGmkAIUNvObZ4N0xzA8u77QsXqSBTmb0RxB4Lnx94X6+2bk
         2grA+nqFHVDs787pD983h08TAd5tu5i5RyLkISgzhMhfwrNZ7zrN2+OoykY0x1k9jyHH
         9nZN1SxrsM4bpU3z2fNCwHv2w4HR/HhiqPkk0UjV6CV8oYk2yEyF++Z8uhR8wZCwotvT
         MLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=toZsHcJ5V4Fb9J9FAQx56aAn4a5VxmvX4VFMjwp/Po4=;
        b=OQXP8KQUWDL5FkKI9H+kibzOt9UIdx9Oc1RmRrvrIhon+biTrl0bWmPyK6stC/bM3u
         tqrL3QTR9V+n3bAurnOYVnHAgGYYjCcbTrrLdi8gMNPTMQvLTXo+vwhwYj2x8g87R7xf
         WSiw7jTuwtoMA21KHzJ6uu5FYUdyUYCL4b2izmhzUTsEh30dhK3L9zxtqpfnqv9qEMlO
         bw2Qrb97+vcYmEERl6yEa/+gMrakq3GCQt9AA9qAFtb3KgOso/MJosOrOebxmF+w20bz
         YBiLXclJYy4ty29SULxCA15UpqjShl0wFPQcGRYx6UJTDJoQPi6d/ddO0UQiuiGHtXDy
         +yzw==
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
Subject: [PATCH 72/76] staging: ks7010: Remove dummy address set.
Date: Fri, 30 Mar 2018 00:08:37 -0700
Message-Id: <20180330070842.25224-74-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Q78hJzEAv5JLrcCBMO0Eq4qyqo4WibYrBOCC/cWjt79s2AVOsoH
 VwKgnq2MyZ7oycmT4Rnjl8ILwdcF22IOrMsgl9xIIDWmAYcCIjHPL4GQZkOiq/Wu8R6a7wB
 BalK0ypIDCL026mFH9+nvCkkRS2Ki92WWOMQTDKRpd2RmDl6bZi60/JdufyJi7UmJcweqzN
 mKO6KVh8JNGOJlN0ICTSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oKCpVLhauUY=:86VD6fRZrZnaxBDIIuIAuB
 f8agdTJeywurY2EUAFLTiaaxrAl/5PpdFrKCW7jnWTD12jKxVUE6Z3mryg3oM6s83FKatHzrD
 v+SAUChkaywpkyxgiLEBFQfslNlaHLv81bpdZnc1X6mXyj0G8dAlV/txytcijk1DcOnmGB7LF
 DtbyYypK/ZOmBFwm2K+TcB2P97og76D3oK2ZD6bFTsjovIpdhRoODYX4LJUeDBV115PqQjMMM
 ODfgsAPnnLZG00ewGp5ooUDK3BzTBHmWLu8pVbqHWLUcdt9ssAJ3ndhNTObUpCslM2SjvjJ6E
 HZK+Kk910FX9HCTPsfeVm1Vy3IhkgJId3EMHNl8ogvqI6GAIOCay4jKSJ3JouWEuklGLvyWOH
 kIeVuoHxqX2SpSUaPJ8lvr1qXaeXprBhl+qB50nosSN9z4Nfl1VZWPbebWBsMwwueXWfBpnjc
 N68PH6ffsXpenN4YLVBy7V3AynLl7H9L6aPTrI2PoAMuJe8oFSqoDlVP3unIzvJ/wjMUaAlv+
 53wHnELsOvGiMOBezBH0QxkspeeAM+kXAXRXqJIoO7Hx1jr0eEWt6r1C+b95V6tOdzFLIxp1a
 Ls5nOpFAuIKnSyySqCPy3sdr/a7hy3rCWGBPmEFHqN6ySyhqk1BY6dxOA0Zb8D4EMJInqmCB9
 ioPjHht/S/CIpEKJWGN8wt00XaRNYb3scWBwp2VFVQmJ/qaM+fWy7t6U2+l/Zniq5bJf/QBxL
 PKRYJ+n0yDlSupSYEzY7QtMOCUfQXr0W8HEyvA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345602818208283?=
X-GMAIL-MSGID: =?utf-8?q?1596345602818208283?=
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
