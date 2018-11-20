Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC514C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6645420C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6645420C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeKTUct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:32:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbeKTUcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:32:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BF20ACC8;
        Tue, 20 Nov 2018 10:04:28 +0000 (UTC)
Message-ID: <17a08397268fddb774ca0d1620d67ca38633a284.camel@suse.de>
Subject: Re: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 20 Nov 2018 11:04:26 +0100
In-Reply-To: <20181120095751.GB17738@kroah.com>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
         <1128999886.40745.1542556549581@email.ionos.de>
         <20181120095751.GB17738@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1GoswkRzsg4vccrjavZ9"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1GoswkRzsg4vccrjavZ9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-11-20 at 10:57 +0100, Greg KH wrote:
> On Sun, Nov 18, 2018 at 04:55:49PM +0100, Stefan Wahren wrote:
> > Hi Nicolas,
> >=20
> > > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 14.
> > > November 2018 um 13:59 geschrieben:
> > >=20
> > >=20
> > > Hi All,
> > >=20
> > > This series was written in parallel with reading and
> > > understanding the
> > > vchiq code. So excuse me for the lack of logic in the sequence of
> > > patches.
> > >=20
> > > The main focus was to delete as much code as possible, I've
> > > counted
> > > around 550 lines, which is not bad. Apart from that there are
> > > some
> > > patches enforcing proper kernel APIs usage.
> > >=20
> > > The only patch that really changes code is the
> > > vchiq_ioc_copy_element_data() rewrite.
> > >=20
> > > The last commit updates the TODO list with some of my
> > > observations, I
> > > realise some of the might be a little opinionated. If anything
> > > it's
> > > going to force a discussion on the topic, which is nice.
> > >=20
> > > It was developed on top of the latest linux-next, and was tested
> > > on a
> > > RPIv3B+ with audio, video and running vchiq_test.
> > >=20
> > > Regards,
> > > Nicolas
> > >=20
> >=20
> > without a changelog i won't start a review.
>=20
> What do you mean by this?  The individual patches have a "changelog"
> in
> them, this is just a summary of the overall changes.
>=20
> What do you feel is missing here?

Hi Greg,
I did send an RFC version of this, to which Stephan made several
comments. I should have added the changelog to the proper series
submission. I've been busy with work, but I'll send the updated version
during the day.

Regards,
Nicolas

>=20
> thanks,
>=20
> greg k-h


--=-1GoswkRzsg4vccrjavZ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlvz3CoACgkQlfZmHno8
x/7h4Af/dOe+yYVyVzGJElH9zLD1mzeFMgT0DwX71QKoACUYgDSfECRwV9TTuT4b
1aXPIulk9tKr8UW91t66GCaPPjsI2UGiA5uyrmNge3uCR9VWECnuZTyJDu0Vf/9x
7Hsqfwp/AudkM0+Biu9bDygm47Uh+UnUkJQjrMKRQp4d6fWlXKIUl6I7Agmh8XeA
CruxVhllGW2f7HwX+lGx+dPYByGTMAFtMtG3JF7ItOWgKQhDXI9X5baXPM4xdcDC
XH4U9bQGGDYd7O+WzXNw/q0mIG+G+fl68EV2fzrIIYnsxkiqGyWWG8KtnkHzjgpJ
OsXaYbxajiueRsRYKOpdY+6xxfJ9Pw==
=qidG
-----END PGP SIGNATURE-----

--=-1GoswkRzsg4vccrjavZ9--

