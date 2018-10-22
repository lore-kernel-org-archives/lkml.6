Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6734BC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C08820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C08820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeJWFaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:30:55 -0400
Received: from sauhun.de ([88.99.104.3]:55290 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbeJWFay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:30:54 -0400
Received: from localhost (unknown [2.121.2.89])
        by pokefinder.org (Postfix) with ESMTPSA id 153034A1C75;
        Mon, 22 Oct 2018 23:10:41 +0200 (CEST)
Date:   Mon, 22 Oct 2018 22:10:38 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/1] rtc: ds1685: simplify getting .driver_data
Message-ID: <20181022211038.GA4915@kunai>
References: <20181021200042.1993-1-wsa+renesas@sang-engineering.com>
 <20181021200042.1993-2-wsa+renesas@sang-engineering.com>
 <20181022155335.GT17341@piout.net>
 <20181022172815.GW17341@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20181022172815.GW17341@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> By the way, is there any reason why this was not part of your patch back
> in April? I had a deja vu feeling ;)

I haven't checked but I guess the driver looked different back then. I
didn't update the rule, so it should have matched back then, too.


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvOPMoACgkQFA3kzBSg
KbZnzxAAqvCrc6pG+W7HZnIYZ1Ae/KZkLbvS+c92Ihmvuw8YyRWoGkRW1HGDFYaC
KjaXr5lBDwNQb+JHu3gRLQUAGijRvmI3jD5JmBysqCmwFY+nXxXdcM8rpa9CPTP+
eZcnYyTKf9YWoTLQB0VHugUAocG6H3X0HhLKzAIwOlnPOezuvK3z1XjTFOeumgxr
esCNFs3a7MqYvJkDK4d+q2UtEjcQ8F2eZKiX6jXAH8svDCQ8shJ82LY6Hnl4fmJg
OWuLiq3UgToTES+UX65h5ipWUesB/kUs1kKdRA/LMQvHqVp4Ip5HXJgK58YGTf3Z
2DG5ycqL2+4UWct7QwuUn7Tblyv67CAHfpUIxYxtZ6D+G/GnpnucVVBt9EzHRnsx
2EUrVCPZUft+HJgTip9ILj57El1jKbt4F2vrKC2yatu51M9CldOrbHZMRBguTB6u
4AyjGEgV3jKrp/HBjenLRc+nJkj44I+9ozLaqYRjPp+A0NKVr8ZXgPtzzLFoePis
WGCI+5rzCr7G+nm62ME7jFQgOD7Vc/bqQzTOE12Ym6SLS1kFeTIVfeBIZrLputxS
gm9ab5Lq35b1ZfQHXY9uEQpAsEG7i7rziTLIJFl0ofaNR58nitzJEzegun46zNRJ
dHGur/wywayZObLjFmUiJK6du5UpZwF0v0WDz8FZljJoQ6LPfIE=
=0mbV
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
