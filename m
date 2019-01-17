Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D90BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7727720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfAQO4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:56:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:59787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfAQO4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:56:03 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Fe4-1h3stF2cwq-00t8JC; Thu, 17
 Jan 2019 15:55:53 +0100
Date:   Thu, 17 Jan 2019 15:55:52 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org
Subject: Re: [RESENDING PATCH] powerpc/wii: properly disable use of BATs when
 requested.
Message-ID: <20190117145552.GA2200@latitude>
References: <7e6748349978f4f177b6a1f3f1c773da98ae3b59.1547570012.git.christophe.leroy@c-s.fr>
 <20190117010509.GH22334@latitude>
 <19fd4dd4-ece2-d508-1ed5-5a9ed2aa84fe@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <19fd4dd4-ece2-d508-1ed5-5a9ed2aa84fe@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:EZSrHJPA/D0Ub2qc+wdNR4m0x2cs+sVtrlYpyk6j1x1+oqF1Snx
 yfi8yVdBXZi0El0g9gsfsBPTwAn/rQOSNGxN8wRRkTS2iso6znxANO9q+PANSQNxA5e+8Al
 dUJOl6SxrLfns+W3f2BtK5+Scpqvyy27s6b5Z+TKgxNX7M6OMlaSrQb2SjIWIYaCy2FTuv6
 cs/ruUhbwplF219uTQIEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fNLh6XirTh0=:Bq7XPlLsnGkbaOqmoyedzs
 7lhQg7b26XQBOIRyT5KCslkiwEasY12z6wQu8cETOopO9EWbxnJqnBRhyP6jvZPSW4wkulv+b
 peu3YZqfVMhoVcZGog56XbLlymj7PA10QWh7PR99BERNvs1G+bjq45m4qOpAAtErmLUS3ShUx
 7/eY8YmhmVH4ieAyjVOjW6sv2TTGdj9HDGyVPyGvlcuCtCiTxpE1QsI0+KbAzBc3nK5viC7zp
 jYkJUHeUeWulimP8p3sUhTv0ngwO1QOQsTxft3vapLwbin7GU0j25gQZ29OE6WSkSaKAm8Mex
 F9eH/9SO/pLP/qpXJEt77jG5nnOaUokMXyPk9Z6zPLkKLLVJRF4ou6NGsnHI5kZcKa141kR6k
 Yt5WGbHZx962gYEhSh3Kgik17g5SLViJLGoVq8peHY0R/AVRXpqL27tHuxK3PqOqfeB2siBrU
 d8YnqT/PYNlSKkROX/yytxgTWYRAzljdIlHYQqGpyKctTRSirUqeAeCDfx2fSj3t5j65wK8wR
 /aXgLihGfn4TWDCbYocK4Rpdmm+w0rQcbSOALb0r3ugNxk0MRqQpxLvPm4GX+hoXQ4hpVaSIU
 TVBpdeEZ4KABOtOYaxBhrqh8kpEwKNCFcNM63kiiL1QPFUE60+xz2dxWHb5fSHyVEZkUJD1v1
 dS8WI4NT7drEjScI3FGpuTbyNzIQeu1knxR9sAwBo8q2uuTYfLSpkqqyDMd43N1p5N3yjYwbt
 zqlzR9Fmr8jugNYM6HZ1pXVeZm7U6ovmIo6ibD11AEefNeT5Z0bk6v7F53XfG4cpAzuzxA530
 s8eV0InTolM1GMJ+ATRTWtOhj6HxH2EvWy3PjTAKazGS0T0Iygl0zy/jfe1tuAeQO+sZn2ngB
 0P0SpjzvuASedH2GCEK7bozUSGyXO1yby0M7e3bIiJ6o6gqoLQtE/QS3RpkjjmqwcOepuzgTK
 W2okzcyMB1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 11:29:06AM +0100, Christophe Leroy wrote:
[...]
> > >   	/* MEM2 64MB@0x10000000 */
> > >   	delta =3D wii_hole_start + wii_hole_size;
> > > +	if (__map_without_bats)
> > > +		return delta;
> > > +
> >=20
> > Nothing is visibly broken without this patch, even with
> > CONFIG_DEBUG_PAGEALLOC (tested on top of v5.0-rc2), but the patch still
> > looks correct.
>=20
> Obviously, CONFIG_DEBUG_PAGEALLOC cannot work without this patch.
> The purpose of CONFIG_DEBUG_PAGEALLOC is to unmap unused parts of memory =
so
> that any access to them will pagefault.
>=20
> As this function inconditionnaly sets a BAT for the second block of RAM, =
any
> access to free area in the upper block will be granted without a fault.
>=20
> I think you can test it by doing a kmalloc() then a kfree(), then try to
> read in that area (hopefully kmalloc() allocates memory from the top so it
> should go in the upper block). Maybe there is an LKDTM test for that.

Ah, makes sense, thanks for the explanation.

>=20
> >=20
> > I'd prefer the 'if' block to be before the whole delta/size calculation,
> > to make the code slightly more readable because the delta and size
> > calculations stay in one visual block. It doesn't need to happen after
> > delta is calculated.
>=20
> Euh ... the function has to return 'delta', so if I put the if block befo=
re
> the calculation of delta, it means we have to calculate delta twice:

Oh, sorry, I misread the code, but you're completely right (I shouldn't
answer mails while tired).

>=20
> 	if (__map_without_bats)
> 		return wii_hole_start + wii_hole_size;
>=20
> 	delta =3D wii_hole_start + wii_hole_size;
>=20
> My eyes don't really like it, so if we want to keep delta and size
> calculation together, the 'if' will go after calculation of size.

I agree.

> In anycase, this change is only really for fixing stable releases because
> this function will go away with my other serie.

ACK


Thanks,
Jonathan

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxAl3AACgkQCDBEmo7z
X9sekw//ae7XPjO55eotK1OhX+5W0gcbkzrIUV14TGSXYWeXO8LhFtt7W3tFjJky
6mAjVmQu0wGSz/9EqKxh1p7GW9/3xWqK6vL6PCG8/9L6s39hQE6BZepE4zUL7SZO
l/WW2RDHfgsUYcTSwHUE3Ph9R+7u33+4IJqEogW8m0HORL+D4aMaeAnRbxS1c1wu
GvUyD99gOOIEVcmKzDzoC5MqTNpQzsPNIB1p+6O/Y+GwFUK0ZQF1YkbaGRLJSbY5
peAp3iGwzamqLumKAI48DYp/46HQK1HsTXBLHd1ykOfYRWWcnjFsbxmzo/vn+vRA
rpWh3TSvEnNqU5RyES8dpcov1hdIVi+yVhGOahbR6Y156+RC241voO8ppPJpQtZS
rQ4jcc/01OExU4yM0eh4OpCx2XBvzv7Se7alH2vjJfSDLcOWFICAyw6g2KlJtIPf
+rhpoCmAN4tpOzKio88iViAfDBivRvqqKvdDNUxfTym/14Z6JMg0Xt9WDKesVcwa
IzCLE8bAFOv2GE8FW3KPvUQRHYoupjCVoFYREbXM8cAIfNmYC2+zqzkcIDeAehXB
9SMOxQGkfCwPgX1rtP+kiOPrJNnMB8F/CZpWekMPAaGgYLdIfGBwLzJ3ox5wveHc
qpKEpg0THoBIbJMcFCEy3kHI+qv4fG4jwmY8YDC8sJ1Jk6WIuSc=
=4s0A
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
