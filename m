Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B9C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2A52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBKCVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 21:21:33 -0500
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:53895 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbfBKCVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 21:21:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 32541100E86C5;
        Mon, 11 Feb 2019 02:21:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stage23_6466a37a65663
X-Filterd-Recvd-Size: 2116
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Feb 2019 02:21:29 +0000 (UTC)
Message-ID: <5c2a49b12bb82279e51045eabf67055944cad3f2.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 10 Feb 2019 18:21:28 -0800
In-Reply-To: <1549823158.4142.12.camel@linux.ibm.com>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
         <1549823158.4142.12.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-02-10 at 10:25 -0800, James Bottomley wrote:
> On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> > Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen
> > as
> > further maintainer to the KEYS-TRUSTED section entry. So, we rectify
> > this
> > with this commit.
> > 
> > The issue was detected when writing a script that parses MAINTAINERS.
> > 
> > Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for
> > trusted keys")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> This isn't really a bug, is it?

No, it's a style defect.

> We have no formatting requirements for the MAINTAINERS file and the
> section owner is free to align with tabs, spaces or nothing as they see
> fit.  Most use a single tab, but a couple don't. The only real thing
> that cares is get_maintainers.pl and it uses \s* as the parse regexp,
> so it doesn't care either.

Not really.

It doesn't 'care' because get_maintainer is designed
to work with badly formatted entries.

checkpatch does emit warnings for MAINTAINER entries
that use anything other than a single tab.



