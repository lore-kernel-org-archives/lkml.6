Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZrYoTRDEwuz19iQPRlsNrY6Uaf1kNoELglXJYKmz3YD8WV7DYqNk5+w+9gGTxotk0Fr+Q+o
ARC-Seal: i=1; a=rsa-sha256; t=1526575273; cv=none;
        d=google.com; s=arc-20160816;
        b=AyIRbTNWKHv7v9SYmGv37v7uxwgt0CAKcjeh/++3zBhEJBjIA1+EH5SEuqHyP1OMIZ
         L37qCWbIwB82DCZNcwB0ET8YQcrAOTLkfD1zWLD8euLAK7RSoVZEIXkEb+WQThnEbgsh
         1L0vK4DnMQ6R2IQvNoh5H39/pZAyDwSPgoIWSHrt1NanU8Fjl+vLMs3qP+26QthXnKMV
         F2HwsJS8a2cTrPsXlJhehg2JH4rfjS32kO97An6SACeQqo0mkmvxMyAWbZHmhK3C2Lxz
         y961aYh21FW+sXLaEZaXZjT5cKB0qS5xAlWrzVIbm1dbRWszo/cwjTZfhSqQoMAiWXle
         +YPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4q/6cbTqUbjjqxmGWWt8wXXmDGRvL6gBktqItFWdAs4=;
        b=RuZQf+wcnwVqJOq48fK24/vl4Yku9dDSr0+7fnZVzBb/mbtk3OiVnTOw+JTZBSObQ+
         ye+cL9Uy4R338Qhlkl/trILFpV3KMgf547ieL2VQzMog2HEQZBfmNv7ldHIgfRvXvahb
         kTFZYz6GyXF0YrEkNIespYphPcEA0OQi6V2Av7/KK/yuxKnNVFUkv4w3YWsnXb2RXVHZ
         ArcmoV91WGJUIuPvcEKMsMyC4R75QAT3hYhrVK6GbVTLWa7b9e510dphDleGLCflYY6m
         Ko+4bD0SGwENlvEDmFmDeycVqTUhBo5pkHMyhxmrGaNffDMzr7sj99blu1H+BBph+n8/
         95zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=r7p8uMCX;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 172.104.155.198 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=r7p8uMCX;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 172.104.155.198 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, tiwai@suse.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Keyon Jie <yang.jie@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, alsa-devel@alsa-project.org
Subject: Applied "MAINTAINERS: update sound/soc/intel maintainers" to the asoc tree
In-Reply-To: <20180516194901.8128-1-pierre-louis.bossart@linux.intel.com>
Message-Id: <20180517164057.EA3AA44007E@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 17:40:57 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600730193996459134?=
X-GMAIL-MSGID: =?utf-8?q?1600730193996459134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   MAINTAINERS: update sound/soc/intel maintainers

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

>From c90ddb69d4b24bc32edf9c7bcfec85e52427d1c1 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 16 May 2018 14:48:49 -0500
Subject: [PATCH] MAINTAINERS: update sound/soc/intel maintainers

The information for Intel SoC drivers was not updated for several
years. Add myself, Liam and Keyon (Jie) as maintainers to get notified
of contributions and bug reports. As discussed with Mark and Takashi,
I'll also monitor alsa-devel and ack Intel patches as necessary.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b62e6cf6b1c..fc29793c2f67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7004,14 +7004,13 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
-INTEL ASoC BDW/HSW DRIVERS
+INTEL ASoC DRIVERS
+M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+M:	Liam Girdwood <liam.r.girdwood@linux.intel.com>
 M:	Jie Yang <yang.jie@linux.intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-F:	sound/soc/intel/common/sst-dsp*
-F:	sound/soc/intel/common/sst-firmware.c
-F:	sound/soc/intel/boards/broadwell.c
-F:	sound/soc/intel/haswell/
+F:	sound/soc/intel/
 
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
-- 
2.17.0
