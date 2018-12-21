Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7301218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbeLUCf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:35:56 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54158 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLUCfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:35:55 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BB4E472CC53;
        Fri, 21 Dec 2018 05:35:52 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B0C10964EB0; Fri, 21 Dec 2018 05:35:52 +0300 (MSK)
Date:   Fri, 21 Dec 2018 05:35:52 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/27] elf-em.h: add EM_CSKY
Message-ID: <20181221023552.GB5396@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172200.GG6024@altlinux.org>
 <20181214044308.GA15793@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20181214044308.GA15793@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2018 at 12:43:08PM +0800, Guo Ren wrote:
> Reviewed-by: Guo Ren <guoren@kernel.org>

Given that the whole series is going to be pinged for quite some
time yet, would you mind taking this patch into the csky tree?

Thanks.

> On Thu, Dec 13, 2018 at 08:22:00PM +0300, Dmitry V. Levin wrote:
> > The uapi/linux/audit.h header is going to use EM_CSKY in order
> > to define AUDIT_ARCH_CSKY which is needed to implement
> > syscall_get_arch() which in turn is required to extend
> > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> >=20
> > The value for EM_CSKY has been taken from arch/csky/include/asm/elf.h
> > and confirmed by binutils:include/elf/common.h
> >=20
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >=20
> > Notes:
> >     v6: unchanged
> >=20
> >  include/uapi/linux/elf-em.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> > index 42b7546352a6..ee0b26ab92b0 100644
> > --- a/include/uapi/linux/elf-em.h
> > +++ b/include/uapi/linux/elf-em.h
> > @@ -45,6 +45,7 @@
> >  #define EM_ARCV2	195	/* ARCv2 Cores */
> >  #define EM_RISCV	243	/* RISC-V */
> >  #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
> > +#define EM_CSKY		252	/* C-SKY processor family */
> >  #define EM_FRV		0x5441	/* Fujitsu FR-V */
> > =20
> >  /*
> > --=20
> > ldv

--=20
ldv

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcHFGIAAoJEAVFT+BVnCUIUGwP/3vhB+kDKPYJ3KXU+LQlUADj
oD9Kag51NSHLg5zVr9N5sa4DM3LyygYqz5fh3NcWtM7lNZKrOsyTCStmv1Q23qK+
PbXNOli10kw19zMCdgpT3tKCxcL5+bM6TW+al+D+ey0BlLI4/UlFU5xzjAo4LlRB
2nwpDMos9v6B7V3BBDV+ncMC6UYCnh7vM+CmI78AvcT3Z72juUdVCuTI3CYD6Vw+
o2qSpSnARBczicvWStWh1+Ke8NFjhDL66N1c+fptAM+dIaiJkmN4fHQfnmItFlKy
FEUceKCRIY9gQQbIWJwpgRvle+vNLJi0nVGS1wz8Aos2hAosxFL1PdJ1qHi15elx
KvD/1LPUqBNTFGbQvae/daXIomyqGFXFTW6xTlra8kDUP2Y158TRIExleoT/LNjp
nmEgira10BwQgWYwmTphz/+Oubf9mITr0sUne9ORkFn6Qz3K0RqPEe97R9rqUHNt
NvgaWaQMLB8p+FLTjAPNZcohbi2/pjnZIS/+ZInfPOEGvEQUDgPHVP3nc+/yKS+k
1rv+JRyz+nu8Hp1otmLRsSZELx+fKE7oRv+ALlySgr0D/6jGcZEN4GGyJBqQe6mb
RaYsYraFjGCsgWO3wIRQMZf0Hpo0sDSZrvbSTB6Tbg0pgUVpX/C9ADQP6A/tPnfR
PeWP18XvMaGvddbef5tu
=OW19
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
