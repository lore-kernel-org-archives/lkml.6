Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2956071-1519783790-2-11368017300721800703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  HTML_MESSAGE 0.001, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.180', Host='mail-qt0-f180.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', plain='UTF-8', html='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519783789; b=iCs8fvgSTkIQ5QqNcwa1o99RviJBL0wiVOD0+KLBiW/RH2C
    BIhLBCWr7UQHZXSSe1qlCfuoSKBcvvRrpITby3za5b622fim+O4k+csorYXHtyr7
    mkhfbS20bfarDhcx4oB1QLy/HQ3U26psP7ulQUUKAYsVXACTxoxWAyZJBlcjekBk
    i2qQh4kj2QNyZjiHDqBCBvZYrm5x6zMDJNXxmJBUkK6ZMySl70PZRU77Yk9Md8D2
    w4l1Op3w2xZnqlK6VbYj8jYwvdJOxdKCKGED2iHeoxJXjIGKMeY0zLAVj+z++DIg
    IP1+t5lrG8cjg60v/ZsWRgXtnnHo1Pw6EQlLwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1519783789; bh=zKP4PV0WiZJJy7M6P1938d56hHtv38J/f+Uekj8knFc=; b=U
    PmbURoiFWc7tmUdvAc0YF3asxGyuO0ozAhrc80mOvytjZ1butK4dcCZE0KuEK1sH
    69+XrkyXhQXcQpzNtyJ1X974dXrXQahqjXjHf77iSapjXvoKI7mkZhN06X8haclN
    QxLKMJb92U8Va+wR/n6x2Gi9i+K808aZKWxT9KxJC3LQFml7cchCK+hqzZGP5NSW
    +MBx0L0ATFKHC4MJf7TFe5UbBSjO3mZcyC7RSAHEEppIM5+QkqVXRfXkuZ0RZWW3
    3V0JSUe4qV5/S5aX8fQo0a2uJei7ZCNkfCpwZXyIseXbCLGk2iz6Luj5sodJ6/3o
    F4xu9XdwCX5HCqLHQHnYg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HDxWrQQm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.180 (mail-qt0-f180.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f180.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Kz5pztlT;
    x-ptr=pass x-ptr-helo=mail-qt0-f180.google.com x-ptr-lookup=mail-qt0-f180.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HDxWrQQm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.180 (mail-qt0-f180.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f180.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Kz5pztlT;
    x-ptr=pass x-ptr-helo=mail-qt0-f180.google.com x-ptr-lookup=mail-qt0-f180.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELuF+Fup+0rWrnctnc81h10smL13W6Blep6CUrGTfSVhCZ4+lEtyol5wsJAV5tpugnQEQQd11Pv+l4J+i5UkMrY=
MIME-Version: 1.0
In-Reply-To: <20180221221514.GA31916@roeck-us.net>
References: <1519225343-2929-1-git-send-email-leechu729@gmail.com> <20180221221514.GA31916@roeck-us.net>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Wed, 28 Feb 2018 10:09:47 +0800
Message-ID: <CAFaeLdQVXS+PBUeC=T5qb6YkNA0ggak_c2MxKfZeoYzryimFaw@mail.gmail.com>
Subject: Re: [PATCH] staging: typec: handle vendor defined part and modify drp
 toggling flow
To: Guenter Roeck <linux@roeck-us.net>
Cc: heikki.krogerus@linux.intel.com, Greg KH <greg@kroah.com>, shufan_lee@richtek.com,
	cy_huang@richtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a11425e86cc5a5205663c3c72"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a11425e86cc5a5205663c3c72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

  regmap_write returns a negative return code or 0, thus this can be
simplified to
        return regmap_write(...);

  Ok, I'll modify it in v4


Hmm, normally I'd expect this function _after_ the function it calls.
Guess that doesn't matter much here, so I am fine with it as long
as Greg is ok with it as well.

  Do you mean it maybe better to call vendor's set_vconn after normal
set_vconn is finished?
  If I understand correctly, I can also modify it in v4. For RT1711H, it
also works by enabling/disabling idle mode after set_vconn.


2018-02-22 6:15 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:

> On Wed, Feb 21, 2018 at 11:02:23PM +0800, ShuFanLee wrote:
> > From: ShuFanLee <shufan_lee@richtek.com>
> >
> > Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and expor=
t
> tcpci_irq.
> > More operations can be extended in tcpci_data if needed.
> > According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
> > TCPC shall not start DRP toggling until subsequently the TCPM
> > writes to the COMMAND register to start DRP toggling.
> > DRP toggling flow is chagned as following:
> >   - Write DRP =3D 0 & Rd/Rd
> >   - Write DRP =3D 1
> >   - Set LOOK4CONNECTION command
> >
> > Signed-off-by: ShuFanLee <shufan_lee@richtek.com>
>
> Mostly loooks good to me. Couple of nitpicks below.
>
> Guenter
>
> > ---
> >  drivers/staging/typec/tcpci.c | 128 ++++++++++++++++++++++++++++++
> +++---------
> >  drivers/staging/typec/tcpci.h |  13 +++++
> >  2 files changed, 115 insertions(+), 26 deletions(-)
> >
> >  patch changelogs between v1 & v2
> >  - Remove unnecessary i2c_client in the structure of tcpci
> >  - Rename structure of tcpci_vendor_data to tcpci_data
> >  - Not exporting tcpci read/write wrappers but register i2c regmap in
> glue driver
> >  - Add set_vconn ops in tcpci_data
> >    (It is necessary for RT1711H to enable/disable idle mode before
> disabling/enabling vconn)
> >  - Export tcpci_irq so that vendor can call it in their own IRQ handler
> >
> >  patch changelogs between v2 & v3
> >  - Change the return type of tcpci_irq from int to irqreturn_t
> >
> > diff --git a/drivers/staging/typec/tcpci.c
> b/drivers/staging/typec/tcpci.c
> > index 9bd4412..4959c69 100644
> > --- a/drivers/staging/typec/tcpci.c
> > +++ b/drivers/staging/typec/tcpci.c
> > @@ -21,7 +21,6 @@
> >
> >  struct tcpci {
> >       struct device *dev;
> > -     struct i2c_client *client;
> >
> >       struct tcpm_port *port;
> >
> > @@ -30,6 +29,12 @@ struct tcpci {
> >       bool controls_vbus;
> >
> >       struct tcpc_dev tcpc;
> > +     struct tcpci_data *data;
> > +};
> > +
> > +struct tcpci_chip {
> > +     struct tcpci *tcpci;
> > +     struct tcpci_data data;
> >  };
> >
> >  static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
> > @@ -37,8 +42,7 @@ static inline struct tcpci *tcpc_to_tcpci(struct
> tcpc_dev *tcpc)
> >       return container_of(tcpc, struct tcpci, tcpc);
> >  }
> >
> > -static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,
> > -                     u16 *val)
> > +static int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *va=
l)
> >  {
> >       return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u16));
> >  }
> > @@ -98,8 +102,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum
> typec_cc_status cc)
> >  static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
> >                                   enum typec_cc_status cc)
> >  {
> > +     int ret;
> >       struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
> > -     unsigned int reg =3D TCPC_ROLE_CTRL_DRP;
> > +     unsigned int reg =3D (TCPC_ROLE_CTRL_CC_RD <<
> TCPC_ROLE_CTRL_CC1_SHIFT) |
> > +                        (TCPC_ROLE_CTRL_CC_RD <<
> TCPC_ROLE_CTRL_CC2_SHIFT);
> >
> >       switch (cc) {
> >       default:
> > @@ -117,7 +123,19 @@ static int tcpci_start_drp_toggling(struct
> tcpc_dev *tcpc,
> >               break;
> >       }
> >
> > -     return regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> > +     ret =3D regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> > +     if (ret < 0)
> > +             return ret;
> > +     usleep_range(500, 1000);
> > +     reg |=3D TCPC_ROLE_CTRL_DRP;
> > +     ret =3D regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> > +     if (ret < 0)
> > +             return ret;
> > +     ret =3D regmap_write(tcpci->regmap, TCPC_COMMAND,
> > +                        TCPC_CMD_LOOK4CONNECTION);
> > +     if (ret < 0)
> > +             return ret;
> > +     return 0;
>
> regmap_write returns a negative return code or 0, thus this can be
> simplified to
>         return regmap_write(...);
>
> >  }
> >
> >  static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool
> sink)
> > @@ -178,6 +196,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc,
> bool enable)
> >       struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
> >       int ret;
> >
> > +     /* Handle vendor set vconn */
> > +     if (tcpci->data) {
> > +             if (tcpci->data->set_vconn) {
> > +                     ret =3D tcpci->data->set_vconn(tcpci, tcpci->data=
,
> > +                                                  enable);
> > +                     if (ret < 0)
> > +                             return ret;
> > +             }
> > +     }
> > +
> >       ret =3D regmap_write(tcpci->regmap, TCPC_POWER_CTRL,
> >                          enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
> >       if (ret < 0)
> > @@ -323,6 +351,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
> >       if (time_after(jiffies, timeout))
> >               return -ETIMEDOUT;
> >
> > +     /* Handle vendor init */
> > +     if (tcpci->data) {
> > +             if (tcpci->data->init) {
> > +                     ret =3D tcpci->data->init(tcpci, tcpci->data);
> > +                     if (ret < 0)
> > +                             return ret;
> > +             }
> > +     }
> > +
> >       /* Clear all events */
> >       ret =3D tcpci_write16(tcpci, TCPC_ALERT, 0xffff);
> >       if (ret < 0)
> > @@ -344,9 +381,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
> >       return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
> >  }
> >
> > -static irqreturn_t tcpci_irq(int irq, void *dev_id)
> > +static irqreturn_t _tcpci_irq(int irq, void *dev_id)
> >  {
> >       struct tcpci *tcpci =3D dev_id;
> > +
> > +     return tcpci_irq(tcpci);
> > +}
>
> Hmm, normally I'd expect this function _after_ the function it calls.
> Guess that doesn't matter much here, so I am fine with it as long
> as Greg is ok with it as well.
>
> > +
> > +irqreturn_t tcpci_irq(struct tcpci *tcpci)
> > +{
> >       u16 status;
> >
> >       tcpci_read16(tcpci, TCPC_ALERT, &status);
> > @@ -412,6 +455,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
> >
> >       return IRQ_HANDLED;
> >  }
> > +EXPORT_SYMBOL_GPL(tcpci_irq);
> >
> >  static const struct regmap_config tcpci_regmap_config =3D {
> >       .reg_bits =3D 8,
> > @@ -435,22 +479,18 @@ static int tcpci_parse_config(struct tcpci *tcpci=
)
> >       return 0;
> >  }
> >
> > -static int tcpci_probe(struct i2c_client *client,
> > -                    const struct i2c_device_id *i2c_id)
> > +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_dat=
a
> *data)
> >  {
> >       struct tcpci *tcpci;
> >       int err;
> >
> > -     tcpci =3D devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL);
> > +     tcpci =3D devm_kzalloc(dev, sizeof(*tcpci), GFP_KERNEL);
> >       if (!tcpci)
> > -             return -ENOMEM;
> > +             return ERR_PTR(-ENOMEM);
> >
> > -     tcpci->client =3D client;
> > -     tcpci->dev =3D &client->dev;
> > -     i2c_set_clientdata(client, tcpci);
> > -     tcpci->regmap =3D devm_regmap_init_i2c(client, &tcpci_regmap_conf=
ig);
> > -     if (IS_ERR(tcpci->regmap))
> > -             return PTR_ERR(tcpci->regmap);
> > +     tcpci->dev =3D dev;
> > +     tcpci->data =3D data;
> > +     tcpci->regmap =3D data->regmap;
> >
> >       tcpci->tcpc.init =3D tcpci_init;
> >       tcpci->tcpc.get_vbus =3D tcpci_get_vbus;
> > @@ -467,27 +507,63 @@ static int tcpci_probe(struct i2c_client *client,
> >
> >       err =3D tcpci_parse_config(tcpci);
> >       if (err < 0)
> > -             return err;
> > +             return ERR_PTR(err);
> > +
> > +     tcpci->port =3D tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> > +     if (PTR_ERR_OR_ZERO(tcpci->port))
> > +             return ERR_CAST(tcpci->port);
> >
> > -     /* Disable chip interrupts */
> > -     tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
> > +     return tcpci;
> > +}
> > +EXPORT_SYMBOL_GPL(tcpci_register_port);
> > +
> > +void tcpci_unregister_port(struct tcpci *tcpci)
> > +{
> > +     tcpm_unregister_port(tcpci->port);
> > +}
> > +EXPORT_SYMBOL_GPL(tcpci_unregister_port);
> >
> > -     err =3D devm_request_threaded_irq(tcpci->dev, client->irq, NULL,
> > -                                     tcpci_irq,
> > +static int tcpci_probe(struct i2c_client *client,
> > +                    const struct i2c_device_id *i2c_id)
> > +{
> > +     struct tcpci_chip *chip;
> > +     int err;
> > +     u16 val =3D 0;
> > +
> > +     chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> > +     if (!chip)
> > +             return -ENOMEM;
> > +
> > +     chip->data.regmap =3D devm_regmap_init_i2c(client,
> &tcpci_regmap_config);
> > +     if (IS_ERR(chip->data.regmap))
> > +             return PTR_ERR(chip->data.regmap);
> > +
> > +     /* Disable chip interrupts before requesting irq */
> > +     err =3D regmap_raw_write(chip->data.regmap, TCPC_ALERT_MASK, &val=
,
> > +                            sizeof(u16));
> > +     if (err < 0)
> > +             return err;
> > +
> > +     err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL=
,
> > +                                     _tcpci_irq,
> >                                       IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> > -                                     dev_name(tcpci->dev), tcpci);
> > +                                     dev_name(&client->dev), chip);
> >       if (err < 0)
> >               return err;
> >
> > -     tcpci->port =3D tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> > -     return PTR_ERR_OR_ZERO(tcpci->port);
> > +     chip->tcpci =3D tcpci_register_port(&client->dev, &chip->data);
> > +     if (PTR_ERR_OR_ZERO(chip->tcpci))
> > +             return PTR_ERR(chip->tcpci);
> > +
> > +     i2c_set_clientdata(client, chip);
> > +     return 0;
> >  }
> >
> >  static int tcpci_remove(struct i2c_client *client)
> >  {
> > -     struct tcpci *tcpci =3D i2c_get_clientdata(client);
> > +     struct tcpci_chip *chip =3D i2c_get_clientdata(client);
> >
> > -     tcpm_unregister_port(tcpci->port);
> > +     tcpci_unregister_port(chip->tcpci);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/staging/typec/tcpci.h
> b/drivers/staging/typec/tcpci.h
> > index fdfb06c..40025b2 100644
> > --- a/drivers/staging/typec/tcpci.h
> > +++ b/drivers/staging/typec/tcpci.h
> > @@ -59,6 +59,7 @@
> >  #define TCPC_POWER_CTRL_VCONN_ENABLE BIT(0)
> >
> >  #define TCPC_CC_STATUS                       0x1d
> > +#define TCPC_CC_STATUS_DRPRST                BIT(5)
> >  #define TCPC_CC_STATUS_TERM          BIT(4)
> >  #define TCPC_CC_STATUS_CC2_SHIFT     2
> >  #define TCPC_CC_STATUS_CC2_MASK              0x3
> > @@ -121,4 +122,16 @@
> >  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG               0x76
> >  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG               0x78
> >
> > +struct tcpci;
> > +struct tcpci_data {
> > +     struct regmap *regmap;
> > +     int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> > +     int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> > +                      bool enable);
> > +};
> > +
> > +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_dat=
a
> *data);
> > +void tcpci_unregister_port(struct tcpci *tcpci);
> > +irqreturn_t tcpci_irq(struct tcpci *tcpci);
> > +
> >  #endif /* __LINUX_USB_TCPCI_H */
> > --
> > 1.9.1
> >
>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86

--001a11425e86cc5a5205663c3c72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Guenter,<div><br></div><div>=C2=A0=C2=A0<span style=3D"=
font-size:14px">regmap_write returns a negative return code or 0, thus this=
 can be</span></div><span style=3D"font-size:14px">simplified to</span><br =
style=3D"font-size:14px"><span style=3D"font-size:14px">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return regmap_write(...);<br></span><br style=3D"font-size:14px"=
><div style=3D"font-size:14px"><div class=3D"gmail-adm"><div id=3D"gmail-q_=
161ba858af417c1c_4" class=3D"gmail-ajR gmail-h4"></div></div></div><div>=C2=
=A0 Ok, I&#39;ll modify it in v4</div><div><br></div><div><br></div><div><s=
pan style=3D"font-size:14px">Hmm, normally I&#39;d expect this function _af=
ter_ the function it calls.</span><br style=3D"font-size:14px"><span style=
=3D"font-size:14px">Guess that doesn&#39;t matter much here, so I am fine w=
ith it as long</span><br style=3D"font-size:14px"><span style=3D"font-size:=
14px">as Greg is ok with it as well.</span><br></div><div><span style=3D"fo=
nt-size:14px"><br></span></div><div><span style=3D"font-size:14px">=C2=A0 D=
o you mean it maybe better to call vendor&#39;s set_vconn after normal set_=
vconn is finished?<br>=C2=A0 If I understand correctly, I can also modify i=
t in v4. For RT1711H, it also works by enabling/disabling idle mode after s=
et_vconn.</span></div><div><span style=3D"font-size:14px"><br></span></div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2018-02-22 =
6:15 GMT+08:00 Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@=
roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span>:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><span class=3D"">On Wed, Feb 21, 2018 at 11:02:23=
PM +0800, ShuFanLee wrote:<br>
&gt; From: ShuFanLee &lt;<a href=3D"mailto:shufan_lee@richtek.com">shufan_l=
ee@richtek.com</a>&gt;<br>
&gt;<br>
&gt; Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and expo=
rt tcpci_irq.<br>
&gt; More operations can be extended in tcpci_data if needed.<br>
&gt; According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,<br>
&gt; TCPC shall not start DRP toggling until subsequently the TCPM<br>
&gt; writes to the COMMAND register to start DRP toggling.<br>
&gt; DRP toggling flow is chagned as following:<br>
&gt;=C2=A0 =C2=A0- Write DRP =3D 0 &amp; Rd/Rd<br>
&gt;=C2=A0 =C2=A0- Write DRP =3D 1<br>
&gt;=C2=A0 =C2=A0- Set LOOK4CONNECTION command<br>
&gt;<br>
&gt; Signed-off-by: ShuFanLee &lt;<a href=3D"mailto:shufan_lee@richtek.com"=
>shufan_lee@richtek.com</a>&gt;<br>
<br>
</span>Mostly loooks good to me. Couple of nitpicks below.<br>
<br>
Guenter<br>
<div><div class=3D"h5"><br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/typec/tcpci.c | 128 ++++++++++++++++++++++++++++=
++<wbr>+++---------<br>
&gt;=C2=A0 drivers/staging/typec/tcpci.h |=C2=A0 13 +++++<br>
&gt;=C2=A0 2 files changed, 115 insertions(+), 26 deletions(-)<br>
&gt;<br>
&gt;=C2=A0 patch changelogs between v1 &amp; v2<br>
&gt;=C2=A0 - Remove unnecessary i2c_client in the structure of tcpci<br>
&gt;=C2=A0 - Rename structure of tcpci_vendor_data to tcpci_data<br>
&gt;=C2=A0 - Not exporting tcpci read/write wrappers but register i2c regma=
p in glue driver<br>
&gt;=C2=A0 - Add set_vconn ops in tcpci_data<br>
&gt;=C2=A0 =C2=A0 (It is necessary for RT1711H to enable/disable idle mode =
before disabling/enabling vconn)<br>
&gt;=C2=A0 - Export tcpci_irq so that vendor can call it in their own IRQ h=
andler<br>
&gt;<br>
&gt;=C2=A0 patch changelogs between v2 &amp; v3<br>
&gt;=C2=A0 - Change the return type of tcpci_irq from int to irqreturn_t<br=
>
&gt;<br>
&gt; diff --git a/drivers/staging/typec/tcpci.<wbr>c b/drivers/staging/type=
c/tcpci.<wbr>c<br>
&gt; index 9bd4412..4959c69 100644<br>
&gt; --- a/drivers/staging/typec/tcpci.<wbr>c<br>
&gt; +++ b/drivers/staging/typec/tcpci.<wbr>c<br>
&gt; @@ -21,7 +21,6 @@<br>
&gt;<br>
&gt;=C2=A0 struct tcpci {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct i2c_client *client;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpm_port *port;<br>
&gt;<br>
&gt; @@ -30,6 +29,12 @@ struct tcpci {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool controls_vbus;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpc_dev tcpc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct tcpci_data *data;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct tcpci_chip {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct tcpci_data data;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)=
<br>
&gt; @@ -37,8 +42,7 @@ static inline struct tcpci *tcpc_to_tcpci(struct tcp=
c_dev *tcpc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return container_of(tcpc, struct tcpci, tcpc=
);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0u16 *val)<br>
&gt; +static int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *v=
al)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return regmap_raw_read(tcpci-&gt;regmap, reg=
, val, sizeof(u16));<br>
&gt;=C2=A0 }<br>
&gt; @@ -98,8 +102,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enu=
m typec_cc_status cc)<br>
&gt;=C2=A0 static int tcpci_start_drp_toggling(<wbr>struct tcpc_dev *tcpc,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum typec_cc_status=
 cc)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int reg =3D TCPC_ROLE_CTRL_DRP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int reg =3D (TCPC_ROLE_CTRL_CC_RD &lt;&l=
t; TCPC_ROLE_CTRL_CC1_SHIFT) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (TCPC_ROLE_CTRL_CC_RD &lt;&lt; TCPC_ROLE_CTRL_CC2_SHIFT);<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (cc) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; @@ -117,7 +123,19 @@ static int tcpci_start_drp_toggling(<wbr>struct t=
cpc_dev *tcpc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return regmap_write(tcpci-&gt;regmap, TCPC_ROLE_C=
TRL, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap, TCPC_ROLE_=
CTRL, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(500, 1000);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg |=3D TCPC_ROLE_CTRL_DRP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap, TCPC_ROLE_=
CTRL, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap, TCPC_COMMA=
ND,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 TCPC_CMD_LOOK4CONNECTION);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
</div></div>regmap_write returns a negative return code or 0, thus this can=
 be<br>
simplified to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return regmap_write(...);<br>
<div><div class=3D"h5"><br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, b=
ool sink)<br>
&gt; @@ -178,6 +196,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc,=
 bool enable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Handle vendor set vconn */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data-&g=
t;set_vconn) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D tcpci-&gt;data-&gt;set_vconn(tcpci, tcpci-&gt;data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap, TCPC_=
POWER_CTRL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; @@ -323,6 +351,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (time_after(jiffies, timeout))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ETIMEDOU=
T;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Handle vendor init */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tcpci-&gt;data-&g=
t;init) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D tcpci-&gt;data-&gt;init(tcpci, tcpci-&gt;data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear all events */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D tcpci_write16(tcpci, TCPC_ALERT, 0xf=
fff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; @@ -344,9 +381,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return tcpci_write16(tcpci, TCPC_ALERT_MASK,=
 reg);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static irqreturn_t tcpci_irq(int irq, void *dev_id)<br>
&gt; +static irqreturn_t _tcpci_irq(int irq, void *dev_id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci =3D dev_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return tcpci_irq(tcpci);<br>
&gt; +}<br>
<br>
</div></div>Hmm, normally I&#39;d expect this function _after_ the function=
 it calls.<br>
Guess that doesn&#39;t matter much here, so I am fine with it as long<br>
as Greg is ok with it as well.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +<br>
&gt; +irqreturn_t tcpci_irq(struct tcpci *tcpci)<br>
&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 status;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci_read16(tcpci, TCPC_ALERT, &amp;status)=
;<br>
&gt; @@ -412,6 +455,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id=
)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
&gt;=C2=A0 }<br>
&gt; +EXPORT_SYMBOL_GPL(tcpci_irq);<br>
&gt;<br>
&gt;=C2=A0 static const struct regmap_config tcpci_regmap_config =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.reg_bits =3D 8,<br>
&gt; @@ -435,22 +479,18 @@ static int tcpci_parse_config(struct tcpci *tcpc=
i)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static int tcpci_probe(struct i2c_client *client,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const struct i2c_device_id *i2c_id)<br>
&gt; +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_da=
ta *data)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tcpci =3D devm_kzalloc(&amp;client-&gt;dev, sizeo=
f(*tcpci), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tcpci =3D devm_kzalloc(dev, sizeof(*tcpci), GFP_K=
ERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tcpci)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-ENOME=
M);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tcpci-&gt;client =3D client;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tcpci-&gt;dev =3D &amp;client-&gt;dev;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, tcpci);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tcpci-&gt;regmap =3D devm_regmap_init_i2c(client,=
 &amp;tcpci_regmap_config);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (IS_ERR(tcpci-&gt;regmap))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(tcpci-=
&gt;regmap);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tcpci-&gt;dev =3D dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tcpci-&gt;data =3D data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tcpci-&gt;regmap =3D data-&gt;regmap;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;tcpc.init =3D tcpci_init;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci-&gt;tcpc.get_vbus =3D tcpci_get_vbus;<=
br>
&gt; @@ -467,27 +507,63 @@ static int tcpci_probe(struct i2c_client *client=
,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D tcpci_parse_config(tcpci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(err);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tcpci-&gt;port =3D tcpm_register_port(tcpci-&gt;d=
ev, &amp;tcpci-&gt;tcpc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (PTR_ERR_OR_ZERO(tcpci-&gt;port))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_CAST(tcpci=
-&gt;port);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Disable chip interrupts */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return tcpci;<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL_GPL(tcpci_<wbr>register_port);<br>
&gt; +<br>
&gt; +void tcpci_unregister_port(struct tcpci *tcpci)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tcpm_unregister_port(tcpci-&gt;<wbr>port);<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL_GPL(tcpci_<wbr>unregister_port);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0err =3D devm_request_threaded_irq(<wbr>tcpci-&gt;=
dev, client-&gt;irq, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcpci_irq,<b=
r>
&gt; +static int tcpci_probe(struct i2c_client *client,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const struct i2c_device_id *i2c_id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct tcpci_chip *chip;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 val =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0chip =3D devm_kzalloc(&amp;client-&gt;dev, sizeof=
(*chip), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!chip)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0chip-&gt;data.regmap =3D devm_regmap_init_i2c(cli=
ent, &amp;tcpci_regmap_config);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(chip-&gt;data.regmap))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(chip-&=
gt;data.regmap);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disable chip interrupts before requesting irq =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D regmap_raw_write(chip-&gt;data.<wbr>regma=
p, TCPC_ALERT_MASK, &amp;val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(u16));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D devm_request_threaded_irq(&amp;<wbr>clien=
t-&gt;dev, client-&gt;irq, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_tcpci_irq,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IRQF_O=
NESHOT | IRQF_TRIGGER_LOW,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_name(tcp=
ci-&gt;dev), tcpci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_name(&am=
p;client-&gt;dev), chip);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tcpci-&gt;port =3D tcpm_register_port(tcpci-&gt;d=
ev, &amp;tcpci-&gt;tcpc);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return PTR_ERR_OR_ZERO(tcpci-&gt;port);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0chip-&gt;tcpci =3D tcpci_register_port(&amp;clien=
t-&gt;<wbr>dev, &amp;chip-&gt;data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (PTR_ERR_OR_ZERO(chip-&gt;tcpci))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(chip-&=
gt;tcpci);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static int tcpci_remove(struct i2c_client *client)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci =3D i2c_get_clientdata(client=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct tcpci_chip *chip =3D i2c_get_clientdata(cl=
ient);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tcpm_unregister_port(tcpci-&gt;<wbr>port);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tcpci_unregister_port(chip-&gt;<wbr>tcpci);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/staging/typec/tcpci.<wbr>h b/drivers/staging/type=
c/tcpci.<wbr>h<br>
&gt; index fdfb06c..40025b2 100644<br>
&gt; --- a/drivers/staging/typec/tcpci.<wbr>h<br>
&gt; +++ b/drivers/staging/typec/tcpci.<wbr>h<br>
&gt; @@ -59,6 +59,7 @@<br>
&gt;=C2=A0 #define TCPC_POWER_CTRL_VCONN_ENABLE BIT(0)<br>
&gt;<br>
&gt;=C2=A0 #define TCPC_CC_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1d<br>
&gt; +#define TCPC_CC_STATUS_DRPRST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 BIT(5)<br>
&gt;=C2=A0 #define TCPC_CC_STATUS_TERM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BI=
T(4)<br>
&gt;=C2=A0 #define TCPC_CC_STATUS_CC2_SHIFT=C2=A0 =C2=A0 =C2=A02<br>
&gt;=C2=A0 #define TCPC_CC_STATUS_CC2_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x3<br>
&gt; @@ -121,4 +122,16 @@<br>
&gt;=C2=A0 #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x76<br>
&gt;=C2=A0 #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x78<br>
&gt;<br>
&gt; +struct tcpci;<br>
&gt; +struct tcpci_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct regmap *regmap;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int (*init)(struct tcpci *tcpci, struct tcpci_dat=
a *data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int (*set_vconn)(struct tcpci *tcpci, struct tcpc=
i_data *data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bool enable);<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_da=
ta *data);<br>
&gt; +void tcpci_unregister_port(struct tcpci *tcpci);<br>
&gt; +irqreturn_t tcpci_irq(struct tcpci *tcpci);<br>
&gt; +<br>
&gt;=C2=A0 #endif /* __LINUX_USB_TCPCI_H */<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Best Regards,<div>=E6=9B=B8=E5=B8=86</div></div></div>
</div>

--001a11425e86cc5a5205663c3c72--
