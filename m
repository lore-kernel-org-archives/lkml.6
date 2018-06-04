Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeFDUub (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:50:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45706 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeFDUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:50:25 -0400
X-Google-Smtp-Source: ADUXVKIAjPp0bucq89qt8urV7ytleJikytAUhEyVlptJ0o5pq081pvL1kStxHjoWZ1uPL1m1Nss2VQ==
Subject: [PATCH 2/2] MAINTAINERS: Update Albert's email, he's back at Berkeley
Date: Mon,  4 Jun 2018 13:50:11 -0700
Message-Id: <20180604205011.23086-3-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180604205011.23086-1-palmer@sifive.com>
References: <20180604205011.23086-1-palmer@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was adding a MAINTAINERS entry for SiFive's drivers I realized
that Albert's email is out of date -- he's gone back to Berkeley, so his
SiFive email is technically defunct.  This patch updates his entry to a
current email address, hosted at Berkeley.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8f906d1d1e2..c2d32726264f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12004,7 +12004,7 @@ F:	drivers/mtd/nand/raw/r852.h
 
 RISC-V ARCHITECTURE
 M:	Palmer Dabbelt <palmer@sifive.com>
-M:	Albert Ou <albert@sifive.com>
+M:	Albert Ou <aou@eecs.berkeley.edu>
 L:	linux-riscv@lists.infradead.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
 S:	Supported
-- 
2.16.4
