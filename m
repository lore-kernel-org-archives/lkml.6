Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BB8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 21:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3682A20663
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 21:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfAMVCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 16:02:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:39445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfAMVCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 16:02:36 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO7im-1gfV7B0Wpw-005Y5l; Sun, 13
 Jan 2019 22:02:29 +0100
Date:   Sun, 13 Jan 2019 22:02:27 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for
 STRICT_KERNEL_RWX
Message-ID: <20190113210227.GB22334@latitude>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:1k09skc6yFJs8tPR3q1qx1iosbmurc4kmuCiIsWU517Vv6BeQLm
 M7GlNHz9rvqbSMjX5vTdd2vLz2NPSj27LrxXze09fyAn2pjwGCce1rS7EgpEu398hFV3JDR
 F3cyXgJjzjfrZlUqohq67XAuvf2jfcet53zNo8dzTyOcylhEWOZlBBR15LQlazy+WzvPMh9
 FOwZqdulAOJg9AWZmVcvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c/YQ9dubQhA=:CF0N71E1/CMUiakEv9DF/d
 ShbDrfWz1IiRdKjWCdbcdYb86qVXohlbZIFwzkXn5ooscA4vIS/p5p20h3KNUjY7RPt21VCyc
 V2mxIkyAFzEA+bPzK/3W0cKbGMYmb/LYPvdCL3bwtDVNOOKV2KTs2kFLM4D/bx1kShMrzCbE2
 61Wy/h9a9qbnx04oLf+BQG8JnftsE7cxSo1NSxIa1cWgfzRPLLzVT70lMhmKB00lC58dTobnD
 6hD1Khtxqj1XEVOx0crw0DaeuMPbcIeSa9FXCyk8eBqCeOCPKuVjDzRVx06WT3ItsBZ5EpscB
 n/gm4/Qvka85Sn7EJHCsa3/5XbfbKfOPj9kII0iVkaDnV+73lry+rIERwNyPn5joujE2Lfxwr
 kfHOBmBMaNN6KubQc5BouNlpFRwR3sPcpk54osLtBl8Bc3tJVkjcwXV58PgEx012i84t4qdqi
 9tODXb6AocqBPw8GDfqa5RzKIiD6qnMMetrzzJdkw42518XXol11598Z3Yrz+Ao6l8aDvPpZt
 U/pTEtZS1ko4x9qictuYxoJvYdR2nBHrkZvDuFjk0Wuz/rNklFPrAWRkh6tZvu3NHN+wa8GMJ
 IFnsxZ0YukfxuD63HA6GRFDudlGVT573YlvGvYyr8qWwG4I5ex67deQ9msseZrXY+KJISWqvq
 cyQj7Gr+0dN507U3uq3577iDsknPb6WyUBbFbjJ3eyk4Q0X+ruT4IvWR2VyWSzg79EUgLITfH
 HLFd724r0V97XDTAPA8J99DYgRoULMTQ1a9xbPZLop+MF9kqa2uSjRbRzp07JW5ApBVyWA4r0
 5jcr7v8p8vPWcZ+XuZT2r68zUOfwmZtnuLHPa03soXZX7MKapUQjKJ5qjq1DKepH8LsJKyN2o
 DETPQtrtlGdtZQJMVU5PLkjJqGk6ALMY0o+dXSFjhoQedQkyorV2Y1YERGpH7g
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 13, 2019 at 08:43:07PM +0100, Christophe Leroy wrote:
> Le 13/01/2019 =C3=A0 19:16, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > I just tested the whole series on my Wii (I didn't test any intermediate
> > steps). Without CONFIG_STRICT_KERNEL_RWX, it seems to work fine, but
> > with it, I get the following error while booting:
>=20
> Argh !
>=20
> Can you please send the System.map file generated at compile time ?

Here:
  https://gist.githubusercontent.com/neuschaefer/12ccc87ff8aeff543fad558e87=
42cd2b/raw/d49d321709cac364779e6893bbd91ff5a80bcb03/System.map

And here's the config, reduced with 'make savedefconfig':
  https://gist.githubusercontent.com/neuschaefer/12ccc87ff8aeff543fad558e87=
42cd2b/raw/d49d321709cac364779e6893bbd91ff5a80bcb03/config

The exact code I used is here:
  https://github.com/neuschaefer/linux/tree/ppcbat-test


Thanks,
Jonathan

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlw7p1QACgkQCDBEmo7z
X9uK+BAAwh4EPxyL8nT2mZS4HlKu3HrUC+kGg0riUzcJAkCOEE1RQJdmaAH7nBtN
gCina4VwHsB8gst1f7G6ee7OJLeNbgT6gMHnvdhFWpOp9H9941mJEzVoi/CYbO2d
bNBsUHtWIrme1k9TtTyUIrzwtoSEYpzVCp2fc5XedTDzW4p2FT9gGV+igFR88p5E
4tGdcmzXPqHeg3DkB7B6SqnznSVMSUzuHydqBFzwM5d0FtnDbw3LEtI6KDkpty2P
k8tccVVypqMFwRf2IGoarpTQlTyNFFhUaxYN8gca+tkbVvTdeEotIAjAW/aoRMNa
X0dbR8aNAaeyDBVR/sSl+4O62IGUbak7zwlGWZQ9xD1AeXHsO1ebhQl/HvozYzaQ
LtcTjWJE1T4wlgh0IB8jLIdoOItl/BOpB6df1g0eN6x8T8zfP90O3k41QvRmB8mu
QVr35WjWuddqlh4QTdhJw5dO12vSyODhXjx7vdMO/ms2BJubzw2x0hF7xylr+yzh
pyyFslMvhDpxqOBLiOw+wi7Emf8R5n7DmK1Z6CiBgTZmJIFmY2R2WL3Mrk5RZno4
0f/QCysnXF/AvBBhrDGBImxqQSQ4ar8WwN0WCQuwlbX5Fn1FdEkDfm0gO15Duy4U
1X+h5EEUROpyBO5NsjN56CPVDYW43/21xBYmOrCP6Q8fkanl3xI=
=aNz3
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
