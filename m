Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3903807-1520837838-2-4945239680765504367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.174', Host='mail-qt0-f174.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520837836; b=n93yEZPSbrrVXjnQVwgBOeeOtpakEIsj/3xhfd47jA04Qr6
    9ckP11g58vcEYl2YnFy94wj9nytlhzEaWx5Sin6DcP/GwM5fhEOZsypkjoggzFcR
    iMfTFFFexx5722+nZljsTtU1AyuNt0NwjxdMn9krXDgUG5kjHJOhSgbvbU+UlcYL
    oKv2aBVVoy/X8+OPtKMx8IF+sBmm5C479V/0PDc85ONO7SJJkXa8sdlLLTqv6EDs
    ucdiGr9YhXEiz9hcW1ASqfXQbuHWEP/6euOzTBzKjJxyMQAU/XXNJWEC05nfAQ/Z
    WFY33A21Z3NhbqJhRC+KDDJAQ+V3pD/NAKVGlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1520837836; bh=joClJIci
    31hKn54WsVo3gFiZ7txFY708S1mIx4de6ms=; b=t3EQxAxSKl/YrXfLu3fWBdeR
    liNnq5rc3HVZG8X8SfVJpvsp5Cp/3U6/FEp0cIYyLzQ686mvcXr/TY4R2AgV9rrK
    KwIg/+7C9spKOb4PdzKweXReK1gI6yRT1vjlPwynPJVzjmYwyB8+NxZ9V0Vi//5Y
    tZCAf5TsP5hEz4aXsXkJSmGBgnmfmve042vfOqPGYtJtGensYZ66v7BORZvHQn+n
    KjTq7ksBL7hSrTmAdgK2H1SiBx5RtZGszhCxsF75BR3wmtJykrsEUDL/wK5OGwGu
    BmlBsHEa91+fmwIhD756ryzhYixWCde7IgiFLuTplvm0Jf+46hy3Hk501Z1fmQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Dmid/uEY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.174 (mail-qt0-f174.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f174.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jf1E/x7e;
    x-ptr=pass x-ptr-helo=mail-qt0-f174.google.com x-ptr-lookup=mail-qt0-f174.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Dmid/uEY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.174 (mail-qt0-f174.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f174.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jf1E/x7e;
    x-ptr=pass x-ptr-helo=mail-qt0-f174.google.com x-ptr-lookup=mail-qt0-f174.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELv4r7O8rr7Z2+112KCqgMdYndjz2y7Z5UWWO1BHESa18xUjfF6+ZQlDTUsehYtQ8B5NPipWOGaoN0vQOOgVPCM=
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB391795EEE76FBDCFDBD541BB89D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
References: <1520301032-10109-1-git-send-email-leechu729@gmail.com>
 <VI1PR0402MB39170322F313A03DC0018A8089D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <CAFaeLdQDHSdeoG9fPVrBheohBGMkG-KirFtF-ra48AXfMWhVNw@mail.gmail.com> <VI1PR0402MB391795EEE76FBDCFDBD541BB89D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Mon, 12 Mar 2018 14:57:14 +0800
Message-ID: <CAFaeLdSBJ_SD9gtGbQsCchxQ03PBi3=6D4bjCpYrnm-xoRdvCg@mail.gmail.com>
Subject: Re: [PATCH v7] staging: typec: handle vendor defined part and modify
 drp toggling flow
To: Jun Li <jun.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"greg@kroah.com" <greg@kroah.com>, "shufan_lee@richtek.com" <shufan_lee@richtek.com>,
	"cy_huang@richtek.com" <cy_huang@richtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jun,

2018-03-12 13:58 GMT+08:00 Jun Li <jun.li@nxp.com>:
> Hi
>> -----Original Message-----
>> From: =E6=9D=8E=E6=9B=B8=E5=B8=86 [mailto:leechu729@gmail.com]
>> Sent: 2018=E5=B9=B43=E6=9C=8812=E6=97=A5 13:22
>> To: Jun Li <jun.li@nxp.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
>> heikki.krogerus@linux.intel.com; linux@roeck-us.net; greg@kroah.com;
>> shufan_lee@richtek.com; cy_huang@richtek.com;
>> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org
>> Subject: Re: [PATCH v7] staging: typec: handle vendor defined part and m=
odify
>> drp toggling flow
>>
>> Hi Jun,
>>
>>   Thank you.
>>
>> 2018-03-12 12:33 GMT+08:00 Jun Li <jun.li@nxp.com>:
>> > Hi,
>> >
>> >> +static irqreturn_t _tcpci_irq(int irq, void *dev_id) {
>> >> +     struct tcpci *tcpci =3D dev_id;
>> >> +
>> >> +     return tcpci_irq(tcpci);
>> >> +}
>> >>
>> > ...
>> >
>> >> +     err =3D devm_request_threaded_irq(&client->dev, client->irq, NU=
LL,
>> >> +                                     _tcpci_irq,
>> >>                                       IRQF_ONESHOT |
>> IRQF_TRIGGER_LOW,
>> >> -                                     dev_name(tcpci->dev), tcpci);
>> >> +                                     dev_name(&client->dev), chip);
>> >
>> > - dev_name(&client->dev), chip);
>> > + dev_name(&client->dev), chip->tcpci);
>> >
>> > Did you ever test this patch?
>> I've tested this patch with tcpci_rt1711h.c that will be sent out for re=
viewing in
>> the next patch after tcpci's modification is passed.
>> Because interrupt handler is registered in tcpci_rt1711h.c, here is the =
place I
>> didn't notice.
>
> Understood.
>
>> The interrupt handler for tcpci.c should be modified as following:
>>  static irqreturn_t _tcpci_irq(int irq, void *dev_id)  {
>> -       struct tcpci *tcpci =3D dev_id;
>> +       struct tcpci_chip *chip =3D dev_id;
>>
>> -       return tcpci_irq(tcpci);
>> +       return tcpci_irq(chip->tcpci);
>>  }
>>
>
> Either way is OK to fix it.
> You may send out your v8 and notify Greg to drop your v7 version.
>
> Jun Li

May I add you in the Reported-by list?

--=20
Best Regards,
=E6=9B=B8=E5=B8=86
