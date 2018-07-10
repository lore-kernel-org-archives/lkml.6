Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17801C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD78F2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD78F2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbeGJXsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:48:12 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:37020 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732270AbeGJXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:47:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 956E1180A8124;
        Tue, 10 Jul 2018 23:46:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: quiet81_356c89d935e02
X-Filterd-Recvd-Size: 1870
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Jul 2018 23:46:07 +0000 (UTC)
Message-ID: <400ec2706f9239ae1819a60df0ddcd39e067d927.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
From:   Joe Perches <joe@perches.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Jul 2018 16:46:05 -0700
In-Reply-To: <20180710220803.GA6387@amd>
References: <20180710121014.31119-1-geert+renesas@glider.be>
         <20180710204706.GA30083@amd>
         <CAMuHMdVZae7Nb-Nr=f1uJD9ASxaio0Ob-5__FHzN=gEp9MSc+g@mail.gmail.com>
         <20180710220803.GA6387@amd>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 00:08 +0200, Pavel Machek wrote:
> On Tue 2018-07-10 22:50:14, Geert Uytterhoeven wrote:
> > Hi Pavel,
> > 
> > On Tue, Jul 10, 2018 at 10:47 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > > Print an error if none of the Signed-off-by lines cover the patch
> > > > author.
> > > 
> > > Is it good idea? Signed-off-by system was _not_ meant to prevent
> > > submission of third party patches.
> > 
> > My main motivation is catching accidentally forgotten Sobs.
> > It's still up to you to submit or accept a patch that triggers
> > checkpatch errors.
> 
> Should it be at warning level, then, or explicitely saying this is
> okay if you are not patch author?

Yes to both.

