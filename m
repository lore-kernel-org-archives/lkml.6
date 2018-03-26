Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48omN/uLPeFdzV3fdAAUrU6gHJnhv1h8E9hm9tTD2eVCX2O+6ZHAm5TXgeIS9DL7T0epPZo
ARC-Seal: i=1; a=rsa-sha256; t=1522055933; cv=none;
        d=google.com; s=arc-20160816;
        b=UJosMD+JRBqs/m/LDUASVBW8rcORxoYyuc8qKPzIMifou+RDODClPsXGwvCG7kTWNz
         IffZiYAlBsBNa3+FfRfIT7g4Vxhdpf7WSHLoSD4sYRzXSaQ55B6E6/iTjDCma7PKy3zG
         Yq/3g9Jlc9/hFN+uWvPbwxiRF29BwzsE2a/2JBXAx2h3iXK8RZjXUZSpjme2DW/Bnxlv
         J8p4OfVCr55DcT2O2DvZ86dVrFrNNBrrOC4+muws/pwQD3kJeKhPP+rXfadflwccv4gY
         UKP4uaiJMQUD5tHGiEnLgxK0hO5ZIXUQJDmUVwhAWMYHGsSHYXZKyBsqFUsqRcux6iqD
         aYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2/hF4uvcrhoYS0oCMXZTWCUDx0g51K+RnEBR1pdDJC0=;
        b=Tr8hvPukJs8pBK2QarlgDlSb4zrPWV3Yn18yEAGWplFpBZLS+xPnzxELaHgCo0Zs+b
         6QpdiL0TOobREt4O6on6Y1BUR7wuRXF0W7gOt6IOyxMIQotUoNO8vZzInjGeswmwzDG6
         cr9JT980NxoHKXpxsSK8O9at4b2f5jGVvBOqMA+wNQKeYYOFy1U77nmyQogoiAOGtREW
         94tZ9HnAjyZdGnxXA2OKAnLRdRJc15nXr4IdOOVOGgNQI7t9J6gEjHQ7LWmO5JNXrPxa
         uaulPJ/r40xhHSMHgW687E42ql2gyhdcyYo5hneAe+4BsNGbodB4aHaL4xDD4wOAodZk
         ShZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: lkp@intel.com,
	gregkh@linuxfoundation.org
Cc: kbuild-all@01.org,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH] staging: rtl8723bs: Remove duplicate #defines.
Date: Mon, 26 Mar 2018 02:18:30 -0700
Message-Id: <20180326091830.30132-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
X-Provags-ID: V03:K0:9azq8aBpn/8VhhbTTnQnjeV/m7bF0b8fyJo91zik8TUESvpbtr7
 HghvSWH7YrSr1ILqTl+BTn+I81uwlVuiJzmz9zewr2gKPxy96uuSzZJ0SsyBhT86xzfECa0
 isU7T+yluNhvVUEIty7GCkXglcnoNxJ5z0YUdgaK0dqQb3vVlNI9WUCmltueMjXYAJiNrFP
 Y2BTb0i3FlEDJgb3k1mKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:46R1lUJ83x4=:KS2Ix9WRkPcmFJGUJkvEjS
 PB+pABQ+Ucv8LPCVtfUQO/X9rTOi9vDRVpgvccFs+vd7mODa6HStV2+wO1WvrdoN5PGL+CSER
 0xncg0uEGn9wKZfIrw2aksxdDuPO92S6MU13KuGlmJiyxsd8DVXiyrnx0yFMYFMmVP6f91zUv
 /aK4q3nHqZye7lEHmOuIIMq0HuUN5EdkFHdMfyySZmFcDyjqb4yla1CTbqF0j9AsBGU1OaMci
 3g4UEJQ4LoaWn8jA7kaosnDVAldcuXNrj/C48hNkIPFCpgVcoPENHLiM3KIPVqajdeQ3C0Cb6
 SNVGk6OMA3SHlTRDhqPOoEsidFnBViygmnE34cyNhZBBX97sOxkipt1SZO6A/vlCrKZgMlu5X
 CmJ79uvCaLRw2wDddz62wTjxMv0G8wycnwWV40vGmp6upROF4ySwz65b7+OyCEEtcL/lWfvaK
 MCg8W8cpUBHBJCuLI8u/uAFFw5XuMzsDxx4nw5vYGIp1asOEtsKkm2tSSTdUKzYzsN3J1cSBX
 h3gSxNHK2VOw4MH2pz8IyvXrDHvI2gDviDD8nZdmi60iq3dQgmQscmkM3QMpJK/E+ADByGLjz
 ypFGNND+sx5YYBx54K7vX8s6gJ1HxWI5J5b7Tbo6uwS07776szXrH80Yz6sQoGl+3AUoajU42
 E6wS6aPMib5EL4V9RTYv/JYKBq9Ey+ZqBBh2fCGEU0BckeMyzsvCUiil2zpZ7fwPCKD6QPUn9
 2o71bLJdS0Z3Pov3vCeG71+EtBFhy+sZe3CmSA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595991322054206590?=
X-GMAIL-MSGID: =?utf-8?q?1595991322054206590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The modified file includes 'linux/ieee80211.h', but redefines many
constants that already exist in the header.  This will create a conflict
if the values are ever changed in the kernel.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 73ce63770c3c..a2402495f447 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -435,19 +435,7 @@ struct ieee80211_snap_hdr {
 #define WLAN_GET_SEQ_SEQ(seq)  ((seq) & RTW_IEEE80211_SCTL_SEQ)
 
 /* Authentication algorithms */
-#define WLAN_AUTH_OPEN 0
-#define WLAN_AUTH_SHARED_KEY 1
-
-#define WLAN_AUTH_CHALLENGE_LEN 128
-
 #define WLAN_CAPABILITY_BSS (1<<0)
-#define WLAN_CAPABILITY_IBSS (1<<1)
-#define WLAN_CAPABILITY_CF_POLLABLE (1<<2)
-#define WLAN_CAPABILITY_CF_POLL_REQUEST (1<<3)
-#define WLAN_CAPABILITY_PRIVACY (1<<4)
-#define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
-#define WLAN_CAPABILITY_PBCC (1<<6)
-#define WLAN_CAPABILITY_CHANNEL_AGILITY (1<<7)
 #define WLAN_CAPABILITY_SHORT_SLOT (1<<10)
 
 /* Status codes */
-- 
2.16.2
