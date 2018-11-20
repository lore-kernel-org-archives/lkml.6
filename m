Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB3C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0C220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbeKUD1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:27:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33300 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:27:42 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B974C80854; Tue, 20 Nov 2018 17:57:30 +0100 (CET)
Date:   Tue, 20 Nov 2018 17:57:33 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        timmurray@google.com, joelaf@google.com, surenb@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181120165732.GA13147@amd>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd>
 <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
 <20181120094950.11978b68@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20181120094950.11978b68@lwn.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-20 09:49:50, Jonathan Corbet wrote:
> On Tue, 20 Nov 2018 10:05:21 +0100
> Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> > Why can't the documentation describe the current implementation, and
> > change in the future if the implementation changes? I doubt somebody
> > would ever rely on the pid being reused while having the descriptor
> > open. How would that make sense?
>=20
> In the hopes of ending this discussion, I'm going to go ahead and apply
> this.  Documenting current behavior is good, especially in situations
> where that behavior can surprise people; if the implementation changes,
> the docs can change with it.

I'd still prefer changing from "does not" to "may not".

It is really simple change, and once we documented a behaviour, we
really should not be changing it.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv0PPwACgkQMOfwapXb+vIm1wCgtqq+S/IMFCHeWfVA9EAAo+l5
f4IAni29EPb2X3/9RSgyLOSK4XjdQmfa
=K4i7
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
