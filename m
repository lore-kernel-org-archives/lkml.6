Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeERHvL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:51:11 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:44569 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750882AbeERHvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:51:07 -0400
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc: Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <20180515014152.GV1392@brightrain.aerifal.cx>
 <87tvr814pn.wl-ysato@users.sourceforge.jp>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <3bb59c28-3160-2892-c8f2-fd27777d61a9@physik.fu-berlin.de>
Date: Fri, 18 May 2018 09:51:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87tvr814pn.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 93.193.95.163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 08:42 AM, Yoshinori Sato wrote:
>> Can you give me a brief explanation of how to reproduce the bootloader
>> installation? For now I'm just using the existing MBR/partitioning you
>> sent me, and replacing zImage.itb in /boot makes it attempt to load a
>> new kernel, but I haven't gotten any output yet to know if it's
>> working.
> 
> landisk's u-boot using spl.
> You should be able to update it by the following procedure.
> 1. Rebuild u-boot.
> 2. Format ext4 for HDD first partition.
> 3. put u-boot.img to HDD first partition.
> 4. put spl/u-boot-spl.bin to HDD MBR and subsequent region.
I will try to set up uboot this way on my USL-5P over the weekend.

Thanks for these instructions.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
