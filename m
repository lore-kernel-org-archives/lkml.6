Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927865-1522393788-2-13814904877433373443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endask.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393787; b=nEwcJTANyVBkKpB4PshiH19+33e1++3QD5HX4BHXs4J4Fa7Msv
    GE0cwJBUP+3rA1GGp84qbmcFLbxUW20wwwou1GPZB98BS9PmakpX2XL243dFtthL
    4KcYvN+joAox6tuiODY7GGlTotg9S5gomwihIXDFFfuwM2X019bO5OGyUaefbC2h
    Nkk08m/DRLXpnA01IId8FGWIwpZ+a/J5kAsSiQwhKAmxi9JUO/vMcaCyeAxrEq4y
    2PSnmEcY38GxFEyNoAqclmWCId4CL8MheIuSxzzPyZsY4v7UiNBt2psx+mGEqirX
    8Xdx2CX3T6IVrFxFwf8RsDLtItLXN3UIMRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393787; bh=YLROz
    kWS7yiId6IiONsX9lnJBzhjaXyavbDYvNIVh5o=; b=NrwEPTxqNqAQQM45Bmqqy
    +Mh/UHMi2hX3aKtSiEfq/nk1HV2Pd/RP3+MsqpGX9e/cO+PQFt+KecDy4Lomn4nT
    waFHcorYYpIqO4MS4VN7+8nzTBDhe6AzE1FztBFDKvoWraDK3v9dYMvyufPb9ixw
    QmRI9I6F9ldP2y9sEGOmZsYIuwn9xl378l+0XuALtPDXEK0lLnilTIBb58IBeLQT
    TVLkXcl84HzoHogGjnh5f2v4l7ztDyTm1jvJ54aW3xjRDSLlL2BHx441dhDpO6g/
    vpxqeSn1ixNF1PpNJZNkRsSkm/iSMGF7HpEyyHBjhzVHJnsBPCj0SdEu2HMbIST3
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLRsbssEZ6pevC/kEuCrjL2YsMNBVWkiZHhuhdUtHZdwi7sQ7ixaCeKrhdIAUsAL9NCvJI04DfqJMs9zmshlqnXnfYEDTjik9oulnhJjTcuCe8mvBdE6
    Ie8OoApdK8tIAwkUC+YPHuE/87bQkU3JrNEAtWJswGOouySp3mVxQPifQa/nmQ6r/7sgDet62zYgKvrE2zAuCCpwEqjJS+OnklkTcjUzLe1DanSx28Q8QgII
    UfqrKAvlc6ZY4wFPea5zWw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 11/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_mib_set_request_t'.
Date: Fri, 30 Mar 2018 00:07:34 -0700
Message-Id: <20180330070842.25224-11-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:eeDXvIKRbMDSUpJywC14/P0l/kX82QhoCwh/qyYdMARt+0R/rSA
 YFZhayiffudRaixEEdx4LZprtoTk2DqE+zXMJIdh8c1AbO2Ax++WQhgOuNKVGghBVgaKrR+
 bRcUlAJXHDSgJpqlnmkdgo9D7SNFFvJSUwtw16lRC0mkE4ypfaxdPLXGY6HyPdBoqSW7nJ1
 y2AH//w9uMx+TbdIiKOyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9xzKtnRKGKk=:A5Fbv3qD1OdihCAkwt5I+W
 YDLv1W3ruwnKmj2kCCtyBlu8QRX2XJbLuC7vx7H0kvwI47M1ncvsujObZT34wyOhE46A4BmOb
 1oZGT7LfJv1zoIcng0C9QYfcEgV8ffTR4P+AaHmd8FQI2WlBccUTGkvIPZQS+8TFgViARe0iM
 bTroliPsyhNladmaZDJbV+j/hNS+8npfNG44TMdXfuXSxdLogwP5csU20aPzdDWiDvNfphVqZ
 xeZ1/Cx5YQ47uGHn59h7EgMsU9ctMdSp8JDFuY5OenmpYFd0kLijZPkO3Y/Sgy4J7j+/EgNLL
 DHJ4NCtpEmMpnfi+lFWgT6bDGRg/Gzo5FKqEIb3tQt4pTXJYyD6kL0OAaoPZY8WiluhqBypCY
 FVccDJMY5HYblfjK+Z6TtWaWxuKFgjcyVgZC2HrqEsOdX9i+pVhXLOYpymd0q/vSQvWAVPjeF
 joj34ikRWT+b+aXdanSDeCE0dkUouHf766odCMXnqQ2kvtF0Ip6orpcrduzwDYBHu9jf4Fg1c
 jxUvc/330Ha8+dx7eFETGLUhyLZ7EtJteDXM/gZysiF4rX7KyHppa95T6qWMwxz1Isxc4YiSH
 yoUmJDJ+CkoGeVIQ3ViTrHd3cu16X6vnmQgqKIZsFfwRMK13vAux0aaQ/LJqtQiLlqYDPLOYp
 8Jg4fcvHMRYR15KMbVBFOYV48pT5vyVJSQ0oM07QTtlGIAYdSMurBiWeyz+w7K4nAqMuf6sqa
 NwyQXbatn1ZZKsep2Q9QFbmx4HY9ma2BcYxpGg==
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_mib_set_request_t' with 'struct
hostif_mib_set_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index cc1e5f441cf0..6295e01d91da 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1258,7 +1258,7 @@ void hostif_mib_set_request(struct ks_wlan_private *priv,
 			    unsigned long mib_attribute, unsigned short size,
 			    unsigned short type, void *vp)
 {
-	struct hostif_mib_set_request_t *pp;
+	struct hostif_mib_set_request *pp;
 
 	if (priv->dev_state < DEVICE_STATE_BOOT)
 		return;
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index de4e0ed6c576..5261810fbc76 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -169,7 +169,7 @@ struct hostif_mib_get_confirm {
 	struct hostif_mib_value mib_value;
 } __packed;
 
-struct hostif_mib_set_request_t {
+struct hostif_mib_set_request {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
 	struct hostif_mib_value mib_value;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
