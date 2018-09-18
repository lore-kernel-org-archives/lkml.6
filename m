Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BE0214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BE0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeIRUNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:13:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41592 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbeIRUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:13:22 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g2HAr-0001f1-Vd; Tue, 18 Sep 2018 10:40:21 -0400
Message-ID: <1e3c2ab11320c1c2f320f9e24ac0d31625bd60e6.camel@surriel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
From:   Rik van Riel <riel@surriel.com>
To:     "Jan H." =?ISO-8859-1?Q?Sch=F6nherr?= <jschoenh@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Tue, 18 Sep 2018 10:40:21 -0400
In-Reply-To: <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
         <20180914111251.GC24106@hirez.programming.kicks-ass.net>
         <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-K5YcfEiG96vCjA3wYFT9"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K5YcfEiG96vCjA3wYFT9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-09-14 at 18:25 +0200, Jan H. Sch=C3=B6nherr wrote:
> On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
> > On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Sch=C3=B6nherr wrote:
> > >=20
> > > B) Why would I want this?
> > >    In the L1TF context, it prevents other applications from
> > > loading
> > >    additional data into the L1 cache, while one application tries
> > > to leak
> > >    data.
> >=20
> > That is the whole and only reason you did this;
>=20
> It really isn't. But as your mind seems made up, I'm not going to
> bother
> to argue.

What are the other use cases, and what kind of performance
numbers do you have to show examples of workloads where
coscheduling provides a performance benefit?

--=20
All Rights Reversed.

--=-K5YcfEiG96vCjA3wYFT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluhDlUACgkQznnekoTE
3oP3cwf7B7g/aayyrfSwUnziwRifp9BU+EM2IVUSW5m0vioYVjkr3zt2D00aAiYQ
v8gI9K/9tenserR1I+Gt1f6XHbp/Ht1aaRhmPVqSMk6TJoKHcZNkfihZZwnFoKpf
NoKXaEnNVqgSKn5ZD6n6ZQ8c/PYTkBRmu/qoco6KvThNwDbruTKWCuRHfti7ktV4
qqr854sWzQ19C+9qsujQ8C1xoZhGn6I3YKyHG79KUKo8zsrWjvFVuHrmtmJawdww
GdPzKnwXlBC3wUW9LAuFwhZIZr4S+gDhZ5i/5xtI40wISZS5vV6gFIQzIhJZh4BO
tXnvBDms5QRy2PaSTJ1r/s4yz6b6RQ==
=PtBi
-----END PGP SIGNATURE-----

--=-K5YcfEiG96vCjA3wYFT9--

