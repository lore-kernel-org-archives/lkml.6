Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCZPhU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:37:20 -0400
Received: from muru.com ([72.249.23.125]:33934 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752082AbeCZPhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:37:18 -0400
Date: Mon, 26 Mar 2018 08:37:14 -0700
From: Tony Lindgren <tony@atomide.com>
To: =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Rich Felker <dalias@libc.org>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        James Hogan <james.hogan@mips.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression with arm in next with stack protector
Message-ID: <20180326153714.GG5700@atomide.com>
References: <20180323181452.GJ5799@atomide.com>
 <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
 <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
 <tencent_79FD53B203715FD7439C6EAB@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_79FD53B203715FD7439C6EAB@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* 陈华才 <chenhc@lemote.com> [180326 06:59]:
> Hi, Tony and Fabio,
> 
> Could you please upload your kernel binary to somewhere for me? I don't understand why some ARM boards is OK while others are broken.

Well the kernel I'm testing is just current Linux next cross
compiled omap2plus_defconfig kernel. I do have few more config
options enabled like LOCKDEP and DEBUG_ATOMIC_SLEEP, but I
doubt they matter here :)

Then I'm using gcc-7.3.0 and binutils-2.30 built with the
buildall.git scripts:

git://git.infradead.org/users/segher/buildall.git

If you still need binaries, let me know.

Do you know which arm devices are working with your patch?

Regards,

Tony
