Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3924802-1522161016-2-13592398829902438485
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  FROM_EXCESS_BASE64 0.979, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.195', Host='mail-qt0-f195.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522161015; b=VNz2wxA0JrSAKNx3ptmuSNR510gLDzt9gLO3GFsgJl5+pJA
    gYQ9HlWUs6MqVG686RS1LMFPTplQWJWgRdVljE7MtoRmklaGJgLlNZSlwP3gSCVi
    rrIrg2qkKBJ3CHXXT3M2LJA9H/2kUSFAS1+iDY8C6uIG5SymdCn4Ykq1Z2pczezA
    DtP0MIozk4ZVFYGQItDD9gP8HkqvPlDw/sQENa0RnB5GVpB4xjAV0915wJCgrvPW
    94WYU9iQb9sxSdXANABIqhOIEzt+Ibfm5PtjfKz6ureAEuOIlmCuHKK7qtyJzSS6
    VFwCYZNUUIAiScvxqpCcsTs4nRvubW6uUIMfMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1522161015; bh=FrgxLcsZ
    1pgPNjDnuQeARCLszXalyD4oud5CgNlu2Jk=; b=OqxkRKjlLwt49iegn/dPEh7w
    yR1UMVNBsaWrQUCNonJ0VFQPh4cYG0L5N919Bum9nEiWVIg/2LQa8zeDrlcW9HP6
    LeqcoHT/XV7zN7fLnZqdgQXwXALVM8INSpLPL5s0LZx+GWr+WRFPxDq72oEAIUdx
    Me7L3GVKBheMdtqsyqh31eZOAuXMUqcKDMQn20X0Ec5bdZNGUUnWZP0RBW94P/qp
    JRBhku7tZ3XoEb7f8+KLxksTr6RAxSYs1fDVNHEP0d/M+nIuCEs0O+OIbOHvxa61
    PP7BUkUxp0/03h+6rahLrK17cwSN2x2SUCRhIC+NPQ6fPi2nHvjEyVwsDHT4Rw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BwQ6pzjt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.195 (mail-qt0-f195.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f195.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qZ6YjKyU;
    x-ptr=pass x-ptr-helo=mail-qt0-f195.google.com x-ptr-lookup=mail-qt0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BwQ6pzjt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.195 (mail-qt0-f195.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f195.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qZ6YjKyU;
    x-ptr=pass x-ptr-helo=mail-qt0-f195.google.com x-ptr-lookup=mail-qt0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOY5A5q5IgmnqhuEJ0yApE1srgu/skgOwjwYSn8CEwk5fDO+fmAZxwtEwb/no9HWjgt0F1J/JdZCJy/Kmw3ZqBdOQzJruN1N67sW3hvPIkuUZKKDshwB
    HndqAiGGbU0y+/QHNkHpQsjwmBY6QTdlqMk4P9VxeQqwhA58sobauebnQ9v2oFVk29h4Zieg45sVniNcFXvu78yI4O0BI8n3F+M=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=2K89khEDmCizEOrojVurBQ==:117
    a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10 a=RmZWWTEyPbYA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=l0hiEBf7AAAA:8 a=2k4UmVB2yNvayh7x70oA:9
    a=4uA5deffAPoedhbP:21 a=DnfOUGr995En0hL-:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ynCB8LqupOr-u-Kv-6Up:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AG47ELsGUps9Y962sSXRTt6FeUhqZEEerYxmnkPvQZvG9NycQOrmkC7S1wVq9YEm8zX1WbK+vu7k4dN4SACc5haB+JU=
MIME-Version: 1.0
In-Reply-To: <20180326222336.jqix6k4pyqy4bg36@rob-hp-laptop>
References: <1521537304-7531-1-git-send-email-leechu729@gmail.com>
 <1521537304-7531-3-git-send-email-leechu729@gmail.com> <20180326222336.jqix6k4pyqy4bg36@rob-hp-laptop>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Tue, 27 Mar 2018 22:30:13 +0800
Message-ID: <CAFaeLdQXQnE9XpAsgOPg=D_wAqEKe4dQhtKYrS1sDT5wgqSdVw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: rt1711h device tree binding document
To: Rob Herring <robh@kernel.org>
Cc: Greg KH <greg@kroah.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>, mark.rutland@arm.com,
	=?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,

2018-03-27 6:23 GMT+08:00 Rob Herring <robh@kernel.org>:
> On Tue, Mar 20, 2018 at 05:15:04PM +0800, ShuFan Lee wrote:
>> From: ShuFan Lee <shufan_lee@richtek.com>
>>
>> Add device tree binding document for Richtek RT1711H Type-C chip driver
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
>>  - add dt-bindings for rt1711h typec driver
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
>
> Drop this. You should simply always have interrupts property.
Does this also imply that we could always assume client->irq is ready
for request?
Therefore, there's no need to check client->irq and get gpio through
rt,intr-gpios.
>
> Rob



--=20
Best Regards,
=E6=9B=B8=E5=B8=86
