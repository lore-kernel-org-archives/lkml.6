Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBHPli (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:41:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34968 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:41:36 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: Add the DT binding files entry to MAINTAINERS" to the asoc tree
In-Reply-To: <20180205170500.8992-1-s.nawrocki@samsung.com>
Message-Id: <E1ejoKL-0008Sx-2L@debutante>
Date: Thu, 08 Feb 2018 15:41:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: Add the DT binding files entry to MAINTAINERS

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

>From 4b20f44e41b421be608756c395ccf4fcb1305824 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 5 Feb 2018 18:05:00 +0100
Subject: [PATCH] ASoC: samsung: Add the DT binding files entry to MAINTAINERS

This patch adds missing DT binding files to the Samsung ASoC
drivers entry.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87a5120d5d47..930fd1e32f12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11923,6 +11923,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/samsung/
+F:	Documentation/devicetree/bindings/sound/samsung*
 
 SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-- 
2.15.1
