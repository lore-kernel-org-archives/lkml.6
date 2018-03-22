Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCVW2W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbeCVW2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:28:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866332183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Thu, 22 Mar 2018 23:28:13 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules fix for 4.16-rc7
Message-ID: <20180322222813.ymjaa3bvquad5uav@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v4.16-rc7

for you to fetch changes up to 3f553b308bb004eb730da8e00a28150c157c7724:

  module: propagate error in modules_open() (2018-03-08 21:58:51 +0100)

----------------------------------------------------------------
Modules fix for v4.16-rc7

- Propagate error in modules_open() to avoid possible later NULL
  dereference if seq_open() had failed.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Leon Yu (1):
      module: propagate error in modules_open()

 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
