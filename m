Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55395C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287B2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F287B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeI2TND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:13:03 -0400
Received: from thyrsus.com ([71.162.243.5]:53716 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeI2TND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:13:03 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 3D6AE3A42A2; Sat, 29 Sep 2018 08:44:18 -0400 (EDT)
Date:   Sat, 29 Sep 2018 08:44:18 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        xDynamite <dreamingforward@gmail.com>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180929124418.GA23354@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        xDynamite <dreamingforward@gmail.com>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com, riel@surriel.com,
        ec429@cantab.net, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
References: <87zhwbj8xe.fsf@redhat.com>
 <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
 <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
 <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
 <CAMjeLr-j1XhZJgcvsP5z6SHCDmbUA=rMyfvQpX40qKBK+2ojbw@mail.gmail.com>
 <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at>
 <20180928165653.17bbdb13@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928165653.17bbdb13@alans-desktop>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <gnomes@lxorguk.ukuu.org.uk>:
> The wording IMHO just needs tightening up - and that's a useful
> discussion that ought to he bad. I tihnk everyone understands the *inent*
> of such wording - don't go around doxing people, or posting their home
> address on facebook and calling for people to attend with pitchforks.

I'm going to, again, avoid normative statements and try to clarify what
the questions are here, speaking from my anthropologist/game-theorist head.

As a matter of process, there are two different sets of issues about changing
the CoC wording.  Referring to my previous post on ethos and telos:

       https://lkml.org/lkml/2018/9/23/212

1. The wording needs to be tweaked to make it clearer what things are against
the ethos. For example: we may want Code violations to include hateful speech
on the mailing list directed at other LKML members.  Does it follow that
we want the Code to proscribe "hate speech" directed against third parties,
or off-list "hateful" behavior? Perhaps we do, perhaps not; but either
way the boundaries need to be clearer.

2. The language needs to be examined with particular care to discover
where it implies a change to LKML's telos. I argue no position at this time
about whether LKML's telos *should* change, but I note that the rather heated
dissent the CoC has provoked comes from a widespread perception that it *is*, in
fact, a none-too-covert attempt to alter the telos.

I further note that this perception is supported by the CoC Author's
"Post-Meritocracy manifesto".

        https://postmeritocracy.org/

Kernel contributors, understandably, want a clear read on whether the
application of the CoC is to be guided by meritocratic or
"post-meritocratic" principles.  This is a telos issue, not just
an ethos issue, and much more fundamental.

I endorse a suggestion made elsewhere that a revised CoC would best be
developed by an RFC-like process. Because *that is how we do such things*;
that is *our* culture's mechanism for achieving and maintaining consensus
on difficult issues.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


