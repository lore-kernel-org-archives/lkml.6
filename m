Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85985C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1F920855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548075416;
	bh=Nr7X6UbcEo4FC1SeWNL+U06AidF97EcJHWPX6Ot6hqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aP4lhTo6R3+fUdUtR1k4CbcB5JAXjkePYqvKms8zIQ4Akp9dRnioIuY5HSOAiME6I
	 v0uzv7S5HL/fPt3HTS6qYXkMZL7aVtUA4d1Om0thsfZkevLeW6fSW2y54xnQDHSzi+
	 AYCgcDQuGKje1DdjXw//Hh8f4SQzeymqSYXGeFw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfAUM4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:56:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfAUM4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mVaEVPdU/bhPWPCtM76Lx0PzPFRXpL/jkWW2A31Z5JA=; b=b9Ra6kmBiM70kIRO4PZBH8UQW
        5qwlk9W8GNXCRxqvLBtsmb2K2i9oXC4H/x/MNyDxnBW52LRJ5G16ZLK0wN/P4SwMrnGKrMYEUgCAn
        6pRHhzOsgWUkgCZPK5LhG3mAcImhcftLYA1GuJaaWXGujJ0nQ5Zq2C0FHwhv8mEARJd2g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glZ8C-0004Ph-Ji; Mon, 21 Jan 2019 12:56:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2A6C7112767C; Mon, 21 Jan 2019 12:56:48 +0000 (GMT)
Date:   Mon, 21 Jan 2019 12:56:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [RFC 2/7] domainsctrl: Introduce domains controller framework
Message-ID: <20190121125648.GC12679@sirena.org.uk>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
 <20190114144202.27315-3-benjamin.gaignard@st.com>
 <20190117172758.GD7003@sirena.org.uk>
 <7a1c6906-7b16-317f-ead8-35bbcf07d95a@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <7a1c6906-7b16-317f-ead8-35bbcf07d95a@st.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 09:26:45AM +0000, Benjamin GAIGNARD wrote:
> On 1/17/19 6:27 PM, Mark Brown wrote:
> > On Mon, Jan 14, 2019 at 03:41:57PM +0100, Benjamin Gaignard wrote:

> > Do you have any clients in the works for this?  It seems fairly likely
> > that everything is fine in terms of setting the mode but it'd be good to
> > confirm that's the case.  The main thing I can think of that might be a

> Patch 3 use those functions to apply the default configuration before probing
> a driver (or after unbind it). I have in mind that drivers could ask to apply

Right, I saw that but I was more thinking of individual drivers.

> a configuration like it is done for pinctrl in resume/suspend functions.
> An example of that could be to start the hardware block on the main processor
> and, when going to sleep, change the configuration to grant the access to lower
> power processor.

Yes, that sounds like a good application.  I can also imagine something
like handing some hardware over to an acceleration engine (or a smaller
microcontroller core acting as one).

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxFwY8ACgkQJNaLcl1U
h9BRVQf/SCt9cFEUoyj1jpdrWzNQk9/QpMeo9vIdIQW3azOOG2Ya9vrQvs8/un1s
Wu9XQ00tWL2DfHnYD+qsYr/ZpwXS2zBpVr4lnjLzCrtti2JfY9Bw6WWiLl+P6NLv
FAvHf9ipSSsKH+t/+Rq3C5R1j08FqwVzs7nLuJokeG2SMUvgUY4N4TUNR5Z910yz
uQJ6mI82eoZIlNgNLZ+LQkmgLLgoz+NQvHCj8QXI02UFdeBp48vnYICzpKSw7XI4
J41/URlNxdA/r61J4yCKcp0tLuiIUsbKSnIriv4EOJ7qY+qemqI1i2I8a1tcraSI
elFp1PN76cHt7KH4ynwdJM0hV01HSA==
=Ashd
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
