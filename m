Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0DDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DBD218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfBHVnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:43:13 -0500
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:51486 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727300AbfBHVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:43:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D0C3C180E2E40;
        Fri,  8 Feb 2019 21:43:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: war94_1bbb3e4fe2f46
X-Filterd-Recvd-Size: 1948
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Feb 2019 21:43:10 +0000 (UTC)
Message-ID: <1c29159a1b55cb6ad278023588861268e22e626c.camel@perches.com>
Subject: Re: [PATCH v3 00/15] Habana Labs kernel driver
From:   Joe Perches <joe@perches.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 08 Feb 2019 13:43:09 -0800
In-Reply-To: <CAFCwf10K9Ejqm_=jrtOyXAs4yL-6zs1X79O=dwjg=2jmB3PPYA@mail.gmail.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
         <20190206115237.GA6750@rapoport-lnx>
         <CAFCwf10K9Ejqm_=jrtOyXAs4yL-6zs1X79O=dwjg=2jmB3PPYA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 23:33 +0200, Oded Gabbay wrote:
> On Wed, Feb 6, 2019 at 1:52 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > On Mon, Feb 04, 2019 at 10:32:39PM +0200, Oded Gabbay wrote:
> > > Hello,
> > > This is v3 of the Habana Labs kernel driver patch-set. It contains minor fixes
> > > according to reviews done on v2. In addition, it is rebased on v5.0-rc5.
[]
> > Nit: git am is unhappy about black lines at EOF, e.g:
> > 
> > Applying: habanalabs: add basic Goya support
> > .git/rebase-apply/patch:29: new blank line at EOF.
> > +
> Yes, but on the other hand, joe perches gave me a comment about
> missing newline at end of Makefile.
> So either diff will complain or git am.

Not really.

The desired modification was the last non-blank line of
the Makefile should have a terminating newline, not that
there was a blank line at EOF.


