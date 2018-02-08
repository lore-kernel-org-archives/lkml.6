Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBHKLk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:11:40 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:33215 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHKLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:11:39 -0500
Date: Thu, 8 Feb 2018 11:11:36 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cris-kernel@axis.com
Subject: [GIT PULL] CRIS for 4.16
Message-ID: <20180208101136.GQ11498@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Please pull the below for the only change I had in the CRIS tree for 4.16.
It looks as there was som breakage in 4.15-rc3 for CRIS, which I'll send
as a separate pull-request based on 4.15 asap.

The following changes since commit bebc6082da0a9f5d47a1ea2edc099bf671058bd4:

  Linux 4.14 (2017-11-12 10:46:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jesper/cris.git tags/cris-for-4.16

for you to fetch changes up to fd989db807a00d552ebf29d8ffb20c2ef04742da:

  cris: Fix conflicting types for _etext, _edata, _end (2018-01-13 22:42:09 +0100)

----------------------------------------------------------------
CRIS port changes for 4.16

Includes only a small fix for some conflicting symbols, aligning CRIS
with other platforms.

----------------------------------------------------------------
Sergey Senozhatsky (1):
      cris: Fix conflicting types for _etext, _edata, _end

 arch/cris/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
