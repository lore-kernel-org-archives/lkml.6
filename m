Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBHWyx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:54:53 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40935 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBHWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:54:51 -0500
X-Google-Smtp-Source: AH8x225Xbhl2ahTOdw0uGq/qZdBdiS8fpXA98I9nLVfVxkNvVgWYZfNtJYKvh9bfSO8BNeZ52ALvmQ==
Date: Thu, 8 Feb 2018 23:54:46 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, Christoph Hellwig <hch@lst.de>,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, Will Deacon <will.deacon@arm.com>, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com, albert@sifive.com,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: kconfig: Remove RISCV_IRQ_INTC select
Message-ID: <20180208225446.rj7ioyeikaqfm2jc@huvuddator>
References: <CAFkk2KSUeepo0mSKeV9r2uMO1=euVV2L6QpsMAO0Ew6znG+BRQ@mail.gmail.com>
 <mhng-300ca2ca-2316-487a-aaa8-9e61b5b67b30@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-300ca2ca-2316-487a-aaa8-9e61b5b67b30@palmer-si-x1c4>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISCV_IRQ_INTC configuration symbol is undefined, but RISCV selects
it. Quoting Palmer Dabbelt:

	It looks like this slipped through, the symbol has been renamed
	RISCV_INTC.

No RISCV_INTC configuration symbol has been merged either. Just remove
the RISCV_IRQ_INTC select for now.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/riscv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b6722c246d9c..2be44b6651c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -34,7 +34,6 @@ config RISCV
 	select HAVE_ARCH_TRACEHOOK
 	select MODULES_USE_ELF_RELA if MODULES
 	select THREAD_INFO_IN_TASK
-	select RISCV_IRQ_INTC
 	select RISCV_TIMER
 
 config MMU
-- 
2.14.1
