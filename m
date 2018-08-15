Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9662CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E08216E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E08216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeHOJNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:13:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:46838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbeHOJNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:13:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E109CAD05;
        Wed, 15 Aug 2018 06:22:54 +0000 (UTC)
Date:   Wed, 15 Aug 2018 08:23:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC pile for 4.19
Message-ID: <20180815062312.GD23008@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

not a lot this time, it being a lazy, vacation time... :-)

Please pull,
thanks.

---
The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_4.19

for you to fetch changes up to 190bd6e98afc512fb16d4a471acd488e36141637:

  EDAC, sb_edac: Add support for systems with segmented PCI buses (2018-07-25 11:17:15 +0200)

----------------------------------------------------------------
* Add support for systems with PCI segmented buses to sb_edac, by Masayoshi Mizuma

* The usual pile of fixes and cleanups

----------------------------------------------------------------
Christophe JAILLET (1):
      EDAC, altera: Fix an error handling path in altr_s10_sdram_probe()

Johan Hovold (2):
      EDAC: Fix memleak in module init error path
      EDAC, i7core: Fix memleaks and use-after-free on probe and remove

Kees Cook (1):
      EDAC, thunderx: Remove VLA usage

Masayoshi Mizuma (1):
      EDAC, sb_edac: Add support for systems with segmented PCI buses

 drivers/edac/altera_edac.c   |  3 ++-
 drivers/edac/edac_mc_sysfs.c |  6 +++---
 drivers/edac/i7core_edac.c   | 22 +++++++++++++++-------
 drivers/edac/sb_edac.c       | 17 ++++++++++++-----
 drivers/edac/thunderx_edac.c | 14 +++++++++-----
 5 files changed, 41 insertions(+), 21 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
