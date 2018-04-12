Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1207910-1523544509-2-8829697646553309661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523544508; b=vfXwNL30Rnw5mC3R5hmqfl9bZSeosBcikptLfVrPjP7k8ZS6d0
    ZIJ3l68mE35wlOqUNPWQnymeuPUR2wrb/N4ZU+6CAFy1VYMPEsREkcD+a9WWGr1T
    ZemRaHlMv9fLT/0zZuIvd5UoCGJdq1YeXm2ZL6aOeCpTZGsOd6YGRytVtDFGjORL
    egJ4SZ/ojB04C4gcNqwFB099TxdaSynlVJbjn/xyzbe5D1abMlPAH7dZV3vKFXUr
    8CJYDoWmEdGSgApGjtzT7kouGo2Vlx+iJk+rFo2fpmm9+1SaodUDjmVqTdAmThxT
    B0cchBsmW5kkGb43oO8DDfzRdjFVhnvF9KLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=fm2; t=1523544508; bh=OCLjiVU6QB3tTvcb6u
    4aDxEq0nhvjNUzkI/gRCtqcFY=; b=RLAksajVjlG+uI4Aeitr8F2eo3W2lDpluy
    wi6EQ3FothSngffrc2/aW9rf0dkmBbMCGP5yWzIYu+HrPE5eC2R3uZ2+6+qBKl1O
    Pha1o9I5b5iKl6+rD6kzHLnG4YAfqulIKoUYv83XotKTaACYsduGTOuf7kZYUxGA
    X4Ua/3TM2mulvvBQF1LXYBq45jho+RXNFT+r3lyodfAiv7JXFO4/qR5JRsaEfdPk
    NIEjb7ApQXVxUHtoc9bgu4qzNKoH5MiYJkD2lkYwNrQtFic+QAsQGTI0U5brHk5D
    8rmm9mEK16syOty46yrFEsLekSrDMtgY5IEBNBNWqQ8C3fcMWqlQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=C5+7EAMB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=C5+7EAMB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjCh+GwOFx4DwwMXP4XtxzEwGCtv7cRbU8K7gxoFAdJZMtwlIPgO2JUd33GK5HqDwlDNNEL4yVLftsY88TEtDZOl3JrVCdesM53GPisHSp7G1wQLVBY
    Dd6Ru0/gNMsm5TK920vTQOAszdAKbf3vUUZ/gZcaD0lJO1CQ601DqW40n0NA18eXc991vvIsGynyaZs6EzbAvVOF0FyFuk11SnkeF6RTzaPVb+MSWa0i0p1q
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=Ms95HSm5-DtX0BCDy7MA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=ST-jHhOKWsTCqRlWije3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeDLOsR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:48:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeDLOsO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 10:48:14 -0400
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut <marex@denx.de>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, marex@denx.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_esai: Fix divisor calculation failure at lower ratio" to the asoc tree
In-Reply-To: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1f6dWF-0005B1-It@debutante>
Date: Thu, 12 Apr 2018 15:48:11 +0100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c656941df9bc80f7ec65b92ca73c42f8b0b62628 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 8 Apr 2018 16:57:35 -0700
Subject: [PATCH] ASoC: fsl_esai: Fix divisor calculation failure at lower
 ratio

When the desired ratio is less than 256, the savesub (tolerance)
in the calculation would become 0. This will then fail the loop-
search immediately without reporting any errors.

But if the ratio is smaller enough, there is no need to calculate
the tolerance because PM divisor alone is enough to get the ratio.

So a simple fix could be just to set PM directly instead of going
into the loop-search.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/fsl/fsl_esai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 40a700493f4c..da8fd98c7f51 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -144,6 +144,13 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
 
 	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
 
+	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
+	if (ratio <= 256) {
+		pm = ratio;
+		fp = 1;
+		goto out;
+	}
+
 	/* Set the max fluctuation -- 0.1% of the max devisor */
 	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
 
-- 
2.17.0
