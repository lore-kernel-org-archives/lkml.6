Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELvQN4BkC8ZGl8OyTwHaWQk5nJhK64TOHOo9NRajBk3otex2Xd11cSoyrazWwQMZdrVXChs5
ARC-Seal: i=1; a=rsa-sha256; t=1522140092; cv=none;
        d=google.com; s=arc-20160816;
        b=QqqWWcZdJhbrpG2IbvwKAa7ukK2q87K9KpZ1rTE1YePAhizBs/+ZYmvsots543fUoA
         ZVZwXGfCnbTrq6FzjrA6pR/dpIfdBXGsh93/iNnLpRZMu2RtqevQ9ttOPMIWtiEjHg45
         vI34ylmbBAA0jZJ+H5u9N8NeppsPCfZWRN7KSd/gKF9jNvDY8SXZ2B/g4yezOkOJmvYQ
         SC0HG8vkwsl2N8dQHeTWeT9XjWRTt53H4MgUOhxeZ6Ynnsja2lKWBYj9fZ1oPy977HbF
         rld/l8n1jr6Paut7xCAhf+JYwFIJdzSQIhnpaPd23WgG8gOcsja5DAc42eqhLRJqBoqG
         enbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=yvA0oL9vKzzxe3g3eNMHn1ekvSHv9EHieJ/L6xMMMiQ=;
        b=h2SG3XgA4Dz5UIsaCfnHkjY2Jn6I41XgIoj4xYy2ssfB8HNcuOLHLZqm1WmeaNKSFo
         eUw6o+t7Aez58tNo6PfhNYQ5tuRfJ8MTZwep0Do+LIDBVueuDMBTbpuk6gGMbygEZmuc
         UVVWoEr28ErXAGXOtVb5Tsj4CbwpNnu7K6YJnaT/kvRXiC3lXgJ6nvRsI41I49AWvJDo
         NK9GKokCvDt+e8ycWsKaCTQAy2tge8DxUR2CkrsQc3UPIlHxFSMNgEr0A8QeG4TwBsVs
         AGsMhGSgIr/L6144udSLcOiXIIBmBabmQk22rlF+1I/hNzmqiUcIe37KYUIJxtP52PZ2
         IojQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 11/23] staging: rtl8723bs: Remove unnecessary length #define's.
Date: Tue, 27 Mar 2018 01:41:03 -0700
Message-Id: <20180327084115.16129-11-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:gSLOXKwckDya7zAz4eNtx0SyeKvmsfAQjoeYcHd9nrV8jwOSu0+
 yCk6ws4erU51K3kGt22o4ggz+LgeWAForgn+osy6dZlZUjPtMSSTq6Tq+r68s+ZwikRvMKa
 JPLscHv6XRaXTmJ7UZwPotqrXzyWNrrL3VOkUW7w73BOISrkysLn2gcWQlC/D+FCG/QDBo7
 AJLN4httjlTsyIdIbV+fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:utYYTfmd3UI=:kEx+2nad27vGTii41OPS+F
 pmFzWB3mzZazqQuWh8MC6vEDFzt3JGUpad9TpuU7pLuLQr6SLrQMoaiJYwyRmeJ5wI7b8o1q6
 KtKO4rHFnN7c4U0Lb+6jWi3Pc/hROVxmQbra5683DSAfc8c9xMyjgWhre4Yd8MaMMSohzSh1o
 uY9QWfoCPfQFT6YcxngyNDAhIi6aNBaL61WtDp5udQA8gwnNWpm7PSF8uulheKMAZK82lz/3p
 wD3VU0sxqX5cQW3oOXJzwx+HV36yrbKTEFJgWfEuySGnWpSgRe9+pIc03ZvJZCSUEmNRZLrYt
 4d0K3aJPkDXfFonxVdoTs2/EwhG4S774F7beyNJJHXu0lPn1l2iAe+lKUn9WEhm2ku6038dZE
 om+Ebf2QvqkvaeQgaP/XhSXANdWWz0ILsr00Lqo7Wis3BA9wY21JdmHTtAnPsouMIZ/PiWXec
 EdhUMO+eARoJqQx3CQIE+QajrAIkXBnBSE4H6egzKZ14sKwbct2AWPLboRr/3nNW2clciX2mQ
 oywvqhAondktFfeXjEJZY9dg8WhBAwawTnPHsCMM05ciyx8Krnvga1q2X9R7wwffCEX4uXjJV
 8Zc/m+KzFwGpoBD9R1thYq2t+8ph0zpJVr7Qe42tREk3BAtU/dMTMr00Rxxg5M57NVbPTGbWJ
 nvSYAZR5qwghOw3EISw0BW0xRaWysvN5cuET/o3jr2lU7wBsHoUIx/xLg0RvEONH9sGhWqXQp
 Ewxq6QQ25DLG+DCbP41I2FGq6n5Q9jUWvwDcxQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079569794595913?=
X-GMAIL-MSGID: =?utf-8?q?1596079569794595913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver statically defines constants representing the size of
certain structs using literal integers as values.  Replace those
constants with the sizeof() macro.  Other length constants are already
defined in 'linux/ieee80211.h'; remove those #define's.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  6 +++---
 drivers/staging/rtl8723bs/include/ieee80211.h | 16 ----------------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 7d7756e40bcb..2816c68b8254 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1219,7 +1219,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	}
 
 
-	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset) {
+	if (pkt_len < sizeof(struct ieee80211_hdr_3addr) + ie_offset) {
 		DBG_871X("handle_assoc(reassoc =%d) - too short payload (len =%lu)"
 		       "\n", reassoc, (unsigned long)pkt_len);
 		return _FAIL;
@@ -1236,8 +1236,8 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	/* listen_interval = le16_to_cpu(*(unsigned short *)(pframe + WLAN_HDR_A3_LEN+2)); */
 	listen_interval = RTW_GET_LE16(pframe + WLAN_HDR_A3_LEN+2);
 
-	left = pkt_len - (IEEE80211_3ADDR_LEN + ie_offset);
-	pos = pframe + (IEEE80211_3ADDR_LEN + ie_offset);
+	left = pkt_len - (sizeof(struct ieee80211_hdr_3addr) + ie_offset);
+	pos = pframe + (sizeof(struct ieee80211_hdr_3addr) + ie_offset);
 
 
 	DBG_871X("%s\n", __func__);
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index a353dc9b883a..c8e5251c2760 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -272,20 +272,6 @@ struct sta_data{
 	u64	tx_drops;
 };
 
-#define IEEE80211_DATA_LEN		2304
-/* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
-   6.2.1.1.2.
-
-   The figure in section 7.1.2 suggests a body size of up to 2312
-   bytes is allowed, which is a bit confusing, I suspect this
-   represents the 2304 bytes of real data, plus a possible 8 bytes of
-   WEP IV and ICV. (this interpretation suggested by Ramiro Barreiro) */
-
-
-#define IEEE80211_HLEN			30
-#define IEEE80211_FRAME_LEN		(IEEE80211_DATA_LEN + IEEE80211_HLEN)
-
-
 /* this is stolen from ipw2200 driver */
 #define IEEE_IBSS_MAC_HASH_SIZE 31
 
@@ -313,8 +299,6 @@ enum eap_type {
 	EAPOL_ENCAP_ASF_ALERT
 };
 
-#define IEEE80211_3ADDR_LEN 24
-#define IEEE80211_4ADDR_LEN 30
 #define IEEE80211_FCS_LEN    4
 
 #define MIN_FRAG_THRESHOLD     256U
-- 
2.16.3
