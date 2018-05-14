Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeENWNd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeENWNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:13:32 -0400
Date: Mon, 14 May 2018 23:13:27 +0100
From: James Hogan <jhogan@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: fix spelling mistake: "cop_unsuable" ->
 "cop_unusable"
Message-ID: <20180514221326.GC29541@jamesdev>
References: <20180514172350.26601-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20180514172350.26601-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 06:23:50PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in debugfs_entries text
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Adding KVM folk. Its a fairly trivial change so I'll just take it as a
fix via the MIPS tree unless anybody objects.

This does change the name of one of the stats counters debugfs files
though (which I have no doubt isn't relied upon by anything), so I've
added:

Fixes: 669e846e6c4e ("KVM/MIPS32: MIPS arch specific APIs for KVM")
Cc: <stable@vger.kernel.org> # 3.10+

Thanks
James

> ---
>  arch/mips/kvm/mips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 2549fdd27ee1..0f725e9cee8f 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -45,7 +45,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D {
>  	{ "cache",	  VCPU_STAT(cache_exits),	 KVM_STAT_VCPU },
>  	{ "signal",	  VCPU_STAT(signal_exits),	 KVM_STAT_VCPU },
>  	{ "interrupt",	  VCPU_STAT(int_exits),		 KVM_STAT_VCPU },
> -	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
> +	{ "cop_unusable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
>  	{ "tlbmod",	  VCPU_STAT(tlbmod_exits),	 KVM_STAT_VCPU },
>  	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits),	 KVM_STAT_VCPU },
>  	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits),	 KVM_STAT_VCPU },
> --=20
> 2.17.0
>=20

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoKBQAKCRA1zuSGKxAj
8vEWAP0WiOiXuPk1YrXK8FVgnv1SV4ZByfR3S33VjwPpgWy1nQEAumPws9ZYuPRR
gLEqrdEV6UnTOyGBfqiZ7xxsdXiYsw8=
=w39k
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
