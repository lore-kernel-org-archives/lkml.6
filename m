Return-Path: <kernel-hardening-return-12341-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv1e/MsevLc4ZsNqiaxCYdnesiGVw7IN6R48XKLjzBGpoIKEm590gl8htqAp4i0NkCfq3Ue
ARC-Seal: i=1; a=rsa-sha256; t=1520633770; cv=none;
        d=google.com; s=arc-20160816;
        b=dVUbcGOA4r364aTThmN0t1taUV7rXkPvet6lrdWFYFHR8ZPVVAvRU17vJS7Ay2/1Vk
         3Dr+YSI3HrbWea6ScCaEMokXQLH7zGayXKorSsxCW27rld6QOKnsAeAHxlcIc/edDOD2
         0utmVxDwIJFfq93hOiD0ahmcJpp2jPOmA74s3v+3MjQpJllfdUO+9VCF9Y5iURq9vfgX
         XjNjvt3WqYKeuFEg+pJ7R46Sc1ucc2euxuBA2WB46xxW470wADnyLXRcv4Ip8QKRUfGs
         BCYTL623Q1N+1DafbOpHQ8qxQbjHh2oGdw+67fPgqVWZq+tqIOJOiMEgCPztFvQc3q/L
         uhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=O59kq8/QpHFuE87P2BKCW5nhv703//meU8hgjqoWR+g=;
        b=XiLteuv+OyXwYCHwv9aOYOt+0iTHugVJJz6DkIyRfcClQCuLPvLQJs8QR/FkztLD05
         6OgWwKlvjo/knt75V0k5/smXfRaWHf0lXcqLgPeQrIdK08UZA9z27REw25KWAlF9ZNoe
         y855tK6jwBMGUu5df4dEmWL9n2HIvKoyGJPqGDg3L03MvgWfFI3y6ec5VysthZGOJS1Q
         60he7ZCAoSfoEsKOn8M6LFMzqHx42shaJP6RIxAsh5M9yVfuB2qeTlgbyP3Q+tMqHfZv
         TUocaBDpDOQv9YH1WDlLbsiMcdArXvEtyWIAkGBl/NYr5PUM02QHSd7curcGxzOECej5
         9LyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12341-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12341-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12341-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12341-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 23:15:42 +0100
From: Stephen Kitt <steve@sk2.org>
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>, Sudarsana Kalluru
 <sudarsana.kalluru@qlogic.com>
Cc: linux-scsi@vger.kernel.org, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bfa: remove VLA
Message-ID: <20180309231542.3eb53b87@heffalump.sk2.org>
In-Reply-To: <CAGXu5j+_DvU4jNESxO2zBvP_VrTxOwVzh_NXqdw+S5amQukNjg@mail.gmail.com>
References: <20180308213841.13807-1-steve@sk2.org>
	<CAGXu5j+_DvU4jNESxO2zBvP_VrTxOwVzh_NXqdw+S5amQukNjg@mail.gmail.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/jOtjcHV197POdtlrpWmTaxu"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 546905879944580586
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkeeigdduheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407144538028292?=
X-GMAIL-MSGID: =?utf-8?q?1594500076045555030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/jOtjcHV197POdtlrpWmTaxu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I sent this to the wrong maintainers, sorry =E2=80=94 you=E2=80=99ll find t=
he original patch
on https://patchwork.kernel.org/patch/10269257/

Regards,

Stephen


On Thu, 8 Mar 2018 13:43:07 -0800, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Mar 8, 2018 at 1:38 PM, Stephen Kitt <steve@sk2.org> wrote:
> > In preparation to enabling -Wvla, remove VLAs and replace them with
> > fixed-length arrays instead.
> >
> > bfad_bsg.c uses a variable-length array declaration to measure the
> > size of a putative array; this can be replaced by the product of the
> > size of an element and the number of elements, avoiding the VLA
> > altogether.
> >
> > This was prompted by https://lkml.org/lkml/2018/3/7/621
> >
> > Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20
> -Kees
>=20
> > ---
> >  drivers/scsi/bfa/bfad_bsg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
> > index 3976e787ba64..7c884f881180 100644
> > --- a/drivers/scsi/bfa/bfad_bsg.c
> > +++ b/drivers/scsi/bfa/bfad_bsg.c
> > @@ -891,7 +891,7 @@ bfad_iocmd_fabric_get_lports(struct bfad_s *bfad,
> > void *cmd,
> >
> >         if (bfad_chk_iocmd_sz(payload_len,
> >                 sizeof(struct bfa_bsg_fabric_get_lports_s),
> > -               sizeof(wwn_t[iocmd->nports])) !=3D BFA_STATUS_OK) {
> > +               sizeof(wwn_t) * iocmd->nports) !=3D BFA_STATUS_OK) {
> >                 iocmd->status =3D BFA_STATUS_VERSION_FAIL;
> >                 goto out;
> >         }
> > --
> > 2.11.0
> > =20
>=20
>=20
>=20
> --=20
> Kees Cook
> Pixel Security

--Sig_/jOtjcHV197POdtlrpWmTaxu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAlqjB48ACgkQgNMC9Yht
g5wCVg//UcQ24fCOOWQ5szsHoH5YyR1bybfaTFF7kioyZbs8Y81CvCAHDrPG4e/L
amizlXarNLtjYRGGCilsR8G7ZVa0PzaZiVE4H+r4feFZ4YARFgZH2Hu2qyySwTRK
yu0tchLBE3/QlGgNC/0zd7pPWMXcNeB88OZCbcIGjy/GG5SO1XRjiPaAKsHfe6b3
9AFyr4bHKwqzuZaLLMZSJgb9J1RIFH0ZF4KPc+bc4tHMlNryU4VWJzuucZQzS5AI
tzFbuwi7V+7R9qj7o7TdrDKw64HrBgFci+f1xRkGKoOrPTXpXMSWt0zMjaKI47ft
FNvFoftDHNRNs+4v7b3mczLW0UAFiLA9gGSwWqv4ra/Ot0BcevILYdc2RQrIIcZ0
FBWugDaSnexs/IcTkaooInaR0mDGZig9NcWd0mzmcszg/b6hqqtcuSXrQX0W9TAH
St5ObogNFnBIrqHNROyCtKhZBxsKqTlAMOhvQziTtUoCG4jmVt4OpJ/J6K+SJ6zw
BCRn7FkKb5fbnd7RsUOKn6RiP87OXie2f/lGn1JpaOZq47ndHw01xh2b0u6aAq/j
fVMqK5ODTNYYogt/GQrxIGQ5bjt5rWa/147XMZW1NGWJ896eq/nkv9Cb33PhC0si
wPAvk2D7+fdMYeeXdkWWU1YvljrI6s1FWO8blFVY00rvNgJXEeg=
=jztF
-----END PGP SIGNATURE-----

--Sig_/jOtjcHV197POdtlrpWmTaxu--
