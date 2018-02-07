Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeBGDAW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 22:00:22 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40817 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBGDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 22:00:21 -0500
X-Google-Smtp-Source: AH8x226/WD60n2tU8SRe7ASqU5HXml9ZLvYZ4xDwF2jif2/mJHQrNT4zJM92s6V1bzXhk5hrUnn+Gw==
Date: Tue, 6 Feb 2018 19:00:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: [GIT PULL] gcc-plugins updates for v4.16-rc1
Message-ID: <20180207030018.GA24413@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugins changes for v4.16-rc1. This is a small
set of changes entirely in support of the coming gcc 8 release.

Thanks!

-Kees

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.16-rc1

for you to fetch changes up to b86729109c5fd0a480300f40608aac68764b5adf:

  gcc-plugins: Use dynamic initializers (2018-02-05 17:27:46 -0800)

----------------------------------------------------------------
- update includes for gcc 8 (Valdis Kletnieks)
- update initializers for gcc 8

----------------------------------------------------------------
Kees Cook (1):
      gcc-plugins: Use dynamic initializers

Valdis Kletnieks (1):
      gcc-plugins: Add include required by GCC release 8

 scripts/gcc-plugins/gcc-common.h              |  4 ++
 scripts/gcc-plugins/latent_entropy_plugin.c   | 17 ++----
 scripts/gcc-plugins/randomize_layout_plugin.c | 75 ++++++++-------------------
 scripts/gcc-plugins/structleak_plugin.c       | 19 +++----
 4 files changed, 37 insertions(+), 78 deletions(-)

-- 
Kees Cook
Pixel Security
