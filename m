Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E782083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E782083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJOSbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:31:35 -0400
Received: from nautica.notk.org ([91.121.71.147]:50920 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeJOSbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:31:34 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 321A3C009; Mon, 15 Oct 2018 12:46:51 +0200 (CEST)
Date:   Mon, 15 Oct 2018 12:46:36 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 2/2] 9p/trans_fd: put worker reqs on destroy
Message-ID: <20181015104636.GA14200@nautica>
References: <20181009020949.GA29622@nautica>
 <1539057956-23741-1-git-send-email-asmadeus@codewreck.org>
 <1539057956-23741-2-git-send-email-asmadeus@codewreck.org>
 <CAAHj5qgBteZQOkjF-n3OXvN9e0v6NYEsqg3YOitEKW0jikTpng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAHj5qgBteZQOkjF-n3OXvN9e0v6NYEsqg3YOitEKW0jikTpng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Tue, Oct 09, 2018:
> Il giorno mar 9 ott 2018 alle ore 06:06 Dominique Martinet
> > Fixes: 728356dedeff8 ("9p: Add refcount to p9_req_t")
> > Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> > Cc: Eric Van Hensbergen <ericvh@gmail.com>
> > Cc: Latchesar Ionkov <lucho@ionkov.net>
> > Cc: Tomas Bortoli <tomasbortoli@gmail.com>
>
> Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>

Thanks Tomas.

Tests seem ok, I've push both patches to my next branch, and will submit
them with the rest in a couple of weeks.
Quite a few of my patches haven't had reviews this cycle, if you read
this and have a bit of time, please pull my branch and have a read, or
each commit has a link to the lkml post to reply somewhat easily.


Reminder gir url:
 git://github.com/martinetd/linux 9p-next

-- 
Dominique
