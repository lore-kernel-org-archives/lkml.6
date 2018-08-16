Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A9EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0182920657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bonedaddy.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbeHPFYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:24:47 -0400
Received: from li1077-42.members.linode.com ([45.33.94.42]:41766 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeHPFYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:24:47 -0400
Received: from chianamo (d122-109-112-175.per801.wa.optusnet.com.au [122.109.112.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id EE717180041;
        Wed, 15 Aug 2018 22:29:38 -0400 (EDT)
Message-ID: <10df62228da4824d65f3f4765657ef776833d12c.camel@bonedaddy.net>
Subject: Re: linux: REGRESSION: drm: cmdline EDID override mechanisms
 broken since 4.15
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <87h8jw7wqc.fsf@intel.com>
References: <4eea367179f91d3e60d1405c54befec7958e5c0f.camel@bonedaddy.net>
         <87h8jw7wqc.fsf@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-3dH9wv1Yao2GrPcXOsvr"
Date:   Thu, 16 Aug 2018 10:29:32 +0800
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3dH9wv1Yao2GrPcXOsvr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-15 at 13:25 +0300, Jani Nikula wrote:

> Please file a bug over at [1], describe the symptomps of how it doesn't
> work (black screen, wrong mode, what?), add drm.debug=3D14 module
> parameter, attach dmesg for before/after the bisected commit.

Filed the bug here:

https://bugs.freedesktop.org/show_bug.cgi?id=3D107583%27

> Does adding video=3DVGA-1:e parameter make a difference?

That works around the issue. I assume this means the VGA will always be
enabled even if it is not plugged in?

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-3dH9wv1Yao2GrPcXOsvr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAlt04YwACgkQMRa6Xp/6
aaPN4g//ZAG8ucKOhZ5oX7e1Gj1fmWJ33nb7AEfIjQwqIY8Mq4heJUfMDUuXeUYp
DBkflpdIdz0IikDM2jJ3dyHjhskpkQPANdrSpd63QtikFlzvpsl5kFAe+j6GG98u
X7/ZZ2nWeZ3wyebMzEmBo/frFKQZWSPiHiYTMkH63eLAK5vsqjef0aun05X5hTGx
3mUwOHQdrvK5Yv5Ijs4jyGpuGE0flCUrQWucDyDcanGiDZFt9jlr68oa3GSkPJ6m
jF0EgOkyb6duGD1RCXutJiwWg6eAl3yI7uhljwd4QkDbQQUkeksQK4jV7P0vK91E
Oh30WkoIz2TegFRd7sEst3ZwJtEJMinUED4OUoIm4/cdIXLnj574kyke1/CGHmA2
Yw+2udUYjJ7Nd3jzlF7q9Aj2mJnwKSKdpql1W4SctCiQq1xvmmKI1jyERx6ti1BU
9dEEcQDki86cJQC+RlnI0IYHbZyEfTm2aqyT22FOo1hWfgYhkEkLxE6TwanEJnTS
LFbDUcn2C5uovlPvj4hbGOoLbVwPP5TXEs7SBVY1MadQcq/LOVWDszIU6z2vOM1i
DCLtRWZI1yqdAs93cBZwwCzg/y3gTKrEU1zaP0h3l9DHQtfEbV/uzdRbASTME0IR
y/xuylcxeexOg+W2teBZm9+fM5ty9EKryDBHa/BkK5dgduhGbaQ=
=xax5
-----END PGP SIGNATURE-----

--=-3dH9wv1Yao2GrPcXOsvr--

