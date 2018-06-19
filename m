Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0020C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33EF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33EF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756956AbeFSJuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:50:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:24476 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755946AbeFSJuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:50:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 02:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="asc'?scan'208";a="64424072"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2018 02:50:05 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     linux-usb-owner@vger.kernel.org
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        David Lechner <david@lechnology.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: add error handling for skb_realloc_headroom
In-Reply-To: <1528778503-41615-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528778503-41615-1-git-send-email-jiazhouyang09@gmail.com>
Date:   Tue, 19 Jun 2018 12:47:42 +0300
Message-ID: <87vaafw1j5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

linux-usb-owner@vger.kernel.org writes:
> When skb_realloc_headroom fails, the lack of error-handling code may
> cause unexpected results.
>
> This patch adds error-handling code after calling skb_realloc_headroom.
>
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>

From=20linux-usb-owner??? I can't apply this patch.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlso0T4ACgkQzL64meEa
mQY/xhAAs+30wERTUootYBnVRVWG+nxRFYVuvpUSu6lzt3Kfelo3hd+woVkjBeHF
xUNzUiE1DAWoSGBIAnY51RIGJtNS85Kc+Q4aULyVhKu/4vteq5kf5Ju+8yoLu98l
yzK+uEHvsv73meHVBiEvfxvsnL4UNbjLS/MS3Q/kPVU0f6pYV2d8yRAT7blLMj1Z
m2W0vHupB0a9jVxYht/VfelfCrxkTgCEuulx6dBubRUxu9zHrt+VmAfILrNLRghz
TOZjkc2GRHcTeUIE0CsSgkSqsjUg8iUllbcS9UdZDb7a+7t5uRHomako1heWWUB/
d2U9M+ivYQTl+cCBUTCt2qEV1K/+XcN+nEoNaPnkmojF3Dcebj6tGlV6OZA4WKE2
4Iz1jgbDqN18x+KxtdIAiFLfz0qgL+Gk7YFSvmM21Q7JmviGEmaJhwy7NHalRYFZ
qwJBzTJW6kVp6vwty/RJcwTGVdOedZGjoWawbrUZTPVmvPSu7HeISH6XaOAGWFSw
9is0CKXB0RbyJzT8YEG+XPEYNZ84umqQdnVeaBK0JQbCcEQWfCqMU6R7j+l/CEPw
Gc3UHZXspWj5gcty8gRMQmsjT6d0pbyWIy85frcTO0IG2ogNoZ93c7W59On4VQsB
P6gzeaRpF950DVCTlEUhGOhoFRIPrSEwfKG+VZb37M1mddyC/hk=
=vh+D
-----END PGP SIGNATURE-----
--=-=-=--
