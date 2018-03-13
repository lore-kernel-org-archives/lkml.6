Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeCMSrL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:47:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40577 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCMSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:47:08 -0400
X-Google-Smtp-Source: AG47ELt5HgBcJwsMVwjn67y6fN0XOeQMIB1C36BF8zYXXTWuvSSOrUzEUCb1wlZplg1MQa1vg6Shpg==
Date: Tue, 13 Mar 2018 19:46:52 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v4.16-rc6
Message-ID: <20180313184652.dzjmoxs7zl4ocrfw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these small changes to silence a few warnings in auxdisplay.

This is my first pull request, so if there is anything wrong, please let
me know!

Also, note that for the moment my PGP/GPG key is only signed by 2 other
kernel maintainers and that we did it over email/Skype. I used GitHub
as well for the same reason.

Cheers,
Miguel Ojeda

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v4.16-rc6

for you to fetch changes up to 26a2c54d03bd514fb3d3520706f911b3ca56b011:

  auxdisplay: img-ascii-lcd: Silence 2 uninitialized warnings (2018-03-13 18:16:38 +0100)

----------------------------------------------------------------
Silence a few warnings in auxdisplay.

  - A couple of uninitialized warnings reported by the build service.

  - A doc comment warning under W=1.

  - Three fall through comments not recognized under W=1.

----------------------------------------------------------------
Miguel Ojeda (3):
      auxdisplay: panel: Change comments to silence fallthrough warnings
      auxdisplay: img-ascii-lcd: Fix doc comment to silence warnings
      auxdisplay: img-ascii-lcd: Silence 2 uninitialized warnings

 drivers/auxdisplay/img-ascii-lcd.c | 6 +++---
 drivers/auxdisplay/panel.c         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
