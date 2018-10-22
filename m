Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAB220779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ydOoFDOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAB220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeJVRZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:25:40 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:63020 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJVRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:25:40 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 509534BB45;
        Mon, 22 Oct 2018 11:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received; s=mail20150812; t=1540199278; bh=6uTVjvcF5l
        +mpohXDlqqFOwMfZmIIuwkqsPbKLUfw9w=; b=ydOoFDOIHikAi6hqRH+CS1A2GG
        euSUTmPBydo+10fMDPx2aKM7PtI2L2VRrkQwEnHcF6lReCj1uMSrl5UaeoO20u18
        /MVTZWDWh3xwz/l6+EJfMevsK5do/v/x36BXd0SZJAbrrzHxD92YHS+CM4b5GcfR
        xSoIZR4Ebvv4P6HAn5v4wA6o4SIdinvFsRxRIf9Vw15xyuOkEaLNHG9Y93kz7pPX
        EVDI0TIxQHXipi2O5I319uwAe9+LdSWHsDBrBgkmtsv+FStPfkhDZpA6hFv0kRQ0
        agFA0KYU+rz5w8zppGCClW+EWtDXaiKIRtNkf3KglyWDz5jobrY3cFXppRbg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id a7l2VbH4JtZt; Mon, 22 Oct 2018 11:07:58 +0200 (CEST)
From:   Rainer Fiebig <jrf@mailbox.org>
To:     NeilBrown <neil@brown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
Date:   Mon, 22 Oct 2018 11:09:26 +0200
Message-ID: <1922559.38OmgndT9b@siriux>
In-Reply-To: <87y3ar80ac.fsf@notabene.neil.brown.name>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 22. Oktober 2018, 08:20:11 schrieb NeilBrown:
> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
> > Hi all,
> >=20
> > As everyone knows by now, we added a new Code of Conduct to the ker=
nel
> > tree a few weeks ago.
>=20
> I wanted to stay detached from all this, but as remaining (publicly)

And I didn't expect myself to ever post in this matter again, as I had
already given up and relegated it to the "waste of precious lifetime"=20=

category. But your initiative and courage deserve support and so:

+1.

> I call on the community to consider what *does* need to be said, abou=
t
> conduct, to people outside the community and who have recently joined=
.
> What is the document that you would have liked to have read as you we=
re
> starting out?  It is all too long ago for me to remember clearly, and=
 so
> much has changed.

On the day the patch came out, I started working on a modified version,=
=20
a CoC that I could have lived with. I guess this was my way of dealing=20=

with this unfortunate affair.=20

So please find below what I would have submitted for discussion.

Thanks and regards!

Rainer Fiebig


Disclosure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
My contribution to the Linux kernel is admittedly negligible: I run rc-=

kernels, have reported a few problems, helped to fix them and fixed one=
=20
myself. To the extent of the time and effort this took me, I dare to gi=
ve=20
my opinion in this matter.=20

---


Code of Conduct
+++++++++++++++

The goal of the Linux kernel development process is to maintain and adv=
ance
the most robust operating system kernel ever.

Needless to say, views on how to achieve this will differ at times.

In order to keep arguments civilized and to ensure an open, positive=20=

and constructive environment, we have setup guidelines=20
that participants are expected to comply with:

No bias
=3D=3D=3D=3D=3D=3D=3D

Nobody must be discriminated or favored due to personal traits like
- for example - age, gender or ethnicity. They are irrelevant.
What counts is whether the contribution is in line with a/m goal.
Any such contribution will be carefully reviewed.

Be excellent to each other
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Don't do to others what you don't want others to do to you.
Straightforward talk is fine. But dissent can be communicated in a=20
non-destructive manner. And keep in mind that at times it may be *you*=20=

who is dead wrong.

Examples of encouraged behavior:

* Being respectful of differing viewpoints
* Criticizing constructively, i. e. showing ways for improvement
* Accepting constructive criticism
* Focusing on what is best for our goal and the community

Examples of unacceptable behavior:

* Comments intended to insult, depreciate or defame a person
* Public or private harassment
* Unwelcome sexual attention or advances
* Fabricating incriminations by quoting out of context
* Publishing others=E2=80=99 private information, such as a physical or=
 electronic
  address, without explicit permission
* Promoting political agendas
* Trolling

Responsibilities
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

All participants are responsible for complying with this Code of Conduc=
t.

Maintainers are responsible for clarifying the standards of acceptable=20=

behavior and are expected to take appropriate and fair corrective actio=
n in=20
response to any instances of obviously unacceptable behavior.

Maintainers have the right to ban temporarily or permanently any contri=
butor=20
who's behavior is not aligned to this Code of Conduct.

Arbitration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Anyone who feels abused, harassed or affected by otherwise unacceptable=
=20
behavior may report this to the Technical Advisory Board (TAB)=20
at <tab@lists.linux-foundation.org>.=20

All complaints will be reviewed and investigated and will result in a r=
esponse=20
that is deemed necessary and appropriate to the circumstances.=20

The TAB is obligated to maintain confidentiality with regard to the rep=
orter=20
of an incident.

Further details of specific arbitration policies may be posted separate=
ly.

Attribution
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Some elements of this Code of Conduct are derived from the Contributor=20=

Covenant, version 1.4, available at https://www.contributor-covenant.or=
g/version/1/4/code-of-conduct.html
