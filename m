Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELvubbl1wmhxCcxOTRYnQmXUIynD5HKhTbatw64VqNQqvQQ20ACmkH9oARqkHVe//V6GFCLv
ARC-Seal: i=1; a=rsa-sha256; t=1522140088; cv=none;
        d=google.com; s=arc-20160816;
        b=pdNgxk8WvvAkTsFZFNHqVv3jjB+0jiAf9p31xybWazHRP6u2je6CYXeOkYLVx+Y8ID
         H/CxVXpwzCpusUZKvTfMaYmpTsoZYcwKLhOKHoNAxnFogT+GoT/Hrrz/yis5j6ZxCG0D
         LDiNqkofz1TUOH5bF9CLsYNwAKnaxZPTc8zptwVTNFKJW56YGT8Rny3zafki6WniPJfS
         32MnnLzLKzQfXHk7jfI2EPrrQ5e25W8ynYQYMjChjWZwwfc9ZQtJBxdQqWYYi3EfVSTf
         YrantdCCxXErlx9T0ohuUtwfihmIqSRXpCuoJR1XIPAf+Ut4soWGJY7nLHFHlQumKhva
         NAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DXjzTFfvIx/MBiMEFq36RB0m8pZEjcrRCeJr7lRbNsQ=;
        b=p+6srDk1rs6bLiW2RYr4wy6qyIy+Kl3IkntYt30BQQGinEgUgGkzJi0zKwdSIr0RB+
         YovGJ3TgWkxZ3ShXpFjR5GvZGzD+bWlgHQkL3bw5UDodAALiDNh4Fk9kXj/ralU3xXw9
         Hna/2GA15ENITDOkSWCl0NBgaW5Tut41HDB2VwjdiwnDRrQFK0V572Ie9q0+4Q5htfhO
         z5uZZRkfphw5L0J68o4IJ+Ncuev2xvys5wO3Tn58rNcxIInqXs78GpdGyBRsnkxvsaZ4
         EQm+G2X5Ub7lUK1THiprM+OwHHNKlMuFO9cHuIwDk23v/UBzIuL/ZUuo4+wt0+q4S30b
         fC1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 04/23] staging: rtl8723bs: Replace RTW_IEEE80211_FTYPE_* with IEEE80211_FTYPE_*.
Date: Tue, 27 Mar 2018 01:40:56 -0700
Message-Id: <20180327084115.16129-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:p2Ztc6Lc0AKqEJsZZq/xEsjT+eRbx0ILFC49g4grSf6v8J6NC88
 6DnGkkLbXjsl1Xarif9fphMZl/MOIHUv6hffzDwtAcuIcXRqsJ4cnMq90prGYGub5w17j0C
 EKkx/bNzzo6hzaDjKTN/ZCN6sphBEWU0qEKFpcvJAEHFlR/f6IqUHDVGXMRWMyho33ujT6F
 Lfj4GRKut9xkTjCISEyFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jzLvcs46GAw=:eCHiHc1RlPmoE2knrUMVvA
 YGVu2KF/trFpkrEQpXyUchvBdfbuVKAqojrPpZMNeClzLnZNTTnKU4oqTa2oTTaiKp/ERE32Q
 C2Rba1tgVQSLZ/6QjB1XPUNDme123am9YiBHqvlCuuGp/VL+L3JUSi4kKXmY/HI+T4HEbFVYs
 H1cVVexUWV15fCyqVW9Xax3nwcOCO1oUkuV51vpf55zy1Saf7kr8JVHxmChqEDxkdYs7DnGii
 JboTmixRKjOg8hNTJCP+jQscSRTKl92rlUXbZgi8emVyUzqVIhvm/eIiIrn4o0TMu6N7IXNSS
 2NCHVGmNlLBtGQHRYmQriJA4Zuf4inebugcsMpYHUaUHMeMOSwz2CnN5LHiP9Q8fTOC1d833M
 SggIpr3lElnh5xejO+gJvYzgQT27N6thvjD9Jk4GG1YoAsEvMkshuyAiHx9rPm0k74/cv98U7
 gRFJUdRtkWNzAFqLKpPk0L6Qn9McAcQ9EWhmTegO7W3kSdnrAEnC7e/5hXOld41p/w0OhBymg
 wRLDE+YaMWey7T748R3fX7fZs6ofTJJnkCDKdJEO1FGStxkHR+03LynNZntxhK+VTvORt4B59
 /zDdEEhCxzlxP5eb8X02qhzCGqdaMfcPtfyki0wYWsu9vhZStfZEfH1l8kR8vqMbvcL5P4oyv
 jPjc8W7kYh4FWpi/G1Jg/fb6NuVn7B2to7DvPE75bJqBpuaf6DrB9uAjEfdJ3B1d9crqJqVxO
 HqY+u/p8KhJjE8OVfWv+gNFtkRY32tTRNkYfOw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079565558346152?=
X-GMAIL-MSGID: =?utf-8?q?1596079565558346152?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver defines the constants RTW_IEEE80211_FTYPE_*, but all these
values are already defined in 'linux/ieee80211.h' as IEEE80211_FTYPE_*.
Remove the locally defined constants, and substitute the kernel constants.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    | 2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h     | 5 -----
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 ++--
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 22c219e8a75f..e31e06fd6e9f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1381,7 +1381,7 @@ int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *act
 	fc = le16_to_cpu(((struct ieee80211_hdr_3addr *)frame)->frame_control);
 
 	if ((fc & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE))
-		!= (RTW_IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
+		!= (IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
 	) {
 		return false;
 	}
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 746ac7cf3ccd..c33b9c4ccd56 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -324,11 +324,6 @@ enum eap_type {
 #define MIN_FRAG_THRESHOLD     256U
 #define	MAX_FRAG_THRESHOLD     2346U
 
-#define RTW_IEEE80211_FTYPE_MGMT		0x0000
-#define RTW_IEEE80211_FTYPE_CTL		0x0004
-#define RTW_IEEE80211_FTYPE_DATA		0x0008
-#define RTW_IEEE80211_FTYPE_EXT		0x000c
-
 /* management */
 #define RTW_IEEE80211_STYPE_ASSOC_REQ	0x0000
 #define RTW_IEEE80211_STYPE_ASSOC_RESP	0x0010
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index a955b94614d0..4b84965ec5c5 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2517,7 +2517,7 @@ static int rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_de
 	dot11_hdr = (struct ieee80211_hdr *)skb->data;
 	frame_control = le16_to_cpu(dot11_hdr->frame_control);
 	/* Check if the QoS bit is set */
-	if ((frame_control & IEEE80211_FCTL_FTYPE) == RTW_IEEE80211_FTYPE_DATA) {
+	if ((frame_control & IEEE80211_FCTL_FTYPE) == IEEE80211_FTYPE_DATA) {
 		/* Check if this ia a Wireless Distribution System (WDS) frame
 		 * which has 4 MAC addresses
 		 */
@@ -2546,7 +2546,7 @@ static int rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_de
 
 	}
 	else if ((frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE))
-		== (RTW_IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
+		== (IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
 	)
 	{
 		/* only for action frames */
-- 
2.16.3
