Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeB0BNy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 20:13:54 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46847 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeB0BNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 20:13:53 -0500
X-Google-Smtp-Source: AH8x225AkW1+ROLctUa5Pu4QZKLd8AYZg0HKea5FqExaaBSMoKOS33i4fQwl8bQLnQBrQT1fCnaTVA==
Date: Mon, 26 Feb 2018 17:13:50 -0800
From: Kees Cook <keescook@chromium.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [GIT PULL] seccomp update for v4.16-rc4
Message-ID: <20180227011350.GA5122@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Please pull this seccomp change for v4.16-rc4. This disables the seccomp
samples when cross compiling. We're seen too many build issues here, so
it's best to just disable it, especially since they're just the samples.

Thanks!

-Kees

The following changes since commit d057dc4e35e16050befa3dda943876dab39cbf80:

  seccomp: add a selftest for get_metadata (2018-02-21 16:56:03 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v4.16-rc4

for you to fetch changes up to 6275ecbcd3ae3aaf47c3bc1e46343a50f16b2577:

  samples/seccomp: do not compile when cross compiled (2018-02-22 09:31:43 -0800)

----------------------------------------------------------------
- do not build samples when cross compiling (Michal Hocko)

----------------------------------------------------------------
Michal Hocko (1):
      samples/seccomp: do not compile when cross compiled

 samples/seccomp/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

-- 
Kees Cook
Pixel Security
