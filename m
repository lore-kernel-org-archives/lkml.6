Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759762AbeD1JW0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 05:22:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:15285 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759657AbeD1JWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 05:22:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,338,1520924400";
   d="scan'208";a="51536664"
Date: Sat, 28 Apr 2018 17:21:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: kbuild-all@01.org, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        dannenberg@ti.com, afd@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: Re: [PATCH v2 3/3] ASoC: tas6424: Allow disabling auto diagnostics
 for faster power-on
Message-ID: <201804281505.b24ElkrY%fengguang.wu@intel.com>
References: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jean-Jacques-Hiblot/ASoc-TAS6424-Add-support-for-mute-standby-and-faster-power-on/20180428-113427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tas6424.c:61:1: sparse: symbol 'diags_enum' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
