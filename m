Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48eC7+FcNCtrSs1gMM98VAKjnjvsFr1LGCTryN8EmZIcG4q8vJtY8dVQ7sDSXXh9jUFmPps
ARC-Seal: i=1; a=rsa-sha256; t=1522476597; cv=none;
        d=google.com; s=arc-20160816;
        b=n9nCJBdy9Y5B+sMhizzWuLwUmPhCaoy5hVSDzsmKHx74jpkZ+XxvhWoyPY8Vlic8gf
         7xWQXAjCLCkhOInt30Jfx1r9X9XR5j2d4q5q6MyPU46niHIq/4su6lNep1i6TliWh2Pz
         Tmqn7kqgcCQ2O1j/XUOqX8E+JDK71LQy4VXfvPospva5LSMlMv62vGNpa1M9YBPvxKAg
         WJ/C3RcaJPRpSwNyJX5xa+yLQvc8Ehuy7QqJma1pf4FqpTpC83nGEa4sHwQYonMOGlBM
         VL/eMiyXAGwA+9W571crQZtXpp2xdKE91Z1ZrxuJSWzoS7YYF7bc4+kQOO8PQTh8w7MN
         y4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=LM84dWckC/aUw/M/ckkXMUzh3+GJdO2fw+DFmEto550=;
        b=GweV9suSV1Xzq/EaaYpKpNSjxWgiiy9uEHR94PzPqeQm0PBoPEFJNwi1N83MOE+OKa
         GxOw7LZMTJpTnXOYy67s3SYIHjgPXextAz09tII9JGnBXT2Q0hBqF6y4W2zDY8ny3JEv
         oFPi3fSOmrsXAvxviQim869ldmKPB8c3Lg2VeuyM2dnN/6rhG9wE+Rx/AurWZcLDvEku
         IKKZZFy7A68RXdmT0WPWXaA3GUnnkby3aKIiVfLd4o6Gjby2ZMadqVEFl1uNhy7KevTH
         8z+toOFpxcIscxAdj8Iwv515Zyr+MkZCYfI6PWcHFBgr4PkKDwG3ZJslFOo2dufOJlnP
         Zxlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 39/75] staging: ks7010: Remove unused 'struct last_associate_t'.
Date: Fri, 30 Mar 2018 23:08:19 -0700
Message-Id: <20180331060855.9452-39-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:1sR1DRPS8tVNJJN2L+quR+EVyUUbQtfSddu0BZkcalhct8nI/Mn
 Z6sIrq3TYRp8UBXO5fmGYDcCXaSbiQPtMTzTHWZMSvU+gI9XzpRg2X5ThCWFZRbKVIsxLFS
 hQmf/bc/Ag+Yo0lNjJyg6KFLKw2XSq4i3CIecmtQihsBsU8LkTg5xziWj3FqAMowiSfsRTJ
 XFJWsFdgda7SoILurW0MA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dTNoEGhrL9M=:gkL7WM27mubh08Z5aGBkC5
 AfCcuiXCOMyGLdAn1l3HNiSzAxOnPI6fmcUDF5r1UiBABJtrT1sSa/CJ32PNwbREzmaCliMD7
 vS7T1Hj07Ny0Y4yzQto+II9HZ4AasY+pfNxrtboapfhOTguT4iXyMCvwRBfEwp5Ez/hmqJpcK
 4lxEkpJX6fgogN9oBce8t2SkX/vG2jdq1NuT91x8tTMIipkSumcL0iZlzUnEZDH+6z4+pMAvx
 Q+rSZZwLOpTnaKXEvX+mSDn79XDNp4demb9MKQg7rMmwAuvbKiP9bNQumNW/d3pcv9uxqTzbK
 q2JrNtSu4ekNWt+by1z9j41a3Y2f507j73C/wGuNP+P2Kj8HHzoO/kjkfkaQp0ASom8AbGaHk
 NMfqSKJhf7DZTL6UsuCeOZDebL6jDF9DxDMuRgTj0FlbYeRYDV77D/7x71Fxxq4GDVghz4GuO
 zXrKMltWzlg+t8k0+ijcqjonEdgVCrdtNSaMSLrcsPlRpcTHIZ/4nrv73a8IyoqyKK/aYaGVy
 RzqPsVfnx0s+fV8h7iIbFqAC8ASy2otv/te0OollrcLdp6n6Ju9c3yefEENo9dmPHdQbgO8By
 VIgoQZASpTNhqjekNapemYAk8QWVpJvR4LZClx7+3wj9einBpkv68MJc0TMkT1m3fOztH3kNW
 XT7ZrFfPmUegg0RaKtK1Oz4Yiq4YEK4eOBmW+hVu/ZuxdLRWPHvOx8YxVDpMB7QYB45Xiq2em
 t1lE4j1qWQCbvd+o2EjWNe857L7ohXFvVrPcgw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432420588846523?=
X-GMAIL-MSGID: =?utf-8?q?1596432420588846523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct last_associate_t' is not used in this driver. Remove 'struct
last_associate_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index ce9f29699fa1..50584a1d2a6b 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -371,11 +371,6 @@ struct hostif_adhoc_set2_request {
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct last_associate_t {
-	u8 type;
-	u8 status;
-} __packed;
-
 struct association_request_t {
 	u8 type;
 	u8 pad;
-- 
2.16.3
