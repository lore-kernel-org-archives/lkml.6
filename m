Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF4B2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF4B2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeHQTGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:06:16 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:51382 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbeHQTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:06:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C550A18033E6F;
        Fri, 17 Aug 2018 16:02:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: end50_6b2e3e4f9461c
X-Filterd-Recvd-Size: 2242
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Aug 2018 16:02:16 +0000 (UTC)
Message-ID: <960e6632bb6c9e45845e9078af6dd5939cd3bea6.camel@perches.com>
Subject: Re: [PATCH] license-rules.rst and LICENSES: Use only spdx version 3
 with -only and -or-later
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        linux-doc@vger.kernel.org
Date:   Fri, 17 Aug 2018 09:02:15 -0700
In-Reply-To: <20180817053711.1f7ef05b@lwn.net>
References: <f9a4cd2b1c1cd7938a4e0b8aa9489a0ad96669ca.1534443693.git.joe@perches.com>
         <20180817053711.1f7ef05b@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 05:37 -0600, Jonathan Corbet wrote:
> On Thu, 16 Aug 2018 11:26:03 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > The current linux-kernel source git tree has a mixture of the deprecated
> > spdx version 2 and the newer version 3 uses.
> > 
> > Update the process/license-rules.rst file to show only the version 3 style
> > and use only the version 3 styles in LICENSES.
> > 
> > Add a script to update all old versions in the tree as well.
> > 
> > I suggest this be applied and the script be run and applied immediately
> > after an -rc1.  The script could also be used at any time after the initial
> > use to update any other deprecated spdx license uses.
> 
> All seems OK to me, with one question: if we're going to run the script
> and fix everything up, do we really need to add that script to the tree
> as well?  It seems like something we shouldn't need again.

linux-next has other files with licenses that would need to be
updated even after an -rc1

