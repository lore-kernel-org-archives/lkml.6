Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faXBTr3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F1276070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeFFKZ0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:25:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39398 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932332AbeFFKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:25:08 -0400
X-Google-Smtp-Source: ADUXVKJX1bkNR9wEOJ0g/WKmyVgaQUYgFUY7V09CCfBoA5IYRvBHlNBE92e1MkYlxxKnb1uVTD1TcA==
Date: Wed, 6 Jun 2018 11:25:14 +0100
From: John Whitmore <arigead@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: John Whitmore <johnfwhitmore@gmail.com>,
        kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        colin.king@canonical.com
Subject: Re: [PATCH v5 8/8] staging: rtl8192e: remove unnecessary parentheses
 - Coding Style
Message-ID: <20180606102512.lvepwliyqd6pkbgj@xux707>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
 <20180603120413.13042-9-johnfwhitmore@gmail.com>
 <20180603122835.GB18700@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fp3nulox5qwidvps"
Content-Disposition: inline
In-Reply-To: <20180603122835.GB18700@kroah.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fp3nulox5qwidvps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 03, 2018 at 02:28:35PM +0200, Greg KH wrote:
> On Sun, Jun 03, 2018 at 01:04:13PM +0100, John Whitmore wrote:
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> I can not take patches without any changelog text at all :(

Sorry I created a one line commit message, which became the subject of the
patch email. I couldn't think of anything more to add for a second line. My
mistake. I did an ammend of that, as it was the last commit, to add a second
line.

Now I'm probably going to get this next bit wrong. Can I simply bump the
version of patch 8/8 to v6 and resend that single patch file, or bump all 8
patches to v6 and resend all of them? I'll bump the last patch file and attach
it to this email, hope for the best.

--fp3nulox5qwidvps
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0008-staging-rtl8192e-remove-unnecessary-parentheses-Codi.patch"

>From 4d01cfb7d18e507b163a25a69938f323cd61e9fe Mon Sep 17 00:00:00 2001
From: John Whitmore <johnfwhitmore@gmail.com>
Date: Sun, 3 Jun 2018 12:54:22 +0100
Subject: [PATCH v6 8/8] staging: rtl8192e: remove unnecessary parentheses -
 Coding Style

Remove unneccessary parentheses - Coding Style change

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9cca4a8f1cf5..fad740309558 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -529,7 +529,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
+		pCapELE = (PHT_CAPABILITY_ELE)&posHTCap[4];
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
@@ -1072,10 +1072,10 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
 	// Initialize all of the parameters related to 11n
-	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0, sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0, sizeof(pHTInfo->PeerHTInfoBuf));
+	memset((void *)(&pHTInfo->SelfHTCap), 0, sizeof(pHTInfo->SelfHTCap));
+	memset((void *)(&pHTInfo->SelfHTInfo), 0, sizeof(pHTInfo->SelfHTInfo));
+	memset((void *)(&pHTInfo->PeerHTCapBuf), 0, sizeof(pHTInfo->PeerHTCapBuf));
+	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0, sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
 	pHTInfo->ChnlOp = CHNLOP_NONE;
@@ -1091,7 +1091,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 
 	//MCS rate initialized here
 	{
-		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
 
 		RegHTSuppRateSets[0] = 0xFF;	//support MCS 0~7
 		RegHTSuppRateSets[1] = 0xFF;	//support MCS 8~15
-- 
2.17.0


--fp3nulox5qwidvps--
