Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2355499-1521449713-2-7208660648710622220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521449713; b=qrzeyRHn9Gvo+S6wdwOsFJpLa0TtOtruzRx04MtLnhx+p3V
    YduEJlheyAsKF9BxumCXM4H5TVw+lSBAqwP6CaovoRcFRfi0nMPgRKZoENggAqQV
    DekyjAiMi/ZE7btFrgigSeLML1CXNRlN9mWOHjs87ZK+8Nc58DrTt5Q3tTJ4H3jk
    Er+tBI/isngDmNppJyQzCvMTO7PxDQ1xasW19r2f6jxBay0UCsJAawoi5t+gVEJ3
    J3bJPOv0ABCBbiwC0GjifIig7j1KE0Yz7XzmqdnwzUKkxDzeKNotBWKfFFcsUEgF
    B4l1lLIAQ04s9WWHH6oYCWjgS50yWGjmRWRbiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1521449713; bh=qIFHgK/N3PNvGDdXad/Qy+RAgcTse/L/S6ZbXQ
    pNf5c=; b=YoR11zcviIi0P2I4NriN2WKH0WEi+0EoXwbJCiiU6FE7LmlKiFV87Z
    pCWbR7vg9gIsV+brgU1lf3otZ19SY3w+YjQXeEmjDmm/roLACvByjdI5PGXwJ1ZR
    AjqSSrJA5LnKg67RgeWrolMI9M3FoR6EvxJBXx4CrbiAA4b1J+aJiB7uIC0ptC7+
    w4TbPdGc00XMapTxE7ZeUyNyTpURJ8ICUBN8n7hobp6nJrZo2lJ23vgGA0hVwJJH
    qoM3ICeuPjpfKAmrnVnqslF2KKa5+V5ncKuLsfnLTZ/Wh+3k1glWFQdtYu+DOh52
    25tHR9Wd2dLD9UMNx2SthH+npee4hLEw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffujghffffkgggtshhpjeesghdtreertddttdenucfhrhhomhephfgvlhhiphgvuceurghlsghiuceosggrlhgsiheskhgvrhhnvghlrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdduledvrdehhedrhedvrdekkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheefkeeknecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffujghffffkgggtshhpjeesghdtreertddttdenucfhrhhomhephfgvlhhiphgvuceurghlsghiuceosggrlhgsiheskhgvrhhnvghlrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdduledvrdehhedrhedvrdekkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheefkeeknecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeCSIy7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 04:54:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:22023 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932792AbeCSIy6 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 19 Mar 2018 04:54:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="asc'?scan'208";a="34983632"
From: Felipe Balbi <balbi@kernel.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Roger Quadros <rogerq@ti.com>
Cc: "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <410670D7E743164D87FA6160E7907A560113ABBA4B@am04wembxa.internal.synopsys.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com> <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com> <87y3isffog.fsf@linux.intel.com> <5ea0ad17-d538-72ec-ed59-004242c4cd26@ti.com> <410670D7E743164D87FA6160E7907A560113ABB478@am04wembxa.internal.synopsys.com> <87zi38438h.fsf@linux.intel.com> <410670D7E743164D87FA6160E7907A560113ABBA4B@am04wembxa.internal.synopsys.com>
Date: Mon, 19 Mar 2018 10:54:34 +0200
Message-ID: <87d100qwc5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>>>>>> Thanks for picking this for -next.
>>>>>> Is it better to have this in v4.16-rc fixes?
>>>>>> and also stable? v4.12+
>>>>>
>>>>> Well, there was no "Fixes: foobar" or "Cc: stable" lines in the commit
>>>>> log ;-)
>>>>>
>>>>> The best we can do now, is wait for -rc1 and manually send the commit=
 to
>>>>> stable.
>>>>>
>>>>
>>>> That's fine. Thanks.
>>>>
>>>
>>> Same issue seen in dwc3_gadget_ep_dequeue() function where also used
>>> wait_event_lock_irq() - as result infinite loop.
>>=20
>> how did this happen? During rmmod dwc3? Or, perhaps, after you unloaded
>> a gadget driver?
>>=20
> No, not during rmmod's.
> We using our internal USB testing tool. Test case; ISOC OUT, transfer=20
> size N frames. When host starts ISOC OUT traffic then the dwc3 based on=20
> "Transfer not ready" event in frame F starts transfers staring from=20
> frame F+4 (for bInterval=3D1) as result 4 requests, which already queued=
=20
> on device side, remain incomplete. Function driver on some timeout=20
> trying dequeue these 4 requests (without disabling EP) to complete test.
> For IN ISOC's these requests completed on MISSED ISOC event, but for=20
> ISOC OUT required call dequeue on some timeout.

okay

>>> Actually to fix this issue I updated condition of wait function
>>> from:
>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>>> to:
>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING & DWC3_EP_ENABLED)
>>=20
>> you're not fixing anything. You're, essentially, removing the entire
>> end transfer pending logic.=20
> yes, you are right, but how to overcome this infinite loop? Replace=20
> wait_event_lock_irq() by  wait_event_interruptible_lock_irq_timeout()?

The best way here would be to figure why we're missing command complete
IRQ in those cases. According to documentation, we *should* receive that
interrupt, so why is it missing?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqvesoACgkQzL64meEa
mQbJhw/8DAGqXP8g8zqUOV8LBuA4l2yVQrKn9FlgSdTG5+GkfICZftGBjMqUFjCW
YVIGGl7BbUooaj2dVCl2HsAWhYYyhJH9Ij22MB21wxM4baX8Qf0wO4lm8n++F8cg
hodJMv+GJ7tvtReg4dxAKTLhO54CPZgUdQiLqo4ANseFCZ+FFGLNGkneGlJSq70o
0unrQrioFY0Sr9WeY5BwqkLxZVhr6IEbH8l2iZ9nVOfpaQTk43e5BdQ8NT2KpKii
RgXMZQregqTh4U7ZZmg2siZf0McQ9wIIvvYLrnPT6y0LBqwKqwR2k28VGaXzpxYO
KPUhzHgPEMwkz4RGW6HpiGYJ3MXaBuoqBQhWEFqgNLX8Ncvy2Gh3unatdupUtd35
vSZuYxVkelVAkZ7wgaE2JLMuQnSeCqNch/9S6F4vx5a6+MMVH8ciu0oUEOojfm3R
wh5hGpjcxcn1J5ZYVsD6u58v4AmK/0hIXlyonVu9kVIgxTiQ9GD5Sk3H204RMQwu
YcsBusF8P7i+9rIWBWet3FkxnAHArtbv1cgZi9aCbHdUkYQy48E1w2oNov1v9kXd
76joh02a+ILdr/9BS3C5FPQZJe0NuzcpY1azdyL7YlAEJfnzn5dknHQJsnRWnBJ5
rL4Kd4tQ2v7e0XMcGVdM3VGgHs/BKbP3Wf7St6g3059idF25O2w=
=yCfT
-----END PGP SIGNATURE-----
--=-=-=--
