Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0804EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCAB20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCAB20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeKJAt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:49:58 -0500
Received: from fieldses.org ([173.255.197.46]:40246 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKJAt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:49:57 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id B25502014; Fri,  9 Nov 2018 10:08:59 -0500 (EST)
Date:   Fri, 9 Nov 2018 10:08:59 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] fs/locks: create a tree of dependent requests.
Message-ID: <20181109150859.GA13643@fieldses.org>
References: <154138128401.31651.1381177427603557514.stgit@noble>
 <154138144796.31651.14201944346371750178.stgit@noble>
 <20181108213030.GF6090@fieldses.org>
 <87k1lnw0ec.fsf@notabene.neil.brown.name>
 <20181109030913.GA8831@fieldses.org>
 <87bm6ywyyj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm6ywyyj.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 05:24:04PM +1100, NeilBrown wrote:
> Thanks pretty thorough - and even looks correct.
> I'll re-reading some time when it isn't late, and maybe make it into a
> comment in the code.
> I agree, this sort of documentation can be quite helpful.

OK.  The idea looks sound to me, and the only problems I found were
documentation.  (I'd like this and the details in the 0/12 mail captured
somewhere.  And if we came up with better blocker/blocked/block naming
I'd be happier, though I definitely wouldn't want the patches help up
for that.)  Feel free to add my ACK to the series.

--b.
