Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5AC208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5AC208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936775AbeFRJdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:33:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:55688 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935930AbeFRIYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 01:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="asc'?scan'208";a="238046352"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2018 01:24:25 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: gadget: ccid: add support for USB CCID Gadget Device
In-Reply-To: <20180608185443.GB874@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com> <87r2ltcopp.fsf@linux.intel.com> <20180530140415.GE2939@gmail.com> <20180608185443.GB874@gmail.com>
Date:   Mon, 18 Jun 2018 11:22:04 +0300
Message-ID: <87efh4zeqb.fsf@linux.intel.com>
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

Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> Hi Felipe,
>
> Should I send out v4 or what do you think?

sorry for the delay, have been busy with other tasks.

> On Wed, May 30, 2018 at 04:04:15PM +0200, Marcus Folkesson wrote:
>> Hi Filipe,
>>=20
>> On Wed, May 30, 2018 at 03:28:18PM +0300, Felipe Balbi wrote:
>> > Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>> >=20
>> > > Chip Card Interface Device (CCID) protocol is a USB protocol that
>> > > allows a smartcard device to be connected to a computer via a card
>> > > reader using a standard USB interface, without the need for each man=
ufacturer
>> > > of smartcards to provide its own reader or protocol.
>> > >
>> > > This gadget driver makes Linux show up as a CCID device to the host =
and let a
>> > > userspace daemon act as the smartcard.
>> > >
>> > > This is useful when the Linux gadget itself should act as a cryptogr=
aphic
>> > > device or forward APDUs to an embedded smartcard device.
>> > >
>> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> >=20
>> > this could be done entirely in userspace with functionfs, why do we ne=
ed
>> > this part in the kernel? It does very little.
>>=20
>> Andrzej pointed this out, and I actually do not have any good answer
>> more than that the userspace application could be kept small and the
>> important configuration of the CCID device is done with well (I hope)
>> documented configfs attributes.

can we use existing open source applications without modification by
accepting this glue layer?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlsna6wACgkQzL64meEa
mQYvWw//VgJIBEcHq2r19UEadJADomBWLb+wFVrvpsRwiWTrNC1ZGfoFJsqSGZiE
uEp1MCTsMulYqpswbZ1frOoL95P+6QVbjoPzvUoYzXB1Bn6yeGjX8Y2CkP/7uJkd
jbG9pJ7JlfcwklRjtYMEAO01v5PqWJicBdEkfGE8rFpHW4dh5UdnWO61g7biao0W
LwXwN2DHLOaJGdRwrW+ij1bmDfioB0neHU3ugv2jXenDhzCqQu96sMQXh0p6hYG7
Pn+IBZ+JJd5+TVjpC/mvV4QmJ54rIti5aFyHM9/sudKY6jU6WR86hU6mZIOr6+Cs
M3xVPV/L2C5qMBBOXWbujc2hIoKEnoACGmQhK+Qh2+Amk66vOHeScNu9GOiK2nw1
BtbuO+6i/dUdPUESSYpPY/vtKBOJmcCFkRXZRuaydwdtP2xrh2YD22Q1zTc8EOEz
AQwdBWOjTQxmeb8ngfXhBrYWUTLA1Y8ni/34NzfTJsxaigDmKXMTcouAxn0yt9dy
nOagRplUSg5hFIyTFsss+1lTfydu7emgY9F/NBQ3an8O4gevTGde6MymEyo9bFJx
OwfvjWTnZ/en2FCiPwhqwIB37isv1Xq+VSoWs/x9rJvhp6ZCUJ+WWbJFg0xA8yyT
+VgNkCtdMWFBSmAKXc+Om/6zCSUuI78oPV/Et0XJP+QOTYiUgb8=
=yKvW
-----END PGP SIGNATURE-----
--=-=-=--
