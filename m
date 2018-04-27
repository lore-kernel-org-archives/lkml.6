Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759229AbeD0UI0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:08:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:44857 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759214AbeD0UIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:08:23 -0400
X-Google-Smtp-Source: AB8JxZr4FCjTE0nIxLc/S33dQJSu7IF1Z2hfORlbcjq/LP7fk6Sfg3HVEA8QTSog+nvsvme9Q1tx4w==
Date: Fri, 27 Apr 2018 13:08:22 -0700 (PDT)
X-Google-Original-Date: Fri, 27 Apr 2018 13:08:03 PDT (-0700)
Subject: RE: Makefile:636: arch/score/Makefile: No such file or directory
In-Reply-To: <831EE4E5E37DCC428EB295A351E662494CAE8B50@shsmsx102.ccr.corp.intel.com>
CC: fengguang.wu@intel.com, Arnd Bergmann <arnd@arndb.de>, lkp@intel.com,
        kbuild-all@01.org, linux-kernel@vger.kernel.org, shun.hao@intel.com
From: Palmer Dabbelt <palmer@sifive.com>
To: philip.li@intel.com
Message-ID: <mhng-720c981d-9bf4-41f4-8428-fd35ad45e9dd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018 18:00:25 PDT (-0700), philip.li@intel.com wrote:
>
>> >Please stop trying to build the removed architectures: tile, blackfin,
>> >metag, m32r, frv, mn10300, cris and score.
>> >
>> >https://lwn.net/Articles/748074/ has details about why this broke.
>>
>> Sorry about that!  It looks the architectures removal is not thorough
>> enough. Hao, would you help take a look?
> sure, we will handle this.
>
>>
>> >Note that we do have a few new architectures that you may want
>> >to add if you haven't done this already: nds32 and riscv were added
>> >this year, and a couple of older architectures that didn't have upstream
>> >gcc releases now have those, and I uploaded gcc binaries to
>> >https://cdn.kernel.org/pub/tools/crosstool/.
>> >
>> >This should allow building everything we have in the kernel now.
>> >Unfortunately the nds32 toolchain I uploaded is a little incomplete,
>> >but I have a gcc-6.4 build that (mostly) works and gcc-8 should
>> >be fine as well once it gets released.
>>
>> OK, thanks for the tips! Philip may help plan add the 2 new archs
>> nds32 and riscv.
> thanks for info, we will add new archs support in near future.

Thanks!  If you have any RISC-V questions feel free to ping me, but it should 
be pretty straight-forward as I think my trees are already in the system and 
our upstream toolchain works for Linux.
