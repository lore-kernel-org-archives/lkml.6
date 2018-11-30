Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6CC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235D220867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235D220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blastwave.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLAKFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:05:55 -0500
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:34876 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeLAKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:05:55 -0500
Received: from atl4mhob09.registeredsite.com (atl4mhob09.registeredsite.com [209.17.115.47])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id wAUMmaTG007912
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 17:48:36 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail02pod2.registeredsite.com [10.30.77.36])
        by atl4mhob09.registeredsite.com (8.14.4/8.14.4) with ESMTP id wAUMmYHc016529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 17:48:34 -0500
Received: (qmail 37930 invoked by uid 0); 30 Nov 2018 22:48:34 -0000
X-TCPREMOTEIP: 174.118.245.214
X-Authenticated-UID: dclarke@blastwave.org
Received: from unknown (HELO ?172.16.35.3?) (dclarke@blastwave.org@174.118.245.214)
  by 0 with ESMTPA; 30 Nov 2018 22:48:34 -0000
Subject: Re: [PATCH RFC 05/15] parisc: replace **** with a hug
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-6-jarkko.sakkinen@linux.intel.com>
From:   Dennis Clarke <dclarke@blastwave.org>
Message-ID: <cc2c08ea-2d9b-4aac-ba98-e7cec57a9cce@blastwave.org>
Date:   Fri, 30 Nov 2018 17:48:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181130192737.15053-6-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 2:27 PM, Jarkko Sakkinen wrote:
> In order to comply with the CoC, replace **** with a hug.
> 

To be honest the source has been full of sh!t and other expressions
for a long long time now. I am sure we all know this and it would
take a pile of effort to clean^H^H^H^Hsanitize and ruin the flavour and
ambiance of the whole damn thing.  Everyone knows this :


c $ find . -type f | xargs grep -ic " shit " | grep -v ":0$" | awk 
'BEGIN{FS=":";print "\nshitlist"}{print $2 " " $1}' | sort -n

shitlist
1 ./linux-4.20-rc4/arch/powerpc/kernel/eeh_driver.c
1 ./linux-4.20-rc4/arch/sparc/kernel/pcic.c
1 ./linux-4.20-rc4/arch/sparc/mm/srmmu.c
1 ./linux-4.20-rc4/drivers/ata/sata_via.c
1 ./linux-4.20-rc4/drivers/infiniband/hw/qib/qib_file_ops.c
1 ./linux-4.20-rc4/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
1 ./linux-4.20-rc4/drivers/net/ethernet/sun/sunhme.c
1 ./linux-4.20-rc4/drivers/net/wan/z85230.c
1 ./linux-4.20-rc4/drivers/net/wireless/intel/iwlegacy/3945-mac.c
1 ./linux-4.20-rc4/net/ipv4/tcp_input.c
1 ./linux-4.20-rc4/sound/pci/ac97/ac97_patch.c
1 ./linux-4.20-rc4/sound/pci/cs46xx/dsp_spos_scb_lib.c
c $

c $ find . -type f | xargs grep -ic " piss " | grep -v ":0$" | awk 
'BEGIN{FS=":";print "\npisspot"}{print $2 " " $1}' | sort -n

pisspot
1 ./linux-4.20-rc4/Documentation/process/submitting-patches.rst
1 ./linux-4.20-rc4/Documentation/translations/ja_JP/SubmittingPatches
1 ./linux-4.20-rc4/Documentation/translations/zh_CN/SubmittingPatches
c $

c $ grep -in " piss " 
./linux-4.20-rc4/Documentation/process/submitting-patches.rst
817:Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".


c $ find . -type f | xargs grep -ic " fuck " | grep -v ":0$" | awk 
'BEGIN{FS=":";print "\nfucked"}{print $2 " " $1}' | sort -n

fucked
1 ./linux-4.20-rc4/Documentation/kernel-hacking/locking.rst
1 ./linux-4.20-rc4/arch/m68k/include/asm/sun3ints.h
1 ./linux-4.20-rc4/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
1 ./linux-4.20-rc4/drivers/media/i2c/bt819.c
1 ./linux-4.20-rc4/drivers/net/ethernet/sun/sunhme.c
c $


c $ find . -type f | xargs grep -ic " fucked " | grep -v ":0$" | awk 
'BEGIN{FS=":";print "\nreally fucked"}{print $2 " " $1}' | sort -n

really fucked
1 ./linux-4.20-rc4/drivers/cpufreq/powernow-k7.c
1 ./linux-4.20-rc4/drivers/ide/cmd640.c
1 ./linux-4.20-rc4/fs/notify/inotify/inotify_user.c
1 ./linux-4.20-rc4/lib/vsprintf.c
12 ./linux-4.20-rc4/arch/mips/pci/ops-bridge.c
c $

The finest example of colorful comments is arch/mips/pci/ops-bridge.c:


     54          addr = 
&bridge->b_type0_cfg_dev[slot].f[fn].c[PCI_VENDOR_ID];
     55          if (get_dbe(cf, (u32 *) addr))
     56                  return PCIBIOS_DEVICE_NOT_FOUND;
     57
     58          /*
     59           * IOC3 is fucking fucked beyond belief ...  Don't even 
give the
     60           * generic PCI code a chance to look at it for real ...
     61           */
     62          if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 
<< 16)))
     63                  goto oh_my_gawd;
     64
.
.
.
     76  oh_my_gawd:
     77
     78          /*
     79           * IOC3 is fucking fucked beyond belief ...  Don't even 
give the
     80           * generic PCI code a chance to look at the wrong register.
     81           */
     82          if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
     83                  *value = emulate_ioc3_cfg(where, size);
     84                  return PCIBIOS_SUCCESSFUL;
     85          }
     86
     87          /*
     88           * IOC3 is fucking fucked beyond belief ...  Don't try 
to access
     89           * anything but 32-bit words ...
     90           */
     91          addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
     92


Ah yes .. I remember the days when IBM bought Lotus and no one could
have a beer in the office anymore.  Everyone that was good walked out.
Let's not do that.

Dennis Clarke

