Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeBLRQ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:16:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:29139 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeBLRQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:16:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="17089318"
Date: Tue, 13 Feb 2018 01:16:06 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [asoc:topic/rt5659 1/3] sound/soc/codecs/rt5659.c:4048:6: sparse:
 symbol 'rt5659_intel_hd_header_probe_setup' was not declared. Should it be
 static?
Message-ID: <201802130145.hD2DgN3c%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/rt5659
head:   de86a33253d07675abbb1fa294ffb4f3df6f219e
commit: 041e74b71491acadad74b275e8b05add165d92b4 [1/3] ASoC: rt5659: Add the support of Intel HDA Header
reproduce:
        # apt-get install sparse
        git checkout 041e74b71491acadad74b275e8b05add165d92b4
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/rt5659.c:4048:6: sparse: symbol 'rt5659_intel_hd_header_probe_setup' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
