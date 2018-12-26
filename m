Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAAAC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94B2218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeLZQtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:49:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:41891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeLZQty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:49:54 -0500
Received: from ls3530.dellerweb.de ([92.116.132.153]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LhCDT-1h75Xp122x-00oXUt; Wed, 26 Dec 2018 17:49:46 +0100
Date:   Wed, 26 Dec 2018 17:49:42 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Firoz Khan <firoz.khan@linaro.org>
Subject: [GIT PULL] parisc architecture updates for kernel v4.21
Message-ID: <20181226164942.GA19410@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:v6iT1c8edhl6dnTQZvwfGWHZZU0nbhBU8FSDNjFnBj/U+0g9Sg+
 eqKnEQdBJB0Slsfxlxby87+DbhWcFX/txgs1bA045klxPq9MKamQx06sa8c/w28lpgDxSXg
 EnpZ1oCWXrHS3EJNKF4ltJz1K9jXTpR6PmCT/+DnL3MCD0n0qZfoWqStH8/B6QKTu/VJqWX
 rXP3oAvVYjfn7bEIV8A8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AgdX/KSdjJk=:TaBYFVAeQw/3u/yZubSoIa
 bPolua/sAhN19+SQFRWvAXMJgK66tYGRlRNi4/+KuWccsTX4AjA3jZbWEC2++ARVd3UQYYL03
 0SK4zmsaT4CqqcpgMpSt4/a3qsdfkOrmf/OBSdqdXByJp2ISFfra746N8Tlm2k8o8eri34kqj
 yMmflsMwLfdpuKJOtEWMiSuVeUVY6nF5RpEyYwn4zFORTVa/NdpzS8DLJzqEZ7REHjZ0Ya4Ha
 NLtT0pNMKZjHHlI7NtnplI0fN9a8yNLaKRpkWKRsipaJcszXTAE61esj6SykAN7yNphtNKEbR
 gHwx1LcJvWp4qJprhKTtYS11QRSj0JfNvC0TmK2NRRtPi2xqQjgnyTAb5nxlhzy2AQ+MOsznN
 3ZSnG4QIQA+WWWbcIWVX3KGHkS1E1hC1NFYfPkM5YhxFb2r5OZsYDGbJvF3dW2CsGAn9SgqxN
 58iN2P87jlYnXnbi7JoBs850W08RGN0A0nSzCy0u2Gt9jtU9mpUceUzaNckaZX+Ip4UU4EG5i
 2G6YSaO1P6egzfRL0t5umWpxfLglsGsywUIXG+YEmtNE+gu5HmihB8+1CliSZjBonrpfmDQHx
 ywy3hqnkUt9kCJ3tDr3Nk2RLdTNe/LnxYA5PP30WwjLcz9swLwC0V8+x7IjeVL/HQXb/X3XKf
 yg87xc0YUrtYl2t+NsWe2SKBBWDngCn25jsojuWFhPLzlNHDfpHf1QlOuPkoIjkER4J6GYbJx
 fp7IjBdHjx9e3fA/Z1VnQVVy7Brcurp+goCM5JHeIniGv7MJAaCikH4Lr2VJ65joBWo57n//6
 0OOJjcQTcdPj2GM9Sii8POdV9VTBo05pWKBsEdywJTrhVFRq6ek8Up9weGSyd+3lWujuAlj27
 zUKqX626czXb899V315z2kGZ3BnUj6Kuz+yzyJ7MY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for 4.21-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.21-1

The major change in this patchset is the new system call table
generation support from Firoz Khan.
    
Thanks,
Helge

----------------------------------------------------------------
Firoz Khan (6):
      parisc: move __IGNORE* entries to non uapi header
      parisc: add __NR_syscalls along with __NR_Linux_syscalls
      parisc: remove __NR_Linux from uapi header file.
      parisc: add system call table generation support
      parisc: generate uapi header and system call table files
      parisc: syscalls: ignore nfsservctl for other architectures

Helge Deller (3):
      parisc: Split out alternative live patching code
      parisc: Fix serio address output
      parisc: Fix HP SDC hpa address output

 arch/parisc/Makefile                      |   3 +
 arch/parisc/include/asm/Kbuild            |   3 +
 arch/parisc/include/asm/alternative.h     |   4 +
 arch/parisc/include/asm/unistd.h          |   8 +
 arch/parisc/include/uapi/asm/Kbuild       |   2 +
 arch/parisc/include/uapi/asm/unistd.h     | 379 +-----------------------
 arch/parisc/kernel/Makefile               |   2 +-
 arch/parisc/kernel/alternative.c          |  98 +++++++
 arch/parisc/kernel/module.c               |  14 +
 arch/parisc/kernel/setup.c                |  80 ------
 arch/parisc/kernel/syscall.S              |  11 +-
 arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
 arch/parisc/kernel/syscalls/Makefile      |  55 ++++
 arch/parisc/kernel/syscalls/syscall.tbl   | 369 ++++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh |  36 +++
 drivers/input/serio/gscps2.c              |   4 +-
 drivers/input/serio/hp_sdc.c              |   4 +-
 scripts/checksyscalls.sh                  |   1 +
 19 files changed, 648 insertions(+), 920 deletions(-)
 create mode 100644 arch/parisc/kernel/alternative.c
 delete mode 100644 arch/parisc/kernel/syscall_table.S
 create mode 100644 arch/parisc/kernel/syscalls/Makefile
 create mode 100644 arch/parisc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
