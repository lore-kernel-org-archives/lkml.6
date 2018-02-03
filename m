Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeBCKcp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 05:32:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:45180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeBCKcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 05:32:36 -0500
Date: Sat, 3 Feb 2018 11:32:33 +0100
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Martin =?UTF-8?B?SHVuZGVi?= =?UTF-8?B?w7hsbA==?=
        <martin.hundeboll@prevas.dk>
Subject: [GIT PULL] dmi fixes for v4.16
Message-ID: <20180203113233.4a5c2fc0@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem updates/fixes for Linux v4.16 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 drivers/firmware/dmi-sysfs.c |  2 +-
 drivers/firmware/dmi_scan.c  | 64 +++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 37 deletions(-)

---------------

Ard Biesheuvel (1):
      firmware: dmi: handle missing DMI data gracefully

Jean Delvare (3):
      firmware: dmi: Optimize dmi_matches
      firmware: dmi_scan: Drop dmi_initialized
      firmware: dmi_scan: Fix handling of empty DMI strings

Thanks,
-- 
Jean Delvare
SUSE L3 Support
