Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A249AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382CC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382CC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeI1WV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:21:56 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:34468 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1WVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:21:55 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8SFustW017023;
        Fri, 28 Sep 2018 16:56:54 +0100
Date:   Fri, 28 Sep 2018 16:56:53 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     xDynamite <dreamingforward@gmail.com>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180928165653.17bbdb13@alans-desktop>
In-Reply-To: <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
        <20180919081812.020f19e3@lwn.net>
        <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
        <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
        <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
        <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
        <87zhwbj8xe.fsf@redhat.com>
        <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
        <20180921231545.GC2966@thunk.org>
        <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
        <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
        <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
        <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
        <CAMjeLr-j1XhZJgcvsP5z6SHCDmbUA=rMyfvQpX40qKBK+2ojbw@mail.gmail.com>
        <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, then I have to repeat myself: Signed-off source code (in form of
> patches) in a well-known programming language for a (nowadays)
> well-known GPLv2 licensed project mailed on "everyone can subscribe"
> mailinglists, (thus) to be found in several $SEARCH_ENGINE-indexed
> mailinglist archives, if accepted to be found in lots of publicly
> accessible git repos can be not intended to be published?
> 
> I wonder what else must happen.

There is a bigger problem in the ambiguity.

It's easy to deal with signed off by lines because I had the sense to
make sure that the DCO covered us for EU data protection and thus it's
explicit.

It's relatively easy to deal with the case of 'I contributed some code'.

It's really not at all obvious what happens with 'I got some code from
another project that contains it's authors name'.

The wording IMHO just needs tightening up - and that's a useful
discussion that ought to he bad. I tihnk everyone understands the *inent*
of such wording - don't go around doxing people, or posting their home
address on facebook and calling for people to attend with pitchforks.

There's a second related area that needs sorting out in wording which is
the implication of any kind of privacy in a complaint - which is really
bad in two ways

As it is set up now the tab is not a lawyer so the tab could not claim
any kind of legal privilege. That means in the event of a complaint the
tab would be powerless not to release almost all the info in the
complaint if hit by a data protectin request in many jurisdictions. Sure
they'd have to (and be required to) remove some of the information that
might identify the complainant.

Secondly one thing that we've learned repeatedly (and notably from the
church scandals) is that there are some complaints that should upon
receipt be handed directly to law enforcement, but there is no carve out
for this.

The other issue is that whoever handles any complaint system needs a
budget and lawyers because they will potentially have to field judicial
reviews and other challenges. That means the TAB needs to have
exemplary record keeping and process because anyone who stands up in a
legal challenge and says 'Umm.. we read it and talked about it and kind
of decided X but I don't remember why and there are no minutes and there
is on process document' is going to get fried. Someone needs to have that
process in place well in advance.

Alan
