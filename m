Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeBZJpJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:45:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbeBZJpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:45:05 -0500
Date: Mon, 26 Feb 2018 10:44:45 +0100
From: Borislav Petkov <bp@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for 4.16
Message-ID: <20180226094445.GA14140@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull this one fix to sb_edac, preventing memory corruption on
KNL.

Thx.

---
The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_fixes_for_4.16

for you to fetch changes up to bf8486709ac7fad99e4040dea73fe466c57a4ae1:

  EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL (2018-02-23 12:05:37 +0100)

----------------------------------------------------------------
sb_edac: Prevent memory corruption on KNL (from Anna Karbownik)

----------------------------------------------------------------
Anna Karbownik (1):
      EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL

 drivers/edac/sb_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
