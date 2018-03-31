Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+K2jr9zC6GKorVV8NuZHLasToKufK+2dUORcF+1wDSMZuMK1dnMtbrojfenZtY1pP/kSL+
ARC-Seal: i=1; a=rsa-sha256; t=1522476576; cv=none;
        d=google.com; s=arc-20160816;
        b=Rcx3tmIUCurToSUpJ8YAnbh+aGeFe7/+thZPEbJBd3OFGTXXMBna/uKcha0+zDfrFL
         Ej0AOTwF7/EPX8oMyn/7UvjpyEzaKndeKj63VPvs5x6LnZrvAmDIFAg5cq0cTdJ+vTaS
         z3EfFkKCnJ3K0kGFNel3MqFF8XB/YhoQ0pao1wFfXkLNZm1CrxTcMGIv7gZGE+ptaDsM
         jkf7jWzUC/p0tvGZUUohK3hpMyvtaU6AFN1gA/30dru42TFc69kvoGs1Pqzu1qDXCKQi
         utkbYxA9noLdSDOmvvhLG70UXmsublgNFw0TaYYNFP2Ghq2TJtb62/VdvK4q+KKW206S
         WZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0wyJVZWrUhA5KuWQk7XpUdfgiAEWCpzYcfX1JIIOphM=;
        b=RhzRJQqvavFTSV/5rG730MIgN+jc+n8amoVjUWGUgg4pMxNoqyZmSDCtOD8/JZjKEi
         Ic77yLVT3d7sLyYzdvpKtgMWX6wWU/+iNHf/PrAWQTsAYpmLXlvmITKZAQCxDkrUruKE
         fFNNfg2QUJse2KXGuCRj0wXkv4N06m7awXddbbsKJSKz7RSw12Fkippyhvxv+nkK3saQ
         BMWPRJDPFFiMIamfmDC5xDVYkiJakLT3vkmRgPNyJ+7YvxJnmNhP5WyQDwc7xvWluLcT
         62vnmEvaEzz+qQJKtqcXB2MVgNwrywE9mPxKKmpGYhf9b+yb+Roa8BKuD6wChxy60BSo
         M1Bw==
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
Subject: [PATCH v2 16/75] staging: ks7010: Remove unused 'struct hostif_start_confirm_t'.
Date: Fri, 30 Mar 2018 23:07:56 -0700
Message-Id: <20180331060855.9452-16-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:5DzRLvNYoLA7x9f0pkhRKFkuQvLz5qhbNlgRcNOYp0oUtq/TMwT
 0F8DnABruHMfW8T5ahAVZejaDDH4vaxkRHhMcEAL2Pv28RdboqNumB7JwJYnym2cy5ZWh0O
 CgrnUCe9LSFkUio8+d950pKDJK5tZwULXwgkF+H4DW8NMGeZ2Fd2UTmOzyyFI9GaVTUJSwH
 jTovb48egs4zr87TUKCMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u022aPjoSlQ=:E5HSO1/2Ek1RkPzZ9/N3Rd
 Scvz4myKI+SNzZER9+8BcfgDWUQ1mL3gufkKruryaFWnI9wD2/pyh9d3H9S5UEMZmQTcUCh2v
 Zom36i5ThBDQsLCEC0rgWe5cYI70ApXnW58kVkuNi82GKWim0bcl44LmxFiTwMsuJlfDE3rtA
 FIQIMCBmkV72LOuGk09Tl7EzUZTesUaO/eASFOondGUI268yhVHfAYRmrOLVMmG6doACZIzlv
 msQeHQYHLS4ttUCaBz62LwpvKbGGv/P92JqlYf+Zdeez2Nf0UKtToeqKfBzDtJ2jotSx1a6tr
 7oQh9PweVmXPcLS3IcBM++bZtPy5H7AEYpqXa+0HQRpjoFJG282dLPQ9KFyAfGbMgMFCoP5ti
 6oROD0V7XxyQr6MaDBfNDL4avyIdVRBrlcZxDgm/knDKMnLrlqD8q4IXJgESWFTROAukU9Yud
 lSAyvNOw9IgEOLwUTzrgjHogBMIV7FctApaanD7AK0sv3SBDclufvgK/yLDlbU2EfjXD/fr3M
 XKXGuajEL7bxhcdas7Z96VjEnbsII34MtXZOWoxTlCSzJV0B8O4NhB3DYFi3/W94aSP+ty2v5
 i1NoaYa2+E4JI0kRPci2QNCherKv8gDXGHV7Ijut3ZIUavVgsuJxWp3SYv2+k+aYI3J7mOmjI
 h8nFYSxL0xU1xLlSRq5JBNb4EuG2+GpWVedQXxQuL51U52eQWG5YwqSOMO8C5CmX17iqEI88m
 s+hTrM0M3txSzeE+M7hB/F9oNaM+2/0Rj6i3bA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432399111316124?=
X-GMAIL-MSGID: =?utf-8?q?1596432399111316124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_start_confirm_t' is not used in this driver. Remove 'struct
hostif_start_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index ef1e77b40e4e..af656a839a0a 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -196,11 +196,6 @@ struct hostif_start_request {
 #define MODE_ADHOC          3
 } __packed;
 
-struct hostif_start_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 struct ssid_t {
 	u8 size;
 	u8 body[IEEE80211_MAX_SSID_LEN];
-- 
2.16.3
