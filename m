Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeA3EBZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 23:01:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752221AbeA3EBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 23:01:23 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/4] objtool: seg fault fixes and retpoline improvements
Date: Mon, 29 Jan 2018 22:00:38 -0600
Message-Id: <cover.1517284349.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some assorted fixes and improvements.

Josh Poimboeuf (4):
  objtool: Improve retpoline alternative handling
  objtool: Add support for alternatives at the end of a section
  objtool: Warn on stripped section symbol
  objtool: Don't print '.tmp_' prefix for .o files

 tools/objtool/check.c   | 110 ++++++++++++++++++++++++++++++------------------
 tools/objtool/orc_gen.c |   5 +++
 2 files changed, 73 insertions(+), 42 deletions(-)

-- 
2.14.3
