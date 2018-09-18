Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B07BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2DF214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2DF214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeISBup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:50:45 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:57975 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbeISBup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:50:45 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E1424300168B5;
        Tue, 18 Sep 2018 22:16:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B70DC6F164; Tue, 18 Sep 2018 22:16:31 +0200 (CEST)
Date:   Tue, 18 Sep 2018 22:16:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chris Mason <clm@fb.com>, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lxom.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180918201631.as5zjjkldtkduwll@wunner.de>
References: <20180917114852.hzo36b2fewdzqc4t@wunner.de>
 <20180917122430.GA3320@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917122430.GA3320@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:24:30PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 17, 2018 at 01:48:52PM +0200, Lukas Wunner wrote:
> > On Sun, Sep 16, 2018 at 12:22:43PM -0700, Linus Torvalds wrote:
> > > +Scope
> > > +=====
> > > +
> > > +This Code of Conduct applies both within project spaces and in public
> > > +spaces when an individual is representing the project or its community.
> > > +Examples of representing a project or community include using an
> > > +official project e-mail address, posting via an official social media
> > > +account, or acting as an appointed representative at an online or
> > > +offline event. Representation of a project may be further defined and
> > > +clarified by project maintainers.
> > 
> > Seriously though, I read this to know what I need to be aware of but oddly
> > the language of this paragraph says it doesn't apply to me:  I'm not using
> > an official project e-mail address nor an official social media account,
> > nor has anyone appointed me as representative.  I can live with that, I'm
> > just wondering what the benefit of a document is that only seems to apply
> > to a tiny fraction of the community.
> 
> I do not think you are reading the document correctly.  As an example,
> it should cover any emails sent to this list.  That is not a "tiny
> fraction" by my last count :)

You may want to make that more explicit in the document.

The document appears to be geared towards smaller projects with
official project e-mail addresses handed out to a group and it
specifies dos and don'ts for members of that group when they have
their project hat on.

However in the kernel community there's a large continuum with
Linus and those who send him pulls on one end of the spectrum,
and random folks writing on the mailing lists or bugzillas at
the other end.  The further we get to the latter end, the more
menthal gymnastics are necessary (at least for me) to consider
the document applicable to them, given the restrictions laid
out in the "Scope" paragraph.

Just my 2 cents anyway.

Thanks,

Lukas
