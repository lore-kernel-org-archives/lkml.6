Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3579367-1520832133-2-10952529067246260540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.193', Host='mail-qk0-f193.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520832133; b=LF1Zs3sqCx0pecKDX2v/Sdh3MmZYVgh1x8AqRHvbk0A7d9J
    jYNBlYQaAUIQl009D1u072VLXruK0k7NTm5CnUaGgPVQZ7hVHu1zq6c5nOyBYKQE
    uMDGG0qSa9NrkrzwGPBeqQew1Yw0+rxWX4X9s8ZqKGrHkFMSM+YcPJ/gDU977Coy
    Kc3dKEzfr0CGCazX8CrrsRg+S15xDxe4oAxSfFCRNwnttgom9DthMP9itRAGvbRU
    /jeD32/rNzMvk62DoCNLXnS+mr52kFJF55d0iR99701EKx4GZxrzLcWbY+pOJ35f
    LmwijIUDG6U3TYpX4rVG6BXfk3aMqgGcj1yrBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1520832133; bh=cvbzJKGj
    rwRn7q6NKUR6PYVv1hrhRVHgi5j3Fvk2uQ0=; b=gX4I/PsneNOKOJTFvyik2N3/
    DS99q9Eb4Kfdx1R3mv0bipJci6RHslUZzq5k1NuUOJFPguTvJiZ50vKWbRSGonwC
    QJbQLauD3wOpzUZOtUiRt8NLoPBKeUogTuX+ZtlE3gs7yb7HrbuLBQWPQoGazo3F
    uF7YyOnDhVzuFLLICqSXIIb/Ys2t2yZHfmH9Z9KLTuJwCsaC81boXDY/7lceH2jY
    Jbk3DIigfidhhDHRAstSimT76SPzgt7ff3RiMkFACiWVASqEIfF23rgNJ2sjLmg2
    Jn+gEJt7mb/98CmjiGB3jhx7y9PGaXCVQvPDf+CurqnsgEXgnkx1sDgIsiSzVA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u4iLnPKM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nbD5KTB7;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u4iLnPKM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nbD5KTB7;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELsJ5UWze4tLtCM+YuceAgLCx1aiZV7kp5ubLbCXZXLOS0biN/uh+waaK6aDxDXiz7pMBsjnprF19pNB5g38bxo=
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB39170322F313A03DC0018A8089D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
References: <1520301032-10109-1-git-send-email-leechu729@gmail.com> <VI1PR0402MB39170322F313A03DC0018A8089D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Mon, 12 Mar 2018 13:22:10 +0800
Message-ID: <CAFaeLdQDHSdeoG9fPVrBheohBGMkG-KirFtF-ra48AXfMWhVNw@mail.gmail.com>
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

  Thank you.

2018-03-12 12:33 GMT+08:00 Jun Li <jun.li@nxp.com>:
> Hi,
>
>> +static irqreturn_t _tcpci_irq(int irq, void *dev_id) {
>> +     struct tcpci *tcpci =3D dev_id;
>> +
>> +     return tcpci_irq(tcpci);
>> +}
>>
> ...
>
>> +     err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> +                                     _tcpci_irq,
>>                                       IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>> -                                     dev_name(tcpci->dev), tcpci);
>> +                                     dev_name(&client->dev), chip);
>
> - dev_name(&client->dev), chip);
> + dev_name(&client->dev), chip->tcpci);
>
> Did you ever test this patch?
I've tested this patch with tcpci_rt1711h.c that will be sent out for
reviewing in the next patch after tcpci's modification is passed.
Because interrupt handler is registered in tcpci_rt1711h.c, here is
the place I didn't notice.
The interrupt handler for tcpci.c should be modified as following:
 static irqreturn_t _tcpci_irq(int irq, void *dev_id)
 {
-       struct tcpci *tcpci =3D dev_id;
+       struct tcpci_chip *chip =3D dev_id;

-       return tcpci_irq(tcpci);
+       return tcpci_irq(chip->tcpci);
 }

>
> I noticed Greg already picked this patch[1]:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit=
/?h=3Dusb-testing&id=3D8f94390226487bcb86c554ddc12eef0d27bdec3b
>
> One more minor comment below.
>
> Jun Li
>
>> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci=
.h index
>> fdfb06c..a2c1754 100644
>> --- a/drivers/staging/typec/tcpci.h
>> +++ b/drivers/staging/typec/tcpci.h
>> @@ -59,6 +59,7 @@
>>  #define TCPC_POWER_CTRL_VCONN_ENABLE BIT(0)
>>
>>  #define TCPC_CC_STATUS                       0x1d
>> +#define TCPC_CC_STATUS_DRPRST                BIT(5)
>
> Defined but not used.
This definition can be removed for now.
>
>>  #define TCPC_CC_STATUS_TERM          BIT(4)
>>  #define TCPC_CC_STATUS_CC2_SHIFT     2
>>  #define TCPC_CC_STATUS_CC2_MASK              0x3
>> @@ -121,4 +122,18 @@
>>  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG               0x76
>>  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG               0x78
>>
>> +struct tcpci;
>> +struct tcpci_data {
>> +     struct regmap *regmap;
>> +     int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>> +     int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>> +                      bool enable);
>> +     int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *=
data,
>> +                               enum typec_cc_status cc);
>> +};
>> +
>> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data
>> +*data); void tcpci_unregister_port(struct tcpci *tcpci); irqreturn_t
>> +tcpci_irq(struct tcpci *tcpci);
>> +
>>  #endif /* __LINUX_USB_TCPCI_H */
>> --
>> 1.9.1
>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86
