Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA93C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489EF2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489EF2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJJXdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:33:10 -0400
Received: from nautica.notk.org ([91.121.71.147]:43008 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJXdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:33:10 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9E978C009; Wed, 10 Oct 2018 18:10:18 +0200 (CEST)
Date:   Wed, 10 Oct 2018 18:10:03 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dvyukov@google.com, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Subject: Re: Re: BUG: corrupted list in p9_read_work
Message-ID: <20181010161003.GA5371@nautica>
References: <20181010144855.GB20918@nautica>
 <00000000000010889e0577e0f5f2@google.com>
 <20181010160022.GD20918@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010160022.GD20918@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Wed, Oct 10, 2018:
> It works though, is it just picky because I didn't end it in .git? let's
> try again, sorry for the noise...
> 
> #syz test: git://github.com/martinetd/linux.git e4ca13f7d075e551dc158df6af18fb412a1dba0a

And I guess the commit hash needs to be in the default clone branch to
work ?
('git fetch <repo> <hash>' happily fetches the commit in a new clone for
me... But that feels like a github specific behaviour maybe)

Oh, well; made a branch for it, last try for me.

#syz test: git://github.com/martinetd/linux.git for-syzbot

-- 
Dominique
