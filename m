Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+farQExwX4TiPzvGk0oUBQ+QUdh7QBUVHjLklX7T3hnrSc2KANlqmv2gwe+QYIrgMkPX9U
ARC-Seal: i=1; a=rsa-sha256; t=1522393772; cv=none;
        d=google.com; s=arc-20160816;
        b=Qu/c792cekll/USDZ8MUZUfaK9hdcXL9Z9pKxL8iXNwJm9AkkZ796V1GBfqe4Shw8U
         aWXOQrw0EHrQABkQ2ANFCZojaqMnNN93YRQ4KA/NeYdU1Fn/fFppCnQSLJ+E0EtnAHV0
         83XPJjOhexi5cmsa8k7UOEtdBP8JEDPgUiAIFS5cIXq9DKKmq8+wtZ7Y4DpLrJgY++7M
         Oz7NGbZ2UBlFhnu/+NEsz+D42GUdITgcU4MNdxD4o4c9x4ffRbcuOK9EscXGuC3NOD7k
         hhD0GVPNDrODy0h0oywilOzPMPwW5LdjfQx2N2E8mw4Vt8rc5aaFObcEAbUYc/yGT/Ni
         Rz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=beOM0mVTTi5RMcyZb5yc6tpNG54BUlxrpE8xEKVd/KU=;
        b=kxWovh/1uFnkLCeES2lq8Isd0MSVVFNzCZnJRJdSqxMOMRsqD9EidvZ0oWVTWCkDa/
         kKA9M+Kzx4ov89HpDzec4etzu2kjNDvtOURbcyc4Z32p56Ia1NlIAstsKEgvMPl56GAj
         IchGyKyZshO60ODVuZIXaotEkjq7YvyRERIOKb7H78Su2Bw7OiygbvPPv4l7X1OD/4hM
         oBxZL8opQJUpJPqsXHOW+rxWRa+sA1MHAeqnw9oYIy5WAm0X3aq3mIbOMRj2wQNDjb21
         ChDYMyNrjgMCl7IHVtBvrUHlQ/EB9QT89izYDzE4JTSivg4hCF7BEB6fRylqMaRW+D9y
         WkfQ==
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
Subject: [PATCH 39/76] staging: ks7010: Remove trailing _t from 'struct last_associate_t'.
Date: Fri, 30 Mar 2018 00:08:02 -0700
Message-Id: <20180330070842.25224-39-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:K88ipsy4hX+S7KOM7S8XASbhUfmIIcJETibKyv9mA/UwrKxTygy
 34HM7N3UDVAVefCOwleD+lQe2Szqq0p4qcsGnaSGPifCzZenXM0uX0xXK1fvGsxH3Rw0Qha
 R/cvuHggqjqHV79cITaCjmWalg1uagWDHDcrxcyiJKg3sfsezEiSwmgpU07bEi46NQPexto
 Mr/2DORawDzlMJ3BB5Ntg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMdDPOi8AS8=:Qa3So3bW8D0o2Qf1oEfSUC
 UzdRk9oWqAVg5KJEgqAeiNC0Bz2Cd6EmBj1oMGeI3sg45Idtc/9hihETuaKToVyd3NHG+UFCA
 kyc6gqSY1DjBlyomKLeXnAK2rlWniN5BEpIYD2WQL0B886PvrDT/wd3dmUFiY+0bB3Ozn39GH
 /7cwlxrMuHpCrHCz6yWwr/ip+J1j0qvYVQi0qSBY5t5ToAyDr71kKmn/ByeP1rdYnR6+n3NwI
 cvcqhJS38ySLoYApDUrFJcb5LjWsZMUOrhoBLsahgjdGGOBBJf0Nel3WkndrqSsOCSLReHmrA
 JE27ZyHsLdh86WJRzZI1Y3pZEhO2cGr4lPBUH0UujDF44bZvq6pTrpW9znMXC2cqpqGAPsLWi
 9AsvGgMeFJv/LAIq0oY6QnzSJz96F0lU/gEUOHUYcj2V6EJER8FQjfS13J0S0c9C3EZjWD5Oe
 oTJqON7tvLYr0g64F0o/I7+U29MrW05ojdfw8RLcGEsNGp3HPlEUeJMOw63uGUTlf50hpNu0N
 P7Je+U+rduJ8QX1KALH2So8HVUH7yvrVy9j6LrmLgFfp/nPqAsw5M/Rzf2NKSUlR2V4ot74N5
 Tof3Cai1pZutVmyW0p6bMPi2+LB2dnJxcYmNW+pK0JP3BOPme/rLjIWXHXk4aYl6imF2eg2eu
 wHNCecm90Wo1tqTJwHMuy1I20veIDxwjAHcwmi7W3l9XYCUPar/V9DKeSbFt4QpMeUjZP7POD
 SRRsX2Jj61MHIgSv0zZqhC5iLtswy0A6zwAbvw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345572365607613?=
X-GMAIL-MSGID: =?utf-8?q?1596345572365607613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct last_associate_t' with 'struct last_associate'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index e599ab1d9f15..02046ab78a36 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -429,7 +429,7 @@ struct hostif_adhoc_set_confirm {
 	__le16 result_code;
 } __packed;
 
-struct last_associate_t {
+struct last_associate {
 	u8 type;
 	u8 status;
 } __packed;
-- 
2.16.3
