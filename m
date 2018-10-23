Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02589C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEBC207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEBC207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJWMZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:25:49 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:51738 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeJWMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:25:49 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 3690A1A40245; Mon, 22 Oct 2018 21:04:18 -0700 (PDT)
Date:   Mon, 22 Oct 2018 21:04:18 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        reiserfs-devel@vger.kernel.org
Subject: Re: Reiser4 Linux 4.17.19-1 hangs in Google cloud VM, too.
Message-ID: <20181023040418.iz7gcph3qha4bkab@shells.gnugeneration.com>
References: <20181022101912.3CE2E292B005@huitzilopochtli.metztli-it.com>
 <20181023033852.GR32577@ZenIV.linux.org.uk>
 <20181023034719.tqkvdj2eakh2uh2q@shells.gnugeneration.com>
 <20181023035425.GS32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023035425.GS32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 04:54:25AM +0100, Al Viro wrote:
> On Mon, Oct 22, 2018 at 08:47:19PM -0700, Vito Caputo wrote:
> > On Tue, Oct 23, 2018 at 04:38:52AM +0100, Al Viro wrote:
> > > On Mon, Oct 22, 2018 at 03:19:12AM -0700, Metztli Information Technology wrote:
> > > > I installed reiser4 -enhanced Linux kernel 4.17.19-1 --thus replacing the prior hung reiser4 -patched kernel 4.18.15-1 in the Google Compute Engine (GCE) cloud instance. After less than 24 hours the 4.17.19-1 hung in similar way to the 4.18.15-1.
> > > > 
> > > > Please note that I had been running my custom Metztli Reiser4 Debian Stretch image with reiser4 linux 4.14.20-1 without issues for several months
> > > > < https://github.com/Metztli/reiser4-debian-kernel-packaging-4.14.20 >  --until I decided to upgrade to newer kernel(s).
> > > 
> > > Er...  Does anybody maintain reiser4 these days?  I can't recall a single mail
> > > along the lines of "such-and-such VFS/VM/scheduler/etc. change would break reiser4"
> > > in quite a few years (more than a decade, most likely)...
> > 
> > I've wondered if we should rename reiserfs to something else.  As-is,
> > it's not likely to attract any developers since it may as well be named
> > hitlerfs or something similarly uncomfortable to explain to a
> > significant other as what you've been working on.
> 
> Sigh...  Godwin Law in action, at the third posting in thread ;-/
> 
> > That is, assuming it's going to continue to exist in-tree...
> 
> reiser4 has never been in-tree to start with.  And name is completely irrelevant -
> all I'm refering to is that I have not seen any postings on l-k/fsdevel/etc.
> from anybody working on that particular out-of-tree codebase.
> 
> Put it that way - I would expect the bitrot from (apparent) decade-long
> inactivity to be a much more serious problem than anything naming-related.

Would you say bitrot is more or less likely if a project doesn't attract
fresh meat?

Regards,
Vito Caputo
