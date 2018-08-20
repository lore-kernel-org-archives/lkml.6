Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7041EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A2B20C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A2B20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeHTLBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:01:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:37870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbeHTLBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:01:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CFC5AE16;
        Mon, 20 Aug 2018 07:46:29 +0000 (UTC)
Date:   Mon, 20 Aug 2018 09:46:44 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for 4.19
Message-ID: <20180820074644.GC7509@nazgul.tnic>
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

please pull one urgent EDAC fix, details below.

Thanks.

--
The following changes since commit 190bd6e98afc512fb16d4a471acd488e36141637:

  EDAC, sb_edac: Add support for systems with segmented PCI buses (2018-07-25 11:17:15 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_fixes_for_4.19

for you to fetch changes up to b748f2de4b2f578599f46c6000683a8da755bf68:

  EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[] (2018-08-17 15:13:34 +0200)

----------------------------------------------------------------
* An urgent fix for a NULL ptr deref on machines with LRDDR4 DIMMs, from Takashi Iwai.

----------------------------------------------------------------
Takashi Iwai (1):
      EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]

 drivers/edac/edac_mc.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
