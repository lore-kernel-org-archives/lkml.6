Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeDHRU4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 13:20:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37429 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeDHRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 13:20:55 -0400
X-Google-Smtp-Source: AIpwx4/vJhq8mdZJsqOIoUn7GfhdODAhRE95wp9toS26nT4CyRPhVZBg6BQbzGfEP469NPdK2u+3fQ==
Date: Sun, 8 Apr 2018 10:20:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tobias Regnery <tobias.regnery@gmail.com>
Subject: [GIT PULL] pstore updates for v4.17-rc1 (part 2)
Message-ID: <20180408172052.GA40019@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pstore fix for v4.17-rc1. This fixes another Kconfig
combination that Arnd and I missed for pstore's compression support.

Thanks!

-Kees

The following changes since commit 58eb5b6707477ff458db3ee522aac317da719e2a:

  pstore: fix crypto dependencies (2018-03-15 10:06:06 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.17-rc1-fix

for you to fetch changes up to e698aaf37f9fac419ac6c1867137cce83c90c80b:

  pstore: fix crypto dependencies without compression (2018-04-06 15:45:33 -0700)

----------------------------------------------------------------
- Fix another compression Kconfig combination missed in testing (Tobias Regnery)

----------------------------------------------------------------
Tobias Regnery (1):
      pstore: fix crypto dependencies without compression

 fs/pstore/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Kees Cook
Pixel Security
