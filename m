Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623972098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vg3Oy3ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623972098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeGPKYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:24:01 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60674 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeGPKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3hpgwI9Ab1dnZAHt1KPZcPyeIZrWyE3MwkLaJCvSnvk=; b=Vg3Oy3ouwbZawFLJvT6MbAs1/
        1xaAEP8QgU4UF/cZbDGkr05l2ROLZNuyF9fUkQgPklEzYCRZEc2ryvRr8qlVxr4Nf8LA/YEM7h/sl
        fRzp9YWlhpD+Wa/M7wrLBh/fQD007Jf98nqVBFqEB5u60S4VYjal80owFOGSDpx5kQg6c=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:51125)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ff0Fh-0003hn-HO; Mon, 16 Jul 2018 10:57:09 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1ff0FZ-0004Es-Ts; Mon, 16 Jul 2018 10:57:02 +0100
Date:   Mon, 16 Jul 2018 10:57:00 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
Message-ID: <20180716095700.GC17271@n2100.armlinux.org.uk>
References: <20180716075718.4e5ef491@canb.auug.org.au>
 <CAOesGMhVeo6Wc=nMcEnusa+FfwQBWJnxs0LY-zXm4HMau+SMhg@mail.gmail.com>
 <6a9fa6f3-7aef-a83b-72a6-dc9492964b5e@gmail.com>
 <CAGb2v667K4Z6o-KEQROWuCbgJbKLNX_OCpCBOWaECb_qfRMBpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v667K4Z6o-KEQROWuCbgJbKLNX_OCpCBOWaECb_qfRMBpw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 05:24:08PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 16, 2018 at 5:13 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> >
> > On 07/15/2018 03:50 PM, Olof Johansson wrote:
> >> Thanks Stephen, I keep saying every time you catch these that I need
> >> to run the same script. :(
> >>
> >> Florian, I wonder if this happened when you rebased to squash in the fix?
> >
> > Humm, could be, all I did (and it was not the first time) was to do an
> > interactive rebase with --preserve-merges. AFAICT, all of these commits
> > came from Eric's pull request, so what I typically do is just sign off
> > on the merge commit, but do not apply my SoB to all commits coming from
> > that pull request if that makes sense?
> 
> When you rebase, if the commit is re-applied, the committer changes to
> you, so you need to add your SoB to all commits you rebased.
> 
> I suppose you could override it with GIT_COMMITTER_NAME and
> GIT_COMMITTER_EMAIL environment variables, but that sort of distorts
> the SoB if any changes were added due to rebasing, such as resolution
> of merge conflicts.

A different point: should *anyone* be rebasing commits that they did not
themselves commit.  Discuss.

IMHO no - the commits were made public, and anyone could pull the tree
from which they came in order to do further work before submitting that.
Rebasing changes the commit IDs, which can lead to duplicate commits
ending up in mainline.  With other changes on top, this causes totally
unnecessary conflicts.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
