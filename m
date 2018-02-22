Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeBVBLb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 20:11:31 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42909 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeBVBLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 20:11:30 -0500
X-Google-Smtp-Source: AH8x227/fCfjHy6uX/ndrUNebbBx8eVRdDCY2TsZzV5/YY+tW3dgShrqTuQmHFug/VybPYDUvPfnfw==
Date: Wed, 21 Feb 2018 17:11:27 -0800
From: Kees Cook <keescook@chromium.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] seccomp updates for v4.16-rc3
Message-ID: <20180222011127.GA12150@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend to updated address ...]

Hi James,

Please pull these seccomp changes for v4.16-rc3. These are fixes for the
get_metadata interface that landed during -rc1. While the new selftest
is strictly not a bug fix, I think it's in the same spirit of avoiding
bugs.

Thanks!

-Kees

The following changes since commit 26500475ac1b499d8636ff281311d633909f5d20:

  ptrace, seccomp: add support for retrieving seccomp metadata (2017-11-28 15:41:01 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v4.16-rc3

for you to fetch changes up to d057dc4e35e16050befa3dda943876dab39cbf80:

  seccomp: add a selftest for get_metadata (2018-02-21 16:56:03 -0800)

----------------------------------------------------------------
- Fix seccomp GET_METADATA to deal with field sizes correctly (Tycho Andersen)
- Add selftest to make sure GET_METADATA doesn't regress (Tycho Andersen)

----------------------------------------------------------------
Tycho Andersen (3):
      seccomp, ptrace: switch get_metadata types to arch independent
      ptrace, seccomp: tweak get_metadata behavior slightly
      seccomp: add a selftest for get_metadata

 include/uapi/linux/ptrace.h                   |  4 +-
 kernel/seccomp.c                              |  6 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 61 +++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 4 deletions(-)

-- 
Kees Cook
Pixel Security
