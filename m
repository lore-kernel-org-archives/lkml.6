Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeBAPci (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:32:38 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44930 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeBAPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:32:34 -0500
Date: Thu, 01 Feb 2018 10:32:32 -0500 (EST)
Message-Id: <20180201.103232.225802399998503989.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] IDE
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get this small IDE cleanup.

Thanks!

The following changes since commit 47d5cc5be396eca67cc89572957ff16f10fd768e:

  Merge tag 'hwmon-for-linus-v4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2018-01-29 11:20:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 8b76f5da49f0d432a747dbc0c4667dcd1ffb9945:

  ide: remove duplicated assignment to 'cursg' (2018-01-29 15:01:09 -0500)

----------------------------------------------------------------
Colin Ian King (1):
      ide: remove duplicated assignment to 'cursg'

 drivers/ide/ide-taskfile.c | 1 -
 1 file changed, 1 deletion(-)
