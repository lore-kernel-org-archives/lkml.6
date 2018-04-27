Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933486AbeD0PTa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933132AbeD0PT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:19:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA583218C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Fri, 27 Apr 2018 17:19:23 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] modules fix for v4.17-rc3
Message-ID: <20180427151923.dscdjidlusli6aco@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below for a modules fix for 4.17-rc3.

Thanks,

Jessica

---
The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v4.17-rc3

for you to fetch changes up to be71eda5383faa663efdba9ef54a6b8255e3c7f0:

  module: Fix display of wrong module .text address (2018-04-18 22:59:46 +0200)

----------------------------------------------------------------
Modules fix for v4.17-rc3

- Fix display of module section addresses in sysfs, which were getting
hashed with %pK and breaking tools like perf.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Thomas Richter (1):
      module: Fix display of wrong module .text address

 kernel/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
