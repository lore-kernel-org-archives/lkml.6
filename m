Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D34C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33442152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33442152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbeITQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:40:16 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44823 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeITQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:40:16 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A67BB3001EF4C;
        Thu, 20 Sep 2018 12:57:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7D30D110; Thu, 20 Sep 2018 12:57:19 +0200 (CEST)
Date:   Thu, 20 Sep 2018 12:57:19 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andreas Bosch <progandy@bosch-fellbach.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Mason <clm@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lxom.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180920105719.ktnmzcfzih2tytfi@wunner.de>
References: <20180917114852.hzo36b2fewdzqc4t@wunner.de>
 <20180917122430.GA3320@kroah.com>
 <20180918201631.as5zjjkldtkduwll@wunner.de>
 <61b4a3f9-ccd1-061c-1c1b-ec993b056c66@bosch-fellbach.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b4a3f9-ccd1-061c-1c1b-ec993b056c66@bosch-fellbach.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:31:26PM +0200, Andreas Bosch wrote:
> Am 18.09.18 um 22:16 schrieb Lukas Wunner:
> > On Mon, Sep 17, 2018 at 02:24:30PM +0200, Greg Kroah-Hartman wrote:
> >> On Mon, Sep 17, 2018 at 01:48:52PM +0200, Lukas Wunner wrote:
> >>> On Sun, Sep 16, 2018 at 12:22:43PM -0700, Linus Torvalds wrote:
> >>>> +Scope
> >>>> +=====
> >>>> +
> >>>> +This Code of Conduct applies both within project spaces and in public
> >>>> +spaces when an individual is representing the project or its community.
> >>>> +Examples of representing a project or community include using an
> >>>> +official project e-mail address, posting via an official social media
> >>>> +account, or acting as an appointed representative at an online or
> >>>> +offline event. Representation of a project may be further defined and
> >>>> +clarified by project maintainers.
> >>> 
> >>> Seriously though, I read this to know what I need to be aware of but oddly
> >>> the language of this paragraph says it doesn't apply to me:  I'm not using
> >>> an official project e-mail address nor an official social media account,
> >>> nor has anyone appointed me as representative.  I can live with that, I'm
> >>> just wondering what the benefit of a document is that only seems to apply
> >>> to a tiny fraction of the community.
> >> 
> >> I do not think you are reading the document correctly.  As an example,
> >> it should cover any emails sent to this list.  That is not a "tiny
> >> fraction" by my last count :)
> 
> The document applies if you attach the representation qualifier only to
> the public spaces. The chosen language seems problematic since the scope
> of the qualifier is unclear. The two possible readings are: 1) This Code
> of Conduct applies within project spaces. In addition it applies in
> public spaces when an individual is representing the project or its
> community. 2) This Code of Conduct applies both within project spaces and
> in public spaces. It does only apply when an individual is representing
> the project or its community. The first reading is the expected version
> I think, but this should be clarified. -- Andreas

Thanks, that makes sense.  Indeed I had mentally inserted logical
parentheses like this when parsing the sentence:

    This Code of Conduct applies ( both within project spaces and in public
    spaces ) when an individual is representing the project or its community.

It might be beneficial to disambiguate the sentence, e.g.:

    This Code of Conduct applies within project spaces.  It also applies in
    public spaces when an individual is representing the project or its
    community.

If that is the intended meaning.

Kind regards,

Lukas
