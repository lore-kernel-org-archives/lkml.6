Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-463642-1521525533-2-14900078094333045356
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521525532; b=kudgXLUy7spAso47ggz6cX6kapsMyM4TgjEEI7aO5wSXTCj
    Bplcr/ph1C8JbbNhn9qOlHLRtzo49s3V+T5KXCYNWlZjGLCSju7ucF4313GmnIvV
    TlqcJyau5m2JxjOs3BILZc6wXqr6c14BtIwc3S+WP5W7CPyzWrI3/reUq16GfWJO
    O8FKDSZXQixf3GbbTatneysaGvROB4s7zMTmSWTMADT0QJNAT2LERsfVE5wTpAuQ
    I1KecZC3gyb0Za4t5keBF+IEknKpsil6smHCab1Lq5UNW2j3EPh3Fe060drgUwDw
    TWB1yVZrq0uov5acDzON2h7AXKWdCZNBoqE22PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521525532; bh=p
    6YgRKyuzJ1xt/4cJ7vQzVPDu8sZUfIbyYnicprkuQQ=; b=eltbs0gSpVCZtfWWk
    NuFZ29rhegnvYW6Ci/ztMMgqRcTFaRF0BYzw2mSB/nkLmOaVmioFflLAO9b2RDYT
    w7OCpHIFgv3BqOjBmzDRq+AA+JxytJwV0k/6U2XIxs57JSyKNEjOINKf28yCFPmN
    /cbum8FL0t8CU+ZPhYHnsk017vnSspOeuvPtGg4uvrJD4I7xvSd0RDydcoyuqthN
    zkEA7hV2BKjKXz0d3uJNpngEbFjPa2oGuviymLIoIJnYgGqTgwAHkGYOMMAunn/1
    QUc0EzYsPXmB2zhgaimE8N+6LRuKbN7KdvvwwxiV3G+RSgtKfNeS6UfRP3r6tdqa
    Jiisw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 3/6] staging: ks7010: Remove unnecessary parentheses.
Date: Mon, 19 Mar 2018 22:58:12 -0700
Message-Id: <20180320055815.32651-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320055815.32651-1-quytelda@tamalin.org>
References: <20180319185125.GA13209@kroah.com>
 <20180320055815.32651-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:/qsJ7FEsGll9R4IjpGcKuFtoViKIrfiam0a4kMdqdJ6k9FUAauW
 wd5xAS+07bUt6hmwWWzU3KYp/GmIrYzVC5n9rgqHobwb4w9GBuQky2InFJO/HNNSp+mN+rT
 mptzDtr1pW+m0BeabqGPKzJHsdeI0+CC0woVXjcTkIBhs8Z8b0ESOd6sLoFj4MYDV+e9t7j
 sDUahoXoT6XR1BU36ALww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fKM2fLR44cU=:gB8RQAT5+7MfQfENo6OVIY
 3ENGcy5iCES2UsJ7fzUCn0N65mlozmAoihPHrLKWD1MBRvDfPh+/SzVJQ1LoKKMzaz41bWqJC
 qhgz9ilAJ6gWMB1YaXE1FzX6oG2AZ4lPZ4fPnzl6KAI0W8z6SSc4+KcdpULq6/huJclN9sO/y
 iN9DaClSwergGKwrQXvf/I01XwNUq0I+RJW8IwD5V20tDxIyccsv8SrcLQEgtyzIOtuIOSY9x
 M+fXVgGWFQM8z8YgIku3b3KD6NCKuxdtyctShl83cGgG4j9WAqBposQnyMmW6D3Ib6g7tV+ES
 TT77mFb+yZimM1A4ywVYSVN/bvUaM1gVP+BL5dYngNDoxB1r1/gdF06+uq7y0HCu+MW18Bw32
 4BJ6FQC+eIKiX28qCQTgOYav4EOMgGYnghH+IDrT6PTlMnTRFxfUDvQtLXlz7t2yqMFzi9NAe
 I1kdobFGOw4Husqj17L7JuBORYLt3bHyow8uUJQW0LpDoz6VlZhNrVbfWb/I6Fs5LdZF4wYbo
 LqqBU2xcayBKlDERrAV7r7/BiPVVpYEZeQneDqxiE0G5v/VeecegvWjmawduMKRIM1v6jXcvl
 n7M8l1dxQqx5y7b3nJMpszSCP1qnAp6aNauiM/UYmwxOsWR+Dg20PiyH89cI/8N9ne/onm/R+
 7gAN9C0rE16dPQ2r0sxmIte2fVITpF5aKkEINBL7xDoLqGYXXl0eeBrSMAmmS6DO6tHTaxJdO
 Wc0HSBSpYP7bD8lvlTb/lQqoPMUQHpVWSmHlbw==
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

Remove unnecessary parentheses highlighted by checkpatch.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 948d45280d18..00b97e8e9b4f 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -45,7 +45,7 @@ inline u8 get_BYTE(struct ks_wlan_private *priv)
 {
 	u8 data;
 
-	data = *(priv->rxp)++;
+	data = *priv->rxp++;
 	/* length check in advance ! */
 	--(priv->rx_size);
 	return data;
@@ -860,7 +860,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 		DPRINTK(4, " scan_ind_count=%d :: aplist.size=%d\n",
 			priv->scan_ind_count, priv->aplist.size);
 		get_ap_information(priv, (struct ap_info_t *)(priv->rxp),
-				   &(priv->aplist.ap[priv->scan_ind_count - 1]));
+				   &priv->aplist.ap[priv->scan_ind_count - 1]);
 		priv->aplist.size = priv->scan_ind_count;
 	} else {
 		DPRINTK(4, " count over :: scan_ind_count=%d\n",
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
