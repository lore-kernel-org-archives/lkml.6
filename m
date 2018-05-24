Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159963-2-9884726592469601352
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159963; b=BJ3KTIoGwxoYpIYvmN0qWqzBWgIG16CNrRQOV0QolS4S9aedgD
    5Jyg+hdcgbeqcqyuL7u0QxGyGtUQ1c+v/AJ+eORzkFCb4/qOzdZTqZyuSvtbomJJ
    F/Z07T7A2121PJ7+7wP1HlwUBZn2xZAEAHMriCKf1LaFtbzVmY96QADZ/pdPAQpM
    YdsUAOJ3MrzP8nFAAcdNuoOJfRX1S2hdHamAC5ajxeataDBgP9ye7M2hGVvBiYO2
    kq/45xXtbhYtgiLtDLFWk24swRqwgi0N18RaSv2bXDqEF0f7rSew/MZrUixvOTO4
    C1tC9oX3UfkDfcf8JIB/azonvGQhsTTFeVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159963; bh=ZDAh/D6V/sUBuWjACXJH/J0BvsCs0T
    AJ0r1XHNrE5EQ=; b=IXO80npnFC4i5woUZrewWt4o+0+VuX40FXzw3r+Ay4pZb9
    tR/yVt1/vTelmhSn2uamKQJfr8lMrQCg8rz+CvrLgbXM2BLTyX0TLTC1MBJVqg5q
    m7nY28/Brkg2kKaAVLEVm8Mk/xhBjNaDN1YeAjBUBWJWtnNQs5YDTynFPuYrv3QY
    1byEauWvhLBPpE5upIgXo4dh9xXnjGSmVbnToMg/SIY0L3Eaj+XZ0acPhcrBGZpn
    sznRXJluiHc0y6s3kp5sEkMsXYTsNnmitnmw5dDMgPfZhR6pnYWqxs+1qK85uNAv
    4a1EHge7aVliEDzSz12H8BVT8/kUYFeCYWpjcccA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=XsK/8SMb x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=XsK/8SMb x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNe2G1hvKj0HFKkGNKqRYvH+dQW/ba4TnwPl+bkRocrEznh5uDpjrNgJS+YEU63JqUY+YXf+A3HiMdDm8jmwFUFFAkinxpMmvmDbp8bVNGpEWTkcK0Z/
    +sx8atpEFNWKbK3zjUE8hdqmAVeNN22+yQPGHdG9XZPka2fGc0QD3eHBWo3fQAAzrIVFsyDyNxSTLGSIbmCUA0kX7UOmFn8W1ysxNZKp8vkteT4VIbKIWbe2
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Feg6x53VAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ZLJLGyPowvUEx_4YTKoA:9
    a=QEXdDO2ut3YA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968302AbeEXJzP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968296AbeEXJzL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 089/165] staging: ks7010: Use constants from ieee80211_eid instead of literal ints.
Date: Thu, 24 May 2018 11:38:15 +0200
Message-Id: <20180524093625.629864043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quytelda Kahja <quytelda@tamalin.org>

[ Upstream commit dc13498ab47fdfae3cda4df712beb2e4244b3fe0 ]

The case statement in get_ap_information() should not use literal integers
to parse information element IDs when these values are provided by name
in 'enum ieee80211_eid' in the header 'linux/ieee80211.h'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Reviewed-by: Tobin C. Harding <me@tobin.cc>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/ks7010/ks_hostif.c |   31 +++++++++++++++----------------
 drivers/staging/ks7010/ks_hostif.h |    1 +
 2 files changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -242,9 +242,8 @@ int get_ap_information(struct ks_wlan_pr
 	offset = 0;
 
 	while (bsize > offset) {
-		/* DPRINTK(4, "Element ID=%d\n",*bp); */
-		switch (*bp) {
-		case 0:	/* ssid */
+		switch (*bp) { /* Information Element ID */
+		case WLAN_EID_SSID:
 			if (*(bp + 1) <= SSID_MAX_SIZE) {
 				ap->ssid.size = *(bp + 1);
 			} else {
@@ -254,8 +253,8 @@ int get_ap_information(struct ks_wlan_pr
 			}
 			memcpy(ap->ssid.body, bp + 2, ap->ssid.size);
 			break;
-		case 1:	/* rate */
-		case 50:	/* ext rate */
+		case WLAN_EID_SUPP_RATES:
+		case WLAN_EID_EXT_SUPP_RATES:
 			if ((*(bp + 1) + ap->rate_set.size) <=
 			    RATE_SET_MAX_SIZE) {
 				memcpy(&ap->rate_set.body[ap->rate_set.size],
@@ -271,9 +270,9 @@ int get_ap_information(struct ks_wlan_pr
 				    (RATE_SET_MAX_SIZE - ap->rate_set.size);
 			}
 			break;
-		case 3:	/* DS parameter */
+		case WLAN_EID_DS_PARAMS:
 			break;
-		case 48:	/* RSN(WPA2) */
+		case WLAN_EID_RSN:
 			ap->rsn_ie.id = *bp;
 			if (*(bp + 1) <= RSN_IE_BODY_MAX) {
 				ap->rsn_ie.size = *(bp + 1);
@@ -284,8 +283,8 @@ int get_ap_information(struct ks_wlan_pr
 			}
 			memcpy(ap->rsn_ie.body, bp + 2, ap->rsn_ie.size);
 			break;
-		case 221:	/* WPA */
-			if (memcmp(bp + 2, "\x00\x50\xf2\x01", 4) == 0) {	/* WPA OUI check */
+		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
+			if (memcmp(bp + 2, "\x00\x50\xf2\x01", 4) == 0) { /* WPA OUI check */
 				ap->wpa_ie.id = *bp;
 				if (*(bp + 1) <= RSN_IE_BODY_MAX) {
 					ap->wpa_ie.size = *(bp + 1);
@@ -300,18 +299,18 @@ int get_ap_information(struct ks_wlan_pr
 			}
 			break;
 
-		case 2:	/* FH parameter */
-		case 4:	/* CF parameter */
-		case 5:	/* TIM */
-		case 6:	/* IBSS parameter */
-		case 7:	/* Country */
-		case 42:	/* ERP information */
-		case 47:	/* Reserve ID 47 Broadcom AP */
+		case WLAN_EID_FH_PARAMS:
+		case WLAN_EID_CF_PARAMS:
+		case WLAN_EID_TIM:
+		case WLAN_EID_IBSS_PARAMS:
+		case WLAN_EID_COUNTRY:
+		case WLAN_EID_ERP_INFO:
 			break;
 		default:
 			DPRINTK(4, "unknown Element ID=%d\n", *bp);
 			break;
 		}
+
 		offset += 2;	/* id & size field */
 		offset += *(bp + 1);	/* +size offset */
 		bp += (*(bp + 1) + 2);	/* pointer update */
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -13,6 +13,7 @@
 #define _KS_HOSTIF_H_
 
 #include <linux/compiler.h>
+#include <linux/ieee80211.h>
 
 /*
  * HOST-MAC I/F events
