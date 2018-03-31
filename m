Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/LLEDozPPr9Be8LorMaXgFg7D9t7q8pAiE81EPvOar4kl6Pk6UXo9vuRT2gycA8YWj94xs
ARC-Seal: i=1; a=rsa-sha256; t=1522476565; cv=none;
        d=google.com; s=arc-20160816;
        b=NrI99RicS29fc0cA6aY2Qmh7WmgY+DAIg61uE4aisFlKUyClPWUbjqFYGWJrJDqKbZ
         vLj6xjR7HrQFn8YzrOxuxAJn1UJQoFB4Tn/u00guqOCHyGOmt8aaEgNoLG3YHWvg9HfG
         pia9KluMNn8E7q7EI7+Rbklgzmd0mLtb52fwmn0fsM+cZw84qiKWbuWfeiwpr3toitex
         keUjrV1PTgzhWuzVSUKnVSinTrRtsjox+56+qrgQ8gzBsibmP/yexRO1QdmSQ9QGjAFS
         0hvRnzWn16mH3HyLBGdXwAnKpNeXPF5mo7I0E5R1LJ0iaS/oRLbclkb3pQ4JlBes93+m
         dY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DfXOvFSVOIMBsO5+1mVSV7GK7pNwdW19Bb4ScPJ8s40=;
        b=SXbIdDC0Eq9L93OFeGLotBnTe7d/viLbMu6MMmyQKw2YGBVxyairJsnNG5suFmN74n
         zpIn1sDCgVuSIeIHQzxx5tEZR1ZaBecWsbOXkoJAbB9p/LSWo3qR2136dnm7NNr+SnUI
         RahECQPtbW3KR/OKjQb8r6ORLda8aAHHkyEbv2svpWJoQsFR3qVUezWky2heWz+ospCB
         Lhmg+vA0GDFaySojcBglz0PJLM/FfUYydc+rwNeMsKEmWRl0sBKU9lO/COC2eUmN3JJe
         ub61Whq/gIBeHf5m5QVfovjfR9tsHvckJSiGHXP0Wxn00sTrOpCz6G6YyJmx2gRwKPoC
         /hog==
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
Subject: [PATCH v2 04/75] staging: ks7010: Remove trailing _t from 'struct pmk_cache_t'.
Date: Fri, 30 Mar 2018 23:07:44 -0700
Message-Id: <20180331060855.9452-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:fAsCYEdOnB4wBHYXcCHc6A4mdhSvvgNGJygZ6cDyRE+xN3uAS/Y
 6IKBBZ5JmckBz/7+CN3Rr2fOl8XaUtyThyEZMTRJDO55rE5MhLw1rn8aXTBbaWBWUmCyybC
 wBvsaWKpzdKH6llJH8T2xBFHRZRGpfoq1Vg3jJyraG3t6lxtq1dMYic6lU9Wkd/pwq0AGpG
 UyZd/MvPtdGHPRp1TIcTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u2l9I/etlnQ=:0R3EWbA1j9nTB2Nq3cSH3/
 GSX9OIxVM2Y54XyHoyEsG3dep/W+niPzosptaMCRDcH3WeLQvYiIXQ3bTDVLFT/rP6hIpMlLd
 j4IPvdk+DL9FA7D09Hhhbmn5NECqarigOOVtBr7fUy1AcRKxSzaJGuaArv6hG76g3Fk1csDJF
 p7zLeZldT7dOn6eZMw9/6EBaJ4UhFufxXQC60sdSdKkF710WKQTF1f9WQ6kXm34KicUwSlfXp
 akbxpRjrn6l7+vBgo2V2wSYziW0/OMFVQf/++v0gdD9UyC0V9q0kkBLgJ7uMAsSruG3RbSj4X
 0GZK2O0kZ1tKsm/EUqqZV49HyeybdktBNxPE0Y887N7+UsDsdljFU1B2z2Xt39BDa3Vvp7ZAa
 w5DZWS89L4ibgYewIL8zjybkR/IIA9EHzYKJr2Mftowb+ZN73ECeBbna3U8DUgBkkkW2SH8n3
 C9N+dNXi+ofgByZN/vHggEmkfa9Ze0/GqaS0mDplAd3mfF/pfKhZjGhkVfsOKKp9ybg2KPwDt
 izgRJoKJA/v3vGEyLZ3f0j1d4R9hJtw2hxaJnkBbE1xTT1K5HLVPMovCIAGYLk0uRX+C8nlid
 vL0mG4DUNEBleKihAh2zVGB243H3UMbN6EjF2DraOslX86kEjQ+fq94oefUi3GQ62ZMI/Y/4L
 t5N4qNdlRxK1LfhJEfvGEiCKDcn8yV8GbItJudmc0ncmj+4VXfntCnd2PnKxEVWXxnATdt5kL
 pl84SIpWklSWyA7yMCMhF+0eJg+vhmSH0EsAXg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432387201576846?=
X-GMAIL-MSGID: =?utf-8?q?1596432387201576846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct pmk_cache_t' with 'struct pmk_cache'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 8c269624401b..b8a9d242e95b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -2123,7 +2123,7 @@ void hostif_sme_set_key(struct ks_wlan_private *priv, int type)
 static
 void hostif_sme_set_pmksa(struct ks_wlan_private *priv)
 {
-	struct pmk_cache_t {
+	struct pmk_cache {
 		__le16 size;
 		struct {
 			u8 bssid[ETH_ALEN];
-- 
2.16.3
