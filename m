Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+sFo7ZtEb1LbCUbU1pMt4VsYWoRw++DCH1oMhUrbY4HfFZOSo+j0OayKP2sA+mOCgm1Vlw
ARC-Seal: i=1; a=rsa-sha256; t=1522393782; cv=none;
        d=google.com; s=arc-20160816;
        b=U5RkpAQeqD0zAraqFu8pvH9IPdQY1PtJ8eBKdJ8C3YB2N7W0qx8BgGSwCkU/BVNKkh
         69mFEYqojV5GnjkqFdMzOAvJ0jyd3lfoT9cIjMq8btkxV0GX7LeroHJChJ7JpEkXbLJU
         IpsYG3y/wOtUIkFNsWadJX+Px78gA/WPipzVx5m5xIWBOXNhqiCv0ZKP6eB2EodWfaKL
         4lHT93JIl4JAf7MQnie2iOp6N/dvobKrjmBpL5ZllA0whu4ia2xymrsmgwMlxtnGLST2
         7Nx4aAkH+oExvpvnAvlQGdL5K+FMdRVLe7PZ+vZYLHaYEVHz1fj0ZVZGXZR/lMSivR/S
         I2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KEhyMQiy+LW6+A6KCxzFeNwYW6060lMdKBMSQC4Z7AM=;
        b=LLVl5a1nfneZm+mWcYapv7JAVgmhshHDNKsQ6uLhXHal5IRluDAH/8vZeynCBP/HTV
         CQ+sj75hfTPbIkmyAweuaCarCZeEqMoIrKrPv35ut9spjviHgVzZ5HyiVrh0P4rHEDKJ
         mTA0v+oL9n32RmzUAy+K+r/Hafmoc3mMh7+xHbN6S2pYVvubvXsEzYgmr3HFBpwqB6l2
         eIPMSBlgJJCTXApAKwwYtnEu2Lu3qta6Te+vgalXHpj9+5nF7oevzDsGlKCA0jOFlX4a
         2aF5QFEMKK7Lb7TU1A6sCCsxq/F+fvzGPuUanLNW0b7X376behfCdNRt+IHYD94eNlKa
         unQA==
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
Subject: [PATCH 51/76] staging: ks7010: Remove trailing _t from 'struct hostt_t'.
Date: Fri, 30 Mar 2018 00:08:14 -0700
Message-Id: <20180330070842.25224-51-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:saFzTum6sH44ZpvZuiVTY9HUT0KWOCpWHZsbVEjJlHE/x/vh9MW
 GsAI07vzQHKDxYvE16tDiGnd6Kn1mjKqxx+7V4IIrO4e2/UvAL1zOSWeiQSiceHzqVMbiqJ
 2UsQ9JRVhu03tabOtDbm30ys5gQBPt4ZABFujiUhGO0YYkrJOsT+ulmii9QKzug1nOypNii
 P+gKZQRFdImrDBAFyqZRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KlVmuxvwc5Y=:y7a2xIzYqvKBy3AmPagomf
 jNMiTmE1H4JFGGzePEG5UNGE2IywauJal6WKX7hlme8lsdvp/7ODQ4/RPunozwMleaO+CXsZd
 xtqifQOPn/hW4Y8TdgIy6bnhGG8F5b41vs6613cB99Fen+DRrsWXJ1M59j3/aS9sEQqbLPoui
 8aiJnxk52mbmwmQi1+RY16JMVUsyOEGY0TZN2ru8RjZ2pt2jTO62AdZl6CsTGwlwjKTHDRkce
 wSkjWn0W8T0OzRc5V7PjGNz627lZ5zAnUHS4EiZF1wI+n1eJuZJOnG4o1PRFEIhBpPS+zoovh
 z/DIakaeeqvwj1WkTX/kJLX1lQM8b1Ktv0F9+7DQSrZWLGOD0driWpwkF21Ob7J5WEra9Fsvz
 RGADcfV3Ia7rn/3VO7EXbudhpTlQkRlDnrauf+dSWZoZTRTPGWV9ItEEy+fJZWd1zv5t3YFLj
 A1QhsbSedGLAn0+TM3oL1IopcDYCSTbDFeCX0A8DxtD3RfBXcZMfBdGeeixBSnseLiY4RlSQK
 /y3zzziFLpMHB2b6e3MUz1SfIagmmjkWQ50VEcGOfFXcD6AFPuAl/X926TVOndbcwUVVR1Xi7
 Q2/6pT3eaYlXgSG7Kbca6kOnYXzXHcrH//XcQE03vQPjqlmuPA4CaBwI9FSFj73FKVWn5xFR6
 nL16ZttMgzofitCdGNwO+05Tne+Ri3QbZLCPHtMZpEanCzsQNmCBCYwLQ1lM2fybrun5jTCKS
 TA3I71wIpDUkNm+ZNISIto0D08vpY7vU1ZdvZbYqj3YYnvzq6xRZaG5HiAuzBcZRHreim+v2t
 T9uw/KkIZgTJUK9a+vxqnDEH8mWU0NCwLnOX4F21GryDqH8j3O+RCZrKdpJDsuWowhdhcnOST
 IaEfGjaawTHbCRbhuuriLDaVSoPah9DHVKBzoz0t7RNX8j2M0fNDv41AxKUi9p
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345582782268025?=
X-GMAIL-MSGID: =?utf-8?q?1596345582782268025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostt_t' with 'struct hostt'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 1b7036c32d1c..3ea62b708b01 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -196,7 +196,7 @@ struct sme_info {
 	unsigned long sme_flag;
 };
 
-struct hostt_t {
+struct hostt {
 	int buff[SME_EVENT_BUFF_SIZE];
 	unsigned int qhead;
 	unsigned int qtail;
@@ -483,7 +483,7 @@ struct ks_wlan_private {
 	struct local_eeprom_sum_t eeprom_sum;
 	u8 eeprom_checksum;
 
-	struct hostt_t hostt;
+	struct hostt hostt;
 
 	unsigned long last_doze;
 	unsigned long last_wakeup;
-- 
2.16.3
