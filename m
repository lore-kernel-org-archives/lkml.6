Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3145149-1518622348-2-4034286396247691904
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  HTML_MESSAGE 0.001, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.193', Host='mail-qt0-f193.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', plain='UTF-8', html='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518622346; b=ghAeI8fama/reAygifmHqZpEHhVeIaR89bmzeAyIMSbJMTF
    DdNCkHkXCvFwyNS03ZyMPoHBy/IMrmSvb5X88w7Dk96BKsMQ+8V58RZpx8RIBkNf
    e72Dh3f2ftAslLH9zINcZqM76ktzPRVGiiQlHvlj/UN/PaxBfTe3gka155dQKnbD
    d3xIZc+769UmFRzlbY+POnt6iftP91SaCsUKlSkqVrzWEs702oKilqyKD29uv1rE
    ov2erN/a/pSw/d7l6StjsCoQ4mkjuide7bRwwtobuJSNWLIK2Z404Ce9/6+mvBtE
    /rWoE7xLRmzOhMqE/5PE37XRgUAx5VMdTBXPrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1518622346; bh=Cn7lMsOfKRz5iylOeyX76Xl/yOldJQqKVt7qSzTbRGw=; b=R
    k+mZAPWbQqqaSuVXuKiaLDTYLXbleoSrwvdswh+gntVc8SBvIGu4j+pfB9aBMnOC
    vK6hWHXF/qkkVuc4sIfKJ3XIhYkIzWipv8yE5kQZ+M1eP53MIgLwEbYxoVEAJgUK
    A+kznsI/Wsk3/Fh3tG0/oZve+v1I+e6vNfrUc+aK9lUZnTUBovlEF6lawgeO3exn
    HjSK8uHtaiHrmRdEc+rgxzdnlBmFfjt66gFJhdn/YjvAT0WsKVL82udPu4QhRYlP
    v4ag7zo6j+/aNr7tW/SSvWdwnFvnhq2I0g+NoKIQ8msBBmVj7t/r8BInEycdfENH
    IdpbrENMWx3EABsQx/0Tg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eSghkf4z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.193 (mail-qt0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f193.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AYFnEmX9;
    x-ptr=pass x-ptr-helo=mail-qt0-f193.google.com x-ptr-lookup=mail-qt0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eSghkf4z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.193 (mail-qt0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f193.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AYFnEmX9;
    x-ptr=pass x-ptr-helo=mail-qt0-f193.google.com x-ptr-lookup=mail-qt0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227jVNQKnns1439vcWIWJwF6kCQHxtWjboA/tM8lkDKXkH12vxfqXcnXBSAuy2ucokFhWityuMzVo08irDiMcb0=
MIME-Version: 1.0
In-Reply-To: <71b01ca3-99ce-8af4-0967-0aaca4ea6fcf@roeck-us.net>
References: <1518612334-24140-1-git-send-email-leechu729@gmail.com> <71b01ca3-99ce-8af4-0967-0aaca4ea6fcf@roeck-us.net>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Wed, 14 Feb 2018 23:32:23 +0800
Message-ID: <CAFaeLdSFqw8qnp4zz2Eoiv9EWTmixtFMnp4-6sYdBRJzHCgvwA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: typec: handle vendor defined part and modify
 drp toggling flow
To: Guenter Roeck <linux@roeck-us.net>
Cc: heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, cy_huang@richtek.com, shufan_lee@richtek.com,
	Greg KH <greg@kroah.com>
Content-Type: multipart/alternative; boundary="001a11374c0c628f1805652dd15e"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a11374c0c628f1805652dd15e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Guenter,

I've thought about registering interrupt early, prior to
tcpci_register_port. Just like you said.
But to make sure interrupt handler will not be invoked, we'll also need to
mask all alerts early.
And we'll need another structure used as dev_id of
devm_request_threaded_irq() because tcpci is not allocated yet at that time=
.
For example:

struct tcpci_chip {
        struct tcpci *tcpci;
        struct tcpci_data;
       ...
};

static int tcpci_probe(struct i2c_client *client,
                      const struct i2c_device_id *i2c_id)
{
        u16 val =3D 0;
        struct tcpci_chip *chip;

        chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
....
....
....
        /* Disable chip interrupts */
       regmap_raw_write(chip->data.regmap, TCPC_ALERT_MASK, &val,
sizeof(u16));

       err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
                                       _tcpci_irq,
                                        IRQF_ONESHOT | IRQF_TRIGGER_LOW,
                                        dev_name(&client->dev), chip);
        if (err < 0)
                return err;

       chip->tcpci =3D tcpci_register_port(&client->dev, &chip->data);
       if (PTR_ERR_OR_ZERO(chip->tcpci))
               return PTR_ERR(chip->tcpci);

If you agree with this flow, I think this one will be better.


2018-02-14 22:46 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:

> On 02/14/2018 04:45 AM, ShuFanLee wrote:
>
>> From: ShuFanLee <shufan_lee@richtek.com>
>>
>> Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and export
>> tcpci_irq.
>> More operations can be extended in tcpci_data if needed.
>> According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
>> TCPC shall not start DRP toggling until subsequently the TCPM
>> writes to the COMMAND register to start DRP toggling.
>> DRP toggling flow is chagned as following:
>>    - Write DRP =3D 0 & Rd/Rd
>>    - Write DRP =3D 1
>>    - Set LOOK4CONNECTION command
>>
>> Signed-off-by: ShuFanLee <shufan_lee@richtek.com>
>> ---
>>   drivers/staging/typec/tcpci.c | 111 ++++++++++++++++++++++++++++++
>> ++++--------
>>   drivers/staging/typec/tcpci.h |  13 +++++
>>   2 files changed, 103 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci=
.
>> c
>> index 9bd4412..461fbd48 100644
>> --- a/drivers/staging/typec/tcpci.c
>> +++ b/drivers/staging/typec/tcpci.c
>> @@ -21,7 +21,6 @@
>>     struct tcpci {
>>         struct device *dev;
>> -       struct i2c_client *client;
>>         struct tcpm_port *port;
>>   @@ -30,6 +29,7 @@ struct tcpci {
>>         bool controls_vbus;
>>         struct tcpc_dev tcpc;
>> +       struct tcpci_data *data;
>>   };
>>     static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
>> @@ -98,8 +98,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum
>> typec_cc_status cc)
>>   static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>>                                     enum typec_cc_status cc)
>>   {
>> +       int ret;
>>         struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
>> -       unsigned int reg =3D TCPC_ROLE_CTRL_DRP;
>> +       unsigned int reg =3D (TCPC_ROLE_CTRL_CC_RD <<
>> TCPC_ROLE_CTRL_CC1_SHIFT) |
>> +                          (TCPC_ROLE_CTRL_CC_RD <<
>> TCPC_ROLE_CTRL_CC2_SHIFT);
>>         switch (cc) {
>>         default:
>> @@ -116,8 +118,19 @@ static int tcpci_start_drp_toggling(struct tcpc_dev
>> *tcpc,
>>                         TCPC_ROLE_CTRL_RP_VAL_SHIFT);
>>                 break;
>>         }
>> -
>> -       return regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>> +       ret =3D regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>> +       if (ret < 0)
>> +               return ret;
>> +       usleep_range(500, 1000);
>> +       reg |=3D TCPC_ROLE_CTRL_DRP;
>> +       ret =3D regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>> +       if (ret < 0)
>> +               return ret;
>> +       ret =3D regmap_write(tcpci->regmap, TCPC_COMMAND,
>> +                          TCPC_CMD_LOOK4CONNECTION);
>> +       if (ret < 0)
>> +               return ret;
>> +       return 0;
>>   }
>>     static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool
>> sink)
>> @@ -178,6 +191,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc,
>> bool enable)
>>         struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
>>         int ret;
>>   +     /* Handle vendor set vconn */
>> +       if (tcpci->data) {
>> +               if (tcpci->data->set_vconn) {
>> +                       ret =3D tcpci->data->set_vconn(tcpci, tcpci->dat=
a,
>> +                                                    enable);
>> +                       if (ret < 0)
>> +                               return ret;
>> +               }
>> +       }
>> +
>>         ret =3D regmap_write(tcpci->regmap, TCPC_POWER_CTRL,
>>                            enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>>         if (ret < 0)
>> @@ -323,6 +346,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>>         if (time_after(jiffies, timeout))
>>                 return -ETIMEDOUT;
>>   +     /* Handle vendor init */
>> +       if (tcpci->data) {
>> +               if (tcpci->data->init) {
>> +                       ret =3D tcpci->data->init(tcpci, tcpci->data);
>> +                       if (ret < 0)
>> +                               return ret;
>> +               }
>> +       }
>> +
>>         /* Clear all events */
>>         ret =3D tcpci_write16(tcpci, TCPC_ALERT, 0xffff);
>>         if (ret < 0)
>> @@ -344,9 +376,16 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>>         return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
>>   }
>>   -static irqreturn_t tcpci_irq(int irq, void *dev_id)
>> +static irqreturn_t _tcpci_irq(int irq, void *dev_id)
>>   {
>>         struct tcpci *tcpci =3D dev_id;
>> +
>> +       tcpci_irq(tcpci);
>> +       return IRQ_HANDLED;
>>
>
> This should probably be
>         return tcpci_irq(tcpci);
>
> +}
>> +
>> +int tcpci_irq(struct tcpci *tcpci)
>>
>
> and this should be
>
> irqreturn_t tcpci_irq(struct tcpci *tcpci)
>
> Otherwise it doesn't add value to have tcpci_irq() return anything.
> Alternative would be to make it
>
> void tcpci_irq(struct tcpci *tcpci)
>
> if it will always only return IRQ_HANDLED.
>
> Guenter
>
>
> +{
>>         u16 status;
>>         tcpci_read16(tcpci, TCPC_ALERT, &status);
>> @@ -412,6 +451,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
>>         return IRQ_HANDLED;
>>   }
>> +EXPORT_SYMBOL_GPL(tcpci_irq);
>>     static const struct regmap_config tcpci_regmap_config =3D {
>>         .reg_bits =3D 8,
>> @@ -435,22 +475,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)
>>         return 0;
>>   }
>>   -static int tcpci_probe(struct i2c_client *client,
>> -                      const struct i2c_device_id *i2c_id)
>> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data
>> *data)
>>   {
>>         struct tcpci *tcpci;
>>         int err;
>>   -     tcpci =3D devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL)=
;
>> +       tcpci =3D devm_kzalloc(dev, sizeof(*tcpci), GFP_KERNEL);
>>         if (!tcpci)
>> -               return -ENOMEM;
>> +               return ERR_PTR(-ENOMEM);
>>   -     tcpci->client =3D client;
>> -       tcpci->dev =3D &client->dev;
>> -       i2c_set_clientdata(client, tcpci);
>> -       tcpci->regmap =3D devm_regmap_init_i2c(client,
>> &tcpci_regmap_config);
>> -       if (IS_ERR(tcpci->regmap))
>> -               return PTR_ERR(tcpci->regmap);
>> +       tcpci->dev =3D dev;
>> +       tcpci->data =3D data;
>> +       tcpci->regmap =3D data->regmap;
>>         tcpci->tcpc.init =3D tcpci_init;
>>         tcpci->tcpc.get_vbus =3D tcpci_get_vbus;
>> @@ -467,27 +503,60 @@ static int tcpci_probe(struct i2c_client *client,
>>         err =3D tcpci_parse_config(tcpci);
>>         if (err < 0)
>> -               return err;
>> +               return ERR_PTR(err);
>>         /* Disable chip interrupts */
>>         tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
>>   -     err =3D devm_request_threaded_irq(tcpci->dev, client->irq, NULL,
>> -                                       tcpci_irq,
>> +       tcpci->port =3D tcpm_register_port(tcpci->dev, &tcpci->tcpc);
>> +       if (PTR_ERR_OR_ZERO(tcpci->port))
>> +               return ERR_CAST(tcpci->port);
>> +
>> +       return tcpci;
>> +}
>> +EXPORT_SYMBOL_GPL(tcpci_register_port);
>> +
>> +void tcpci_unregister_port(struct tcpci *tcpci)
>> +{
>> +       tcpm_unregister_port(tcpci->port);
>> +}
>> +EXPORT_SYMBOL_GPL(tcpci_unregister_port);
>> +
>> +static int tcpci_probe(struct i2c_client *client,
>> +                      const struct i2c_device_id *i2c_id)
>> +{
>> +       struct tcpci *tcpci;
>> +       struct tcpci_data *data;
>> +       int err;
>> +
>> +       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +
>> +       data->regmap =3D devm_regmap_init_i2c(client, &tcpci_regmap_conf=
ig);
>> +       if (IS_ERR(data->regmap))
>> +               return PTR_ERR(data->regmap);
>> +
>> +       tcpci =3D tcpci_register_port(&client->dev, data);
>> +       if (PTR_ERR_OR_ZERO(tcpci))
>> +               return PTR_ERR(tcpci);
>> +
>> +       err =3D devm_request_threaded_irq(&client->dev, client->irq, NUL=
L,
>> +                                       _tcpci_irq,
>>                                         IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>>                                         dev_name(tcpci->dev), tcpci);
>>
>
> I am a bit concerned that this may cause problems, since
> tcpm_register_port()
> will send messages to the driver, which may trigger interrupts. It may be
> necessary to register interrupts early, prior to calling
> tcpci_register_port().
>
>         if (err < 0)
>>                 return err;
>>
>
> You'll need to call tcpm_unregister_port() here (or register the interrup=
t
> first).
>
> Guenter
>
>
>   -     tcpci->port =3D tcpm_register_port(tcpci->dev, &tcpci->tcpc);
>> -       return PTR_ERR_OR_ZERO(tcpci->port);
>> +       i2c_set_clientdata(client, tcpci);
>> +       return 0;
>>   }
>>     static int tcpci_remove(struct i2c_client *client)
>>   {
>>         struct tcpci *tcpci =3D i2c_get_clientdata(client);
>>   -     tcpm_unregister_port(tcpci->port);
>> +       tcpci_unregister_port(tcpci);
>>         return 0;
>>   }
>> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci=
.
>> h
>> index fdfb06c..c838723 100644
>> --- a/drivers/staging/typec/tcpci.h
>> +++ b/drivers/staging/typec/tcpci.h
>> @@ -59,6 +59,7 @@
>>   #define TCPC_POWER_CTRL_VCONN_ENABLE  BIT(0)
>>     #define TCPC_CC_STATUS                      0x1d
>> +#define TCPC_CC_STATUS_DRPRST          BIT(5)
>>   #define TCPC_CC_STATUS_TERM           BIT(4)
>>   #define TCPC_CC_STATUS_CC2_SHIFT      2
>>   #define TCPC_CC_STATUS_CC2_MASK               0x3
>> @@ -121,4 +122,16 @@
>>   #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG                0x76
>>   #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG                0x78
>>   +struct tcpci;
>> +struct tcpci_data {
>> +       struct regmap *regmap;
>> +       int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>> +       int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>> +                        bool enable);
>> +};
>> +
>> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data
>> *data);
>> +void tcpci_unregister_port(struct tcpci *tcpci);
>> +int tcpci_irq(struct tcpci *tcpci);
>> +
>>   #endif /* __LINUX_USB_TCPCI_H */
>>
>>
>


--=20
Best Regards,
=E6=9B=B8=E5=B8=86

--001a11374c0c628f1805652dd15e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">HI Guenter,<div><br></div><div>I&#39;ve thought about regi=
stering interrupt early, prior to tcpci_register_port. Just like you said.<=
/div><div>But to make sure interrupt handler will not be invoked,=C2=A0we&#=
39;ll also need to mask all alerts early.</div><div>And we&#39;ll need anot=
her structure used as dev_id of devm_request_threaded_irq() because tcpci i=
s not allocated yet at that time.</div><div>For example:</div><div><br></di=
v><div><font color=3D"#500050"><span style=3D"font-size:14px">struct tcpci_=
chip {</span></font></div><div><font color=3D"#500050"><span style=3D"font-=
size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpci *tcpci;</span></font></=
div><div><font color=3D"#500050"><span style=3D"font-size:14px">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct tcpci_data;</span></font></div><div><font color=3D=
"#500050"><span style=3D"font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0...</sp=
an></font></div><div><font color=3D"#500050"><span style=3D"font-size:14px"=
>};</span></font></div><div><font color=3D"#500050"><span style=3D"font-siz=
e:14px"><br></span></font></div><div><span style=3D"color:rgb(80,0,80);font=
-size:14px">static int tcpci_probe(struct i2c_client *client,</span><br sty=
le=3D"color:rgb(80,0,80);font-size:14px"><span style=3D"color:rgb(80,0,80);=
font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const struct i2c_device_id *i2c_id)</span><br></div><div>=
<span style=3D"color:rgb(80,0,80);font-size:14px">{</span></div><div><font =
color=3D"#500050"><span style=3D"font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 u16 val =3D 0;</span></font></div><div><font color=3D"#500050"><span st=
yle=3D"font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpci_chip *chip;=
</span></font></div><div><font color=3D"#500050"><span style=3D"font-size:1=
4px"><br></span></font></div><div><font color=3D"#500050"><span style=3D"fo=
nt-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 chip =3D devm_kzalloc(&amp;client=
-&gt;dev, sizeof(*chip), GFP_KERNEL);</span></font></div><div><font color=
=3D"#500050"><span style=3D"font-size:14px">....</span></font></div><div><f=
ont color=3D"#500050"><span style=3D"font-size:14px">....</span></font></di=
v><div><font color=3D"#500050"><span style=3D"font-size:14px">....</span></=
font></div><div><font color=3D"#500050"><span style=3D"font-size:14px">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0/* Disable chip interrupts */</span></font></=
div><div><font color=3D"#500050"><span style=3D"font-size:14px">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0regmap_raw_write(chip-&gt;data.regmap,=C2=A0TCPC_ALERT_MAS=
K, &amp;val, sizeof(u16));</span></font></div><div><font color=3D"#500050">=
<span style=3D"font-size:14px"><br></span></font></div><div><span style=3D"=
color:rgb(80,0,80);font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D devm_=
request_threaded_irq(&amp;cli</span><wbr style=3D"color:rgb(80,0,80);font-s=
ize:14px"><span style=3D"color:rgb(80,0,80);font-size:14px">ent-&gt;dev, cl=
ient-&gt;irq, NULL,</span><br style=3D"color:rgb(80,0,80);font-size:14px"><=
span style=3D"color:rgb(80,0,80);font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_tcpci_irq,</span><br style=3D"col=
or:rgb(80,0,80);font-size:14px"><span style=3D"color:rgb(80,0,80);font-size=
:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I=
RQF_ONESHOT | IRQF_TRIGGER_LOW,</span><br style=3D"color:rgb(80,0,80);font-=
size:14px"><span style=3D"color:rgb(80,0,80);font-size:14px">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name(&amp;client-&=
gt;dev), chip);</span><br></div><div><span style=3D"color:rgb(80,0,80);font=
-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err &lt; 0)</span></div><div><s=
pan style=3D"color:rgb(80,0,80);font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;</span></div><div><span style=3D"co=
lor:rgb(80,0,80);font-size:14px"><br></span></div><div><span style=3D"color=
:rgb(80,0,80);font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0chip-&gt;tcpci =3D=
 tcpci_register_port(&amp;client-&gt;d</span><wbr style=3D"color:rgb(80,0,8=
0);font-size:14px"><span style=3D"color:rgb(80,0,80);font-size:14px">ev, &a=
mp;chip-&gt;data);</span><br style=3D"color:rgb(80,0,80);font-size:14px"><s=
pan style=3D"color:rgb(80,0,80);font-size:14px">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (PTR_ERR_OR_ZERO(chip-&gt;tcpci))</span><br style=3D"color:rgb(80,0,80);=
font-size:14px"><span style=3D"color:rgb(80,0,80);font-size:14px">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(chip-&gt;tcp=
ci);</span>=C2=A0</div><div><br></div><div>If you agree with this flow, I t=
hink this one will be better.</div><div><br></div></div><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">2018-02-14 22:46 GMT+08:00 Guenter R=
oeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"=
_blank">linux@roeck-us.net</a>&gt;</span>:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div class=3D"HOEnZb"><div class=3D"h5">On 02/14/2018 04:45 AM, ShuFanLee=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: ShuFanLee &lt;<a href=3D"mailto:shufan_lee@richtek.com" target=3D"_bl=
ank">shufan_lee@richtek.com</a>&gt;<br>
<br>
Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and export tc=
pci_irq.<br>
More operations can be extended in tcpci_data if needed.<br>
According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,<br>
TCPC shall not start DRP toggling until subsequently the TCPM<br>
writes to the COMMAND register to start DRP toggling.<br>
DRP toggling flow is chagned as following:<br>
=C2=A0 =C2=A0- Write DRP =3D 0 &amp; Rd/Rd<br>
=C2=A0 =C2=A0- Write DRP =3D 1<br>
=C2=A0 =C2=A0- Set LOOK4CONNECTION command<br>
<br>
Signed-off-by: ShuFanLee &lt;<a href=3D"mailto:shufan_lee@richtek.com" targ=
et=3D"_blank">shufan_lee@richtek.com</a>&gt;<br>
---<br>
=C2=A0 drivers/staging/typec/tcpci.c | 111 ++++++++++++++++++++++++++++++<w=
br>++++--------<br>
=C2=A0 drivers/staging/typec/tcpci.h |=C2=A0 13 +++++<br>
=C2=A0 2 files changed, 103 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/drivers/staging/typec/tcpci.<wbr>c b/drivers/staging/typec/tcp=
ci.<wbr>c<br>
index 9bd4412..461fbd48 100644<br>
--- a/drivers/staging/typec/tcpci.<wbr>c<br>
+++ b/drivers/staging/typec/tcpci.<wbr>c<br>
@@ -21,7 +21,6 @@<br>
=C2=A0 =C2=A0 struct tcpci {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device *dev;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_client *client;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpm_port *port;<br>
=C2=A0 @@ -30,6 +29,7 @@ struct tcpci {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool controls_vbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpc_dev tcpc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci_data *data;<br>
=C2=A0 };<br>
=C2=A0 =C2=A0 static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tc=
pc)<br>
@@ -98,8 +98,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum type=
c_cc_status cc)<br>
=C2=A0 static int tcpci_start_drp_toggling(struc<wbr>t tcpc_dev *tcpc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum typec_cc_status c=
c)<br>
=C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int reg =3D TCPC_ROLE_CTRL_DRP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int reg =3D (TCPC_ROLE_CTRL_CC_RD &lt;=
&lt; TCPC_ROLE_CTRL_CC1_SHIFT) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (TCPC_ROLE_CTRL_CC_RD &lt;&lt; TCPC_ROLE_CTRL_CC2_SHIFT);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (cc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
@@ -116,8 +118,19 @@ static int tcpci_start_drp_toggling(struc<wbr>t tcpc_d=
ev *tcpc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TCPC_ROLE_CTRL_RP_VAL_SHIFT);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return regmap_write(tcpci-&gt;regmap, TCPC_ROLE=
_CTRL, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap, TCPC_ROL=
E_CTRL, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0usleep_range(500, 1000);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reg |=3D TCPC_ROLE_CTRL_DRP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap, TCPC_ROL=
E_CTRL, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap, TCPC_COM=
MAND,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TCPC_CMD_LOOK4CONNECTION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 }<br>
=C2=A0 =C2=A0 static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc=
, bool sink)<br>
@@ -178,6 +191,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool=
 enable)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0/* Handle vendor set vconn */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data-=
&gt;set_vconn) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D tcpci-&gt;data-&gt;set_vconn(tcpci, tcpci-&gt;data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_write(tcpci-&gt;regmap, TCPC_POW=
ER_CTRL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
@@ -323,6 +346,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (time_after(jiffies, timeout))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ETIMEDOUT;<=
br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0/* Handle vendor init */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data-=
&gt;init) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D tcpci-&gt;data-&gt;init(tcpci, tcpci-&gt;data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear all events */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D tcpci_write16(tcpci, TCPC_ALERT, 0xffff=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
@@ -344,9 +376,16 @@ static int tcpci_init(struct tcpc_dev *tcpc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tcpci_write16(tcpci, TCPC_ALERT_MASK, re=
g);<br>
=C2=A0 }<br>
=C2=A0 -static irqreturn_t tcpci_irq(int irq, void *dev_id)<br>
+static irqreturn_t _tcpci_irq(int irq, void *dev_id)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpci *tcpci =3D dev_id;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci_irq(tcpci);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
</blockquote>
<br></div></div>
This should probably be<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tcpci_irq(tcpci);<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+}<br>
+<br>
+int tcpci_irq(struct tcpci *tcpci)<br>
</blockquote>
<br></span>
and this should be<br>
<br>
irqreturn_t tcpci_irq(struct tcpci *tcpci)<br>
<br>
Otherwise it doesn&#39;t add value to have tcpci_irq() return anything.<br>
Alternative would be to make it<br>
<br>
void tcpci_irq(struct tcpci *tcpci)<br>
<br>
if it will always only return IRQ_HANDLED.<br>
<br>
Guenter<div><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 status;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcpci_read16(tcpci, TCPC_ALERT, &amp;status);<b=
r>
@@ -412,6 +451,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;<br>
=C2=A0 }<br>
+EXPORT_SYMBOL_GPL(tcpci_irq);<br>
=C2=A0 =C2=A0 static const struct regmap_config tcpci_regmap_config =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reg_bits =3D 8,<br>
@@ -435,22 +475,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 }<br>
=C2=A0 -static int tcpci_probe(struct i2c_client *client,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const struct i2c_device_id *i2c_id)<br>
+struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *d=
ata)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpci *tcpci;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
=C2=A0 -=C2=A0 =C2=A0 =C2=A0tcpci =3D devm_kzalloc(&amp;client-&gt;dev, siz=
eof(*tcpci), GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci =3D devm_kzalloc(dev, sizeof(*tcpci), GFP=
_KERNEL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tcpci)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-ENO=
MEM);<br>
=C2=A0 -=C2=A0 =C2=A0 =C2=A0tcpci-&gt;client =3D client;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;dev =3D &amp;client-&gt;dev;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, tcpci);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;regmap =3D devm_regmap_init_i2c(clien=
t, &amp;tcpci_regmap_config);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(tcpci-&gt;regmap))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(tcpc=
i-&gt;regmap);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;dev =3D dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;data =3D data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;regmap =3D data-&gt;regmap;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcpci-&gt;tcpc.init =3D tcpci_init;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcpci-&gt;tcpc.get_vbus =3D tcpci_get_vbus;<br>
@@ -467,27 +503,60 @@ static int tcpci_probe(struct i2c_client *client,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D tcpci_parse_config(tcpci);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err &lt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(err)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Disable chip interrupts */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);<br>
=C2=A0 -=C2=A0 =C2=A0 =C2=A0err =3D devm_request_threaded_irq(tcpc<wbr>i-&g=
t;dev, client-&gt;irq, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci_irq=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;port =3D tcpm_register_port(tcpci-&gt=
;dev, &amp;tcpci-&gt;tcpc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (PTR_ERR_OR_ZERO(tcpci-&gt;port))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_CAST(tcp=
ci-&gt;port);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return tcpci;<br>
+}<br>
+EXPORT_SYMBOL_GPL(tcpci_regis<wbr>ter_port);<br>
+<br>
+void tcpci_unregister_port(struct tcpci *tcpci)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpm_unregister_port(tcpci-&gt;p<wbr>ort);<br>
+}<br>
+EXPORT_SYMBOL_GPL(tcpci_unreg<wbr>ister_port);<br>
+<br>
+static int tcpci_probe(struct i2c_client *client,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const struct i2c_device_id *i2c_id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci_data *data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D devm_kzalloc(&amp;client-&gt;dev, size=
of(*data), GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;regmap =3D devm_regmap_init_i2c(client=
, &amp;tcpci_regmap_config);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(data-&gt;regmap))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(data=
-&gt;regmap);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci =3D tcpci_register_port(&amp;client-&gt;d=
<wbr>ev, data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (PTR_ERR_OR_ZERO(tcpci))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(tcpc=
i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D devm_request_threaded_irq(&amp;cli<wbr>=
ent-&gt;dev, client-&gt;irq, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_tcpci_ir=
q,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_ONE=
SHOT | IRQF_TRIGGER_LOW,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name=
(tcpci-&gt;dev), tcpci);<br>
</blockquote>
<br></div></div>
I am a bit concerned that this may cause problems, since tcpm_register_port=
()<br>
will send messages to the driver, which may trigger interrupts. It may be<b=
r>
necessary to register interrupts early, prior to calling tcpci_register_por=
t().<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
</blockquote>
<br></span>
You&#39;ll need to call tcpm_unregister_port() here (or register the interr=
upt first).<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Guenter</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 -=C2=A0 =C2=A0 =C2=A0tcpci-&gt;port =3D tcpm_register_port(tcpci-&gt=
;dev, &amp;tcpci-&gt;tcpc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR_OR_ZERO(tcpci-&gt;port);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, tcpci);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 }<br>
=C2=A0 =C2=A0 static int tcpci_remove(struct i2c_client *client)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcpci *tcpci =3D i2c_get_clientdata(clie=
nt);<br>
=C2=A0 -=C2=A0 =C2=A0 =C2=A0tcpm_unregister_port(tcpci-&gt;p<wbr>ort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci_unregister_port(tcpci);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 }<br>
diff --git a/drivers/staging/typec/tcpci.<wbr>h b/drivers/staging/typec/tcp=
ci.<wbr>h<br>
index fdfb06c..c838723 100644<br>
--- a/drivers/staging/typec/tcpci.<wbr>h<br>
+++ b/drivers/staging/typec/tcpci.<wbr>h<br>
@@ -59,6 +59,7 @@<br>
=C2=A0 #define TCPC_POWER_CTRL_VCONN_ENABLE=C2=A0 BIT(0)<br>
=C2=A0 =C2=A0 #define TCPC_CC_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1d<br>
+#define TCPC_CC_STATUS_DRPRST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(5)<br>
=C2=A0 #define TCPC_CC_STATUS_TERM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
BIT(4)<br>
=C2=A0 #define TCPC_CC_STATUS_CC2_SHIFT=C2=A0 =C2=A0 =C2=A0 2<br>
=C2=A0 #define TCPC_CC_STATUS_CC2_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x3<br>
@@ -121,4 +122,16 @@<br>
=C2=A0 #define TCPC_VBUS_VOLTAGE_ALARM_HI_<wbr>CFG=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x76<br>
=C2=A0 #define TCPC_VBUS_VOLTAGE_ALARM_LO_<wbr>CFG=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x78<br>
=C2=A0 +struct tcpci;<br>
+struct tcpci_data {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct regmap *regmap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*init)(struct tcpci *tcpci, struct tcpci_d=
ata *data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*set_vconn)(struct tcpci *tcpci, struct tc=
pci_data *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool enable);<br>
+};<br>
+<br>
+struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *d=
ata);<br>
+void tcpci_unregister_port(struct tcpci *tcpci);<br>
+int tcpci_irq(struct tcpci *tcpci);<br>
+<br>
=C2=A0 #endif /* __LINUX_USB_TCPCI_H */<br>
<br>
</blockquote>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Best Regards,<div>=E6=9B=B8=E5=B8=86</div></div></div>
</div>

--001a11374c0c628f1805652dd15e--
