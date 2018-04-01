Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1340219-1522625720-5-871173366189147328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522625720; b=JWk3IXt2aJX1jkaE3dzysz2oQiMU1w5IRPcSxyBSqQWrIcpEod
    n/SXVIkvuSMEShqHoI27JfO2p2cVDoyylAwQ7PVrcrMl39cNIKW3Moi695Jeubny
    9+d4/DcWjRTDgWA9mupX9/UwNfrKBdZtci/F8NCTAIBZkRZxIYhge1gvytDg/Reb
    kobQAGbYdbfcEYvH+0pf1FDpE450uA99Hy9IMtDCDfzPB/OF8fFvYEYLXW2mdcvj
    00aDKF0+b5RRhrAD9Qkq2QtIzLMFigZfVxK1iOrgNExzrrBTGBALreecPhnU9BiG
    sI9OOVM/82zuQ3mENSIhEjLI34yB4g1NhbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1522625720; bh=dY7RgbeanFscxCDkhS+PlIX8x/iovz+
    T2zPh1ZbjWkQ=; b=rsQLnvcQMToq69zh4IHcs8jYPyHDuN1/FRziYW395cPP1c/
    DoAZ46gHEYbcsYhKqX31RLTdgMfZSPgLKrKww9jUayHclsdm8QUV3PREjb2Tttly
    TrlUN28UgcfQ7BoLYpSUs4RAK1qaGo2smlW4EyAOxqmAyVsZATt+QnEuoYWRg2bF
    DFgztKCDIsv+MdV/nzkMnRu32SQRLBhZXA7+18a5IhgfNHgOdA5KTBN/ty6KSfk6
    CooKV3kqw4zAM8byYcgfCusxDpHazX5aSWuUH+B/Oq1Ij/3uSb2mLCzDsA749/UW
    Qn6zHzeAMFOlBmwyygpfLJNwl119IG18+yY3TIg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMhQMm7dhO+2NMwTZ74FPfUDVcFX6EUMQvwYENyMwjFOJe0XYUmwgTF7VZra8dYOr7hUrayh7EEA8CWKp5/tjUf2qzK4gaqJViWCkMo5hkXFqu+yWjyG
    iUo/7deN0tNe846j/LVVNuzMvom28VTdi8qD0Um4EA0CGHUE3gR2giGn6t08x4r084VFlW2EvaF1GkoPNRqCVdlvongqWzk5ST24aFJHvKst2UhyDMdqt8GG
    m3+dtsIRRHi5NyptoBxFWA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
    a=Kd1tUaAdevIA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=XVhiXIj6AAAA:8 a=h4u8RHx9Uphfh-EF390A:9
    a=BRoDSqUdzD0nEcNPvNEA:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=bPq-zhyswAju2HgL2p1_:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Chris Coffey <cmc@babblebit.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 02 Apr 2018 09:34:58 +1000
Subject: Re: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <20180329124745.24694-1-cmc@babblebit.net>
References: <20180329095637.GA16778@kroah.com>
 <20180329124745.24694-1-cmc@babblebit.net>
Message-ID: <87vada1owt.fsf@notabene.neil.brown.name>
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
Cc: devel@driverdev.osuosl.org, Chris Coffey <cmc@babblebit.net>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4342063453300880579=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============4342063453300880579==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29 2018, Chris Coffey wrote:

> This fixes the following sparse warning:
>
> drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
> 'mtk_set_ethtool_ops' was not declared. Should it be static?
>
> Signed-off-by: Chris Coffey <cmc@babblebit.net>

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> ---
> Changes in v2:
>  - Per GregKH's feedback (thanks!), don't add unnecessary new .h file
>  dependencies. This patch version reverts those changes and fixes the
>  problem directly in ethtool.c (which is that it didn't include
>  ethtool.h anywhere -- mtk_set_ethtool_ops is not static).
>
>  drivers/staging/mt7621-eth/ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt762=
1-eth/ethtool.c
> index 38ba0c040a..5268c5ca09 100644
> --- a/drivers/staging/mt7621-eth/ethtool.c
> +++ b/drivers/staging/mt7621-eth/ethtool.c
> @@ -13,6 +13,7 @@
>   */
>=20=20
>  #include "mtk_eth_soc.h"
> +#include "ethtool.h"
>=20=20
>  static const char mtk_gdma_str[][ETH_GSTRING_LEN] =3D {
>  #define _FE(x...)	# x,
> --=20
> 2.11.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrBbKMACgkQOeye3VZi
gbmWphAAw5pBrEWrvsgAMo5LGy+Vpt4tkXJ0R8OzjHtg26YX6XQmPDTYdlooVTG0
CG/Q4zfsXFi+TK0mmRbIh5uRdAwEvyX1VlK7V/FKszHZ5mU8qS5P2UYRI64PbrME
xCrpA+QVtuQHtzMZJVLDj0c0VpgFQCh73SN9OYwW2f5RWKJYr1rhLFfXjc2BMkBL
2cvzo7vCLbzpq7OukMJ9zPYwonFXk3LwxJX28seQkxAHd2be59r96uV7qevACTTK
CISYJc5o0/mXjwy7PDZqF75Ma9cLqNNtjVedTjrfoyxkMejEW8vhUB8WuSxkDHc/
pPdqNUdFItQDRNjb6lAYAqxCYQQHId3UbTIdrkGOxzQWdB6pGTINwkDj/gS03NFs
s35A9QwzWqWQfFV2u1qvwMzbnVdVwqjNgwGTrQvVwdh3rAGgXW0MmNr8My+TR1vc
HSQI4eNmtcRONaBm0yNyOvs73Gm3yJZmzvVw62frnvVV4e8jv8umIH76dBufXGJd
K9RNnbw7iEBtq3v5OVhTymReSVQ4tZOPGwxs8jOtZjmlRTzsHmHGvHTtoqUZ4+nH
f8mwsTa5j7RYo6Epa/bpDp6bvhCL4UamZ8BC4EVIzdn921t1vNd2W8rMJ29kgwOX
p75oSRRW+rHNDs9vih3vp0yHIkQabnmRFDL/adEcC+zzM0XBCzM=
=MGT+
-----END PGP SIGNATURE-----
--=-=-=--

--===============4342063453300880579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============4342063453300880579==--
