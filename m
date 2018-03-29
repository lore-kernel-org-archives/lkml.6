Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4151933-1522302752-2-5197346106830234918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensk.us-asciisv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302751; b=Z7sP68YR2RPubzp/2jLkbDAenZeDQodUVVrhgaDqlUeCoX0
    uhlDWOTy2y3iiPHdlZFOIZ9H/TMPB8MgWZKgE5Qdo/I9vC8rvFuaJDATLg6BLOVx
    YUJ0U+dXHKHPReSdhDY7YepsSBH9btg/7URH70/Tkeddku+OFEvwXu0QLjXmz03o
    FWCDk5mqo4g+7dUCb1Fn4pa2Uzjme2qJlMLRo/hR1nHCLCgVlINa6u5NJNN8qckr
    WqZ1R9Lrwd1qoLvszk4vVU7d4jDlzHaVVboacICSjkJvn3jK2QzHhD4eJ/Esyh/G
    RN/h94ToFvLQzzoY1jFrMcKJYrOkPnfOnH83xAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302751; bh=G
    agw8/wDAKtcVTfBX5TmTFrX95XChiHQ1+rUIK4usrw=; b=vxKYtj33P/nzoBxAy
    rXO24oWjNaP8P47GmlgGdHT1baywW77EUYRz9akCa32oAFU5ncYa9+hkLQ65GI4f
    eUEcZtxGUUsWueBpYExGHC50q+qdl5BXIwLAxw2WfljXUfvsw/84EcAWyr/3faX0
    JJaROi9RkpTfDr1TOUzHdjyd2HKRmrow/rJdIPDfOMJ4geeZrlthRLdLT0D745B1
    ZSnPT5D2jQ+DrJZGSlmgZ5zAhztZd1UWIyNfu9x7/IjWKyTYWK9H9m4Q1JNIGT7M
    1xaJ4MBcdUUWSyNOMbv5eMEosR0EdwOeq9X/rTrLflLTGW53CvaVs4oFY7IITHNk
    mlnZw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCAIM6scjBSGMUhqWnPRZQoXGOiyTPC1kVM6kWxkirE5vjQIAkfvXxWXyhHKImCHoASJBzOJgN9Eu6oAYr+n/H9EEByns3UJz1O61eB3FgfI4MFfD+e0
    BPNOF99Bku1Tu927j3oWwoBo964l6AVeguDZ59C48dSY792CXxOGLVeSVMmZo1E1COcjgClFujy/mKkX/rB/KYogvci6FUcHAAWw0JJNUHpgPD3G3Z329PIs
    OVKAqBNFI6WrSS/6r1Ywgg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=2tVUsQXlzfN4wu-OacwA:9 a=wo00M_fbomGCIDl8:21 a=TKiBwV1OdNmKy844:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 5/9] staging: ks7010: Change mac_address_valid to a bool
 instead of int.
Date: Wed, 28 Mar 2018 22:51:48 -0700
Message-Id: <20180329055152.13059-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:rEsd5FHru8xXN6bUiBsHTK2eI+A+q9IkkkQ8feKmaH8cqjTIx1G
 ubADVNRQBZMct28FUJNg+oeStT5911wwFaNGJUS+kc9a+7pWS+FpDtd6VQNVJEeL+2HU4Yn
 6RCCoF9QdavNaBbYtzIEaFPQSrly4Qi2++WwAymqfpykN8zyoQ5bBWT58HBta9m4IPUz+pM
 lPSGU4BYLPkqAmQ6QTTCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hjeliiW2dRY=:lkdkeYDx8djEqi0NJMojoF
 k/wbXlg5YFJ2EJUT3LzHB71/v31Gkw7EptHOJIOOINi/a2P/vH1MUnphBaEl3MWsThds2DvPv
 ozaApUPVI7oJahOztX90Mao1fh9Mrtk1P4DiUg7EJbapUkRrNZGFbJdO0LafXxG1OpnvlWFMD
 kUfb0AmmgOtuLTVcyqCdPfhpK/ge2Gt31vcOfpOdQfKzMQvx9MoTUp5DBzNcdt0yo3IJepiAt
 LmxtcrQjekqp6R64AW4bOrLJJ0qyi9dA5V7W65fuSScZONqWx1T822q6cchhXBKXe9Mk1T5bs
 chKeNYCOVCDVarXqUKMRmThrhW9V8gci7STAfnMxHmqxcd5YHA906708BTTTfIeHJwt0B2K8y
 2b22xaEsPrfxtEXA6V3GNy9dzTAi3sdVHEq0MAYYQcwdeHVezvwpM9V5M09smnwZ1flvo9xzP
 Y5PvQ6wayQaNCtX5wivh7xdRomayQzcao4ez0DO3pZlg8rspGGYFpyHi/XwnPE8wdYfF48F9j
 OS8PJ9ddkwOnrH/eagVGPGrwcom8vhSRNSVSMJ184qmFeH+6Pyq3p/gykE3RYLR5a5JUHYf9B
 unMN57hFVqvshG0jbFnswGchtfvaNuZD566o/m46uTZYjwDKpI8xhKe+xHiPoM/9YyDHWjigT
 tC7VYAfWFQVNmUD79iatWIycGhN1vTWKuCqdgrkJyBz1T/qEiNAwhOe0wewSjKqQaFwKdDxAg
 jN+JmOg2ydSytiClBscSMzuDiQ+D64XiMWvO9Q==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'mac_address_valid' is only ever assigned 0 or 1, so it makes more sense
to use a bool type for this variable.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 4 ++--
 drivers/staging/ks7010/ks_wlan.h     | 2 +-
 drivers/staging/ks7010/ks_wlan_net.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index a02b73e4e81f..79d21a64ffa2 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -523,7 +523,7 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 		/* MAC address */
 		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
 		memcpy(priv->eth_addr, priv->rxp, ETH_ALEN);
-		priv->mac_address_valid = 1;
+		priv->mac_address_valid = true;
 		dev->dev_addr[0] = priv->eth_addr[0];
 		dev->dev_addr[1] = priv->eth_addr[1];
 		dev->dev_addr[2] = priv->eth_addr[2];
@@ -638,7 +638,7 @@ void hostif_mib_set_confirm(struct ks_wlan_private *priv)
 		hostif_sme_enqueue(priv, SME_MULTICAST_CONFIRM);
 		break;
 	case LOCAL_CURRENTADDRESS:
-		priv->mac_address_valid = 1;
+		priv->mac_address_valid = true;
 		break;
 	case DOT11_RSN_CONFIG_MULTICAST_CIPHER:
 		hostif_sme_enqueue(priv, SME_RSN_MCAST_CONFIRM);
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index f1f6c88adcca..846bb1041850 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -456,7 +456,7 @@ struct ks_wlan_private {
 	unsigned char firmware_version[128 + 1];
 	int version_size;
 
-	int mac_address_valid;	/* Mac Address Status */
+	bool mac_address_valid;	/* Mac Address Status */
 
 	int dev_state;
 
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 41f89f930f50..df6192be8a3e 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2767,7 +2767,7 @@ int ks_wlan_set_mac_address(struct net_device *dev, void *addr)
 	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
 	memcpy(priv->eth_addr, mac_addr->sa_data, ETH_ALEN);
 
-	priv->mac_address_valid = 0;
+	priv->mac_address_valid = false;
 	hostif_sme_enqueue(priv, SME_MACADDRESS_SET_REQUEST);
 	netdev_info(dev, "ks_wlan:  MAC ADDRESS = %pM\n", priv->eth_addr);
 	return 0;
@@ -2890,7 +2890,7 @@ int ks_wlan_net_start(struct net_device *dev)
 	/* int rc; */
 
 	priv = netdev_priv(dev);
-	priv->mac_address_valid = 0;
+	priv->mac_address_valid = false;
 	priv->need_commit = 0;
 
 	priv->device_open_status = 1;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
