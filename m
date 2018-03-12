Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-110966-1520853970-2-11432754671726231905
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.193', Host='mail-qk0-f193.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520853970; b=t9MsnedMpbPBP9Wqos5L6/Exs5ZZcq4k9NZPFm0fTK1G2ru
    HoNX4fwL44kUnYUDk+iNlWP5AJQBE9y2dYZjEyHiBeey21oL8eOygmjczeuPA7L5
    FGCAaOLuhctFOAW0S3ceVPEenXnY15SokL+PKMd4L6RiRcQks6I0NzbrMB3QP9ju
    EYsFSTL41IENkUfWhxM1O6WJyL9Nl1QVoILH2qR+MFSX57Qz0QCkLpcN2vZR/oG3
    Ii9UEkQnDJaQsaJPgoG8zBZZzRqJktOXJjOgIzp3Prgj03Lq//p7kSzNWWajrM49
    yOMV612hE/iGEhBJcXyhyxXMMaZi3Ywp9W9ITJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1520853970; bh=4hhVNTN7
    q5DzTPP/VW6yAnoHk78fvbRdA+gb44AogOM=; b=cuZGiqfEt0YDsi/kB3txF5wC
    gVBVxGgUTyH3LOAudOGBidEfz1fuEe90raIwWJrDMIV9vvG7bqTgDZTOh5rwcPxj
    ieBcjuKH7KbQAlpn9BDFWVI/D4yDCnJ3HyyyBUt0J9pBybSgn2ReQcfUJ6j1GER0
    QSRfra0qfobioP61TxQrdjJodPrK25f1s892fNAfQGrUCDB5IyZ81z4jkH7cBqKS
    oOy1xZFAx5E+ISWhqzbAjK3UkgjHFOu5c1YskxXiE04ENRioCMp3Jh6SGzxaKFu/
    dlRyXx+kO4uZKkxGM0E8YBvQDjKUZkmx8ebhmU+0qzpdBRMZGx+Be9hu64mZTA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pX9NZuYq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CqtrXga5;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pX9NZuYq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CqtrXga5;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELsXUZQbEF9ac3uctp4KjWQjth4mE9uObcvOGRCTE01P4gpIPMtnncmkYZY68gDTe9x1F9fQpTfniv9l3p4m/lo=
MIME-Version: 1.0
In-Reply-To: <20180312110722.GB10444@kroah.com>
References: <1520848002-3801-1-git-send-email-leechu729@gmail.com> <20180312110722.GB10444@kroah.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Mon, 12 Mar 2018 19:26:07 +0800
Message-ID: <CAFaeLdSSqDok6_jaa4wwxuo+71qkv7ha5Rs81B7LvEAsRZDfYg@mail.gmail.com>
Subject: Re: [PATCH] Fixes: 8f9439022648("staging: typec: modify parameter of tcpci_irq")
To: Greg KH <greg@kroah.com>
Cc: heikki.krogerus@linux.intel.com, Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

2018-03-12 19:07 GMT+08:00 Greg KH <greg@kroah.com>:
> On Mon, Mar 12, 2018 at 05:46:42PM +0800, ShuFan Lee wrote:
>> From: ShuFan Lee <shufan_lee@richtek.com>
>
> Your subject is odd, that line should be below, in the signed-off-by:
> area, not as the subject of the patch :(
>
> Can you fix this up and resend?
Yes.
If I understand correctly, the title should be like
staging: typec: modify parameter of tcpci_irq
and the "Fixes" tag should be put in the signed-off-by area.

Should it be in the beginning of the area:
Fixes: 8f9439022648("staging: typec: handle vendor defined part and
modify drp toggling flow")
Signed-off-by: xxx

or the end of the area?
Signed-off-by: xxx
Fixes: 8f9439022648("staging: typec: handle vendor defined part and
modify drp toggling flow")

>
> thanks,
>
> greg k-h



--=20
Best Regards,
=E6=9B=B8=E5=B8=86
