Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48P7PttPu0Bgk+xYteYriITUCJLgRdedKje07h6Vk6mRiYCuxvFgzGiwp0y5wCLibEJcEoI
ARC-Seal: i=1; a=rsa-sha256; t=1522393788; cv=none;
        d=google.com; s=arc-20160816;
        b=KQ067aXaoJamaWMIktOPC41riVdXzvFZB8lN5OxImgmT2KoZ/DOYFX4APRHXJNIo54
         9KiAVIgAS1qsuK+bnDsQwnOKIcco+U67VGnk8VHCNP7LnNwzlBEeaUoe7ZtdVp88ZfcU
         1n3UuazIgf2oy/FR8Dul7+Dv/L7mFO4TrfSp5iYRkHZGHY1OlM3ygtPj/y52F+P/bYdb
         iOgBocqHHmfGmvlZW9IadBqkmeY12SO2WDv2XyDNhysQdUu/SM8hHDo839OBnkcBwIAO
         cH500JmfxJMdjN8oZLNFivy53USKolK1vTsAkdNwikON1YWeZzKV6YIKEOW/VwW7iYAy
         jBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QZ7XwPZEOVOrul14J6wRLIdqMVG4JRDOwR5HVP6/MW8=;
        b=kq8/cDhYRSoANd2/PqQw+S7A+5Jh9nmIPRc29r/3EsO3fLenSeIshh+z6yBd6RZSz/
         U6CdNmUfPgplp/y8m1sjRBZKbmgsvGUuUqN25lrOK5n0ZbqH/OWTLsuJwvD+/HBcRM9U
         rocPnJIlwKP50gRdEsO82uCUZ63/SUwqaehpvNm1NdEs6QifmpwMWeINHJI+qaJmlltj
         7h2V3sfEu2w7fKcqO3HmCAKJ3qMHL2sUV3DuAH6bzpC8cYbsjXRd3QqgVCo03xqiznD6
         PLeC0E0Uhq0gOneZ2G7+U5WYe7RfjBTMF13rYoJ8SZ78qbTzxoWAmt2Aj30ZzoXUw7mW
         LH8Q==
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
Subject: [PATCH 58/76] staging: ks7010: Remove trailing _t from 'struct power_save_status_t'.
Date: Fri, 30 Mar 2018 00:08:21 -0700
Message-Id: <20180330070842.25224-58-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:GP0OdQb1mNQS0EhKIh3LobuQuvhbjtDJmfxFgN5nGhpVbt7XlWA
 1CXEIznwihmPn1BjoE50fpdA9hcWk/hVwtkLRKmi3MelBOqZ6wrsgpCidFr362gi6hVhQbu
 0U3drjI221HKjBdsJ6UQBG31ap86KBgLdKFVxWJj6Ep+KJwrCDX0S/NegmNpRlg4J4O8Rc+
 ABFsDQTPMxDisgNX7VY/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vCP3RNlNee4=:HCBK/Bk14qIN5EMsQcssJF
 Yjcb1MeeUK3AcjWJWtXtVHeXUlpSqoyBePXJUyZjnWZb2kD9zHQdni468u7Mi24jQPTTRJUMW
 X/nBbjCiQNPPlyLeSNyZzCQol12QTM62J7d6uKIEgWupO8o7hBRIzfR6mTzV3xGdCGWjgh7gV
 BJ1XkVUHczltADGiKymMG8SZ6Fo9w9htMDNDO0ERwdI5HL2KchcR4PKqOmD8iCuTYQ442tu1V
 EWPYvxRRTMCr06rHk9u1tLD57b7D2t+MKw5Wbn+KyyNYMqhnFFxPp8RlV/zevQOkVNYMH6no9
 27SKzyBxhKlrJrpEtt4TkBYzbrvgiiURst9Seww1bhcKfw2gki//CWhDJ29SK6rOHDZrue1ON
 F4V7bHAPQCDo/I79kiB2GtcZnBt+DZSbkMRfGmREyX9Q37ao+8zk81rfrvcRhidNGIpkH6Fug
 Q4sieVoi1eUE80XJm/8hG0bzQ43zdCCK+Y5kCPdIVxmqBOkT6Q7QH9+XsXAPNlSKQxrnVSj5w
 gxcN31ULXXqXMBD4gJ/BtWnJHZagHeLed9Y0RzUac2SxUUudcA9wFy8lgbPj7aZVEZeilUNdu
 y53F1+wF4k9VhEpFsBhIuXwb0+bh4F8S2a1RWNUyOor+mSXTstodbd0UFBw9Ssl3K6Pbc41nd
 ctsdwYiW45PLJIDdavwjFG/pj+2HGvKcWIaaGkWq5mL1dmFhyLVgVC375zbF9frSHcs/T+Bb1
 MGEMv3TLfVNRWVZ/zp9bDdYbS9B2djc0fBx2tlacA6KzMjOxHl58g4sK1kJ/motWUddke0pX3
 eRm8qDIrvk1pcCSYr23TtT/K5OvODpUQsrc7gO99toXbRFSo9+cU9/hzWPJkIGa8PcCtdXWat
 KgGA4su3ae/OR4fWL5Zt5Q+iRkDBF8rO1hgTHswhbFzya0FqcW2dv4Zmk6iJKC
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345588661827429?=
X-GMAIL-MSGID: =?utf-8?q?1596345588661827429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct power_save_status_t' with 'struct
power_save_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index f99b00344d39..edd13060c24c 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -278,7 +278,7 @@ enum {
 	PS_WAKEUP
 };
 
-struct power_save_status_t {
+struct power_save_status {
 	atomic_t status;	/* initialvalue 0 */
 	struct completion wakeup_wait;
 	atomic_t confirm_wait;
@@ -425,7 +425,7 @@ struct ks_wlan_private {
 
 	struct local_aplist aplist;
 	struct local_ap current_ap;
-	struct power_save_status_t psstatus;
+	struct power_save_status psstatus;
 	struct sleep_status_t sleepstatus;
 	struct wpa_status_t wpa;
 	struct pmk_list_t pmklist;
-- 
2.16.3
