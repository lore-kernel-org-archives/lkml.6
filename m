Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932552AbeD0ND2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:03:28 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35789 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbeD0NDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:03:24 -0400
X-Google-Smtp-Source: AB8JxZqm4tiFTvMhm8E9G+VApzJBUB3tnyRefNi0HxfJE1KzpfKolVh0rBjDUuEGx6kjDAy9KfdPKOfWMy29tZvvEIc=
MIME-Version: 1.0
References: <20180425214307.159264-2-edumazet@google.com> <201804271455.cJQuTeDc%fengguang.wu@intel.com>
In-Reply-To: <201804271455.cJQuTeDc%fengguang.wu@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Apr 2018 13:03:11 +0000
Message-ID: <CANn89i+gKvxN1qZSrM8oG_jz-HYXt8iMRt_mpf6Rcx4-u0=WfA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 1:45 AM kbuild test robot <lkp@intel.com> wrote:

> Hi Eric,

> Thank you for the patch! Yet something to improve:

> [auto build test ERROR on net-next/master]

> url:
https://github.com/0day-ci/linux/commits/Eric-Dumazet/tcp-add-TCP_ZEROCOPY_RECEIVE-support-for-zerocopy-receive/20180427-122234
> config: sh-rsk7269_defconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=sh

> All errors (new ones prefixed by >>):

>     net/ipv4/tcp.o: In function `tcp_setsockopt':
> >> tcp.c:(.text+0x3f80): undefined reference to `zap_page_range'

I guess this tcp zerocopy stuff depends on CONFIG_MMU

Thanks.
