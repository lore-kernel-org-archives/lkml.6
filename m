Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-463642-1521525536-2-1676286900757155741
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endahr.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521525535; b=ek9mky+uIiTvsncnYl44PiE6reXwj0/9Kh7ga7il7Z6lnLX
    A7QKBhxQjTed8RjmQCFe1j7hPOTnWHglGXuHN0yPkC009QVWG2UCNacYZEdHUNbj
    uDgGpvCs0kbC5qPydW4EDlQsb40NV01Rhmie+e6E1MwJHgm0lJEO77Npx9jsBvRZ
    lLoeAuQhJLH8umcivq4uHJYvTCaVcCYNUnuKWGOUxqxV/vuujC/KoYcDVp9h9eUX
    zChQTk1hgZO6acYuR+CmUsH4qmuzhFSoEsNM7KaKJvLXFIBe4ZxzCxmgnrKtcLQg
    hfdAofp7c0/d08RTm+pi6Qh9SAER1iC6PKNyMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521525535; bh=T
    dF306mnMStNp3BtK9Bt6dVnVG1/q07tT2syBDlr7SE=; b=KHk1mOoJzbgM7756G
    4b+OpSYaytNCw13YW5EQEM28ybfm+5aH3PAmje27qBSBjXuE0xwjU9Y5x8s+FRxb
    kYpcUwEXJG8p/kc785DZV9vYRpIjECjVkTpXYqXYF0Nt+DYYyQplGcAzUb3JAQos
    oO4Qw+sOLK52pbYqB9lGShi14uu5DAOwyzFcGd9xgpSyNlpyOmooN45SXvj2EN0h
    j8Lt2RHuUCy94kvvGXS3Erl1GoCjJ3/c7jMX1L/9CmnWMsdCawZ8NYa7bG0tjR1k
    1OBahZfarbXH2mbGrFH+OLrkDRkQnzLx08JcMTvGSzzVt5j/wr9TCR0/yAEbAhNe
    6ORcA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 4/6] staging: ks7010: Remove unnecessary braces.
Date: Mon, 19 Mar 2018 22:58:13 -0700
Message-Id: <20180320055815.32651-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320055815.32651-1-quytelda@tamalin.org>
References: <20180319185125.GA13209@kroah.com>
 <20180320055815.32651-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:yLdyUH6/CA2n1Hs8q388wVTuhg3w2dOA2nOV5aDuyiXyf9+/7/V
 uJDs0DS3O2xCexFX7z5BDWE6XOCBIZSfbgRjZAT9ipiAudk38td3Hb+VND38L/chM2yqnLR
 HwHDT56KZjMLIlndqMm4qNNiPQwwXcnEb6Bpq9fy1ArsvsTK6/AYPgVZm1c30w7cKJrB93V
 1R71NJYwlRASXuPo27S+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kyfzv3ovPDg=:LS3tyc8+x1Nc9DyrrlQ8+b
 VbqMqMM6LyF5qDYfnP2Lb316A6h97MJe5nhjWh2Xy8A6qlJ6fK2ga1Xow9j4j3y1nyHyMk7JJ
 wEfttXMDTYAiMlazPepsVeDy3TQHoG9CJg8PtmWmrtjKxaUxqYzUH+S/Y3l3V2spVqjkLVnUV
 4wfkp3yaBe3CdvzO2Pvzz/BAPxI6vfM8Z3NFxfgEVg048+pQKnDcSDs+Nm9tieORn6FTvnCGS
 1owhsTbqAqlkBA0otgQYJMkIYWC80oSE8QPcRkzF1AYK/V3FD3mSOaDULKLsnZGQTscB0Jjnf
 GxaPb+0L5duxmWRdfCZIF7RcoAqh+88N6EckWTZokCvEHFcTLIzZCy827aL7O9kvRb3i0Z749
 HHPcTMCbAFKv2q3tbLs1pyUTqpLwTK6ieTy+NM/2yfwTH8SvA0RNAVt95PNG4ZUd0FDD0ZmmF
 e2iWyBya0/dmB4S+6a0u+3mfPeytidZ+HGAVpeMbRqzr55K1A3yrALnqQBmt++mZtZQBcxDUv
 TxNlp3XZcxLWpN2NoyUHnJa5eQJqftAHEEe5enREBDld4VCux/VZRNq4Lduh029gh6QIiwg3D
 /ebbSXJVrt94onPeP7PXkNrSc8fI4fP1GudXt/nN8AGDRDj+i4OOKUvLSZ8UtaoxyCZSze90F
 dPPUS+kOcTE+DrAejU6LYhSkfv5llCv/mmtPBu5OozzbQGj3t6Jo1TIYiYPPtwXy5anNOWkUf
 6o7rPnnqIQoa7yNs1x+lB/RMf49X1Q8NrCq+Rg==
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

Braces aren't required for a single line if statement.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 00b97e8e9b4f..2de4dbbcd9de 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1387,9 +1387,8 @@ static __le16 ks_wlan_cap(struct ks_wlan_private *priv)
 {
 	u16 capability = 0x0000;
 
-	if (priv->reg.preamble == SHORT_PREAMBLE) {
+	if (priv->reg.preamble == SHORT_PREAMBLE)
 		capability |= WLAN_CAPABILITY_SHORT_PREAMBLE;
-	}
 
 	capability &= ~(WLAN_CAPABILITY_PBCC);	/* pbcc not support */
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
