Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELsTgIcJTMa35ybYlEqLyo74zgJDHFzLCUXLexyyzDX/C73UlUEIQmIePyco2vX8iPlXqxzX
ARC-Seal: i=1; a=rsa-sha256; t=1522140089; cv=none;
        d=google.com; s=arc-20160816;
        b=FTBcHifuqauL8Dm/tkibZ6T3DjnL1tezn5HB01mEzFWJVW7dJkpKQ7VNlkCvQX5+Le
         LDAP++AwfHdLfZrouJ0Ie3M6WVbSLp+IFAhtUXiZAi0IH21sUA4jZLtU0EkI/Zp5ADGR
         2778C1SrCMeXYMaBeNAnt/H3wiZWtmA21Ui1x2WxCBTfVjxu44DYVrrghcrrGkoPQI55
         h6CmHeOUHPPHqXWVyWq9ofI0ckNC8VfKzRoB6FaIXf+qjWfDGs1n34Fc2Ar2ji83sXma
         l+gm8D4B5lYY6cgvIdVh4R2CwT/ah+TRz4c4JAOakwLOZDDrHC480gIhZ2wfz+6JslbY
         9Kqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=A2MHJxJPFk1QT1rrDH4yEKaGWKDztnHv6ZC1aQXHucg=;
        b=rI+bYb12xHybGXepsqM5nDq0BGW0wyK7n/IJT7J1RxrIkPyPa5kM13DFtNMvf0HpWl
         V63soiEzpp+e2mEcipLlb+DbicJJ9yxVMNW7dsUliJMtFtHXWC3o1XRP679vp8u7dSHx
         uqvvS9oZn63OLl58Agg8c4qsjDiEbC50d2B77yORaktTY/HpO/N201WLLYO5mcY4k3qc
         +z35zS2emkIX3QcN1ZMSwut+xEDk0Iuczo1YVUth2bU6844Z0XEmYhq3G/lWxYQk6NWQ
         wxMo7Kr1n24s+GpbSsbyNO4B1p5XW49LEumNkWeqd7ZnMb8GS3HzmEp6NkuL2fFwDFdv
         prhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 05/23] staging: rtl8723bs: Replace RTW_IEEE80211_STYPE_* with IEEE80211_STYPE_*.
Date: Tue, 27 Mar 2018 01:40:57 -0700
Message-Id: <20180327084115.16129-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:zstDqQ8sTsdPfYIpNWRG8Wx5Pi/lsGhsC6bHzKjt8AbEzEmnsxN
 rr0H653A/o4NzbGFhf8NiURkqvdR+z88laM9vRL4DVgWNccG831w255hJ4a/eFJdhpmKw9R
 iBlPLP4fGtDji7c5fENwZGS5ye0wXki2UJHCj6h/4Y1RZJz25Kd6QNAXSOYdeGdxpXDZmyI
 djjwe9S5i6kvm2d1Uq+mA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UlXXPlZoDJo=:fKka1Icv99AkSHclo+Sy5X
 gk2KFfSWcXRMyev6fzTbp+8C5SZTTvSbO83J1q6RG8foU600PZ02B5wNoOnNiuGBtIv4aHlfF
 IsFEbf4TGV9Rx9DkgvBPG+W7GDic22GxZvAUFCX7wBu/pPfOvL4eahw9Si/p6BOHlzr59X3jN
 DZSo0HSbl6lYjJkLyLaEdXWHOG88/j09yZ17qFtHVLVKOAW+BSLZBj9ddR8ip6OcjLJRwbRK5
 PmtjSX4E8l8aDbhD899mWCuh02VmNzu4p1Il6yz184Qdt5WipczaGYg//ILQjYiaIUFZrzD9Z
 6aXQ9RxMoHj1gxjth10EEfGSoxM4vIJe5bv2c2fB3YIx7IxjfqwovmwOO153NaSAPlIOPDzLO
 n2qOsfqKB7mX/EeuzRtKrR+I396/6iNaLOFqj7PsgSORfwlxzjvO+7YJf7dC4tdAHireIn7Xj
 T/5zv46Xf5cl2bUIRhh+1VdhMwpZjkFvxemt2Wqu8ZGW+zZnKtIhnismRcx0o5dAgvj//wpH6
 qZ4XFyLULEyT4mEfLNAfB5wt1rbAK3M4wzDKaM3i95RzX4tPgnXrUXq0dlnU9Eo7CMKB9+TB2
 Dh7z8oDkpU2x3108KFAKygva4Z5yju4MxswnRbffMUowZBwLcEvSz3WyKOoDo7PwLEPk9MmrO
 opFqIZiKwv4Espj2pk1ejmePkFGeztiIQdY0hvxDVXvsaxaTSOJ2NjkaTIMZOmpt7di/a9A2w
 mID4Mbpgb4ITb6fESXCsT1hzpT9KJkLRalY5+A==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079566270707149?=
X-GMAIL-MSGID: =?utf-8?q?1596079566270707149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver defines the constants RTW_IEEE80211_STYPE_*, but all these
values are already defined in 'linux/ieee80211.h' as IEEE80211_STYPE_*.
Remove the locally defined constants, and substitute the kernel constants.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    |  2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h     | 43 -----------------------
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  2 +-
 3 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e31e06fd6e9f..74750dbce379 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1381,7 +1381,7 @@ int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *act
 	fc = le16_to_cpu(((struct ieee80211_hdr_3addr *)frame)->frame_control);
 
 	if ((fc & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE))
-		!= (IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
+		!= (IEEE80211_FTYPE_MGMT|IEEE80211_STYPE_ACTION)
 	) {
 		return false;
 	}
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index c33b9c4ccd56..2c7597ad0470 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -324,49 +324,6 @@ enum eap_type {
 #define MIN_FRAG_THRESHOLD     256U
 #define	MAX_FRAG_THRESHOLD     2346U
 
-/* management */
-#define RTW_IEEE80211_STYPE_ASSOC_REQ	0x0000
-#define RTW_IEEE80211_STYPE_ASSOC_RESP	0x0010
-#define RTW_IEEE80211_STYPE_REASSOC_REQ	0x0020
-#define RTW_IEEE80211_STYPE_REASSOC_RESP	0x0030
-#define RTW_IEEE80211_STYPE_PROBE_REQ	0x0040
-#define RTW_IEEE80211_STYPE_PROBE_RESP	0x0050
-#define RTW_IEEE80211_STYPE_BEACON		0x0080
-#define RTW_IEEE80211_STYPE_ATIM		0x0090
-#define RTW_IEEE80211_STYPE_DISASSOC	0x00A0
-#define RTW_IEEE80211_STYPE_AUTH		0x00B0
-#define RTW_IEEE80211_STYPE_DEAUTH		0x00C0
-#define RTW_IEEE80211_STYPE_ACTION		0x00D0
-
-/* control */
-#define RTW_IEEE80211_STYPE_CTL_EXT		0x0060
-#define RTW_IEEE80211_STYPE_BACK_REQ		0x0080
-#define RTW_IEEE80211_STYPE_BACK		0x0090
-#define RTW_IEEE80211_STYPE_PSPOLL		0x00A0
-#define RTW_IEEE80211_STYPE_RTS		0x00B0
-#define RTW_IEEE80211_STYPE_CTS		0x00C0
-#define RTW_IEEE80211_STYPE_ACK		0x00D0
-#define RTW_IEEE80211_STYPE_CFEND		0x00E0
-#define RTW_IEEE80211_STYPE_CFENDACK		0x00F0
-
-/* data */
-#define RTW_IEEE80211_STYPE_DATA		0x0000
-#define RTW_IEEE80211_STYPE_DATA_CFACK	0x0010
-#define RTW_IEEE80211_STYPE_DATA_CFPOLL	0x0020
-#define RTW_IEEE80211_STYPE_DATA_CFACKPOLL	0x0030
-#define RTW_IEEE80211_STYPE_NULLFUNC	0x0040
-#define RTW_IEEE80211_STYPE_CFACK		0x0050
-#define RTW_IEEE80211_STYPE_CFPOLL		0x0060
-#define RTW_IEEE80211_STYPE_CFACKPOLL	0x0070
-#define RTW_IEEE80211_STYPE_QOS_DATA		0x0080
-#define RTW_IEEE80211_STYPE_QOS_DATA_CFACK		0x0090
-#define RTW_IEEE80211_STYPE_QOS_DATA_CFPOLL		0x00A0
-#define RTW_IEEE80211_STYPE_QOS_DATA_CFACKPOLL	0x00B0
-#define RTW_IEEE80211_STYPE_QOS_NULLFUNC	0x00C0
-#define RTW_IEEE80211_STYPE_QOS_CFACK		0x00D0
-#define RTW_IEEE80211_STYPE_QOS_CFPOLL		0x00E0
-#define RTW_IEEE80211_STYPE_QOS_CFACKPOLL	0x00F0
-
 /* sequence control field */
 #define RTW_IEEE80211_SCTL_FRAG	0x000F
 #define RTW_IEEE80211_SCTL_SEQ	0xFFF0
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 4b84965ec5c5..46bc2e512557 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2546,7 +2546,7 @@ static int rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_de
 
 	}
 	else if ((frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE))
-		== (IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
+		== (IEEE80211_FTYPE_MGMT|IEEE80211_STYPE_ACTION)
 	)
 	{
 		/* only for action frames */
-- 
2.16.3
