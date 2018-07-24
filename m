Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2107220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2107220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbeGXMYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:24:05 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbeGXMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:24:05 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MOYWP-1fcAhg28Or-005po3; Tue, 24 Jul 2018 13:18:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Aastha Gupta <aastha.gupta4104@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8188eu/rtl8723bs: fix character encoding
Date:   Tue, 24 Jul 2018 13:13:28 +0200
Message-Id: <20180724111600.4158975-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
References: <20180724111600.4158975-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=Binary
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D8XrtA2sBx/niz7hu+e9TTgI2w7i7RpHDS9WyLNgajPOQlW00iY
 HTUzyuM7HjMXcbia783tbCA+Dk6zc7gJXW+9k5MyB8QGwx+857PQ0aKZ9i7NSuSbEhEwbTW
 RQC5EN/JAbiYqaihRKJJ4jWMXEqmZnvzdFU5l2hrKq0BJtMS6zzt1a0A3Oj1NCZvWG89MBt
 vKRDDtsrSMS3zs2Qyr6hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PUzVSxpN2UY=:FSrQlV0O/JymVElY7haICJ
 aXTvXan5EPB57r54UrAX1E+F7KXRvjQ4ZY7UpRpubkE0MDASeTpudTEOtBC5mvrkfNkh89NeQ
 6TIQ0KLhP5HIRs9+PBvpKyDqqDJe5B0WMv4H06cCro1QKi8OOnyJqYE1nocLHAiVPrX5cqQWd
 n+JUzxKaFlU2+Mkp70fh1Y3wAsbGnv8nXWeBkCaVmBTbE2gzgz4fNVteqwSEwGNbBI2hg0duH
 3te6jJlMfYE7qqd3fP0ermzcOH6JxhGQJMGNTHIKPOvjRs6ZFMph8dqqXfgCE5PkJzsqWESO6
 O0PM5WrhcUc4IGz4/4lSqQaMWYyhXyZm7+mDy1Soky/sklhRCDsOiIr09BRSg81PSLEUruzir
 9M+d/9qEpMBnpc0Qk4HyoH17lwjCCpAoauGTkCDI0eCuOjBGEyFdhAwuTHSU/8wlkSttrYikI
 WeOz1OOrMKidxUlixZVwWzvrYI00O/J4V5GPf4cbvgVD0f9dYiYHtvQ2QwSvqTEZOADXW6sR+
 RMhSFugMDqP9y2wT4DQL+g/rEZnThc+bZ+xCJV/5HGai6Q+vohsPAY9mQ0iZbKisHnlP4h+qA
 p6DtuHccZNWijbOV+L7MNa6xOKGy9ncsTQX+Yqd7PieIKenEA0SDZG6YYKOKsBCV4Zugu/oSh
 lh7mU7jru/g5Tyl9MN+RxprRGPYf1PRV1s9Vw0lAq1KpDNrpaE41v3aypXT8yoKQy4lqOlspo
 sINvfT8Axgm8pho0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/rtl8188eu/include/odm.h uses an incorrect encoding
for the '...' character in two comments, which makes it one of the
few non-UTF-8 source files.

This removes the odd characters and uses the same ASCII representation
that we have in the regular rtlwifi driver. The second instance
of drivers/staging/rtl8723bs/hal/odm.h is garbled in a different way,
so I change it to be the same as well even though it is already
plain ASCII.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8188eu/include/odm.h | 2 +-
 drivers/staging/rtl8723bs/hal/odm.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/odm.h b/drivers/staging/rtl8188eu/include/odm.h
index 79affc617f35..947481de9cb1 100644
--- a/drivers/staging/rtl8188eu/include/odm.h
+++ b/drivers/staging/rtl8188eu/include/odm.h
@@ -708,7 +708,7 @@ struct odm_dm_struct {
 /* HOOK BEFORE REG INIT----------- */
 	/*  ODM Platform info AP/ADSL/CE/MP = 1/2/3/4 */
 	u8	SupportPlatform;
-	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/ ¡K¡K = 1/2/3/¡K */
+	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/... = 1/2/3/... */
 	u32	SupportAbility;
 	/*  ODM PCIE/USB/SDIO/GSPI = 0/1/2/3 */
 	u8	SupportInterface;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index a4153a660d32..23ab160ac2c8 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -913,7 +913,7 @@ typedef  struct DM_Out_Source_Dynamic_Mechanism_Structure {
 /* HOOK BEFORE REG INIT----------- */
 	/*  ODM Platform info AP/ADSL/CE/MP = 1/2/3/4 */
 	u8 SupportPlatform;
-	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/ ?K?K = 1/2/3/?K */
+	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/... = 1/2/3/... */
 	u32 SupportAbility;
 	/*  ODM PCIE/USB/SDIO = 1/2/3 */
 	u8 SupportInterface;
-- 
2.18.0

