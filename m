Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+fHqJ5P/Oq0xk434Ty+TCO2meBpq/hCtDnTh2EW2olCY8oGoe7mdSt4RGM61JGVZPw/LDY
ARC-Seal: i=1; a=rsa-sha256; t=1522476571; cv=none;
        d=google.com; s=arc-20160816;
        b=kfpO2QUDw83NNY8GpRJnRIl9sfkWxFXquRCLtYVjmnk/T3+GE7jCzdbXBkdTRJGyfb
         ON8aCsOKP2zHDM8K7rXPpp4hmbVUyogb4f49s3Pls5GelKQbzhu8OeM6SjZSAEvYHzzC
         vwn0EFKwun5GTX3FpmYKlC8KQeqNlYmQ41OtvPDoekvo3ziZ335LUg5K6j3zFO4Mi4Do
         RPq63kgtge0LpziGu9kycy2pvuI0IOSn2xRNZNNs8yJiMaNNWhdqvSEwqO8nBKZfhSkv
         VUk3Faz5VEl3N072tciFUKQ6PfPcFVzI3na5LHrQqmce2Kk74v3Wmf7ui6tTaZT74n+D
         fJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mWAaJ7Vv44nGACEwnCWzexAtXAFSWKW+xu2LS8TKTt8=;
        b=y6nweoNZRwzeC486XqMZrAkL4thkEAWkdun14bJcroc9lRfU/CZtt6wrreS+h0yrVV
         XBbrOpdYRhYmFarTQhyRK1wDAa5vaIi6GgwUyKT8fwqKugqQKcp4y7Ei5Zb0kJgx103v
         aUTmKnL/vPLFhczfjItwqkEJttUtlSqmqTE1WONMrAN0NE/B3rsc8kfGXCbHqSv/Qzm7
         xy2h6N23CC9/hN6ymQg8Lmt81WJj5GOheR+DFYTl49+fEF9ZhaclmE3nASvtytnXqInR
         NjuFxGuudFH1MOyoTGBhkx9ID/l4at2bLBcNqgXe3ROgyu1qL598r7a2a0TawY+nkhtT
         yt5w==
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
Subject: [PATCH v2 10/75] staging: ks7010: Remove unused 'struct hostif_mib_get_confirm_t'.
Date: Fri, 30 Mar 2018 23:07:50 -0700
Message-Id: <20180331060855.9452-10-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:yGaR3F8wkzEHYfODxguYoh3TJ1inHDdyn0hIb0so9tAQ8ouAumq
 s/vydlAQWcvCo7iwAhFzOtAityFZUp9b1Vm6MRattV6Kdd/XAnYeBZqermXrWpAGYypdz7W
 oooFqx+SnSrHx6mi3w64wz8IS6TMAhrX0arXi54DdNJrEUcH3sxuNiAct9UjlERL2Ft89d7
 Zqz83Ua8M8mSuUQ+nZVTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wrManTp3o4I=:FxXHdmymH5BsVAgvAniZ7V
 4zp6QbHRtiVtrFY5kK+1F4yUVF0KdQ63sRRR55jcvEtffPTB04JDK+XWuHLaZsv5lbrUaTWMg
 PHJcs1Ttk12j62JGQoB1ovGPLl8mUf44W6pzJZ3vHSsKC6gAWB95Fx/Oo8vjxXpUSv15nRKyO
 0SKceUFmPf84AqgGzu4nf3ozx/p1mUJ6idgemjXRo7ua2UpTpZF/TJQXU559IH1FeFTXMjiqU
 spZpAg1kjY2pp2k9DPMnBfL5NGUctv7i+byrn6PN4hCETc2CGDcVhdtYNG674U7HjK+OcjMlS
 VMFgD1o0RIZMCEghrsgbqadoh7QfjYr7QzTYRR+ROszjoO8bMeLUCQWPbYc6hPN5oJkb6Q0Xl
 0BgS5+BHO86huMXsEAOzhYzpZPK1/2Lb39QQ19+9dgnL+5aZpxDQyXd2KEXo050r7HNysnuq2
 pxp22003CALpKuGAXnmcdWRtsjPCoU1wrDP3dRwbv2yPQEIUNxt8xEvV9KaXY5Xxp87OmqTdf
 6EYlNaPbJUDiJFjEtS/4A2uimoya1dN0r126iovQu5Tpn+M3diHkhcwf1t5eLBI1Hubee+KOe
 IDXj3vY0DfAkZ4YLDNWTYipMhs4d1acMtGoE0qZwyuBHLQ3d5sLa6pti6skyDRnIK5vLipjFx
 gIB6cbr0AK9Ju7WL/tLSOVDpp9ljqqRTnZZRbLciOH2s8htDaEonIwtQ142x1rCoFcdwSifon
 crcHQwT0AcVHpwJ++o50dCoDn3iYqTOB3ceZLg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432393507782560?=
X-GMAIL-MSGID: =?utf-8?q?1596432393507782560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_mib_get_confirm_t' is not used in this driver. Remove
'struct hostif_mib_get_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index aedc832bc04c..e6d6c51ccc43 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -151,16 +151,10 @@ struct hostif_mib_value {
 	u8 body[0];
 } __packed;
 
-struct hostif_mib_get_confirm_t {
-	struct hostif_hdr header;
-	__le32 mib_status;
 #define MIB_SUCCESS    0
 #define MIB_INVALID    1
 #define MIB_READ_ONLY  2
 #define MIB_WRITE_ONLY 3
-	__le32 mib_attribute;
-	struct hostif_mib_value mib_value;
-} __packed;
 
 struct hostif_mib_set_request_t {
 	struct hostif_hdr header;
-- 
2.16.3
