Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD07C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBB42171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfABDy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 22:54:57 -0500
Received: from nautica.notk.org ([91.121.71.147]:55472 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbfABDy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 22:54:56 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B8CD0C009; Wed,  2 Jan 2019 04:54:54 +0100 (CET)
Date:   Wed, 2 Jan 2019 04:54:39 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [GIT PULL] 9p updates for 4.21
Message-ID: <20190102035439.GA30733@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small pull request this time around with only two commits; some missing
prototype warning fix and a syzkaller fix when a 9p server advertises a
too small msize.

The commit date is close-ish because I reworded a commit message to
add a Cc to stable for the msize fix recently, but the patchs themselves
have been in linux-next since Nov 20~ish


Thanks,

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://github.com/martinetd/linux tags/9p-for-4.21

for you to fetch changes up to 574d356b7a02c7e1b01a1d9cba8a26b3c2888f45:

  9p/net: put a lower bound on msize (2018-12-25 17:07:49 +0900)

----------------------------------------------------------------
Pull request for inclusion in 4.21

Missing prototype warning fix and a syzkaller fix when a 9p server
advertises a too small msize

----------------------------------------------------------------
Adeodato Simó (1):
      net/9p: include trans_common.h to fix missing prototype warning.

Dominique Martinet (1):
      9p/net: put a lower bound on msize

 net/9p/client.c       | 21 +++++++++++++++++++++
 net/9p/trans_common.c |  1 +

-- 
Dominique Martinet
