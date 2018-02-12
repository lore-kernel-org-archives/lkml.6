Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeBLRyE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:54:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:42143 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753465AbeBLRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:54:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="27090373"
Date: Tue, 13 Feb 2018 01:53:10 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [asoc:topic/uniphier 3/7] sound/soc/uniphier/aio-core.c:907:5:
 sparse: symbol 'aiodma_rb_get_rp' was not declared. Should it be static?
Message-ID: <201802130150.A223WMAh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/uniphier
head:   db4cb3d04eba91db48da0032c44b83ed7185973c
commit: f37fe2f9987b0460f25a87b1380f8e97a5959121 [3/7] ASoC: uniphier: add support for UniPhier AIO common driver
reproduce:
        # apt-get install sparse
        git checkout f37fe2f9987b0460f25a87b1380f8e97a5959121
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/uniphier/aio-core.c:907:5: sparse: symbol 'aiodma_rb_get_rp' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
