Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeDSIFu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:05:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:55359 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeDSIFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:05:48 -0400
Date: Thu, 19 Apr 2018 10:05:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching fix
Message-ID: <nycvar.YFH.7.76.1804191003320.28129@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching.git for-linus

to receive livepatching fix

=====
- livepatching shadow variable API list_head initialization fix from 
  Petr Mladek
=====

----------------------------------------------------------------
Petr Mladek (2):
      livepatch: Initialize shadow variables safely by a custom callback
      livepatch: Allow to call a custom callback when freeing shadow variables

 Documentation/livepatch/shadow-vars.txt   |  41 ++++++++----
 include/linux/livepatch.h                 |  19 ++++--
 kernel/livepatch/shadow.c                 | 108 ++++++++++++++++++++----------
 samples/livepatch/livepatch-shadow-fix1.c |  43 +++++++++---
 samples/livepatch/livepatch-shadow-fix2.c |  33 ++++-----
 5 files changed, 163 insertions(+), 81 deletions(-)

-- 
Jiri Kosina
SUSE Labs
