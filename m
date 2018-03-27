Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49G30Ge6O5rwd1Hk3dv9o6r5JFJFzsay+//3dhbxfJgDNALglyOzXWKak4doRYrIPQivfqJ
ARC-Seal: i=1; a=rsa-sha256; t=1522140087; cv=none;
        d=google.com; s=arc-20160816;
        b=tg+LsCtp4YiPNXAZKUPD+8iXDLHVzhmVRGXOkPMFEvFe+sMEGt49y2uQQKY1RahooJ
         TzOJCvJKOTx/CmnIwU4Wemn0StftbrlGp1RxfwagZ8MyEJ4r39rZwpMRSjfG1WXYVCou
         uEfmWLrmwJzp43dKCzQpFf6b7nBJ9lvZ9jhx0NYNCQWTCVrAayX66LSijGjEK7Bv9rz/
         xAhAZjHCXTBZwj8+uuyccXBYiw/EnBcSuxdmhSQy7tviTgMTN35D76w9XxeAZv88N00X
         b1xjPg2tV9fsUtGqtb52Mgasl/xGtp6nLGsz3VZCzyFds7GnbkSHtY3Msir9x+DWtgH1
         PxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XmqSNm/1c7G1dW4Z5e90bcDkYgDuY/j11hTuwmSfViw=;
        b=NadtePqCKwwaFdg3wmMG5I+mQwkXVsrlXGGPstF7K3wt3Tg5ediPIOJg//e/KYyi7K
         ka6on793UTyOWXVhg1nEW09MpGeJkhIRihJSlSmtrvwtjzjDomUWIxW3mGBpG/w7YnmN
         h/ESYew0ZpFVe3gLcJ0SIUDTwoTQDSYOegNxHF2NwG+QXHgyKNaVP5T3k9TW8DqvvD3u
         zr65+RmUnKgyF23vLeHtbrODLDbtMB7WvcrIzoA7rpJ1+phMelwnUOHPzLy8MSBV3C30
         39JQt397ZxgvBLuu8SGu1SJNEqCoF93LpqYDOFSSx5UiexUcSnnm+PqdBcq+ksOFOGL4
         iJDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 03/23] staging: rtl8723bs: Replace RTW_IEEE80211_FCTL_* with IEEE80211_FCTL_*.
Date: Tue, 27 Mar 2018 01:40:55 -0700
Message-Id: <20180327084115.16129-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:B4/4d/bxkD2lNTVzPM71DeXcuAnFfoiU21rcQwKok3v+ly/gucB
 yJy0XjmU6C69MpvhGX5JW0tKOBI6dJd30ti0MImKUJ7RYiVR28e5wzO9KK6JGR0KUlPM2H/
 LIbdi2U7nWIXyfrhVay+LZFN0CaSV9aDOD0BdVcBQaIHJ0xpSwMWGdM8ElKjkZxUhb425Qr
 FHix7+zpJzYUQRr4j5DOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iXFI7Q7iEjE=:0FMerEutENaBdhGrc4Bev0
 S6h5v3IERf04Y2J2iAVBv8m4BDiau4OzhxHq9mcSceJEZQUwcQApYdNF6sPN90+R/3cNbH+1n
 y+WfW4ycYn5xNMleWeCnZ2a4H8B4VqL7pSX3SX9ivKnvJI+Zr0VxR16lTqVd+cNmLKjvOuxy6
 7/xNhpkq3YRBd6WWAogG5Kzp1uEF3GJGxUF+k3mb6LVAMovZF15+j2KwDLwBlnr49KLlsOTpN
 4rguSrJN6LEdsTdqPL0L3Kd3NOLH723wBViPYwNcgcS/0huR3VaZEZDuoguw8rkdUv0IH7EMi
 HS1lXYYXRe6xuwrp4oxq2qMVAE4ahSsBhoteQn1maqOf//NFlvWm7aW0UOl5udBA5bIee14pH
 Yo9IXvn7Q2vb9T+kZZne8HPeUJ6SeaC9ZyDdXwadH0D2Q2XJoq8wPhgPfO/9AH6xICjCprHGt
 aJde2yaonW+StK6y92jQPNnF+ZuuEtNRYa6luupyimeXLcJP3+ad+bp7ejPHlmwm7KYkXhICc
 Aj3PkVOr2AbhYnZrgrxayzd/G1k3suGbD3bQh7XlLgi4q1SJfippF+WXbYQpY+MDqttFQL9Gw
 R5As5ik9Y8puoMaNMVzfAhD7GBT8ELLrv2culghgi/hS7ly+CgUG1Un6T3B7DUi2vu+EO8vqy
 JuhWbJT9tkJimr0hlIUekyS8jknsBKEwWbAbyd4D/BR8eLKyTNyw8ZHNgcEI9sb9Ox/vzb2SG
 le/vOHlGDCjhhBr0Zx/5Cbbte0VCNeNKkI1XxQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079565102497485?=
X-GMAIL-MSGID: =?utf-8?q?1596079565102497485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver defines the constants RTW_IEEE80211_FCTL_* for frame
control constants, but all these values are already defined in
'linux/ieee80211.h' as IEEE80211_FCTL_*.  Remove the locally defined
constants, and substitute the kernel constants.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    |  2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h     | 18 ++----------------
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  6 +++---
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 9167900b5f7d..22c219e8a75f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1380,7 +1380,7 @@ int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *act
 
 	fc = le16_to_cpu(((struct ieee80211_hdr_3addr *)frame)->frame_control);
 
-	if ((fc & (RTW_IEEE80211_FCTL_FTYPE|RTW_IEEE80211_FCTL_STYPE))
+	if ((fc & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE))
 		!= (RTW_IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
 	) {
 		return false;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index c76466567ecb..746ac7cf3ccd 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -324,20 +324,6 @@ enum eap_type {
 #define MIN_FRAG_THRESHOLD     256U
 #define	MAX_FRAG_THRESHOLD     2346U
 
-/* Frame control field constants */
-#define RTW_IEEE80211_FCTL_VERS		0x0003
-#define RTW_IEEE80211_FCTL_FTYPE		0x000c
-#define RTW_IEEE80211_FCTL_STYPE		0x00f0
-#define RTW_IEEE80211_FCTL_TODS		0x0100
-#define RTW_IEEE80211_FCTL_FROMDS	0x0200
-#define RTW_IEEE80211_FCTL_MOREFRAGS	0x0400
-#define RTW_IEEE80211_FCTL_RETRY		0x0800
-#define RTW_IEEE80211_FCTL_PM		0x1000
-#define RTW_IEEE80211_FCTL_MOREDATA	0x2000
-#define RTW_IEEE80211_FCTL_PROTECTED	0x4000
-#define RTW_IEEE80211_FCTL_ORDER		0x8000
-#define RTW_IEEE80211_FCTL_CTL_EXT	0x0f00
-
 #define RTW_IEEE80211_FTYPE_MGMT		0x0000
 #define RTW_IEEE80211_FTYPE_CTL		0x0004
 #define RTW_IEEE80211_FTYPE_DATA		0x0008
@@ -426,8 +412,8 @@ struct ieee80211_snap_hdr {
 
 #define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
 
-#define WLAN_FC_GET_TYPE(fc) ((fc) & RTW_IEEE80211_FCTL_FTYPE)
-#define WLAN_FC_GET_STYPE(fc) ((fc) & RTW_IEEE80211_FCTL_STYPE)
+#define WLAN_FC_GET_TYPE(fc) ((fc) & IEEE80211_FCTL_FTYPE)
+#define WLAN_FC_GET_STYPE(fc) ((fc) & IEEE80211_FCTL_STYPE)
 
 #define WLAN_QC_GET_TID(qc) ((qc) & 0x0f)
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 75a4b230ae6e..a955b94614d0 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2517,7 +2517,7 @@ static int rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_de
 	dot11_hdr = (struct ieee80211_hdr *)skb->data;
 	frame_control = le16_to_cpu(dot11_hdr->frame_control);
 	/* Check if the QoS bit is set */
-	if ((frame_control & RTW_IEEE80211_FCTL_FTYPE) == RTW_IEEE80211_FTYPE_DATA) {
+	if ((frame_control & IEEE80211_FCTL_FTYPE) == RTW_IEEE80211_FTYPE_DATA) {
 		/* Check if this ia a Wireless Distribution System (WDS) frame
 		 * which has 4 MAC addresses
 		 */
@@ -2545,7 +2545,7 @@ static int rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_de
 		return ret;
 
 	}
-	else if ((frame_control & (RTW_IEEE80211_FCTL_FTYPE|RTW_IEEE80211_FCTL_STYPE))
+	else if ((frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE))
 		== (RTW_IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION)
 	)
 	{
@@ -2607,7 +2607,7 @@ static int rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_de
 	}
 	else
 	{
-		DBG_8192C("frame_control = 0x%x\n", frame_control & (RTW_IEEE80211_FCTL_FTYPE|RTW_IEEE80211_FCTL_STYPE));
+		DBG_8192C("frame_control = 0x%x\n", frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE));
 	}
 
 
-- 
2.16.3
