Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFCCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C912089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C912089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeKQKxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:53:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:38190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729525AbeKQKxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:53:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95F6EAFB4;
        Sat, 17 Nov 2018 00:39:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Dan Williams <dan.j.williams@intel.com>, rodrigo.vivi@gmail.com
Date:   Sat, 17 Nov 2018 11:38:50 +1100
Cc:     Leon Romanovsky <leon@kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org, mchehab+samsung@kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS: Subsystem Profile
In-Reply-To: <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com> <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com> <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com> <20181115061036.1575223d@silica.lan> <20181115162008.GO3759@mtr-leonro.mtl.com> <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com> <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
Message-ID: <87va4wczc5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Nov 16 2018, Dan Williams wrote:

> On Fri, Nov 16, 2018 at 12:37 PM Rodrigo Vivi <rodrigo.vivi@gmail.com> wrote:
>>
>> On Thu, Nov 15, 2018 at 8:38 AM Leon Romanovsky <leon@kernel.org> wrote:
>> >
>> > On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:
>> > > Em Thu, 15 Nov 2018 09:03:11 +0100
>> > > Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
>> > >
>> > > > Hi Dan,
>> > > >
>> > > > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
>> > > > > Document the basic policies of the libnvdimm subsystem and provide a
>> > > > > first example of a Subsystem Profile for others to duplicate and edit.
>> > > > >
>> > > > > Cc: Ross Zwisler <zwisler@kernel.org>
>> > > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
>> > > > > Cc: Dave Jiang <dave.jiang@intel.com>
>> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> > > >
>> > > > Thanks for your patch!
>> > > >
>> > > > > --- /dev/null
>> > > > > +++ b/Documentation/nvdimm/subsystem-profile.rst
>> > > >
>> > > > > +Trusted Reviewers
>> > > > > +-----------------
>> > > > > +Johannes Thumshirn
>> > > > > +Toshi Kani
>> > > > > +Jeff Moyer
>> > > > > +Robert Elliott
>> > > >
>> > > > Don't you want to add email addresses?
>> > > > Only the first one is listed in MAINTAINERS.
>> > >
>> > > IMO, it makes sense to have their e-mails here, in a way that it could
>> > > easily be parsed by get_maintainers.pl.
>> >
>> > I personally think that list of "trusted reviewers" makes more harm than
>> > good. It creates unneeded negative feelings to those who wanted to be in
>> > this list, but for any reason they don't. Those reviewers will feel
>> > "untrusted".
>>
>> I'd like to +1 on this concern here. Besides leaving all the other
>> people demotivated.
>
> Yes, that's a valid concern, I overlooked that unfortunate interpretation.
>
>>
>> A small group of trusted reviewers doesn't scale. People will get overloaded.
>> Or you won't be able to enforce that all patches need to get Reviews.
>>
>> Reviews should be coming from everywhere and commiters and maintainers
>> deciding on what to trust or re-review.
>>
>> Also the list is hard to maintain and keep the lists updated.
>
> I understand the concern, and as I saw feedback come in I realized
> there were more people that I would add to that reviewer list for
> libnvdimm.
>
> Stepping back the end goal is to have an initial list of recommended
> people to follow up with directly to seek a second opinion, or help in
> cases where a contributor otherwise needs some direction / engagement
> that they are not readily receiving from the maintainer. Typically
> someone just lurks on the mailing list for a few weeks to get a feel
> for who the usual suspects are in the subsystem, but for a new
> contributor identifying those individuals may be difficult.
>
> One of the contributing factors of lack of response to a patchset is
> that they are sent with the implicit expectation that the maintainer
> will get to eventually, and typically other people feel content to sit
> back and watch. If instead a contributor sent a direct mail to a
> "trusted reviewer" saying, "Hey, Alice, Bob seems busy can you help me
> out?" that seems more likely to rope in additional review help.

In here is, I think, a real issue that listing "trusted reviewers" might
help address.
As you say, people don't feel the need to comment - particularly if they
don't see anything wrong (often best to insert a bug to encourage
responses!).
Maybe if we list people, it will make them feel that their opinion is
valuable (trusted!) and that will encourage them to Ack or Review a
patch.
I have found that being given a title of responsibility can change my
thinking from "someone should" to "I should".

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvvYxsACgkQOeye3VZi
gblgmRAAsPOY774odqpS67uPN9Nu4n6RUqay1rldkX7Uu1GQ4x5lAtfuw4rf+zkO
8983uWS0vqJw2goVnvdNJaTpTGuxC4YlSsZ5Md3KojVqYc02SgSAlpDEEHPQ1VSu
aFmS3XGS2xEJRvamJNLEK0EWB88bogXWccUhXJf9HrsCjKwZsEBLSINRDaCqKebR
0asmvTLutpRjvLahFki1uvQUSzjkvN69fn+kf/DP0fpiUL9A814OLep49W0jaN4w
+Q5Pyh11p/AYdPlVSWUML8SVq0z1HlK6WVSrWd0WMHTk2VNmQepyruvMeboHOUbw
Lp72k4Iw1QzWYJXkfel4z8Xj24Ws3jDxEF8CPjOWa+P7aTke4joU+YMaFJK8FOWY
7P0rem9wBeAQeIQ+DHrQtwoz0IFgnxTRxu3eeaVn5uf6qmZKGUtXDPiFBTw2zYlv
ttx7INQB3h7lea1n4P02PNJlwo9jpKLPKFddEyw/2cylUyJTWn1qvOzvOwHR/oRn
AYlYQtJ8mlOMqNGybh/dcSMLIymmPIKF12adNQr1VGMML7VRwFAflybKId8EygKb
122/k51mG3+0cxtIGgeYZVPa/RYpFn167ZzXC45yRuQi0xvwkvtTl5ok94DDJFSo
uzcy7HeYyQWCh6UqVSODqnFDNruQTsEAnNFVjW+r3xSjK0Wjw5Q=
=hoyK
-----END PGP SIGNATURE-----
--=-=-=--
