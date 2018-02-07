Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeBGUq1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:46:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754281AbeBGUq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:46:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425BD2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Wed, 7 Feb 2018 21:46:22 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [GIT PULL] modules updates for 4.16
Message-ID: <20180207204619.my6wmay3iqwogwia@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull below to receive a small set of changes for modules for the 4.16 merge window.

Note: Rusty's MAINTAINERS update was sent to my work email during my leave
of absence, hence the much later commit date. Rusty, if you're still
reading, thank you for your amazing work and I'll try not to screw up too badly :-)

Thanks,

Jessica

---
The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v4.16

for you to fetch changes up to 0cad61d7a3d51e0237a7e421c75b04ebbb5062d0:

  modpost: Remove trailing semicolon (2018-01-16 18:34:04 +0100)

----------------------------------------------------------------
Modules updates for v4.16

Summary of modules changes for the 4.16 merge window:

- Minor code cleanups and MAINTAINERS update

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Luis de Bethencourt (1):
      modpost: Remove trailing semicolon

Namit Gupta (1):
      ftrace/module: Move ftrace_release_mod() to ddebug_cleanup label

Rusty Russell (1):
      MAINTAINERS: Remove from module & paravirt maintenance

 MAINTAINERS           | 2 --
 kernel/module.c       | 7 +------
 scripts/mod/modpost.c | 2 +-
 3 files changed, 2 insertions(+), 9 deletions(-)
