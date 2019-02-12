Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA65C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C2320838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981320;
	bh=2sAzAxLcUkRxOOzyO98v2ASV4VPxUJMj/mvaR4PgJ/8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eyiPQVEv9bmHJruforfmYokj4UdzCLJB/fP8Xb26BCUqxY9FkHiShaoyKoj6dxd4s
	 LsmGFSPfOumEDI6intZ7JfJ88rvV9D0Xc8MyXftf1FopKLJ6SzciJl+7rx4C1TWc9p
	 hfqXoXHo/JPoDC0xispOquA1y+f7DXiNFiVcZYn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfBLOV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:21:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54952 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Nt2OxDh/gEnj7sUhMvapK+qQo/+ELO7PgLCC9mTfujs=; b=ayLaMRdQJoDN
        9aAoXaOja9G25sipUcZM6MioLLXWzKqvB1hqgrPPAmcUEY688EJUiW0Sno1O6+QmqQHmFQsZdG6zg
        XRdpHXQuymX9KLR02uB0IuRwm2Sq59Yn60ZVB9N8OwCmMIL0wadOUH4cT1vbWhjiR1ou0nZAqr1N1
        BsgrU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYwb-0004aN-1z; Tue, 12 Feb 2019 14:21:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7E3621128113; Tue, 12 Feb 2019 14:21:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: Use __printf markup to silence compiler" to the asoc tree
In-Reply-To:  <20190123194131.19406-1-malat@debian.org>
X-Patchwork-Hint: ignore
Message-Id: <20190212142147.7E3621128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:21:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Use __printf markup to silence compiler

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

From 595d2f74cd3caedb704a118bd09c1b4dfbfc0ec0 Mon Sep 17 00:00:00 2001
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 23 Jan 2019 20:41:30 +0100
Subject: [PATCH] ASoC: Use __printf markup to silence compiler

Silence warnings (triggered at W=1) by adding relevant __printf
attributes.

  sound/soc/soc-dapm.c:149:2: warning: function 'pop_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d31d295b540f..dea6fc2353e4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -157,6 +157,7 @@ static void pop_wait(u32 pop_time)
 		schedule_timeout_uninterruptible(msecs_to_jiffies(pop_time));
 }
 
+__printf(3, 4)
 static void pop_dbg(struct device *dev, u32 pop_time, const char *fmt, ...)
 {
 	va_list args;
-- 
2.20.1

