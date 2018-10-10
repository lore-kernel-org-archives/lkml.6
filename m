Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F74C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021042086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021042086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJJXX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:23:26 -0400
Received: from nautica.notk.org ([91.121.71.147]:42204 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJJXX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:23:26 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7759AC009; Wed, 10 Oct 2018 18:00:37 +0200 (CEST)
Date:   Wed, 10 Oct 2018 18:00:22 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dvyukov@google.com, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Subject: Re: Re: BUG: corrupted list in p9_read_work
Message-ID: <20181010160022.GD20918@nautica>
References: <20181010144855.GB20918@nautica>
 <00000000000010889e0577e0f5f2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000010889e0577e0f5f2@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote on Wed, Oct 10, 2018:
>>> But note that syzbot can test fixes itself on request. It boils down
>>> to just giving it the patch and the base tree:
>>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>
>> .. and for clarifying that bit, let's try that! :)
>
>> #syz test: git://github.com/martinetd/linux
>> e4ca13f7d075e551dc158df6af18fb412a1dba0a
>
> "git://github.com/martinetd/linux" does not look like a valid git
> repo address.

It works though, is it just picky because I didn't end it in .git? let's
try again, sorry for the noise...

#syz test: git://github.com/martinetd/linux.git e4ca13f7d075e551dc158df6af18fb412a1dba0a

-- 
Dominique
