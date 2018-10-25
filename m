Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1AFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392732075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392732075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJYTkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:40:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:37706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbeJYTkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:40:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2883AAE78;
        Thu, 25 Oct 2018 11:08:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 21F0D1E06C6; Thu, 25 Oct 2018 13:08:04 +0200 (CEST)
Date:   Thu, 25 Oct 2018 13:08:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC][PATCH 00/11] common implementation of dirent file types
Message-ID: <20181025110804.GG3626@quack2.suse.cz>
References: <20181023201952.GA15676@pathfinder>
 <CAOQ4uxgFdquNqcRXETriSvwc24DDQbmu218WFv-a5K3k0nuu7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgFdquNqcRXETriSvwc24DDQbmu218WFv-a5K3k0nuu7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-10-18 09:43:21, Amir Goldstein wrote:
> Once all comments are addressed and assuming no objections, you have
> two possible ways forward:
> 
> 1. Wait for VFS maintainer to take the common code and patches ACKed
>     by individual maintainers (Al practically maintains some of the small fs
>     himself). Al's backlog is long, so this may be a long wait.
> 
> 2. Ask a filesystem maintainer to carry the common patch along with his
>    specific fs patch through his tree and let other maintainers apply the patch
>    at their own will on the following development cycle.
>    The ext2 tree would be a good candidate for such a move, if Jan accepts
>    this change, considering that all other fs copied the buggy code from ext2.

I can take these patches through my tree if Al takes too long to respond
(but he apparently already had a look at the patches which is a good sign
;) and if patches are reviewed by respective fs maintainers.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
