Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/3astjXNhBwcntQhKIPYRmGD2kRW0/Ms/5gRhlf0zCPOzp5oBfBQZV5Tio4/CBBruAbdg9
ARC-Seal: i=1; a=rsa-sha256; t=1522476574; cv=none;
        d=google.com; s=arc-20160816;
        b=W8J3fSSzc8irurMivmeq4mK2+iQKoCl5M+CR+LTOT8Le/gYHxZNrkFd8+xEtUFbzQ9
         DxJr62l4Yaxbpoyxo598F2Dbk0Pcxn0Kb+QVY6EuV55UOjGAD5e78+JeH+FsH8VWsY6q
         NTALVtJUqsTzCVfLWOYN0wzJk3ldW7FBC0+OiPzYvwjspVoNbC53MbUtiEd9CjFsTW6X
         W30je65x5ME3yLPJpKQhjb8nqyqNMJxiLheBMkggBti/ikjB3Pli9zJwFf2n/dVa70U4
         qbFatYOo2WyYxZDZvkxTDjE+Q92KcoHN3sKFQm1VDI2EmWWxulxLQbYIe9W3ef6Pr7G/
         2OYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Sa6JJOf4C9sdgZlHLdwFGW8YBhs1ZZGkFXRCv5NcyhE=;
        b=mx2vqUmljgEX8Q+Y6EDxpmFX0F4OVdQgV5QGss0zNBfmE37ztyzvW/J07GgZGIGnAb
         Lk7aIwPyvb0l0Hruk/ChvWoH29+B0Nz43T2L6HkczaNgPrqcdUIn/Eyjp6BbqtvjBRoG
         hJGmWCJbThMtN45F4/iwFmpvVYs/XKMxhlQQdRP7hpX51RwImHrrYWkOxFihIqriRk9C
         N5zIQvWGitn8Pha5XscMFvXxOgkXEd0cucV0dVZTQWM9bvMLg+4VH0yQrWKbwkHR1pc7
         bqFFtu51AgOIRay2XDaULEzk073m92e3NiSq/H0X+zRjeKOmnWmEmC40aX1w0w9eQzla
         lKag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 13/75] staging: ks7010: Remove trailing _t from 'struct hostif_power_mgmt_request_t'.
Date: Fri, 30 Mar 2018 23:07:53 -0700
Message-Id: <20180331060855.9452-13-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:VgFgkV77bGflxw5eHYlY0Ofu2zhlci8eH5ATYfSdStWnnoXSVCR
 CBGMncHm4bYRNzIOSm4k9g/nwe/UuiS/XRkP55+ispkeZM/bLk5nEmXunKh1A0BjFaveoaE
 UKtIhgFFNujWfWWJW5Gz3yL4758WRl5IUEYl1y/WWGI/Zbiuz8HNbdf/KUQcppRWpnTCcnP
 k0U421/pEABbircIs4bmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ijb0YOlMkL0=:JNmxpBTbf1yDtIRa0CC3tj
 43h6eR+2GiUFrtKL5snw6gEJ2ulS/ZIJBL1bvmFVs+UkxIW1JoyvJJeA8/NKtq2AVjmmh1eYE
 NaacgX9zCdKyrvNTRSsGTkWZb1cg6XVzMQ3Kx0lU9I+NM5zo0r9ceeOleTENj1wr/vFUJac4q
 58ExWwijUM70W/IU3pMcFjh2O/Ch36agm3Eh9DIorB7pjDsze8E75HhYvB+edWnDTmR/Np5RY
 SwzLThpTWxCSGXrb4/6UXXHg6UgppMQ9YMwLpsxCKqtwUz+QQUFT/T7J6yBVlh9PjTvBse0/l
 69OX7r+YQWRibUHvg3fux/MM1cXTGEyl5UZCrh6z9CvZmsWpzPzKxHdBHF3OzqT8B1UzV3txI
 XMwdnQJyuEmkl/bSHyoEuu3jxv7TFhou9YJzWptkIGsbeG9Wb+4/hf1sh3DekceeFkflV484g
 nUi0HLxkSrHs4ATvRvkN3llocC1P7bSiHR8t+PGfuFKjpRuTpXccRZrIVFIn6r9Oiq6GfGjnq
 jZuFV/XF+6XRoFmaTWRxBKgdjYMflBkQRk0BgKpJXYgBj3QZnTpFfzuT6PPxcvS2VzpPFcZCS
 P56XYXWEugMPzdEhMjp3/oxnQXZXvWERv6V02kysz0H6ibk+8RZw/nd5KNHxi2My3YEDJpjFb
 5rLwvMCooPRyV8t13J0E3pv9FC03xD6BESieOoVk9/WYyi51rCarrj2O9GWcO04usasRExL+6
 0ThvNpdLS31kjYpyJ1zSf7G+AI9Zrbysfz/ZVw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432395969616753?=
X-GMAIL-MSGID: =?utf-8?q?1596432395969616753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_power_mgmt_request_t' with 'struct
hostif_power_mgmt_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 6295e01d91da..848307241195 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1464,7 +1464,7 @@ void hostif_power_mgmt_request(struct ks_wlan_private *priv,
 			       unsigned long mode, unsigned long wake_up,
 			       unsigned long receive_dtims)
 {
-	struct hostif_power_mgmt_request_t *pp;
+	struct hostif_power_mgmt_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_POWER_MGMT_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 5ae6f78eebd6..10842d668afa 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -162,7 +162,7 @@ struct hostif_mib_set_request {
 	struct hostif_mib_value mib_value;
 } __packed;
 
-struct hostif_power_mgmt_request_t {
+struct hostif_power_mgmt_request {
 	struct hostif_hdr header;
 	__le32 mode;
 #define POWER_ACTIVE  1
-- 
2.16.3
