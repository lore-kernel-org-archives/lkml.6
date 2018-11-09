Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA56BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E5820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E5820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeKJApi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:45:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeKJApi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:45:38 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L2QG8UH_H8Eg; Fri,  9 Nov 2018 16:04:40 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED4F31EC03C8;
        Fri,  9 Nov 2018 16:04:39 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Add SPDX identifiers to some more files
Date:   Fri,  9 Nov 2018 16:04:27 +0100
Message-Id: <20181109150431.14147-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's some more files converted to SPDX identifiers.

In the MCE and microcode cases, I've made one patch per subsystem as
this is shared functionality so maybe splitting them even more would not
make any sense.

But I could be wrong and the lawyer logic could very well work in a
completely different way so I'm open to suggestions here.

Thanks.

Borislav Petkov (4):
  EDAC, mce_amd: Add an SPDX identifier
  EDAC, amd64: Add SPDX identifiers
  x86/microcode: Add SPDX license identifiers
  x86/mce: Add an SPDX license identifiers

 arch/x86/kernel/cpu/mcheck/dev-mcelog.c   |  1 +
 arch/x86/kernel/cpu/mcheck/mce-apei.c     | 14 +-------------
 arch/x86/kernel/cpu/mcheck/mce-genpool.c  |  3 +--
 arch/x86/kernel/cpu/mcheck/mce-inject.c   |  9 +--------
 arch/x86/kernel/cpu/mcheck/mce-severity.c |  6 +-----
 arch/x86/kernel/cpu/mcheck/mce.c          |  1 +
 arch/x86/kernel/cpu/mcheck/therm_throt.c  |  1 +
 arch/x86/kernel/cpu/microcode/amd.c       |  4 +---
 arch/x86/kernel/cpu/microcode/core.c      |  6 +-----
 arch/x86/kernel/cpu/microcode/intel.c     |  6 +-----
 drivers/edac/amd64_edac.c                 |  1 +
 drivers/edac/amd64_edac.h                 |  4 +---
 drivers/edac/mce_amd.c                    |  1 +
 13 files changed, 13 insertions(+), 44 deletions(-)

-- 
2.19.1

