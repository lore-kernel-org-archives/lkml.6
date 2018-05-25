Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966981AbeEYQDH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:03:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966645AbeEYQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:03:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: omap: sdma-pcm: add module license
Date: Fri, 25 May 2018 18:02:31 +0200
Message-Id: <20180525160248.4135506-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:IWMz0y8rVcoY6R+HzOD/0NuqmO5MMLX7f2rNrT6gD0S9LXYkAqv
 Yrm5YY9h3xpZqMKYsfHP+NocV6WVkcCj3kLpS+Qa/n+cs+v0UjVto1Iv8oE5TxPPVJAqzIO
 XqZPD7/d9LQbTx+n9A1eTmAD7KG2ZNG8SgaI21dNof5P8Xv0NO1hJaBKgTtNADrqsO5yye2
 obCxrvyfEaMP1Y11L/R4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K1s6PBV6N3Q=:8H5zNVOIgI8oYYZNlo96rp
 ttICSUVLHIzor2f1BSsYk5CMbkk1uPCetTwEXiWqbpcIHl4iNkzWAuhZ1Qs7XuGgT4JgeL9Oi
 EGXIoRboG3vpkrs3XYfCEbzldyl/yAZI9J3YFZaFPBvsdtsG42cLeXMhBvEW5aFudAf63pMNB
 Lec3RQLxEVFaoyORvMs+W2b7KuSbH2OeUIoP6L+QRu7LyAPskF5HKJcdy74uzCgZBD5zfabrk
 4p/kyTqFuf3pC+4MO0TDQhI45J62jWY69pKUOkQ78MObTjIsftGXmQ6t9wExmDW9atATludra
 42lxB1Ya4yU1rqUKOscePNx+VhvQsnZbH4k8a7t4O1DU0FrAOq6ulNfQTZNJOJlkaZGbQNp6E
 ldu1ZEIvTgYw63vK+bwSgK5mCLnsORzxY9xsH4Th25Nnwz9TG7pVlXrdv4uoOK5fWj685UJXR
 p6L5nXjXDPtKIMg+4oKv9CchrsP3XoZDjrq65i4zkPUqD4vB12+r+NWH3reVeuExtpxbnROAr
 uzzNKvJp/X9IWzvvrzup36ikKnP+AFkcLYIjXGF1oAAJ7buka/qHhyucCsZ5ZkhSmSB95HZ+y
 QxoLlPZV6IPi12DCi2DGS2VCXwEjoBpSFW5oKlpJ6ZCIS7O4LNmQe5ADDBGAtOOYYpzDjastU
 ggK6yEFeS82bYEJEl7Y6XPkXoSNm9cWZysWNmMAEFs/CYLuIOcN4z53m8IwDURfXJEtM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild warns that we should have a MODULE_LICENSE() tag in the new module:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o

This adds both the license and author field corresponding to the information
at the top of the file.

Fixes: dde637f2daf1 ("ASoC: omap: Introduce the generic_dmaengine_pcm based sdma-pcm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/omap/sdma-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/omap/sdma-pcm.c b/sound/soc/omap/sdma-pcm.c
index f7b2b5b69d27..e9981bff8bd2 100644
--- a/sound/soc/omap/sdma-pcm.c
+++ b/sound/soc/omap/sdma-pcm.c
@@ -4,6 +4,7 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -66,3 +67,6 @@ int sdma_pcm_platform_register(struct device *dev,
 	return devm_snd_dmaengine_pcm_register(dev, config, flags);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
+
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.9.0
