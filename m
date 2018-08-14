Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01498C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606EA218FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606EA218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbeHNMBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:01:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:52756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728101AbeHNMBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:01:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67C2FAD1A;
        Tue, 14 Aug 2018 09:14:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF6B9DA790; Tue, 14 Aug 2018 11:14:38 +0200 (CEST)
Date:   Tue, 14 Aug 2018 11:14:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 4.19
Message-ID: <20180814091438.GD24025@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1534161966.git.dsterba@suse.com>
 <20180814185005.7a05e8ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814185005.7a05e8ec@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 06:50:05PM +1000, Stephen Rothwell wrote:
> Hi David,
> 
> On Mon, 13 Aug 2018 14:54:07 +0200 David Sterba <dsterba@suse.com> wrote:
> >
> > There are no known pending merge conflicts with other trees. Please
> > pull, thanks.
> 
> Except, presumably with what is in linux-next (which is similar, but
> not identical). :-(
> 
> Please clean up your linux-next included branch.

Done, sorry. Only the pull branch is there now.
