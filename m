Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeERXCM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 19:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbeERXCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 19:02:11 -0400
From: sboyd@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.17-rc5
Date: Fri, 18 May 2018 16:02:09 -0700
Message-Id: <20180518230209.260757-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit c964cfc612b59910593fa10ee1c2673db274c9c7:

  Merge tag 'meson-clk-fixes-4.17-1' of https://github.com/BayLibre/clk-meson into clk-fixes (2018-05-01 14:44:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 9a160601f3fb6ffa196b87d1b5643646be486405:

  clk: stm32: fix: stm32 clock drivers are not compiled by default (2018-05-15 15:47:03 -0700)

----------------------------------------------------------------
A modified revert of a patch that made new choices come out for a couple
stm32 clk drivers that really always need to be there when that
particular machine is compiled in and boot fix on i.MX for Stefan who
noticed odd behavior from the critical flag patch that came in during
the merge window.

----------------------------------------------------------------
Gabriel Fernandez (1):
      clk: stm32: fix: stm32 clock drivers are not compiled by default

Stefan Agner (1):
      clk: imx6ull: use OSC clock during AXI rate change

 drivers/clk/Kconfig          | 6 ++----
 drivers/clk/imx/clk-imx6ul.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
Sent by a computer through tubes
