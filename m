Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1837571-1520262977-2-2902176225750917171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.193', Host='mail-qk0-f193.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520262975; b=KiQEZ0OeupKN5H9F5T8MzV8iKuKlfcqTIR3PFFB1u0VXhER
    8jjMGbxgoMk+49Pext4/yZacy4NYiWzTjQ6baaNYWcbhuQTReVbDZ87vNhdk5JEM
    TV++9EBaIVu7eoimh2pA+NTTcJkbnY4aUUuDljuBcvDkD6/oU7eVVvzmRykCC2a/
    jNlT23d+vvbGrCg7X1efOBm6NS12rUi97BMfjqUKPAlWTXx4XpZrD4aJtU1zWWCN
    P8YFXykc9Wp5pZo83/6718Xgv7fO5mjwN0UUVqrvN74eXHuHQ0FptgG/sW8FxgEm
    WeQSV/M8A+zLeOcteS/HrxlPc4a62VNh0amiT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1520262975; bh=kJ7wyBNI
    Mt+FYyYLNLM3p06YWNgwOB8rmwXLjmKllQ8=; b=u91tTbNeaLX+xUXVMS74WgVh
    i4KNMtjM9yjeBtt4ORTZIIPSgYlLoqG1KkAcvQhu+6O/PPCj/ZWI+R+3B2aXvKMN
    5KGnzo/3xwxGXwi0AQ5OR6Xx2bRPS+XMaoZmexsRClZX9YP95xcScO0c8fL6Y5kf
    AfRM4PBrhJaI2TGRgXMeAg7ZjwTzKoIZ7PB6tai0AoK5OiGGyVXeGYVF71D9nQNd
    4cvxIMkESJ95KnChXz8b79EiD6QoknfOA1w6s8K2lGViJpln74ueRqYsF8sqTcuz
    JW/k8tcN8cJ7G+z4WCiAZvBu5LasXhU4EPXkaAccSaipg/l/V9h0ALsW81ZnLg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tWs/9Pm3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lIUoPL7U;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tWs/9Pm3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lIUoPL7U;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELtYMWp0YTdJFUmeaJJmQULFZJlSqGVDkHcAJhRylz7BcItSkk9KOVh7ciYQC4o9oakwsuFoyE3QFx0tD7vjGo8=
MIME-Version: 1.0
In-Reply-To: <646aee73-935f-0cbc-5d61-8697f8bba4ac@roeck-us.net>
References: <1520223402-19906-1-git-send-email-leechu729@gmail.com> <646aee73-935f-0cbc-5d61-8697f8bba4ac@roeck-us.net>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Mon, 5 Mar 2018 23:16:13 +0800
Message-ID: <CAFaeLdT=_7-97ye75JEw-E3hnZqcQopU2HVeToVehcH-dZwH3w@mail.gmail.com>
Subject: Re: [PATCH v6] staging: typec: handle vendor defined part and modify
 drp toggling flow
To: Guenter Roeck <linux@roeck-us.net>
Cc: heikki.krogerus@linux.intel.com, Greg KH <greg@kroah.com>,
	=?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

2018-03-05 22:49 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 03/04/2018 08:16 PM, ShuFan Lee wrote:
>>
>> From: ShuFan Lee <shufan_lee@richtek.com>
>>
>> Handle vendor defined behavior in tcpci_init, tcpci_set_vconn,
>> tcpci_start_drp_toggling
>> and export tcpci_irq. More operations can be extended in tcpci_data if
>> needed.
>> According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
>> TCPC shall not start DRP toggling until subsequently the TCPM
>> writes to the COMMAND register to start DRP toggling.
>> DRP toggling flow is chagned as following:
>
>
> s/chagned/changed/
Sorry for the type error, I'll correct it in v7.
>
>
>>    - Write DRP =3D 1, Rp level and RC.CCx to Rd/Rd or Rp/Rp
>>    - Set LOOK4CONNECTION command
>>
>> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
>> ---
>>   drivers/staging/typec/tcpci.c | 134
>> ++++++++++++++++++++++++++++++++++--------
>>   drivers/staging/typec/tcpci.h |  15 +++++
>>   2 files changed, 123 insertions(+), 26 deletions(-)
>>
>>   patch changelogs between v1 & v2
>>   - Remove unnecessary i2c_client in the structure of tcpci
>>   - Rename structure of tcpci_vendor_data to tcpci_data
>>   - Not exporting tcpci read/write wrappers but register i2c regmap in
>> glue driver
>>   - Add set_vconn ops in tcpci_data
>>     (It is necessary for RT1711H to enable/disable idle mode before
>> disabling/enabling vconn)
>>   - Export tcpci_irq so that vendor can call it in their own IRQ handler
>>
>>   patch changelogs between v2 & v3
>>   - Change the return type of tcpci_irq from int to irqreturn_t
>>
>>   patch changelogs between v3 & v4
>>   - Directly return regmap_write at the end of drp_toggling function
>>   - Because tcpci_irq is called in _tcpci_irq, move _tcpci_irq to the
>> place after tcpci_irq
>>
>>   patch changelogs between v4 & v5
>>   - Add a space between my first & last name, from ShuFanLee to ShuFan
>> Lee.
>>
>>   patch changelogs between v5 & v6
>>   - Add start_drp_toggling in tcpci_data and call it at the beginning of
>> tcpci_start_drp_toggling
>>   - Modify the flow of tcpci_start_drp_toggling as following
>>      - Set Rp level, RC.CCx to Rd/Rd or Rp/Rp and DRP =3D 1
>>      - Set LOOK4CONNECTION command
>>
>> diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci=
.c
>> index 9bd4412..9e600f7 100644
>> --- a/drivers/staging/typec/tcpci.c
>> +++ b/drivers/staging/typec/tcpci.c
>> @@ -21,7 +21,6 @@
>>     struct tcpci {
>>         struct device *dev;
>> -       struct i2c_client *client;
>>         struct tcpm_port *port;
>>   @@ -30,6 +29,12 @@ struct tcpci {
>>         bool controls_vbus;
>>         struct tcpc_dev tcpc;
>> +       struct tcpci_data *data;
>> +};
>> +
>> +struct tcpci_chip {
>> +       struct tcpci *tcpci;
>> +       struct tcpci_data data;
>>   };
>>     static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
>> @@ -37,8 +42,7 @@ static inline struct tcpci *tcpc_to_tcpci(struct
>> tcpc_dev *tcpc)
>>         return container_of(tcpc, struct tcpci, tcpc);
>>   }
>>   -static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,
>> -                       u16 *val)
>> +static int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *val=
)
>>   {
>>         return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u16));
>>   }
>> @@ -98,9 +102,19 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum
>> typec_cc_status cc)
>>   static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>>                                     enum typec_cc_status cc)
>>   {
>> +       int ret;
>>         struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
>>         unsigned int reg =3D TCPC_ROLE_CTRL_DRP;
>>   +     if (tcpci->data) {
>> +               if (tcpci->data->start_drp_toggling) {
>
>
> From the code flow it is guaranteed that ->data is set. It should therefo=
re
> be unnecessary to check for it (we don't check if ->reg is set either).
Ok, I'll modify it in v7, thank you.
>
>
>> +                       ret =3D tcpci->data->start_drp_toggling(tcpci,
>> +                                                             tcpci->dat=
a,
>> cc);
>> +                       if (ret < 0)
>> +                               return ret;
>> +               }
>> +       }
>> +
>>         switch (cc) {
>>         default:
>>         case TYPEC_CC_RP_DEF:
>> @@ -117,7 +131,17 @@ static int tcpci_start_drp_toggling(struct tcpc_dev
>> *tcpc,
>>                 break;
>>         }
>>   -     return regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>> +       if (cc =3D=3D TYPEC_CC_RD)
>> +               reg |=3D (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHI=
FT)
>> |
>> +                          (TCPC_ROLE_CTRL_CC_RD <<
>> TCPC_ROLE_CTRL_CC2_SHIFT);
>> +       else
>> +               reg |=3D (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHI=
FT)
>> |
>> +                          (TCPC_ROLE_CTRL_CC_RP <<
>> TCPC_ROLE_CTRL_CC2_SHIFT);
>> +       ret =3D regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>> +       if (ret < 0)
>> +               return ret;
>> +       return regmap_write(tcpci->regmap, TCPC_COMMAND,
>> +                           TCPC_CMD_LOOK4CONNECTION);
>>   }
>>     static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool
>> sink)
>> @@ -178,6 +202,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc,
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
>> @@ -323,6 +357,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
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
>> @@ -344,9 +387,8 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>>         return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
>>   }
>>   -static irqreturn_t tcpci_irq(int irq, void *dev_id)
>> +irqreturn_t tcpci_irq(struct tcpci *tcpci)
>>   {
>> -       struct tcpci *tcpci =3D dev_id;
>>         u16 status;
>>         tcpci_read16(tcpci, TCPC_ALERT, &status);
>> @@ -412,6 +454,14 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
>>         return IRQ_HANDLED;
>>   }
>> +EXPORT_SYMBOL_GPL(tcpci_irq);
>> +
>> +static irqreturn_t _tcpci_irq(int irq, void *dev_id)
>> +{
>> +       struct tcpci *tcpci =3D dev_id;
>> +
>> +       return tcpci_irq(tcpci);
>> +}
>>     static const struct regmap_config tcpci_regmap_config =3D {
>>         .reg_bits =3D 8,
>> @@ -435,22 +485,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)
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
>> @@ -467,27 +513,63 @@ static int tcpci_probe(struct i2c_client *client,
>>         err =3D tcpci_parse_config(tcpci);
>>         if (err < 0)
>> -               return err;
>> +               return ERR_PTR(err);
>> +
>> +       tcpci->port =3D tcpm_register_port(tcpci->dev, &tcpci->tcpc);
>> +       if (PTR_ERR_OR_ZERO(tcpci->port))
>> +               return ERR_CAST(tcpci->port);
>>   -     /* Disable chip interrupts */
>> -       tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
>> +       return tcpci;
>> +}
>> +EXPORT_SYMBOL_GPL(tcpci_register_port);
>> +
>> +void tcpci_unregister_port(struct tcpci *tcpci)
>> +{
>> +       tcpm_unregister_port(tcpci->port);
>> +}
>> +EXPORT_SYMBOL_GPL(tcpci_unregister_port);
>>   -     err =3D devm_request_threaded_irq(tcpci->dev, client->irq, NULL,
>> -                                       tcpci_irq,
>> +static int tcpci_probe(struct i2c_client *client,
>> +                      const struct i2c_device_id *i2c_id)
>> +{
>> +       struct tcpci_chip *chip;
>> +       int err;
>> +       u16 val =3D 0;
>> +
>> +       chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>> +       if (!chip)
>> +               return -ENOMEM;
>> +
>> +       chip->data.regmap =3D devm_regmap_init_i2c(client,
>> &tcpci_regmap_config);
>> +       if (IS_ERR(chip->data.regmap))
>> +               return PTR_ERR(chip->data.regmap);
>> +
>> +       /* Disable chip interrupts before requesting irq */
>> +       err =3D regmap_raw_write(chip->data.regmap, TCPC_ALERT_MASK, &va=
l,
>> +                              sizeof(u16));
>> +       if (err < 0)
>> +               return err;
>> +
>> +       err =3D devm_request_threaded_irq(&client->dev, client->irq, NUL=
L,
>> +                                       _tcpci_irq,
>>                                         IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>> -                                       dev_name(tcpci->dev), tcpci);
>> +                                       dev_name(&client->dev), chip);
>>         if (err < 0)
>>                 return err;
>>   -     tcpci->port =3D tcpm_register_port(tcpci->dev, &tcpci->tcpc);
>> -       return PTR_ERR_OR_ZERO(tcpci->port);
>> +       chip->tcpci =3D tcpci_register_port(&client->dev, &chip->data);
>> +       if (PTR_ERR_OR_ZERO(chip->tcpci))
>> +               return PTR_ERR(chip->tcpci);
>> +
>> +       i2c_set_clientdata(client, chip);
>> +       return 0;
>>   }
>>     static int tcpci_remove(struct i2c_client *client)
>>   {
>> -       struct tcpci *tcpci =3D i2c_get_clientdata(client);
>> +       struct tcpci_chip *chip =3D i2c_get_clientdata(client);
>>   -     tcpm_unregister_port(tcpci->port);
>> +       tcpci_unregister_port(chip->tcpci);
>>         return 0;
>>   }
>> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci=
.h
>> index fdfb06c..a2c1754 100644
>> --- a/drivers/staging/typec/tcpci.h
>> +++ b/drivers/staging/typec/tcpci.h
>> @@ -59,6 +59,7 @@
>>   #define TCPC_POWER_CTRL_VCONN_ENABLE  BIT(0)
>>     #define TCPC_CC_STATUS                      0x1d
>> +#define TCPC_CC_STATUS_DRPRST          BIT(5)
>>   #define TCPC_CC_STATUS_TERM           BIT(4)
>>   #define TCPC_CC_STATUS_CC2_SHIFT      2
>>   #define TCPC_CC_STATUS_CC2_MASK               0x3
>> @@ -121,4 +122,18 @@
>>   #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG                0x76
>>   #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG                0x78
>>   +struct tcpci;
>> +struct tcpci_data {
>> +       struct regmap *regmap;
>> +       int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>> +       int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>> +                        bool enable);
>> +       int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data
>> *data,
>> +                                 enum typec_cc_status cc);
>> +};
>> +
>> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data
>> *data);
>> +void tcpci_unregister_port(struct tcpci *tcpci);
>> +irqreturn_t tcpci_irq(struct tcpci *tcpci);
>> +
>>   #endif /* __LINUX_USB_TCPCI_H */
>>
>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86
