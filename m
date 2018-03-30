Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49AqUPLaFPJi0etlbp6jRh2+TGa0qD1z01fUEhRAR3QVv4jfqRjOT1MJhrmPUjk7mAOwLXy
ARC-Seal: i=1; a=rsa-sha256; t=1522393785; cv=none;
        d=google.com; s=arc-20160816;
        b=09sIfPA0ZbLrgwxht05JhshSkON8HF+k1g9aCusQDoW8ZGzSjRcW1/xtfwU1nJDJlA
         8RkPCYSY97/VrJL1U9qjRMmelCuzL57mTd5dHjGBPCyH1mSGf1hGGIEv3N0N+x78nfLz
         lRp1brBN3p9mo8XBS6Tjopclq/DExdyDwHByrbtcJgjnid/ItxeuyQ5Fe95py8wgcXiU
         x37+hAO2KlsJ9ZFGDYs5iuVh5+l3rckaOeRScx8bYB/Oh0yDbZjFpolTewRqVksFMhAB
         5EZH/dq62Bc54gyo9tiVVe6fR5hDn/ZaASPNONGC5de09dmaW1FP6N3HAjlboMbeSeTD
         iajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/ztz8zDrE6AdlcwwEhD6IyNBiRNeImwJsvFSpG2Bhmo=;
        b=y2Y2MRGF/H7HvkeRzi12WZfvmGhhMabPZ9V66/uR3sqsYrZ/3oop/HuUESd4YaI3ka
         oFaiKysCmJmej1f4XuyTlAJvcnb4zN8UEt97OYKsBpTLmr5bauscjT/vbx3yw/hZ7ldI
         f7YlKZrnC5UwpYW/TcLOjjYTZAOfx1PN9knyFlX/7Z12dKfVcAFV6bDs+d2Y7VSaBtkn
         8U5wWaslZa8NqOLCh6oHiWrTKOwkDwZCx8/vyx6bFj0prl4FbZvwV8EpWmqPgTR59iMu
         oHiDTA9OawvmpBJV0fE/EoMCMKJcjnyUav2VromJrrNcHFJS83uDm8T2Ejb9Raz2jKBo
         znnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 55/76] staging: ks7010: Remove trailing _t from 'struct local_aplist_t'.
Date: Fri, 30 Mar 2018 00:08:18 -0700
Message-Id: <20180330070842.25224-55-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:PyntzNj7BEoKCDL2sme1XtAUKb6i9XqQmVnm4xHJ4nQ2q8/+NnD
 vWKvYvQBWB6jGVsWXLrG+p/pUO56wlIPVRUCF+VBpGFs6IfM68QYdIc6fS1jIbBa9LLUvQw
 Xh1RaOfF4SHP0oX3NTeGDDyqcgiEDh+Gy2EWqk6phUDNKWCJml/URGQCafzttGes2RBv15L
 wK645t4GqmY2kSzTFSwNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2L0eaJjk0b8=:evIvmtRHu2OUhz61EpGM08
 HdvUgPH+hyGoj/hpVrQedraUR69brcFoUdSCRFh9VqZWav+OJ2TJnPZlZydpDqTFqAmpMtt2g
 3APkMneU5HHZsOdUhW5NMJsLdnHeKIhQsoaLpxMEUSfEffWqnCJooXY93fZ+pNRVGCxjGzfdq
 /mI/8ghxD37Gjbo6Y+ftbm0VMXwJugmitbqa5vcC58GdAI7Lv9aMo8HJ8lubqy+64NT7lJdyr
 GhyUnzK9Xv8zfhk8yAAaWQIobLWABmslhpvNpnth+X/11LYHDyUZNqaMceCZdHV7AGQS/lc7D
 EDAym8PXLFhbyha/I2f5wPLe88aBymEAA7j1vmJ3cOB2Jvg0XHqOQcfluIEbNEzQH2+A73gYh
 9K/eK9aIjF7ExSy5nU1yWxbOOp4u3ixVp3EbXTbsFrbft9nVYlH0YwL7EFLCSAZr3BsxU7W53
 i8pXEyoNrCy763ekq+zEScDx5CX2RnIr8XSQy1mrcGeWSQnOy5h4DD51ZcvFIyTkotDNec/Q8
 kCB/qZwpV6En+6HHbEap3gF66/JnBDo7Krp01UMTLkHlvexcrxDWRxmdzwx2BLIM90P76letf
 PUx8LWP4PIl4UDQGmx5RXk56MKmjcz/xmqB3FU2iCLAPn+nxFsrurHF5ztbVjdj0xDqQX761S
 cUEkYPZmwcT8snHeqvKK+K+PgP8utrrYMh1/baU1T2vxu3V4haPkhuFhscBVWm2z4U7rjuyJ7
 0yiOjbo87ZCKkBqq84Kl4QGITiZqu82uflsLP7BGGelgVw2AE6h6yiJZ3B2FKHAvsOr6mJclt
 RbItZin7f8DFBHTavLDsQo3jyK8OyURj1avNij0cLE5JD90uYjP+D9W7+5oVG34e+j/6cDBE5
 RWFSjUrJUl6WF36k9zXxHzM4O7ZzzXIVlCOA3HCGBEcjGViLUpD6evRrrmuY3X
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345585971103798?=
X-GMAIL-MSGID: =?utf-8?q?1596345585971103798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct local_aplist_t' with 'struct local_aplist'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 3104ff92c453..57b21d3a2435 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -244,7 +244,7 @@ struct local_ap {
 
 #define LOCAL_APLIST_MAX 31
 #define LOCAL_CURRENT_AP LOCAL_APLIST_MAX
-struct local_aplist_t {
+struct local_aplist {
 	int size;
 	struct local_ap ap[LOCAL_APLIST_MAX + 1];
 };
@@ -423,7 +423,7 @@ struct ks_wlan_private {
 
 	unsigned char eth_addr[ETH_ALEN];
 
-	struct local_aplist_t aplist;
+	struct local_aplist aplist;
 	struct local_ap current_ap;
 	struct power_save_status_t psstatus;
 	struct sleep_status_t sleepstatus;
-- 
2.16.3
