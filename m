Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtPQxp4YVbjCv68w0P+TfVcnC9S9KEyA/tJSCzJPLt9BXw/dpPsG41n1g6sVtkp8vn6Lzoy
ARC-Seal: i=1; a=rsa-sha256; t=1522140087; cv=none;
        d=google.com; s=arc-20160816;
        b=aD5eR9LGDy+ybNbtzC0qJ92pF9uNnqz2el3yn8KLjyJdLq8IBQPO6qBm3swCJAk/Yp
         Ym1fH+HbpVjkXPhzVsIL6yYEHKqz7gDibxQmw7Qb1hE0lJboXdSgmEEjknpJKdnxvWRr
         w0eTYqKnQNNb72EEJdpBfyP8/jxgdzh9JtjYV7XsWxBTGzRsHAmvNNobqhiJ3XdV5Uue
         sKfFC53SMEKQWTwY1hHsTocnQkgAx0PmD587SbLyRKwm4O1PrI8N0fDuGjq5Q4LWL73l
         1/isqdvdRChsHW6wbWYHZesbsLkHVsFmP0icJuzpsf5SAsN2sBwme90lZ/Lg3q4ENekQ
         rvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=G6nzfQdQK6frkswrdMyaO/MaCn2mZAZRfKiK5KIUW3o=;
        b=qe8+oUf3YQ1YIHzxFW5SG8DbhKPv8lXxPlUYSa6prhXuTLw7/WuFsjI922W2rcFz4G
         upnc4l8LVaWzdhvDb8QoEieEFHk849OXNKYSSHdH+SXedSNbVXGnwZ+44cSHtm/OVnMu
         PeaOrqejn4cBOCycAnCBmjSFDdZEcvpUUKUZIU/6E9Y+WKaRO7tPbTzFbX596muz8JqU
         4m6hsrF7OnmyLNHcRpn8EN3DaGAd8JEBz1v2kcrwtstMWQ1hue9YwtwumHQ4ZwzrUZBX
         SCjLeP8589k7w57LIMCC6TxFa5iuhVcyB9hbnbgJKiNdOS9E/VKKaiqf7IejIeOWQ9sU
         j6Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 02/23] staging: rtl8723bs: Remove #defines shadowing enums in 'linux/ieee80211.h'
Date: Tue, 27 Mar 2018 01:40:54 -0700
Message-Id: <20180327084115.16129-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:3Zj/OSiumqQb14e1OuFg52pZPU9JW8p+ptGqerewQY2kFmotbjk
 qz2KJAAaRTEYrTX8PjWL2GQoL2rieJY5zR9ONuNBNEZ1Rs3IMY+0EahJp50Ow5ynmeSLidv
 K5K1mY6QPnVPPz8pS8Gt+u5XiLs0GIJiRvzp3Fy8xyYxRmDgh4jbGUbRTsZ3sDzLihEEx3N
 32wQsdttC56mL7ecI2WHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bOB2AXP9lWs=:avBpv3wda+bQdbV6Py+qI3
 rFT3oOobiMKBnzDRAXz5dEG+BXyjcMZjsLaikk0u8uCAhpIIO98LURgW891GviYaW+u/lQmMk
 03YnnY9MzBkaUcL5ZCb47NQc6JwmboxNBnyCdSj3fqaqmm5MICNd/Yw2gn0DdJt2XZtW8egYB
 AZzxDCH/qYd48F3VGUUdVwnzzFrLSOFMsW35p3HJsn5QiHdcrJfrlxy9g4YUi6qCtQIvlmgX2
 Hlp/d15MWElz52vf2c9Zwo5pQ+0pRTckOpgkwIXjYGL4IfY8hXn4Tuv5XYPBZXPXPPKLfyO9A
 q//5WPDjrYHXdq/fXnmYcMrLvQvD2vJR6j4OMtGKoeq7BqH/eyz3EeSzixZ3p9aa06IX3JkN9
 6AkdKkS33sp+eQ8ThL9ZaD0P2yZ205lAdp6uZXJVc2wVzFo815wHoMfK5NDHRhqz3vzSASH0w
 KQqGOPqf5+FDgX9gEhg1y5OHxrQ/aJWEjLZhzC+dy5rUsoFDPXfB9r8JS+qjJdDT4lViSE7S/
 ACUsROygAXumhJmvacE+jHHbl3z95z36nF9Is5/mu2cPLRjTYiOOFWaKCzBjDBJVctS32jh1J
 PER2fPh+foSr4o19NbcbmR8faGhlLbkcKXGTHy4MrCqam9C5JdQzHYMDQvyCryf7f4za2rJV1
 /edWcyHvIPqkE5K9zEjALmZl4OE7OhmAcn86HdswZI2VKadWUEwO62xPi19U4ivmYbD44gdt8
 pGa4snFwTPCRsKvrFGVnfkwsP9lL4tX8LnsF8w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079564050223473?=
X-GMAIL-MSGID: =?utf-8?q?1596079564050223473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The modified file includes 'linux/ieee80211.h', but #define's many
constants that shadow enum members in the header.  This will create a
conflict if the values are ever changed in the kernel.  Remove these

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 56 ---------------------------
 1 file changed, 56 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index a2402495f447..c76466567ecb 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -438,76 +438,20 @@ struct ieee80211_snap_hdr {
 #define WLAN_CAPABILITY_BSS (1<<0)
 #define WLAN_CAPABILITY_SHORT_SLOT (1<<10)
 
-/* Status codes */
-#define WLAN_STATUS_SUCCESS 0
-#define WLAN_STATUS_UNSPECIFIED_FAILURE 1
-#define WLAN_STATUS_CAPS_UNSUPPORTED 10
-#define WLAN_STATUS_REASSOC_NO_ASSOC 11
-#define WLAN_STATUS_ASSOC_DENIED_UNSPEC 12
-#define WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG 13
-#define WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION 14
-#define WLAN_STATUS_CHALLENGE_FAIL 15
-#define WLAN_STATUS_AUTH_TIMEOUT 16
-#define WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA 17
-#define WLAN_STATUS_ASSOC_DENIED_RATES 18
 /* 802.11b */
 #define WLAN_STATUS_ASSOC_DENIED_NOSHORT 19
-#define WLAN_STATUS_ASSOC_DENIED_NOPBCC 20
-#define WLAN_STATUS_ASSOC_DENIED_NOAGILITY 21
 
 /* Reason codes */
-#define WLAN_REASON_UNSPECIFIED 1
-#define WLAN_REASON_PREV_AUTH_NOT_VALID 2
-#define WLAN_REASON_DEAUTH_LEAVING 3
-#define WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY 4
-#define WLAN_REASON_DISASSOC_AP_BUSY 5
-#define WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA 6
-#define WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA 7
-#define WLAN_REASON_DISASSOC_STA_HAS_LEFT 8
-#define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9
 #define WLAN_REASON_ACTIVE_ROAM 65533
 #define WLAN_REASON_JOIN_WRONG_CHANNEL       65534
 #define WLAN_REASON_EXPIRATION_CHK 65535
 
-/* Information Element IDs */
-#define WLAN_EID_SSID 0
-#define WLAN_EID_SUPP_RATES 1
-#define WLAN_EID_FH_PARAMS 2
-#define WLAN_EID_DS_PARAMS 3
-#define WLAN_EID_CF_PARAMS 4
-#define WLAN_EID_TIM 5
-#define WLAN_EID_IBSS_PARAMS 6
-#define WLAN_EID_CHALLENGE 16
-/* EIDs defined by IEEE 802.11h - START */
-#define WLAN_EID_PWR_CONSTRAINT 32
-#define WLAN_EID_PWR_CAPABILITY 33
-#define WLAN_EID_TPC_REQUEST 34
-#define WLAN_EID_TPC_REPORT 35
-#define WLAN_EID_SUPPORTED_CHANNELS 36
-#define WLAN_EID_CHANNEL_SWITCH 37
-#define WLAN_EID_MEASURE_REQUEST 38
-#define WLAN_EID_MEASURE_REPORT 39
-#define WLAN_EID_QUITE 40
-#define WLAN_EID_IBSS_DFS 41
 /* EIDs defined by IEEE 802.11h - END */
-#define WLAN_EID_ERP_INFO 42
 #define WLAN_EID_HT_CAP 45
-#define WLAN_EID_RSN 48
-#define WLAN_EID_EXT_SUPP_RATES 50
-#define WLAN_EID_MOBILITY_DOMAIN 54
-#define WLAN_EID_FAST_BSS_TRANSITION 55
-#define WLAN_EID_TIMEOUT_INTERVAL 56
-#define WLAN_EID_RIC_DATA 57
-#define WLAN_EID_HT_OPERATION 61
-#define WLAN_EID_SECONDARY_CHANNEL_OFFSET 62
 #define WLAN_EID_20_40_BSS_COEXISTENCE 72
 #define WLAN_EID_20_40_BSS_INTOLERANT 73
 #define WLAN_EID_OVERLAPPING_BSS_SCAN_PARAMS 74
-#define WLAN_EID_MMIE 76
-#define WLAN_EID_VENDOR_SPECIFIC 221
 #define WLAN_EID_GENERIC (WLAN_EID_VENDOR_SPECIFIC)
-#define WLAN_EID_VHT_CAPABILITY 191
-#define WLAN_EID_VHT_OPERATION 192
 #define WLAN_EID_VHT_OP_MODE_NOTIFY 199
 
 #define IEEE80211_MGMT_HDR_LEN 24
-- 
2.16.3
