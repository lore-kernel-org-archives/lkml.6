Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeCFOWB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:22:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44016 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeCFOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:22:00 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/RAS: Some more fixes
Date: Tue,  6 Mar 2018 15:21:40 +0100
Message-Id: <20180306142143.19990-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi guys,

here are some more RAS fixes. Please queue 1st and 3rd for urgent.

Thx.

Borislav Petkov (1):
  x86/MCE: Cleanup and complete struct mce fields definitions

Seunghun Han (1):
  x86/MCE: Synchronize sysfs changes

Tony Luck (1):
  x86/MCE: Save microcode revision in machine check records

 arch/x86/include/uapi/asm/mce.h  | 51 ++++++++++++++++++++++------------------
 arch/x86/kernel/cpu/mcheck/mce.c | 26 ++++++++++++++++++--
 2 files changed, 52 insertions(+), 25 deletions(-)

-- 
2.13.0
