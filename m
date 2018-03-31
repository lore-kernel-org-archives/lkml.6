Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/7PEfjtK9Br7YhbRYH2zVYGcNqwltD3MVoxQ8a0c8sSjGc8OCO/cq57DcnRRY0WOaIs+H+
ARC-Seal: i=1; a=rsa-sha256; t=1522476596; cv=none;
        d=google.com; s=arc-20160816;
        b=YJ+s+JGLr0LByw6e7G9rUIA6sz58TMupQMVHwc/KUDg5RnyIDq08Q02S4T6ZwIs+HF
         qRHV0/cVfTQWoMGxCoosO+3rHmnJ4Jb7HlvjFHhQvlu151C8D/hNklOyUrcGsVn1g5ht
         DG3vkK8EWPOeRDkDrXO2vsTRy3Igdv3jjgLa5/nIxFiqS4zivNMjrTK+dE35caZlSkBo
         iBUtebydRXiQqsDdX0iz47P/0rmauhzD+b068i7Pdox0WA7NerOeCTCg3qj/RKIAo9id
         CvXflXvJyR6htlaN0isVAh2L058q6JD3czqvAVVpsEFp/xO1iW3zuKbzQzPgkINggHcX
         X1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hHU/kpj6lCidO7q147LIEwHNFfiayd8QKhi4RQ9tKJ8=;
        b=ktSJvL1l1USTLapQnOTVH5UTm/JL7e0rLanlEo/Z8kYGP4f7YzkfAQEVC6RwXMwBQ8
         dV0Kuo2fQVzXMJiB1K3Frox5AIwFl7hPber5115FqKBZqR6l06z7TeSm8HrHfa7oZ9Bp
         MUmDvZxOA1Cvhhzy7FUfDF4UXucz5/sbeSEuBmejOMhyHXJnAYc82VPvv7EBcAYIsxQQ
         ILAewNU06ZDOrAMKsmI4mBQokke95IJjo2aWdx7v9MEXWoOc7dsFH69IGFmuOoyZ/X8p
         XP+zDracZylKtZu46Ue7yOkv9xx+Dcqsan6GEGMfa0ym50qhIafxmmjtje9ZMFi42eLv
         3pxg==
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
Subject: [PATCH v2 38/75] staging: ks7010: Remove unused 'struct hostif_adhoc_set_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:18 -0700
Message-Id: <20180331060855.9452-38-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:lhLnWK4OTp8xFhjX9Lq7E8Fss7TFsiG3P+/m6qU7kIkNLPxcmOn
 Kcs9FTlvieXti6ajt7/bkdcjWn9ejoyhFEHKqdhu6SWOxugPhD21tTV2u8DdFqbkmYV0UK6
 m0xj/rRhqhQzuP4YGDrVxJ6VEIi3Wcr2YhPEmLSgIL0w5rhEO4DwbSGWU3m0BgogVG2vceK
 lf0pVVnvuoZSuCcWA/AKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nLIg7LJK7lA=:jWQSH7vMleCI0g0TB4DMxY
 U7DawIy3jBWq+LW+cEHLKPiM21zEY/Mjb8u6a2RlfzAtOlYCBTjwXEsO4puqZNE3QZE83d+JJ
 wr4dldlCbXVdhzC6K0pRqKn3+8C38eKGDdWaw5uxdpaL40xGzoAZ3o9MMIDqIE6vKDDYb2Str
 MZo+xue17GL7bd6VhHnLtHGp3JsRatZFax61/+o9pmKjUH+J+quJpgv6BIzeB+I4ZvG86XN8S
 FLuACXpmf/0xi13rrHF6cpyGJct6CNgUmkjOAubT2rLQuLyJLuOBP6S9nsfvtCqKG3igCGn0t
 rbiUv3ulgYDjbdw4X6+wvb4Gxo7x527AlM7KJipFp0bQWWcw196ZMZ1Q0wCKmbgbT/xKhUUKQ
 HloYQBe8WsmKbN88tjUOiUZbMF5i33nBf9txn371ZFsBtkQhH0vzShgmRYLYaOfbJiC7sci2p
 5w1X3u3q6p80GppTrK5L3f05S/xaZl5OoG8luG1wkNryv6OiB4k+CvqWGfdMJm9lnuBWn58u5
 9+PAR9eLq1jd2DJsEDBTN+uWY1bXx61WNDcyomTrjVMk+7GHYzRa48pxAHNWMXT3NBjYeLyTx
 aXL1tQID4UQA5CDFtPHG/872dpDonig6uAox3m5fl40QxJze12NSTdTn7J2qqSdarFmoX2OOv
 8i4KohQ8hJtWAd4+B3LAV55gAqgP12ChtRcEeD4thDgKlkTeeQR8YCaqXKDa1QWMbbWpP3nFV
 0d6HVtJ6IsH7QrPlzG/reVQDO9vX4frdKRfRkw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432419561580482?=
X-GMAIL-MSGID: =?utf-8?q?1596432419561580482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_adhoc_set_confirm_t' is not used in this driver. Remove
'struct hostif_adhoc_set_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 21b1c5cd9f34..ce9f29699fa1 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -371,11 +371,6 @@ struct hostif_adhoc_set2_request {
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct hostif_adhoc_set_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 struct last_associate_t {
 	u8 type;
 	u8 status;
-- 
2.16.3
