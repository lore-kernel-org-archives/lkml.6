Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeA3WmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:42:10 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46118 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeA3WmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:42:08 -0500
X-Google-Smtp-Source: AH8x226Aj7XQF6ij1hjLZhcgMNIfUoSH3eb5ejt0HUn9Oa9kHvBUG58tqdG7xgnZPIePv/51A4uuqg==
From: Antony Pavlov <antonynpavlov@gmail.com>
To: linux-mips@linux-mips.org
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MIPS: use generic GCC library routines from lib/
Date: Wed, 31 Jan 2018 01:42:00 +0300
Message-Id: <20180130224202.7682-1-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 patch series (https://www.linux-mips.org/archives/linux-mips/2018-01/msg00394.html):

  * sort the CONFIG_* options in arch/mips/Kconfig alphabetically;
  * add notrace to lib/ucmpdi2.c.

Antony Pavlov (1):
  MIPS: use generic GCC library routines from lib/

Palmer Dabbelt (1):
  Add notrace to lib/ucmpdi2.c

 arch/mips/Kconfig       |  5 +++++
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/ashldi3.c | 30 ------------------------------
 arch/mips/lib/ashrdi3.c | 32 --------------------------------
 arch/mips/lib/cmpdi2.c  | 28 ----------------------------
 arch/mips/lib/lshrdi3.c | 30 ------------------------------
 arch/mips/lib/ucmpdi2.c | 22 ----------------------
 lib/ucmpdi2.c           |  2 +-
 8 files changed, 7 insertions(+), 144 deletions(-)
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

-- 
2.11.0
