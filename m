Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E8C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DA42087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5EaQn1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DA42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeILO0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbeILO0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:26:24 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCE32087F;
        Wed, 12 Sep 2018 09:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536744164;
        bh=+SrovpGJqNIJGs1pJqn4PMFxIo+gN3PYi51tTKuVIHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5EaQn1R7MxKV3bzY1vboc/6rKOVYn2/vsFHgjFbU2fGeDAdn9ZW15/EgXaNHwcs6
         hfayntE4+/Ys1XDworD9YmSRnlkAduiXEz1eoD3Wd0EOipfbaEWRW6FYyxqWy4gwDe
         g8rVjS6IEPb7iYSgfdTCnAN8jFBKEb+2LVUnjNaI=
Date:   Wed, 12 Sep 2018 14:52:33 +0530
From:   Vinod <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [GIT PULL] soundwire updates for v4.19-rc1
Message-ID: <20180912092233.GG2766@vkoul-mobl>
References: <20180808162850.GN2395@vkoul-mobl>
 <20180912072945.GA24289@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20180912072945.GA24289@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12-09-18, 09:29, Greg KH wrote:
> On Wed, Aug 08, 2018 at 09:58:50PM +0530, Vinod wrote:
> > Hey Greg,
> >=20
> > Please PULL to receive the soundwire update for v4.19-rc1 with a signed
> > tag as you requested last time and the norm :-)
> >=20
> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56=
ab40:
> >=20
> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tag=
s/soundwire-4.19-rc1
>=20
> It's too late for all of these patches to go into 4.19-final.  Can you
> split this up into two sets of patches?  One for bugfixes to get into
> 4.19-final and one for new features for 4.20-rc1?

Yeah to be fair these were posted a bit late as well. I have already
rebased these on top of 4.19-rc1 and had them included in the linux-next
as well.

I will send fixes tag now. Would -rc6 be apt time for 4.20-rc1
inclusions?

Thanks
--=20
~Vinod

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbmNrYAAoJEHwUBw8lI4NHtmsP/jay4qWpzMACFUIW2Tl0dh/+
3+ke787tUlpus5nacUWJvR37Ukny6McLQglBO/RTMdhmg7VWWEqneP73hHP1Uxd/
1w6CSi+hXv6JVpNmJtC5CcjD8uZRrK56SRU/+wbl2MRlkq9/Jxj9JdXsVVWHeQXE
3sdhXsm+4NtLvxshypUXA6ClswVBLvnOoS5GbQicE8k1hrirOiWBajhl1yZ6Jojp
jyrvXeePYQIDR2kJribsPwzUTN0Xm/L//5uFRWSs7XEeqS4FSiXK3/s0AFQrWX0v
+jQvfoKU0dKRwM5+F0rr4h6m+Dcbv77Yfw96XG11NkDCRld2cthO8WbcFIF3Lvyj
YX8iAh7YZV582OxnX+/iodOJUcy7jZObqA+ifRogbrPjbyvX0p59eo9zgO0L7CmS
FTyEA59oRS36Ax2bYSlEnPPt9R/Q1qo+TKV/228Q8zK549w9xFkZBVM3FWXU6/IK
Yrf7dkn1VcK8R5eu+JWbcy+qrhTQywl8nnt/9cwHiWk2o971MD3HbqJA4xP/mmxs
kng6GiTdjX1O96cvPV9UEjC3VfoPBtY8chodoFZt+A58fm39gI/a5rKekUEYhD+X
T+l/TsHjw5G6PJp2JQL4fyf0H1uNyuGDz7j8HhFfABTJuF4hpLKl06jpV60Kn+el
7mqERZbpHCJcm/4AvPW8
=gHM3
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
