Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeFAPVa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:21:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50694 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeFAPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:21:29 -0400
X-Google-Smtp-Source: ADUXVKIbyJd5Er+6cRr15rM3X+CnZqyIjeaguoK13hRWQg3geDrZQNE3XuM0eCT3GyA4p8KOxQ6m3A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] riscv: fix sparse annotations
Date: Fri,  1 Jun 2018 17:21:20 +0200
Message-Id: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V implementation seems to be quite clean regarding
sparse annotations. There is anyway three small glitches
which are corrected by this series.

Note: the 3rd patch may need another solution.

Luc Van Oostenryck (3):
  riscv: use NULL instead of a plain 0
  riscv: no __user for probe_kernel_address()
  riscv: fix __user annotation for __copy_user()

 arch/riscv/include/asm/cacheflush.h | 2 +-
 arch/riscv/include/asm/tlbflush.h   | 2 +-
 arch/riscv/include/asm/uaccess.h    | 8 ++++----
 arch/riscv/kernel/traps.c           | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1
