Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476733-2-2280293936094281011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476732; b=W14/F6pNIH9FYwpIdFSgDXWRxngANMCgfad9HGs4wFKwxaW7KN
    L7TeLn8FdrwtYJsymkF27Gf0EQ+petZgYvXdHzp1jbprRLONS0+UxYKEwjhhYBWX
    Fho7gl1xpgJCHtTZViiR+LykQ0PZmdQmrPpJmu+N1ar/cNOYZP/CUjeEPESKapWp
    UEW1W+xESHgozpG52Z9L9sneL5kLnay22Y7bmo6JhsffeJhySSBg6G2FXwJujpGT
    qsa1/dBA6gdY8Tu3JxNx/gFyHkws+QBrpgaGwPQM78AW9oWPyOK6wt4ILriwR0Oe
    29KZCgvlRYjpl/nBSjcNBPWndIQduR3PriTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476732; bh=5WM+7
    Xxl2bk29GCdIkGAPpGp6RNcjKoFb+1MGEFu2P8=; b=WcgKSsWoqN+hHVhoV5Q/U
    3Z92J0A3/I0zV/BZMVAxaMKHMUNmmQNYlwJ8dqFWuhhGiWmome8JMq0rzZQt3DPY
    vDAnrvCtDaQ+/H0X77YsJ+eF2xRjgviJVrBNP5i+2y9W8wyQKzQvRCEeDhJ2XVC6
    jplCC1eIWoYz9hBukRup2SZ7Y0nn+2N3TEHK16pjY0W49bdCtdmfMIWMu1M/LXXq
    Lp1t/iatgLAei3kp/ELVhmHXP396Q/k19s7KhRn27JwNsyiiniJoTWUOaw5WlaU3
    Lf/k200iiy2E5wJNy3TEoe6lySAllVOLHBmVYN4rwWHUN9+zRsn7nUQKYEQ6Fa1/
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLDZpT5Dp6I7Vw6THyE8R8H/oUFZ+4SGQGfUZN/1PN6ySk2HmaiFB5Sjql3qh9ZPi45QF1smgx5NtDmb+LdYP3JYIvmhZo3BOjbwMsUbLV1+muON6xzw
    lcfrVFsJuL9PnQ67ZC62DArxPrTuZQNGepZbe5NicCtRdneVjuFOaAopwGUHG0oOyTENdMJLNayB4NnPz0RzVstuj/2MnOLhBtFX6M7YLMeRlQ3k5P6cbpo2
    XdQ/XB8A2WIhJPThC/Z0IQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=XFQVhmj8x42Ih_EBxmgA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 62/75] staging: ks7010: Remove trailing _t from 'struct
 mic_failure_t'.
Date: Fri, 30 Mar 2018 23:08:42 -0700
Message-Id: <20180331060855.9452-62-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Nueytt5rVC9Ry4FJQTwv5njUKaAnpNkK1H0JLjtR+86ibWmzltG
 6t5d0Zu2zYhUipRmwUkaCoozh5VKq6tHcQ0x+5loSf29IJLPiBRmgAOlJ+5Oee6BfPpPvd7
 K0fP3Thn6RGeyXpz/KBgE5oZNwlJy7QWtP3wV3dIoBYHxfLJZ3dOB3EX2l5uNq+EBDUaTeT
 roEai4uegKOeG3GJwoxvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8jauT+buURQ=:nTnuACVLH58wmUzSghPgzL
 Flz4ozZkXUF1p/kjwJnN4A4NCtk3+OOP35pwimoYUBIH5gTgacU17lnYQn1k65+24Mnpd4hCd
 nzzSAgP5lfUZI3zqw3J1TBWAmT7Y9wHSM4op6yJvB5OtXY+hh5MLekG8iHxcq3Sr+QKxfhIzd
 np7HlDPC7/+zoWkHzUL8vYwvs+d9zS6q91+yPec0vpF+PSORtouJ/zcuIJyKaciZVBIhJNoYw
 Okv7u4zQ8PC7UbCJwXXhPsc8l0v48i73o9V3ylyJGmUDJoZoQuI+s/eQ7bo2rfFUWrYMRFjKy
 eoBf1xeLE32J5lLrCwFbOFfi9j/Pz+VIys+1ZwAZpIIDjJQndXIjxB952WagXFfUWC3jzv8Wn
 dw6SznrK/1xGOUT8RHGovHV5c0ruh7m8jbiMPjTwPKjFrtjYTEUzMmWE8SWFk2D6BYMmZboDB
 +waR+TSZ5UgaGs3BaTM20D5Bcrbo2Cq1tdayC/h8UtKhxNhiC0YFdvINFMvTtlmmbDrP1jJ4L
 DL0tJdzjw6DUctk0EOT1VHyzSJwrUkWqmNVBnWVOnWTTqbz22OcmUe7JpXwg5qcTEbUw7BbVt
 bBslx9Jri+flrH8wUH0yKWSYPa+YAGfcYHABgUvMh5GI2/CkmmlBaGgk8cPBAislfILJspwcl
 6kndwT6A53cWRO0ocz4ZAEmIHpVge8er/xjoJO2tNP8Ky7ec1Db0G+i5BXpAoy9QnOpYM70Cf
 6I5wKIqh6QNEwRDp+4R2YIVcdUHCcLosYYvPRQ==
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct mic_failure_t' with 'struct mic_failure'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_wlan.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index d8b40fd83b6b..fbe18ddf3ea0 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -314,7 +314,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 	unsigned char recv_mic[8];
 	char buf[128];
 	unsigned long now;
-	struct mic_failure_t *mic_failure;
+	struct mic_failure *mic_failure;
 	struct michael_mic_t michael_mic;
 	union iwreq_data wrqu;
 	unsigned int key_index = auth_type - 1;
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 2458dbba66a0..c3e61021a75a 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -357,7 +357,7 @@ struct wpa_key {
 #define WPA_KEY_INDEX_MAX 4
 #define WPA_RX_SEQ_LEN 6
 
-struct mic_failure_t {
+struct mic_failure {
 	u16 failure;	/* MIC Failure counter 0 or 1 or 2 */
 	u16 counter;	/* 1sec counter 0-60 */
 	u32 last_failure_time;
@@ -375,7 +375,7 @@ struct wpa_status_t {
 	int txkey;
 	struct wpa_key key[WPA_KEY_INDEX_MAX];
 	struct scan_ext scan_ext;
-	struct mic_failure_t mic_failure;
+	struct mic_failure mic_failure;
 };
 
 #include <linux/list.h>
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
