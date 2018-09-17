Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D5EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A00214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A00214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeIQWCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:02:11 -0400
Received: from sauhun.de ([88.99.104.3]:37462 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbeIQWCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:02:11 -0400
Received: from localhost (i577B9641.versanet.de [87.123.150.65])
        by pokefinder.org (Postfix) with ESMTPSA id C74422CE416;
        Mon, 17 Sep 2018 18:34:01 +0200 (CEST)
Date:   Mon, 17 Sep 2018 18:34:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
Message-ID: <20180917163401.GA1082@kunai>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
 <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Looks good to me. Thanks! :)
>=20
> Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Does that mean I need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle
master/slave combined irq events properly" in i2c/for-next? And apply
this to i2c/for-current?

(and please quote only relevat parts of a message when replying)


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluf13UACgkQFA3kzBSg
KbYc6A//RiNyl613ea1eiJWQ6IlD3nrmnEox+ACiqAlq4Hwv5nJIdNS7RvmaVkS2
RkwPpr9PC/rMJ+OUBJMf73HpnHtAkKt0OExd5CGjUjohJPKRKIAhGzMWFO9k1kfi
MidIgxKhk6assBFO+lRms2X8iHWfpHzA1m+6bn1GDYhCmgnilc6ua/tcWutdPyjb
1qRvw6ZmTKgOcDKnck8LfxoUPlvuhqQxy0nL/bANFpTmC3nCydaSpPfdZIg+TzvI
rhBSdyxR12ZLCsHwGiJEhUpyeHiaxlN/nc0/dRI3F9mxCqKFzcnJXrLTf4T3KaOn
8e5PAxSZI/omdTLq6cNiHUhUaN3XLc1fb5U7EWSjS4/wi1EVePjYdjqRRPb2am0i
n7QFP6WDxL27AE4baPasCLq1fDvM59VjZBjftKCcwVn0a+gj5mJ8mFI1NS/CtjCw
qHIlQRsEnh1taOATGcoTxzmrpiEeb5G+7+BlZYYDVEqs1H0eDBEmD6wy+dUrieXo
P3DY+XFFpuBpqaLA01G8ImGpd9uP2czeMxD6kGuedutqbd2+7tmq8eL5eyjXMD0u
aI6QTa8fiMzIADrKBGWbprMPILXaRxn2hyFUvQtwAWgxmdRrdrPsoi1tH6WeJpFo
NQm+VyMgINQmsBJvxi5ReByjzaXD6odCJ4imLeYFSlNesr6ApSI=
=l6dV
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
