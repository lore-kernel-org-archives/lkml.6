Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2004258-1526160730-2-14186701790640403505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526160729; b=QO4M+kzt6iyaNghR7jSQES3ggZGw4cDZb1eDA8+RhhEIK/BHsE
    uavZDWwSQ76VL7YX2i4dNdUPnv3/aWr/q/aWf1ZrYf1F5TaRMmak/dRt3bDhGQNb
    olSklTQhzlXY+7we4YZYKao9ftnfecWSvDhiIlq5o+ITTG7f8H9YLisYHiGMjdrD
    dCzpTN0RGVCiD4Ogue2ba/JpzU9rTzZEk/mQun9mZ95mzQHmCXxoaGLvTRuqplvv
    7oalcQIM6MiubT4sqLA02TwTdxTA9GqaKKxCclFPJwyX/hux3b49QujuV1aCmvIe
    ctix3xGyuTrK4sC4O2H0BS5rXtSSzVukQWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1526160729; bh=fmClaHz0tZrtGb9+uT267onJaApuTTp
    wBt1voXDshQs=; b=BTV9uGnpFt2UD8VMLt0pypGegYbh3wdztbHpS36hFujxFiH
    30IgGLa+XPjk3+9fDp0V2rgEzU/hFMizKp90Y2hcnHAu7GHmxjwjMmFP+cPNlcZk
    EES7/FZTLtT/rtBtUqUHmLbltLrqXGtCpq4LXzuflDNjmUDAoN/msEN5Pd8qfJM9
    Gpw05YHvQ5tN1nw+ByTyp2hwCnIUpVlJEErGVZlHc8ZrWoxXE2AKNGR9Hyj9oC/0
    BmHKgbrPqIIohB0UoHslPEwTgbQV0C3FT8qXW8wJJvQlMslLPlLuDzsr5PubD08l
    +3BYrTtt+/LPyi/50yM4EOYwskLFW+W71r9nS9g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=suse.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=suse.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgpDk2iWNF2xivsEmE38uV7DxyiU05IZKP0qlwuZorPvVB+e9QoOKdU5hGGS/WyG/YBmrysoc52AqknmIke2Ku9P3rs3Y35bdkPlFUXGN+nv0RHtYlo
    bAm4IUidH/bcDzLyQkPB4S7RCFioTtDBphKW4qHhHQdT3FoquTI3i6IsKvrFhkZ2sZxl2FOvl6XG3KbHEyxRYnN+tq98/GyGdC+aaBOZFVQmSdr0xQQFS9hl
    cqepjE26+RIWjDclfFW18w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=1oJP67jkp3AA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=iox4zFpeAAAA:8
    a=6Po_TGWwzr6NLd_2cf8A:9 a=ewPGH9zu1mhJDVQaPSoA:9 a=ONNS8QRKHyMA:10
    a=DDOyTI_5AAAA:8 a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, oleg.drokin@intel.com,
 andreas.dilger@intel.com, jsimmons@infradead.org, gregkh@linuxfoundation.org,
 aastha.gupta4104@gmail.com
Date: Sun, 13 May 2018 07:31:45 +1000
Subject: Re: [PATCH] staging: lustre: Use 'kvfree()' for memory allocated by
 'kvzalloc()'
In-Reply-To: <20180512121426.22988-1-christophe.jaillet@wanadoo.fr>
References: <20180512121426.22988-1-christophe.jaillet@wanadoo.fr>
Message-ID: <87y3go8sse.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 lustre-devel@lists.lustre.org
Content-Type: multipart/mixed; boundary="===============2883269229712826506=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============2883269229712826506==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, May 12 2018, Christophe JAILLET wrote:

> 'buf' is allocated with 'kvzalloc()'. 'kvfree()' must be used to free it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: NeilBrown <neilb@suse.com>

Thanks.
We could possible add:
Fixes: 11c647caf74b ("staging: lustre: obdclass: variable llog chunk size")

just for completeness.

NeilBrown

> ---
>  drivers/staging/lustre/lustre/obdclass/llog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/lustre/lustre/obdclass/llog.c b/drivers/stag=
ing/lustre/lustre/obdclass/llog.c
> index 693e1129f1f9..5e04d133b596 100644
> --- a/drivers/staging/lustre/lustre/obdclass/llog.c
> +++ b/drivers/staging/lustre/lustre/obdclass/llog.c
> @@ -385,7 +385,7 @@ static int llog_process_thread(void *arg)
>  	if (cd)
>  		cd->lpcd_last_idx =3D last_called_index;
>=20=20
> -	kfree(buf);
> +	kvfree(buf);
>  	lpi->lpi_rc =3D rc;
>  	return 0;
>  }
> --=20
> 2.17.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlr3XUIACgkQOeye3VZi
gbmjwg/+JuSwFsPnPrC23r7O/pDHVq73Y/wJKJJPc67j6iaAJFq3VcL/jCoEzpe1
2xWs9dYP30JphzA4F2W39gqLURP3xzaFEUZFZYRF/bwYrXiJB9Px+bf0yA+f1yvW
TWOcYdWvIQCvCECRAo8z9IMCCtSvjf154gmyx/fJLnmk7wAyoI66M7EwOdk1SrJz
vdtFRX+xxm1giMRR7StG4TiWc7NIGKJIHhsbrU+Xf7QLc1X0e+D4NTEexf0NFKSG
hVyyFr+N2QOQ2PPYPGfAQBTr9nEGyC1XFQ0KLH0bHS9BofXRQVEX0TW8QIisF9OX
vp7dTY75AXiKqL0yKp8FbCKAoOu8vIDQtTT3czGilmi8LlWEYCv8WXlz0HNeKl3U
vpc2Wf9B03bFvQOL5fbVOtliFH54X0a/qx5sy9HsdLgFv/pCiH/gPCSsypZPOuwP
ON28GmTzNMvc5u4bN+L3dfHJdl/TEH2cd0QfHt8O4afKXEzKrqYb3pj3r4SfB0jh
ygFosVuKVRR3Xvbunht6IMwqyBqivR5ctr+NYwIEydw7NQgiaIQUKwA4seSXgFMy
Z1sbjn8YH5I7BBc6sqWjJh1dIevL2CvGntp3EGG3nJAC1f4ikKHDidZLjZbd5y1j
B8sIFogTlopW9IxnzKfsKLjQiGWlu2lj6ervUIeWw1o0dQc/XGY=
=M43m
-----END PGP SIGNATURE-----
--=-=-=--

--===============2883269229712826506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============2883269229712826506==--
