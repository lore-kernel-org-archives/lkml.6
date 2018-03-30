Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48Crix++NxJiB+tq2hn1NMu4J1jZglyC+kPelyNRFRWg31mJxRaaiVmyzE8RlSPV/uu0JCP
ARC-Seal: i=1; a=rsa-sha256; t=1522393777; cv=none;
        d=google.com; s=arc-20160816;
        b=MvLTXjF8R/kQ3GyeSHzJfzkhJdm1tF1WLPL0sw4Tuz2FK00AH0hfWbfUUFGCmCKmwz
         q1fJw9E/3y9/G1mn6WUmTUKpt1MeMs0w5kJvctc7ZkJGY5DnUUvJEBK72UwqUhEUNS9Q
         kxSqQ7R9cy8rYzs6cAXpB8zi7OFupBs4xDPmc074BzBQDZ0+agKwZEyZiPbZgPnCsHx1
         4oP4Q2Ppbv4xiXd8UX1ph69zoZta0QxgmM++WorC38BczHrLW9JV7iczP2tHBhVPsFgh
         6LbE+QO14VN6SoyVu/IDQZpROFERz0LeTdMeASn3i8pLeVYFjID+h5VgffVB2D1yd/3d
         h2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=cG++bmLJbPJGYIgFuGldiiQz4bkA9JCFHA0Kjd5Pg7Y=;
        b=olNczDFvc5/5W41TYwMV0cSanjAteB9LO91LodAUqU8kG4cnWMYmhe4R1bSzvx1cfj
         LL6ptTFAx3hjWi4hBivfDL+Qe8joqDFkifZIrOM24m1zMDFKuo4aZrJliy0xLMFXw+L2
         CZ0v76OaU6DuMJvMr/8WQiW6eHFXiVyvMplei1ztJb7YbR5qzekyZTUrjjew0d2MeUpp
         zwB7vjYntj8cI6BGasxbZlvqGxJ/6BayKsfhX8o1P9XNmHH3YEYvrLmo4c+3YkPxn1ER
         5VrqeOOvgIyMQL4zcgVqOdXGcG9y9aTdpSXtKRKGQbMIItNA47uTJsmZTa04x7cP9lky
         vEmQ==
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
Subject: [PATCH 45/76] staging: ks7010: Remove trailing _t from 'struct hostif_phy_information_request_t'.
Date: Fri, 30 Mar 2018 00:08:08 -0700
Message-Id: <20180330070842.25224-45-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:RjSJxcPFDG7YMaPXPvm8wgi0wYycld9MxStHeZjd6jW5o4MKldA
 Nhx/5xOIJvSmAoYJRNXQLLUH/XXPVUBv7vDMATsG2raqwSVTpOy2em/vV5ypgUx3SDWfNWb
 kg4CC11ljtsCQwc+t2yBHlD/HaH2yb5kePwGlRiomqFQb2G1yojbtxfNB9v9ZhigqyhItgE
 +lNier5oHXycDTaanxzSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JQ2Gtr8ZXcY=:JXEMOweajdte1mzhzRhsPE
 kaHBuk72oEHr5YuFYep5nFEDGC97EWYD+uwneKC5V3De0/CMRmtqXcmwGHYb1PD3Bg9RhWIon
 I9NhkZ4aipHUD2zwskMWvE9GZXmtxJy/6Vpsfu2tl2ukhLe/kPEyIDB2imUKz0FCv10aViQTm
 AkhM136jOGWqvSzvu9sW/d1ZIpd6NK1rVKqRBZbgjIrbXOdx0PgVZZQBfdY50DAhN5qsSJfA5
 eCRgqXi4t5oN0U02a96HKbQo0xFB9b3FEJPcEpZfSwWU3sXweiZr4ARbEPcC17gatVVCC1pef
 1nRhebmASD6cuJxigORg1ilJ/uXPLfjDFK+7sNR359ydkofMSyBLvufu/lkG2i0jXE+fkzLbK
 FTdxwp5fcDCAKmKuwpmvtDYoyqldMv0dVO2/rFY+jpuKHAwTklX+8UZtc06GyKI84z4j1Fvch
 C7SUyqEmUfc4pkVXf0bK5B8UMZgReRxu3+UV9V0iXBWzPkyQ/2TFKMd1KT1aLZqa0oyabIwCE
 V7Cy34iHmcPN3ftyW8VCXOsgOxphJJrrgDXZieyMVj4+sHIW2956kHNP3ZAar8p4vpUahTsUe
 qkDWz8cq52SRSB1SjgSK0uIKQI0co5yuohxM7bn9W+zIp7gYN2TN6ZvghRxJEN+adfeFjfSLW
 tnwFicpP/D8s4vJNtTz/A5UwEdZehnjbEEQjAZdaWwsIyLQBxHSA3i/8lO/34Zy9O6Gfx4846
 gJEqfqjDuY7RcKxvO61Skt4PJ+Mveok9qy586g==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345577436998358?=
X-GMAIL-MSGID: =?utf-8?q?1596345577436998358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_phy_information_request_t' with 'struct
hostif_phy_information_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index aa827949db7e..4bd8a285eac5 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1440,7 +1440,7 @@ void hostif_stop_request(struct ks_wlan_private *priv)
 static
 void hostif_phy_information_request(struct ks_wlan_private *priv)
 {
-	struct hostif_phy_information_request_t *pp;
+	struct hostif_phy_information_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_PHY_INFO_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 2c1bfc9e8610..831c02d6e791 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -478,7 +478,7 @@ struct hostif_bss_scan_confirm {
 	__le16 reserved;
 } __packed;
 
-struct hostif_phy_information_request_t {
+struct hostif_phy_information_request {
 	struct hostif_hdr header;
 	__le16 type;
 #define NORMAL_TYPE	0
-- 
2.16.3
