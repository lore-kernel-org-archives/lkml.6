Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-930196-1521536038-2-9725353156315156654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.195', Host='mail-qk0-f195.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521536038; b=oX/YamymwFmFS9nxjZkFnP136OzemT1xlSPi84Z/qwK2T/g
    ELvK8WGS+xP386z6cKPUOi2WLu4pgItKSpU30Z8aUp4jlbtHnYHWbnY7vLdO/8pt
    qBWdPoKf2Q45ZHrkEwrKxmTCd0bQjQI0ceLuFXe+o2pBo2ZPrckQARM6jWJZmjQA
    vgzNGvtmAT8I3DMtjFwKPrUqdPx+cK7j6953pyRapDH4a7umKlDkWJq0jTfMM/JR
    akJsjXQkMrnNibDHqSpAI2OHgi/Khyta0j31TWdZOOlhjZYlGfA/okBOHzyP3M62
    Ktgaw+iuYWEndlk1xUdmA9QfLtumyQCve0TeUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1521536038; bh=324NQnGY
    3rCnIValoyKa6iwTz2oLcJyDCz4mnoVYIPo=; b=aDK+KydoUep6n+w4BjfTrM+2
    RajzYebfV8Otcf3xvJ1uOKCddY0IflmQH56x+lEWP2pIoGN6/D6nafOihUfOxCZH
    LTRX/p9aHPf2JMpTx7KBfz5/D4P60wTrGP6H7YGbZtm7p2djMdpUF2JjjaSMqiyH
    4DydU65dxRMK3dCp8/OOToe44+lFUZ1URqTqEQxNjXkI7lHsY66pt8mGxsNvrey8
    mTI6foEfKh74eO7sMfAOZsUZ03/64eQuk9UkgI3ZzpxWjaakv8CaQbsFsHHZIwn5
    xsPPtLcOsqJwWmjR0frrW3i57fPO+ryzCooKYhLvwxC95NQEMh+R2UaHdlhdQQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mv6RQhMv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.195 (mail-qk0-f195.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f195.google.com;
    x-aligned-from=pass (Address match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s50Lx7AK;
    x-ptr=pass x-ptr-helo=mail-qk0-f195.google.com x-ptr-lookup=mail-qk0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mv6RQhMv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.195 (mail-qk0-f195.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f195.google.com;
    x-aligned-from=pass (Address match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s50Lx7AK;
    x-ptr=pass x-ptr-helo=mail-qk0-f195.google.com x-ptr-lookup=mail-qk0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Google-Smtp-Source: AG47ELufWvFB20Htg3HDAbv1n+kKKamjY/i0NoCMn72y/IgQRUOSQlaHxHBh/86tfSV1pDbhuBbrGG+sYeAGp2Tnmvc=
MIME-Version: 1.0
In-Reply-To: <20180319162903.GB17189@roeck-us.net>
References: <1521431375-23207-1-git-send-email-leechu729@gmail.com>
 <1521431375-23207-3-git-send-email-leechu729@gmail.com> <20180319162903.GB17189@roeck-us.net>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Tue, 20 Mar 2018 16:53:55 +0800
Message-ID: <CAFaeLdTC72KY+pfVhDXNxEZ-wBCj0jJKr-Ky-EJyUS9Udhnruw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: rt1711h device tree binding document
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg KH <greg@kroah.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	=?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Guenter,

2018-03-20 0:29 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On Mon, Mar 19, 2018 at 11:49:35AM +0800, ShuFan Lee wrote:
>> From: ShuFan Lee <shufan_lee@richtek.com>
>>
>> Add device tree binding document for Richtek RT1711H Type-C chip driver
>
> Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
> is missing. Added here but it might make sense to resend.
Thank you for reminding, I'll resend it.

>
>>
>> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
>> ---
>>  .../devicetree/bindings/usb/richtek,rt1711h.txt    | 30 +++++++++++++++=
+++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711=
h.txt
>>
>>  changelogs between v2 & v3
>>  - add dt-bindings document for rt1711h typec chip driver
>>
>> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b=
/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
>> new file mode 100644
>> index 000000000000..7da4dac78ea7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
>> @@ -0,0 +1,30 @@
>> +Richtek RT1711H TypeC PD Controller.
>> +
>> +Required properties:
>> + - compatible : Must be "richtek,rt1711h".
>> + - reg : Must be 0x4e, it's slave address of RT1711H.
>> +
>> +Recommended properties :
>> + - interrupt-parent : the phandle for the interrupt controller that
>> +   provides interrupts for this device.
>> + - interrupts : <a b> where a is the interrupt number and b represents =
an
>> +   encoding of the sense and level information for the interrupt.
>> +
>> +Optional properties :
>> + - rt,intr-gpios : IRQ GPIO pin that's connected to RT1711H interrupt.
>> +   if interrupt-parent & interrupts are not defined, use this property =
instead.
>> +
>> +Example :
>> +rt1711h@4e {
>> +     compatible =3D "richtek,rt1711h";
>> +     reg =3D <0x4e>;
>> +     interrupt-parent =3D <&gpio26>;
>> +     interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
>> +};
>> +
>> +Example using rt,intr-gpios :
>> +rt1711h@4e {
>> +     compatible =3D "richtek,rt1711h";
>> +     reg =3D <0x4e>;
>> +     rt,intr-gpios =3D <&gpio26 0 0x0>;
>> +};
>> --
>> 1.9.1
>>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86
