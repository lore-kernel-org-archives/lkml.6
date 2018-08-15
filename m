Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F12F21501
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mwVPptLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F12F21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeHONo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:44:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41094 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeHONo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PGCYoq7ya89EZTC8LZAl6L3NBL3n2ZnfV2RmOH2QNcU=; b=mwVPptLehouxdqgbQxSV/LAGb
        1FpSJZuTvRepFc4Svj8zV4ch6mPJM8+0SYsoI9Ttrh0eev08OGtPFSQq6r10xFxhk4WUyEx+LT/8y
        lHXtrwYucXmL8h35KGO8x9V1P/DI10Dd2PB2uE9iDpIO4+YqozFsTf2vNIeGF08iSZSEQ=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fptPt-0001aZ-BO; Wed, 15 Aug 2018 10:52:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 80F4D440078; Wed, 15 Aug 2018 11:52:39 +0100 (BST)
Date:   Wed, 15 Aug 2018 11:52:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lee.jones@linaro.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: Applied "ASoC: dt-bindings: add dt bindings for wcd9335 audio
 codec" to the asoc tree
Message-ID: <20180815105239.GV2414@sirena.org.uk>
References: <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
 <20180801112020.93C4A1124241@debutante.sirena.org.uk>
 <20180814162405.GA450@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xku3GkZTJumTa1rO"
Content-Disposition: inline
In-Reply-To: <20180814162405.GA450@rob-hp-laptop>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xku3GkZTJumTa1rO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 10:24:05AM -0600, Rob Herring wrote:
> On Wed, Aug 01, 2018 at 12:20:20PM +0100, Mark Brown wrote:
> > The patch
> >=20
> >    ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
> >=20
> > has been applied to the asoc tree at
> >=20
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20

> Why is this applied when I had requested changes?

Usually when this happens it's becasue I applied it before you requested
changes, there's some lag between applying and pushing things out and if
I'm working on my laptop also some extra lag before mail reaches me as
well.

--xku3GkZTJumTa1rO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt0BfIACgkQJNaLcl1U
h9AbHgf/YwUj5W487kUnXYDmUInV5C1CzGSnoXIJmiJNKT9YnbdaDas1UWtc4Ea8
02Jq0DckZ4+P81OBVBfCWPzaU4hXlp3/+6MOYzgyi0PBVBJK5gIOdSFAZ77/uzJv
iN93JMFeI/ui/O+0jKck2Zwov4/IC5klHwR9y1l9gV/cvAGKUlkPBZcBByaoHQfc
y1bFUsW0xqTb1u3RKKFksQzkTL0FLmW2c2B+M/Xs5Gi1pTMHvZ3sEB/qMiLImf8P
dXsmzaFbXe+VSPe1QOHwXGMyIMDFkVsgdlX95K8V3gzY/ktdTOtEIG5fDiycbBSF
dWU0Z5VXmD1XmUxbJW+JfE7Y62PG+w==
=k4Ar
-----END PGP SIGNATURE-----

--xku3GkZTJumTa1rO--
