Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeBSUVy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:21:54 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38148 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbeBSUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:21:53 -0500
X-Google-Smtp-Source: AH8x2273GJ4dS7F9fJ+SVXOdadtG8TPmpTdz6FNY1r7YiKvdY036h3uvPwQmYq9cSftbPcfyfUHBTA==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        rpurdie@rpsys.net, jacek.anaszewski@gmail.com
Subject: [GIT PULL] LED update for 4.16-rc3
Date: Mon, 19 Feb 2018 21:20:25 +0100
Message-Id: <1519071625-31593-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED update to MAINTAINERS, to admit the reality.

Message from Richard:

"I've been looking at some of the emails but not needed to be involved
for a while now, you're doing fine without me!" [0]

Many thanks to Richard for his work as a founder of the LED subsystem!

[0] https://lkml.org/lkml/2018/2/18/145

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds_for-4.16-rc3

for you to fetch changes up to a988681dbbca01c64d86455c0153899870d7a63c:

  MAINTAINERS: Remove Richard Purdie from LED maintainers (2018-02-19 20:23:49 +0100)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LED update to MAINTAINERS
----------------------------------------------------------------
Jacek Anaszewski (1):
      MAINTAINERS: Remove Richard Purdie from LED maintainers

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)
