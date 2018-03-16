Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2161282-1521181891-5-11853622188231994543
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521181891; b=jlcGoeWqnNN/prVlSr4QQeHcOnStsNaH2X2it4sqHoyII6r
    eT6J0DiSR+OEXbSVhaHlBJ6DNa8vgXMD32okw8v2rfoqGK9iezQVJQcwoDxDJ8lv
    V1N8Zriv1OlueV19EHWSP53mbNRZtim/PS/EEsUr/KPacgNGxhX3EHnsxaAx9SAQ
    clr3Biu6lIBpkP0UaC8oswX65652OYNGTcPcUrhlLD0yAyW2q8tVeadPeji3oGUN
    5mXyLKdyJMoInD/2LNOzf4lyghJOufg/pE4DiSLlmId/ZLtfgzh1PFNT6dF+v512
    LSj7pw5cUPgIDhYzsmWhBxiZ27ksgstWBuQtDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521181891; bh=U
    /O4Ss1NFkeaYUoRZOrkyQlbSmSkJPN6WATF8V8lD5w=; b=G7Po/jCAfqFkCmnii
    EQ9RfF2L0l6WQr/MKB36gTmnKetfBLZsJoPq31B0qDz7ZhDA1K7+r/2RHAcmujcl
    Y/+e2t9u8O7ZM3G/4q/n9jL1gjZsRtjfXvbK8lX7yFpfewANkD+VPPxDFwoYIqWw
    YqG0F2MxLuJCF6WayfPc6aah2CP2IX+8FOWHDvPgOgtLBDjFdTTI4ld/IBQv453c
    gQtQ2KvsCUyFT46novNbm8vkgFHvdtZTBkZHlyOjb3Bb1iszrP1j6V5sgFlcr+MT
    jC+2oGKvnP9OYvlZgfBdgdYjhE7R+LQja7YhAr/PLGpqe8V+hQD3nL6RsN9P79Gu
    hUKYA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 5/6] staging: ks7010: Fix line over 80 characters.
Date: Thu, 15 Mar 2018 23:30:34 -0700
Message-Id: <20180316063035.3037-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316063035.3037-1-quytelda@tamalin.org>
References: <20180316063035.3037-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:nKfiAL322gHwX2UjJjJ+Tc9WxlRVU0wdS4loxpB07+ftrz0/sOQ
 /IJ9CID4896A0Rtzf3gflEVqJy6T/dTlYIa1MQecKksVITwY6HfLSoumc+zzwNHBtXE7D2E
 xxatz+u6UN5ZOdOM/HWH2llm7SmP4hIlG88P68cqOFPqxX+iDySa27CsxpDw3Ofv2c+xcyk
 FNe1GmZj5RxrNT5y7Fz5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0RjiMdkZYA4=:FEFXawoLw2CNnE2kWEfFSU
 cNhjKB67gQZYj3ubqtaf8ICMAgcExztzBxcirDw+SDiQ7S9Y/SXmgbkwMa19w3s5P4DQFUMMa
 amGE0iUbsOmLuRIkgmmvaYtmr0ytdacSRyWvhqstNkTmw5TKOZY7cf4yovBZSPJHjDN+bbvMp
 ZK/y3Z4PpN/QFDNA+/HPUKg8F4q+1STEw9oPXankxFknfCeusi2maox3rHtmDnXbK3An6WkG3
 GqJqkNM4lim6EdCowweTRYHtPsc6saXW/odwAIJ5uszyFKiZdhHaMD2QF7H6O8CpZkh8K0y4E
 lNhxb7SXoiFBfYQ44bDqU3VFRlc4WRGQzKZvdaCt3fn/oQVRUrDdi3HKI9YLpGnJA7dREEHYP
 IbB4hFaLgTZBMxyTY3UsUf9OKWfELPdnyXiNn3mrZFrjX1aGeF+SAFHIlsRo4TADli8TizMsL
 TShj5j+uaW+dapnj+o1uWiAEfcF851yzwhmfZR4a7fYMPDrD3aISQrJRpKED2CkH6ym6l1quu
 rk8RHo/DJjHsbo1Njg21mwxF+VAvnZzmcs6j2BFmlfNdyPcveVixXqgbO51HV6ztJc4zsiEd5
 Uq1N+WkFkdj9ZjIjaVRLyDiTzx2NmuTgJJr6ux7dhQhbw2rNg4bOF3nN8xuKkvNheotAf87gL
 U/ph7kj6X2iOTzpe0rDHqkaWz6QKcg2Q9SYZFiRBfXVpqQHKtU4aZDVmj+c2MUjHcuP+a6hQn
 VPjG+A9HgSC8Uc8lv0+cy7mgMkJ1jBIEZRDECg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no reason for comment describing the BSSID check for loop
to be spaced so far to the right.  Move it above the for loop.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 2de4dbbcd9de..6fc2c3647908 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -844,7 +844,8 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 	ap_info = (struct ap_info_t *)(priv->rxp);
 
 	if (priv->scan_ind_count) {
-		for (i = 0; i < priv->aplist.size; i++) {	/* bssid check */
+		/* bssid check */
+		for (i = 0; i < priv->aplist.size; i++) {
 			if (memcmp(ap_info->bssid,
 				   priv->aplist.ap[i].bssid, ETH_ALEN) != 0)
 				continue;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
