Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC993C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAEC2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAEC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeLAHIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:08:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:44543 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeLAHIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:08:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 11:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="114367290"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2018 11:57:58 -0800
Date:   Fri, 30 Nov 2018 11:57:58 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Joshua Kinard <kumba@gentoo.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 01/15] MIPS: replace **** with a hug
Message-ID: <20181130195758.GA20328@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:27:10AM -0800, Jarkko Sakkinen wrote:
> In order to comply with the CoC, replace **** with a hug.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Since v17 of the SGX patch set, my cover letters get cut for some
reason. I receive them myself but they don't appear on kernel
lists. I don't what the hug is going on :-/

Here's the cover letter for this patch set:

From 386420215a93d2eb5bbcb061e914cfb16f456de8 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 30 Nov 2018 11:25:40 -0800
Subject: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3

In order to comply with the CoC, replace **** with a hug.

Jarkko Sakkinen (15):
  MIPS: replace **** with a hug
  Documentation: replace **** with a hug
  drm/nouveau: replace **** with a hug
  m68k: replace **** with a hug
  parisc: replace **** with a hug
  cpufreq: replace **** with a hug
  ide: replace **** with a hug
  media: replace **** with a hug
  mtd: replace **** with a hug
  net/sunhme: replace **** with a hug
  scsi: replace **** with a hug
  inotify: replace **** with a hug
  irq: replace **** with a hug
  lib: replace **** with a hug
  net: replace **** with a hug

 Documentation/kernel-hacking/locking.rst      |  2 +-
 arch/m68k/include/asm/sun3ints.h              |  2 +-
 arch/mips/pci/ops-bridge.c                    | 24 +++++++++----------
 arch/mips/sgi-ip22/ip22-setup.c               |  2 +-
 arch/parisc/kernel/sys_parisc.c               |  2 +-
 drivers/cpufreq/powernow-k7.c                 |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   |  2 +-
 .../nouveau/nvkm/subdev/pmu/fuc/macros.fuc    |  2 +-
 drivers/ide/cmd640.c                          |  2 +-
 drivers/media/i2c/bt819.c                     |  8 ++++---
 drivers/mtd/mtd_blkdevs.c                     |  2 +-
 drivers/net/ethernet/sun/sunhme.c             |  4 ++--
 drivers/scsi/qlogicpti.h                      |  2 +-
 fs/notify/inotify/inotify_user.c              |  2 +-
 kernel/irq/timings.c                          |  2 +-
 lib/vsprintf.c                                |  2 +-
 net/core/skbuff.c                             |  2 +-
 17 files changed, 33 insertions(+), 31 deletions(-)

-- 
2.19.1

/Jarkko
