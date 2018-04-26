Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbeDZH2w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:28:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:36066 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753000AbeDZH2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:28:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="46164949"
Date: Thu, 26 Apr 2018 15:28:46 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hao, Shun" <shun.hao@intel.com>, Philip Li <philip.li@intel.com>
Subject: Re: Makefile:636: arch/score/Makefile: No such file or directory
Message-ID: <20180426072846.pa72ohtstnyjsa42@wfg-t540p.sh.intel.com>
References: <201804261013.6YZ6XwpM%fengguang.wu@intel.com>
 <CAK8P3a0tpU7RFasJUuG7V2ZYUoR-iYDzjO13neF08ToAdnLX+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a0tpU7RFasJUuG7V2ZYUoR-iYDzjO13neF08ToAdnLX+w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Shun Hao.

On Thu, Apr 26, 2018 at 09:15:01AM +0200, Arnd Bergmann wrote:
>On Thu, Apr 26, 2018 at 4:23 AM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Arnd,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   26ed24e429d89e045e5eb2d2b75215244347b7f2
>> commit: b8c9c8f0190f4004d3d4364edb2dea5978dfc824 arch: remove score port
>> date:   7 weeks ago
>> config: score-spct6600_defconfig
>
>Please stop trying to build the removed architectures: tile, blackfin,
>metag, m32r, frv, mn10300, cris and score.
>
>https://lwn.net/Articles/748074/ has details about why this broke.

Sorry about that!  It looks the architectures removal is not thorough
enough. Hao, would you help take a look?

>Note that we do have a few new architectures that you may want
>to add if you haven't done this already: nds32 and riscv were added
>this year, and a couple of older architectures that didn't have upstream
>gcc releases now have those, and I uploaded gcc binaries to
>https://cdn.kernel.org/pub/tools/crosstool/.
>
>This should allow building everything we have in the kernel now.
>Unfortunately the nds32 toolchain I uploaded is a little incomplete,
>but I have a gcc-6.4 build that (mostly) works and gcc-8 should
>be fine as well once it gets released.

OK, thanks for the tips! Philip may help plan add the 2 new archs
nds32 and riscv.

Thanks,
Fengguang
