Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49R5b48tzbkXfuh4gNmZaY+WOSTQJvHN01FeHYhd5/NbwHhjLiFo5CfcWVb+Vn2AT5x/8hD
ARC-Seal: i=1; a=rsa-sha256; t=1522393787; cv=none;
        d=google.com; s=arc-20160816;
        b=HG319ByyjpslFUKc5Rq4ULh+AVantkEbg6jRRlwiaCuc5BNa3h1Bm+XpHfdyWEFl1N
         mBumW4xuW2okUFPYThwNeKwkp8OoX3golTnD+Y5hHJmNDd+8GPG2FfzG2oDPymL+uDhG
         YQUJGs/d1dyQ+zvQbDBbK4lcl7cAbnuQF8lPDaof73ZIIEPpRpEAPkOcqgcHphxYphBs
         Fno41AVfpBOai8jBSbD6wmd1Eyp6BEZQncdYLAp8uGWo4DPpRwI3Bfr4c/IL0b0Sw2SC
         +h+Iyh/h6wIBfYud68ygXVBQYe+PhomOKiCBcFLMQiirIdrq8wU9g1Vw4pUaRRyxBsU6
         leTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=c3I/eTN4g5HV4stXGtiMzmP4yCQzvGGuVPzCZrzYVSw=;
        b=PWE5YF7kWu7/K+naaMu8TueKCf74Ir8ykCoYb1cVX3f+A6EtmVvKfNDb07Uo7Fxvdq
         +fk1G0XTc1uCMWHcN1eX2aU1OYIHNJV6YELoxUWSDk/eMIezuCLL3PbPI8z9WmiB/7PP
         1aKQ01bK13o8c4rE9Ow7Shuj1UYyQ1bYPwzxomqpiwzIW6zHrFHoXW7TmB2Lua2UUl5L
         IwKScAc7Me+xGh1oo7FAA1gqiM6PQ9QunpWSvRq4MQHzAF14WqKiPMbDR0eLfYfi/un7
         uR80FtUyn2cjuBrrhGUE7EyHcTJxqHUKLPl5qCSxWps820CmjWcwi7MyYpQWHYAkII2D
         VVYQ==
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
Subject: [PATCH 57/76] staging: ks7010: Remove trailing _t from 'struct local_eeprom_sum_t'.
Date: Fri, 30 Mar 2018 00:08:20 -0700
Message-Id: <20180330070842.25224-57-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:POKLmXzPxtVPlKUAIJHTxZK1z7cglciXke0Ggcvzc7y5eYhoynh
 ckQN4ih6b1slUsQPIqn63aKV3KiSD+8uI4U8YYi+Q7OgHB2w6yXJNxZg3t/nUSMoJIqZA83
 apfrUqUrpOu8dtY0WIf8AmrE2BLPvtBJGEScDZGGwHzwOyDi025ZJnmtlasVaxhvnqhMWTX
 YHkXIaymvhh5ntTZ+M94Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iV+cWUWlwR0=:ltdKF04XpMAXkm9iFvChjY
 6b4sgkLgJPHrU9pG4RHudpEOhkpRa9JJy+EMkqKBrCVdm0CMqS8/fuWQagGb0/vrOxjWta9ST
 BQby/r8GLmo+2tBU4HxqO8lwEgPmY2OH/bW9/Z/a0MNILSS/2fyGuVNFYN7v7tYk4o1X377Ai
 mcE8V8dYZcjmvFHdMF7Jpon+Qi64es/bek6LZtfhrp0LkiB+t6DzUUK6tL0JiUUQvEAQ7DGJS
 c54E2NQyIQjM4l6ercAjQhbaGc9kSq7hRC62yi8CEw2ChsdZigpLFrrdgkayhscA/yzKoIumS
 CFu6sPjk0yKOkTrubQRF6IHhEhgqLGTtHqgF6A6TxU5vm14PqzVNtM38K7Us5m08v02hl63x9
 6NcaohQkdCUdGvqRLPzb4IexviNKzQKcbw+nGeLhpprlDc4OPFgmZNClVP1ipspH4MMP5aA7L
 pACeeepB8B8rBhvYcWf3qcLEQR3miSsyd4f56+aXecXX7CiKS6pj7Ik2nqrOF21chgCPZDgpe
 0cCbMpdGJ3hD3TmqqLgRqZivGI6cBK90Wfq33MPF8+vNcTFr5S1XQx73Nh+whXaF4+cy3FpWc
 ME3m4SGgoB92R4qwnlp9vwZbPP5PQRjNcIat9Es44kIvFX+9SceWYlyBhz211gSdswrV1oAAg
 KWDpxtRRjvuv4T7MdijHXuCsj7dKt0BR9ss8nibKF7RWZmWsIAWe7UtpN3jXuTorZDg5zR4OR
 RRoSkMnnzo6vjvs8JspdKPfioP0X7Bj3InLYMIp/cNx5RripfOTxiK+iBl4mnmUuYwBbIRGHP
 Llpy6c1YTFYD+KBL4743UHCR2DiCfIxKTU9DY8Pl5rhYOMktdvQECYVQ6+WVMb38rWWxrZfAU
 TPPkVylFWV3yRV8m79p5PClsWwvhaHemhwfrPc++4xBLMoRzBpQ0sQHhPEkdOG
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345588498644138?=
X-GMAIL-MSGID: =?utf-8?q?1596345588498644138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct local_eeprom_sum_t' with 'struct
local_eeprom_sum'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index e6c4a0fece54..f99b00344d39 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -256,7 +256,7 @@ struct local_gain {
 	u8 rx_gain;
 };
 
-struct local_eeprom_sum_t {
+struct local_eeprom_sum {
 	u8 type;
 	u8 result;
 };
@@ -480,7 +480,7 @@ struct ks_wlan_private {
 	u8 sleep_mode;
 
 	u8 region;
-	struct local_eeprom_sum_t eeprom_sum;
+	struct local_eeprom_sum eeprom_sum;
 	u8 eeprom_checksum;
 
 	struct hostt hostt;
-- 
2.16.3
