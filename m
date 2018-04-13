Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeDMNyf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:54:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52735 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753704AbeDMNye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:54:34 -0400
Date: Fri, 13 Apr 2018 15:54:30 +0200
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Hung <alex.hung@canonical.com>
Subject: [GIT PULL] dmi fixes for v4.17
Message-ID: <20180413155430.0ee2a14e@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem updates/fixes for Linux v4.17 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 drivers/firmware/dmi_scan.c     | 16 ++++++++++++----
 include/linux/mod_devicetable.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

---------------

Alex Hung (1):
      firmware: dmi_scan: Add DMI_OEM_STRING support to dmi_matches

Jean Delvare (2):
      firmware: dmi_scan: Fix UUID length safety check
      firmware: dmi_scan: Use lowercase letters for UUID

Thanks,
-- 
Jean Delvare
SUSE L3 Support
