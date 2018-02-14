Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3010894-1518619430-2-546463894438320252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  HTML_MESSAGE 0.001, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.194', Host='mail-qt0-f194.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', plain='UTF-8', html='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518619428; b=rPXK+pfpyJDI5yE6965CzWBQjVsGxOrrNPnUm3VAchumEPJ
    Gj9LQkxbwjG6G3MfCnhAkX3Zxg0Hj6JdowTajzEsft3m1a2kI4VwCVpI/MneX8sX
    KjhxiL02rB7RCxGA90tKuk1pmwyXVJyMgzIMsTnfZv+FdgbJKTZ5mEPBTb1if1zc
    +mYJUYMuNO60V8yxNa/dthfQ3ajOYvIMdFqidxfS+78jtxevGL42S9cJiSZbRLzN
    pzstJZmhPOk+f/UE3rTdPaTqG7MOGDVXxeOClmGay4OIrkoMhRve+HBTHD7F3Dt1
    UMvOOSY706NY1sMslwiKjzCZJHQfUhWxoa8cXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1518619428; bh=mB2yrPPgTH2qPYWxId+0g3Dn/AUN2ui1D7iY9d9Dyz4=; b=o
    2HV1Gu+6RoC9sFYsG+4qXb/+/4Y9QuuAuSSXP14GVTNE72mRbweal/CtnQsbMC9n
    1aagnqJ1Nu5fW2japuS9yY+kk092xWGt5odeQg9LtnJJncG+6oMhZJ9BUvWGpic5
    s53peVAKVMWygzDbLoLYQ4prq9OXkjv5Xj/xaSdUu8UFwaujGL1s+as8JmbfE73b
    W4+ApiSnaHxkkRY77SH9tQM0Agoq+MPCK0G+yiaPrEK0kT33c/klvPBS/fsOIEzT
    1QWiNVuLuJ8k+t0WkeGDOMVOWg4/ZKFA9qhYPIjAQxvOyUGOP7imQkN0zC5cZ3yf
    +TzuBxXBjslHw1eB3f4eQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gfPpVIQA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.194 (mail-qt0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DNYuw+4B;
    x-ptr=pass x-ptr-helo=mail-qt0-f194.google.com x-ptr-lookup=mail-qt0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gfPpVIQA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.194 (mail-qt0-f194.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DNYuw+4B;
    x-ptr=pass x-ptr-helo=mail-qt0-f194.google.com x-ptr-lookup=mail-qt0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x2267qP/uk3fCx6WyD77i2kZhYPTfJxrQCAVPLQM2/1t5Na4Qp8RBTB/Dxl+IRa9wXyd6zhPRWcOwU1WoaBDZ+Mk=
MIME-Version: 1.0
In-Reply-To: <20180214125720.GB30479@kroah.com>
References: <1518612334-24140-1-git-send-email-leechu729@gmail.com> <20180214125720.GB30479@kroah.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Wed, 14 Feb 2018 22:43:45 +0800
Message-ID: <CAFaeLdQkCY5zTZrCLAszqZ5AaJxegGCRhsT9NXNJpEPH+rkeoQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: typec: handle vendor defined part and modify
 drp toggling flow
To: Greg KH <greg@kroah.com>
Cc: heikki.krogerus@linux.intel.com, Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, cy_huang@richtek.com,
	shufan_lee@richtek.com
Content-Type: multipart/alternative; boundary="f40304354e0875d5bf05652d23ea"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f40304354e0875d5bf05652d23ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gerg,


What changed from v1?

The diff between v1 and v2 is as following:

diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c

index 305a75d..8bccaa8 100644

--- a/drivers/staging/typec/tcpci.c

+++ b/drivers/staging/typec/tcpci.c

@@ -30,7 +30,7 @@ struct tcpci {

        bool controls_vbus;



        struct tcpc_dev tcpc;

-       struct tcpci_vendor_data *vdata;

+       struct tcpci_data *data;

 };



 static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)

@@ -38,29 +38,16 @@ static inline struct tcpci *tcpc_to_tcpci(struct
tcpc_dev *tcpc)
        return container_of(tcpc, struct tcpci, tcpc);


 }



-int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *val)

+static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,

+                       u16 *val)

 {

        return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u16));

 }

-EXPORT_SYMBOL_GPL(tcpci_read16);



-int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)

+static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)

 {

        return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));

 }

-EXPORT_SYMBOL_GPL(tcpci_write16);

-

-int tcpci_read8(struct tcpci *tcpci, unsigned int reg, u8 *val)

-{

-       return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u8));

-}

-EXPORT_SYMBOL_GPL(tcpci_read8);

-

-int tcpci_write8(struct tcpci *tcpci, unsigned int reg, u8 val)

-{

-       return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u8));

-}

-EXPORT_SYMBOL_GPL(tcpci_write8);



 static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)

 {

@@ -206,6 +193,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool
enable)
        struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);

        int ret;



+       /* Handle vendor set vconn */

+       if (tcpci->data) {

+               if (tcpci->data->set_vconn) {

+                       ret =3D tcpci->data->set_vconn(tcpci, tcpci->data,

+                                                    enable);

+                       if (ret < 0)

+                               return ret;

+               }

+       }

+


        ret =3D regmap_write(tcpci->regmap, TCPC_POWER_CTRL,

                           enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);

        if (ret < 0)

@@ -352,9 +349,9 @@ static int tcpci_init(struct tcpc_dev *tcpc)

                return -ETIMEDOUT;



        /* Handle vendor init */

-       if (tcpci->vdata) {

-               if (tcpci->vdata->init) {

-                       ret =3D (*tcpci->vdata->init)(tcpci, tcpci->vdata);

+       if (tcpci->data) {

+               if (tcpci->data->init) {

+                       ret =3D tcpci->data->init(tcpci, tcpci->data);

                        if (ret < 0)

                                return ret;

                }

@@ -381,20 +378,20 @@ static int tcpci_init(struct tcpc_dev *tcpc)

        return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);

 }



-static irqreturn_t tcpci_irq(int irq, void *dev_id)

+static irqreturn_t _tcpci_irq(int irq, void *dev_id)

 {

        struct tcpci *tcpci =3D dev_id;

+

+       tcpci_irq(tcpci);

+       return IRQ_HANDLED;

+}

+

+int tcpci_irq(struct tcpci *tcpci)

+{

        u16 status;



        tcpci_read16(tcpci, TCPC_ALERT, &status);



-       /* Handle vendor defined interrupt */

-       if (tcpci->vdata) {

-               if (tcpci->vdata->irq_handler)

-                       (*tcpci->vdata->irq_handler)(tcpci, tcpci->vdata,

-                                       &status);

-       }

-

        /*

         * Clear alert status for everything except RX_STATUS, which
shouldn't
         * be cleared until we have successfully retrieved message.

@@ -456,6 +453,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)



        return IRQ_HANDLED;

 }


+EXPORT_SYMBOL_GPL(tcpci_irq);



 static const struct regmap_config tcpci_regmap_config =3D {

        .reg_bits =3D 8,

@@ -479,22 +477,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)

        return 0;

 }



-struct tcpci *tcpci_register_port(struct i2c_client *client,

-                                 struct tcpci_vendor_data *vdata)

+struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data
*data)
 {

        struct tcpci *tcpci;

        int err;



-       tcpci =3D devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL);

+       tcpci =3D devm_kzalloc(dev, sizeof(*tcpci), GFP_KERNEL);

        if (!tcpci)

                return ERR_PTR(-ENOMEM);



-       tcpci->client =3D client;

-       tcpci->dev =3D &client->dev;

-       tcpci->vdata =3D vdata;

-       tcpci->regmap =3D devm_regmap_init_i2c(client, &tcpci_regmap_config=
);

-       if (IS_ERR(tcpci->regmap))

-               return ERR_CAST(tcpci->regmap);

+       tcpci->dev =3D dev;

+       tcpci->data =3D data;

+       tcpci->regmap =3D data->regmap;



        tcpci->tcpc.init =3D tcpci_init;

        tcpci->tcpc.get_vbus =3D tcpci_get_vbus;

@@ -516,13 +510,6 @@ struct tcpci *tcpci_register_port(struct i2c_client
*client,
        /* Disable chip interrupts */

        tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);



-       err =3D devm_request_threaded_irq(tcpci->dev, client->irq, NULL,

-                                       tcpci_irq,

-                                       IRQF_ONESHOT | IRQF_TRIGGER_LOW,

-                                       dev_name(tcpci->dev), tcpci);

-       if (err < 0)

-               return ERR_PTR(err);

-

        tcpci->port =3D tcpm_register_port(tcpci->dev, &tcpci->tcpc);

        if (PTR_ERR_OR_ZERO(tcpci->port))

                return ERR_CAST(tcpci->port);

@@ -541,11 +528,28 @@ static int tcpci_probe(struct i2c_client *client,

                       const struct i2c_device_id *i2c_id)

 {

        struct tcpci *tcpci;

+       struct tcpci_data *data;

+       int err;

+

+       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);

+       if (!data)

+               return -ENOMEM;



-       tcpci =3D tcpci_register_port(client, NULL);

+       data->regmap =3D devm_regmap_init_i2c(client, &tcpci_regmap_config)=
;

+       if (IS_ERR(data->regmap))

+               return PTR_ERR(data->regmap);

+

+       tcpci =3D tcpci_register_port(&client->dev, data);

        if (PTR_ERR_OR_ZERO(tcpci))

                return PTR_ERR(tcpci);



+       err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,

+                                       _tcpci_irq,

+                                       IRQF_ONESHOT | IRQF_TRIGGER_LOW,

+                                       dev_name(tcpci->dev), tcpci);

+       if (err < 0)

+               return err;

+

        i2c_set_clientdata(client, tcpci);

        return 0;

 }

diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h

index b1fcb4a..c838723 100644

--- a/drivers/staging/typec/tcpci.h

+++ b/drivers/staging/typec/tcpci.h

@@ -123,17 +123,15 @@

 #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG         0x78




 struct tcpci;

-struct tcpci_vendor_data {

-       int (*init)(struct tcpci *tcpci, struct tcpci_vendor_data *data);

-       int (*irq_handler)(struct tcpci *tcpci, struct tcpci_vendor_data
*data,
-                          u16 *status);

+struct tcpci_data {

+       struct regmap *regmap;

+       int (*init)(struct tcpci *tcpci, struct tcpci_data *data);

+       int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,

+                        bool enable);

 };



-int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *val);

-int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val);

-int tcpci_read8(struct tcpci *tcpci, unsigned int reg, u8 *val);

-int tcpci_write8(struct tcpci *tcpci, unsigned int reg, u8 val);

-struct tcpci *tcpci_register_port(struct i2c_client *client,

-                                 struct tcpci_vendor_data *data);

+struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data
*data);
 void tcpci_unregister_port(struct tcpci *tcpci);

+int tcpci_irq(struct tcpci *tcpci);

+

 #endif /* __LINUX_USB_TCPCI_H */



And I have to ask, are there no ' ' characters in your name?
Yes, there should be a ' '. So the name is ShuFan Lee.

2018-02-14 20:57 GMT+08:00 Greg KH <greg@kroah.com>:

> On Wed, Feb 14, 2018 at 08:45:34PM +0800, ShuFanLee wrote:
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
> > ---
> >  drivers/staging/typec/tcpci.c | 111 ++++++++++++++++++++++++++++++
> ++++--------
> >  drivers/staging/typec/tcpci.h |  13 +++++
> >  2 files changed, 103 insertions(+), 21 deletions(-)
>
> What changed from v1?
>
> And I have to ask, are there no ' ' characters in your name?
>
> thanks,
>
> greg k-h
>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86

--f40304354e0875d5bf05652d23ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgR2VyZyw8ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+V2hhdCBjaGFuZ2VkIGZyb20gdjE/PC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij48YnI+PC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5UaGUgZGlmZiBiZXR3ZWVuIHYxIGFu
ZCB2MiBpcyBhcyBmb2xsb3dpbmc6PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxNHB4Ij48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjE0cHgiPmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNwY2kuYyBiL2Ry
aXZlcnMvc3RhZ2luZy90eXBlYy90Y3BjaS5jIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5pbmRleCAzMDVhNzVkLi44YmNjYWE4IDEwMDY0NCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxNHB4Ij4tLS0gYS9kcml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNwY2kuYyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rKysgYi9kcml2ZXJz
L3N0YWdpbmcvdHlwZWMvdGNwY2kuYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5AQCAtMzAsNyArMzAsNyBAQCBzdHJ1Y3QgdGNwY2kgeyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRw
eCI+wqAgwqAgwqAgwqAgYm9vbCBjb250cm9sc192YnVzOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCBz
dHJ1Y3QgdGNwY19kZXYgdGNwYzsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDCoCDCoCDCoCBzdHJ1Y3QgdGNwY2lfdmVu
ZG9yX2RhdGEgKnZkYXRhOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTRweCI+KyDCoCDCoCDCoCBzdHJ1Y3QgdGNwY2lfZGF0YSAqZGF0YTsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgfTsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqBzdGF0aWMgaW5saW5l
IHN0cnVjdCB0Y3BjaSAqdGNwY190b190Y3BjaShzdHJ1Y3QgdGNwY19kZXYgKnRjcGMpIMKgIMKg
IMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjE0cHgiPkBAIC0zOCwyOSArMzgsMTYgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgdGNwY2kgKnRj
cGNfdG9fdGNwY2koc3RydWN0IHRjcGNfZGV2ICp0Y3BjKTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgcmV0dXJuIGNvbnRhaW5lcl9vZih0
Y3BjLCBzdHJ1Y3QgdGNwY2ksIHRjcGMpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoH0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9k
aXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi1pbnQgdGNwY2lfcmVhZDE2KHN0cnVj
dCB0Y3BjaSAqdGNwY2ksIHVuc2lnbmVkIGludCByZWcsIHUxNiAqdmFsKSDCoCDCoCDCoCDCoCDC
oCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+K3N0
YXRpYyBpbnQgdGNwY2lfcmVhZDE2KHN0cnVjdCB0Y3BjaSAqdGNwY2ksIHVuc2lnbmVkIGludCBy
ZWcsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHls
ZT0iZm9udC1zaXplOjE0cHgiPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdTE2
ICp2YWwpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjE0cHgiPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTRweCI+wqAgwqAgwqAgwqAgcmV0dXJuIHJlZ21hcF9yYXdfcmVhZCh0Y3BjaS0mZ3Q7cmVnbWFw
LCByZWcsIHZhbCwgc2l6ZW9mKHUxNikpOyDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoH0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi1FWFBPUlRfU1lNQk9MX0dQTCh0Y3BjaV9yZWFk
MTYpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxNHB4Ij7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
NHB4Ij4taW50IHRjcGNpX3dyaXRlMTYoc3RydWN0IHRjcGNpICp0Y3BjaSwgdW5zaWduZWQgaW50
IHJlZywgdTE2IHZhbCkgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjE0cHgiPitzdGF0aWMgaW50IHRjcGNpX3dyaXRlMTYoc3RydWN0
IHRjcGNpICp0Y3BjaSwgdW5zaWduZWQgaW50IHJlZywgdTE2IHZhbCkgwqAgwqAgwqDCoDwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqB7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCByZXR1cm4g
cmVnbWFwX3Jhd193cml0ZSh0Y3BjaS0mZ3Q7cmVnbWFwLCByZWcsICZhbXA7dmFsLCBzaXplb2Yo
dTE2KSk7IMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjE0cHgiPsKgfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTRweCI+LUVYUE9SVF9TWU1CT0xfR1BMKHRjcGNpX3dyaXRlMTYpOyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4taW50IHRjcGNpX3JlYWQ4KHN0
cnVjdCB0Y3BjaSAqdGNwY2ksIHVuc2lnbmVkIGludCByZWcsIHU4ICp2YWwpIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4
Ij4teyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDC
oCDCoCDCoCByZXR1cm4gcmVnbWFwX3Jhd19yZWFkKHRjcGNpLSZndDtyZWdtYXAsIHJlZywgdmFs
LCBzaXplb2YodTgpKTsgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjE0cHgiPi19IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxNHB4Ij4tRVhQT1JUX1NZTUJPTF9HUEwodGNwY2lfcmVhZDgpOyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4taW50IHRj
cGNpX3dyaXRlOChzdHJ1Y3QgdGNwY2kgKnRjcGNpLCB1bnNpZ25lZCBpbnQgcmVnLCB1OCB2YWwp
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxNHB4Ij4teyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTRweCI+LSDCoCDCoCDCoCByZXR1cm4gcmVnbWFwX3Jhd193cml0ZSh0Y3BjaS0mZ3Q7cmVn
bWFwLCByZWcsICZhbXA7dmFsLCBzaXplb2YodTgpKTsgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9k
aXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi19IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tRVhQT1JUX1NZTUJPTF9HUEwodGNwY2lf
d3JpdGU4KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250
LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTRweCI+wqBzdGF0aWMgaW50IHRjcGNpX3NldF9jYyhzdHJ1Y3QgdGNwY19kZXYgKnRjcGMs
IGVudW0gdHlwZWNfY2Nfc3RhdHVzIGNjKSDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5AQCAtMjA2LDYgKzE5MywxNiBAQCBzdGF0aWMgaW50IHRj
cGNpX3NldF92Y29ubihzdHJ1Y3QgdGNwY19kZXYgKnRjcGMsIGJvb2wgZW5hYmxlKTwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgc3RydWN0
IHRjcGNpICp0Y3BjaSA9IHRjcGNfdG9fdGNwY2kodGNwYyk7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCBpbnQgcmV0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRw
eCI+KyDCoCDCoCDCoCAvKiBIYW5kbGUgdmVuZG9yIHNldCB2Y29ubiAqLyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rIMKgIMKgIMKgIGlmICh0
Y3BjaS0mZ3Q7ZGF0YSkgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAo
dGNwY2ktJmd0O2RhdGEtJmd0O3NldF92Y29ubikgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxNHB4Ij4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldCA9
IHRjcGNpLSZndDtkYXRhLSZndDtzZXRfdmNvbm4odGNwY2ksIHRjcGNpLSZndDtkYXRhLCDCoCDC
oCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZW5hYmxlKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwv
ZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGlmIChyZXQgJmx0OyAwKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQt
c2l6ZToxNHB4Ij4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJldHVybiByZXQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48
ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+KyDCoCDCoCDCoCB9IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNp
emU6MTRweCI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCByZXQgPSByZWdt
YXBfd3JpdGUodGNwY2ktJmd0O3JlZ21hcCwgVENQQ19QT1dFUl9DVFJMLCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVuYWJsZSA/IFRDUENfUE9XRVJf
Q1RSTF9WQ09OTl9FTkFCTEUgOiAwKTsgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPkBAIC0z
NTIsOSArMzQ5LDkgQEAgc3RhdGljIGludCB0Y3BjaV9pbml0KHN0cnVjdCB0Y3BjX2RldiAqdGNw
YykgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRw
eCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC1FVElNRURPVVQ7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxl
PSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgLyogSGFuZGxlIHZlbmRvciBpbml0ICovIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi0gwqAgwqAgwqAg
aWYgKHRjcGNpLSZndDt2ZGF0YSkgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBz
dHlsZT0iZm9udC1zaXplOjE0cHgiPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHRjcGNpLSZn
dDt2ZGF0YS0mZ3Q7aW5pdCkgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gKCp0Y3BjaS0mZ3Q7dmRhdGEt
Jmd0O2luaXQpKHRjcGNpLCB0Y3BjaS0mZ3Q7dmRhdGEpOyDCoCDCoCDCoMKgPC9kaXY+PGRpdiBz
dHlsZT0iZm9udC1zaXplOjE0cHgiPisgwqAgwqAgwqAgaWYgKHRjcGNpLSZndDtkYXRhKSB7IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPisg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHRjcGNpLSZndDtkYXRhLSZndDtpbml0KSB7IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9k
aXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcmV0ID0gdGNwY2ktJmd0O2RhdGEtJmd0O2luaXQodGNwY2ksIHRjcGNpLSZndDtk
YXRhKTsgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiByZXQ7IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPkBA
IC0zODEsMjAgKzM3OCwyMCBAQCBzdGF0aWMgaW50IHRjcGNpX2luaXQoc3RydWN0IHRjcGNfZGV2
ICp0Y3BjKSDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTox
NHB4Ij7CoCDCoCDCoCDCoCByZXR1cm4gdGNwY2lfd3JpdGUxNih0Y3BjaSwgVENQQ19BTEVSVF9N
QVNLLCByZWcpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXYgc3R5
bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoH0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRw
eCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tc3RhdGljIGlycXJl
dHVybl90IHRjcGNpX2lycShpbnQgaXJxLCB2b2lkICpkZXZfaWQpIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgi
PitzdGF0aWMgaXJxcmV0dXJuX3QgX3RjcGNpX2lycShpbnQgaXJxLCB2b2lkICpkZXZfaWQpIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXNpemU6MTRweCI+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKg
IMKgIMKgIMKgIHN0cnVjdCB0Y3BjaSAqdGNwY2kgPSBkZXZfaWQ7IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2
IHN0eWxlPSJmb250LXNpemU6MTRweCI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXpl
OjE0cHgiPisgwqAgwqAgwqAgdGNwY2lfaXJxKHRjcGNpKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rIMKgIMKgIMKgIHJldHVybiBJ
UlFfSEFORExFRDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQt
c2l6ZToxNHB4Ij4rfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8
L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+K2ludCB0Y3BjaV9pcnEoc3RydWN0IHRj
cGNpICp0Y3BjaSkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4r
eyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCB1MTYgc3Rh
dHVzOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBzdHlsZT0i
Zm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+
wqAgwqAgwqAgwqAgdGNwY2lfcmVhZDE2KHRjcGNpLCBUQ1BDX0FMRVJULCAmYW1wO3N0YXR1cyk7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2
IHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6
ZToxNHB4Ij4tIMKgIMKgIMKgIC8qIEhhbmRsZSB2ZW5kb3IgZGVmaW5lZCBpbnRlcnJ1cHQgKi8g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2
PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIGlmICh0Y3BjaS0mZ3Q7dmRh
dGEpIHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTox
NHB4Ij4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh0Y3BjaS0mZ3Q7dmRhdGEtJmd0O2lycV9o
YW5kbGVyKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICgqdGNwY2ktJmd0O3ZkYXRhLSZndDtpcnFfaGFuZGxlcikodGNwY2ksIHRj
cGNpLSZndDt2ZGF0YSwgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4
Ij4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZhbXA7c3RhdHVzKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIH0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYg
c3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6
MTRweCI+wqAgwqAgwqAgwqAgLyogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAg
wqAqIENsZWFyIGFsZXJ0IHN0YXR1cyBmb3IgZXZlcnl0aGluZyBleGNlcHQgUlhfU1RBVFVTLCB3
aGljaCBzaG91bGRuJiMzOTt0IMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKg
IMKgIMKgIMKgIMKgKiBiZSBjbGVhcmVkIHVudGlsIHdlIGhhdmUgc3VjY2Vzc2Z1bGx5IHJldHJp
ZXZlZCBtZXNzYWdlLiDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1z
aXplOjE0cHgiPkBAIC00NTYsNiArNDUzLDcgQEAgc3RhdGljIGlycXJldHVybl90IHRjcGNpX2ly
cShpbnQgaXJxLCB2b2lkICpkZXZfaWQpIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7C
oCDCoCDCoCDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rp
dj48ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoH0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTRweCI+K0VYUE9SVF9TWU1CT0xfR1BMKHRjcGNpX2lycSk7IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
NHB4Ij7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4
Ij7CoHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyB0Y3BjaV9yZWdtYXBfY29uZmln
ID0geyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgLnJlZ19iaXRzID0gOCwgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjE0cHgiPkBAIC00NzksMjIgKzQ3NywxOCBAQCBzdGF0aWMgaW50IHRjcGNpX3Bh
cnNlX2NvbmZpZyhzdHJ1Y3QgdGNwY2kgKnRjcGNpKSDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgcmV0dXJuIDA7IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTRweCI+LXN0cnVjdCB0Y3BjaSAqdGNwY2lfcmVnaXN0ZXJfcG9ydChzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCB0Y3BjaV92ZW5kb3JfZGF0
YSAqdmRhdGEpIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxNHB4Ij4rc3RydWN0IHRjcGNpICp0Y3BjaV9yZWdpc3Rlcl9wb3J0KHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHRjcGNpX2RhdGEgKmRhdGEpwqA8L3NwYW4+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgc3RydWN0IHRjcGNpICp0
Y3BjaTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIGludCBlcnI7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxNHB4Ij7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
NHB4Ij4tIMKgIMKgIMKgIHRjcGNpID0gZGV2bV9remFsbG9jKCZhbXA7Y2xpZW50LSZndDtkZXYs
IHNpemVvZigqdGNwY2kpLCBHRlBfS0VSTkVMKTsgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+KyDCoCDCoCDCoCB0Y3BjaSA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqdGNwY2kpLCBHRlBfS0VSTkVMKTsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgi
PsKgIMKgIMKgIMKgIGlmICghdGNwY2kpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
wqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDCoCDCoCDCoCB0Y3BjaS0mZ3Q7Y2xpZW50
ID0gY2xpZW50OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIHRjcGNpLSZndDtkZXYgPSAmYW1wO2NsaWVudC0m
Z3Q7ZGV2OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTRweCI+LSDCoCDCoCDCoCB0Y3BjaS0mZ3Q7dmRhdGEgPSB2ZGF0YTsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDC
oCDCoCDCoCB0Y3BjaS0mZ3Q7cmVnbWFwID0gZGV2bV9yZWdtYXBfaW5pdF9pMmMoY2xpZW50LCAm
YW1wO3RjcGNpX3JlZ21hcF9jb25maWcpOyDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIGlmIChJU19FUlIodGNwY2ktJmd0O3Jl
Z21hcCkpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxNHB4Ij4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBFUlJfQ0FTVCh0Y3BjaS0mZ3Q7
cmVnbWFwKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDC
oDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+KyDCoCDCoCDC
oCB0Y3BjaS0mZ3Q7ZGV2ID0gZGV2OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rIMKgIMKgIMKgIHRjcGNpLSZn
dDtkYXRhID0gZGF0YTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+KyDCoCDCoCDCoCB0Y3BjaS0mZ3Q7cmVnbWFwID0g
ZGF0YS0mZ3Q7cmVnbWFwOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCB0Y3BjaS0mZ3Q7dGNwYy5pbml0ID0gdGNwY2lfaW5pdDsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKg
IMKgIMKgIHRjcGNpLSZndDt0Y3BjLmdldF92YnVzID0gdGNwY2lfZ2V0X3ZidXM7IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5AQCAtNTE2LDEzICs1MTAsNiBAQCBzdHJ1
Y3QgdGNwY2kgKnRjcGNpX3JlZ2lzdGVyX3BvcnQoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCw8
L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKg
IC8qIERpc2FibGUgY2hpcCBpbnRlcnJ1cHRzICovIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIHRjcGNpX3dyaXRlMTYodGNw
Y2ksIFRDUENfQUxFUlRfTUFTSywgMCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0
cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgi
Pi0gwqAgwqAgwqAgZXJyID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycSh0Y3BjaS0mZ3Q7ZGV2
LCBjbGllbnQtJmd0O2lycSwgTlVMTCwgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGNwY2lfaXJxLCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTRweCI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBJUlFGX09ORVNIT1QgfCBJUlFGX1RSSUdHRVJfTE9XLCDCoCDC
oCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBk
ZXZfbmFtZSh0Y3BjaS0mZ3Q7ZGV2KSwgdGNwY2kpOyDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIGlmIChlcnIg
Jmx0OyAwKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm4gRVJSX1BUUihlcnIpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTRweCI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCB0Y3BjaS0mZ3Q7cG9ydCA9IHRjcG1fcmVnaXN0ZXJfcG9y
dCh0Y3BjaS0mZ3Q7ZGV2LCAmYW1wO3RjcGNpLSZndDt0Y3BjKTsgwqAgwqAgwqAgwqAgwqAgwqDC
oDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAg
wqAgaWYgKFBUUl9FUlJfT1JfWkVSTyh0Y3BjaS0mZ3Q7cG9ydCkpIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRp
dj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJl
dHVybiBFUlJfQ0FTVCh0Y3BjaS0mZ3Q7cG9ydCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjE0cHgiPkBAIC01NDEsMTEgKzUyOCwyOCBAQCBzdGF0aWMgaW50IHRjcGNpX3By
b2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmkyY19pZCkgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjE0cHgiPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTRweCI+wqAgwqAgwqAgwqAgc3RydWN0IHRjcGNpICp0Y3BjaTsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48ZGl2PisgwqAgwqAgwqAgc3RydWN0IHRjcGNpX2RhdGEg
KmRhdGE7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIGludCBlcnI7IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48
ZGl2PisgwqAgwqAgwqAgZGF0YSA9IGRldm1fa3phbGxvYygmYW1wO2NsaWVudC0mZ3Q7ZGV2LCBz
aXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDC
oCDCoCDCoCBpZiAoIWRhdGEpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9k
aXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtRU5PTUVNOyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4tIMKgIMKgIMKgIHRjcGNpID0gdGNw
Y2lfcmVnaXN0ZXJfcG9ydChjbGllbnQsIE5VTEwpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCBkYXRhLSZndDtyZWdtYXAg
PSBkZXZtX3JlZ21hcF9pbml0X2kyYyhjbGllbnQsICZhbXA7dGNwY2lfcmVnbWFwX2NvbmZpZyk7
IMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIGlmIChJU19FUlIoZGF0YS0mZ3Q7cmVnbWFw
KSkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4g
UFRSX0VSUihkYXRhLSZndDtyZWdtYXApOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAg
wqAgdGNwY2kgPSB0Y3BjaV9yZWdpc3Rlcl9wb3J0KCZhbXA7Y2xpZW50LSZndDtkZXYsIGRhdGEp
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+wqAgwqAgwqAg
wqAgaWYgKFBUUl9FUlJfT1JfWkVSTyh0Y3BjaSkpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBQVFJfRVJSKHRjcGNpKTsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2
PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgZXJyID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVk
X2lycSgmYW1wO2NsaWVudC0mZ3Q7ZGV2LCBjbGllbnQtJmd0O2lycSwgTlVMTCwgwqAgwqAgwqAg
wqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgX3RjcGNpX2lycSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJUlFGX09ORVNIT1QgfCBJUlFGX1RSSUdHRVJfTE9X
LCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfbmFtZSh0Y3BjaS0mZ3Q7ZGV2KSwgdGNwY2kp
OyDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIGlmIChlcnIgJmx0OyAwKSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCByZXR1cm4gZXJyOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
wqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIGkyY19zZXRfY2xpZW50ZGF0YShjbGllbnQsIHRjcGNp
KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIHJldHVybiAwOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj7CoH0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PmRpZmYgLS1naXQgYS9k
cml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNwY2kuaCBiL2RyaXZlcnMvc3RhZ2luZy90eXBlYy90Y3Bj
aS5oIMKgIMKgIMKgPC9kaXY+PGRpdj5pbmRleCBiMWZjYjRhLi5jODM4NzIzIDEwMDY0NCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4tLS0gYS9kcml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNw
Y2kuaCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rKysgYi9kcml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNw
Y2kuaCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj5AQCAtMTIzLDE3ICsxMjMsMTUgQEAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+wqAjZGVmaW5lIFRDUENfVkJVU19WT0xU
QUdFX0FMQVJNX0xPX0NGRyDCoCDCoCDCoCDCoCAweDc4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj7CoHN0cnVj
dCB0Y3BjaTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48
ZGl2Pi1zdHJ1Y3QgdGNwY2lfdmVuZG9yX2RhdGEgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9k
aXY+PGRpdj4tIMKgIMKgIMKgIGludCAoKmluaXQpKHN0cnVjdCB0Y3BjaSAqdGNwY2ksIHN0cnVj
dCB0Y3BjaV92ZW5kb3JfZGF0YSAqZGF0YSk7IMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi0gwqAgwqAg
wqAgaW50ICgqaXJxX2hhbmRsZXIpKHN0cnVjdCB0Y3BjaSAqdGNwY2ksIHN0cnVjdCB0Y3BjaV92
ZW5kb3JfZGF0YSAqZGF0YSzCoDwvZGl2PjxkaXY+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHUxNiAqc3RhdHVzKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PitzdHJ1Y3QgdGNwY2lfZGF0
YSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKg
IHN0cnVjdCByZWdtYXAgKnJlZ21hcDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PisgwqAg
wqAgwqAgaW50ICgqaW5pdCkoc3RydWN0IHRjcGNpICp0Y3BjaSwgc3RydWN0IHRjcGNpX2RhdGEg
KmRhdGEpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCBpbnQgKCpz
ZXRfdmNvbm4pKHN0cnVjdCB0Y3BjaSAqdGNwY2ksIHN0cnVjdCB0Y3BjaV9kYXRhICpkYXRhLCDC
oCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGJvb2wgZW5hYmxlKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PsKgfTsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDC
oDwvZGl2PjxkaXY+LWludCB0Y3BjaV9yZWFkMTYoc3RydWN0IHRjcGNpICp0Y3BjaSwgdW5zaWdu
ZWQgaW50IHJlZywgdTE2ICp2YWwpOyDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4taW50
IHRjcGNpX3dyaXRlMTYoc3RydWN0IHRjcGNpICp0Y3BjaSwgdW5zaWduZWQgaW50IHJlZywgdTE2
IHZhbCk7IMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi1pbnQgdGNwY2lfcmVhZDgoc3Ry
dWN0IHRjcGNpICp0Y3BjaSwgdW5zaWduZWQgaW50IHJlZywgdTggKnZhbCk7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi1pbnQgdGNwY2lfd3JpdGU4KHN0cnVjdCB0Y3BjaSAqdGNw
Y2ksIHVuc2lnbmVkIGludCByZWcsIHU4IHZhbCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rp
dj48ZGl2Pi1zdHJ1Y3QgdGNwY2kgKnRjcGNpX3JlZ2lzdGVyX3BvcnQoc3RydWN0IGkyY19jbGll
bnQgKmNsaWVudCwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+LSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgdGNwY2lf
dmVuZG9yX2RhdGEgKmRhdGEpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+K3N0cnVj
dCB0Y3BjaSAqdGNwY2lfcmVnaXN0ZXJfcG9ydChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB0
Y3BjaV9kYXRhICpkYXRhKTs8L2Rpdj48ZGl2PsKgdm9pZCB0Y3BjaV91bnJlZ2lzdGVyX3BvcnQo
c3RydWN0IHRjcGNpICp0Y3BjaSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgwqA8L2Rpdj48ZGl2PitpbnQgdGNwY2lfaXJxKHN0cnVjdCB0Y3BjaSAqdGNwY2kp
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj7CoCNlbmRpZiAvKiBfX0xJTlVY
X1VTQl9UQ1BDSV9IICovIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48L2Rpdj48ZGl2IHN0eWxlPSJmb250
LXNpemU6MTRweCI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij48YnI+PC9k
aXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPkFuZCBJIGhhdmUgdG8gYXNrLCBhcmUgdGhl
cmUgbm8gJiMzOTsgJiMzOTsgY2hhcmFjdGVycyBpbiB5b3VyIG5hbWU/PC9kaXY+PC9kaXY+PC9k
aXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPlllcywgdGhlcmUgc2hvdWxkIGJlIGEgJiMz
OTsgJiMzOTsuIFNvIHRoZSBuYW1lIGlzIFNodUZhbiBMZWUuwqA8L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE4LTAyLTE0IDIwOjU3
IEdNVCswODowMCBHcmVnIEtIIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmdy
ZWdAa3JvYWguY29tIiB0YXJnZXQ9Il9ibGFuayI+Z3JlZ0Brcm9haC5jb208L2E+Jmd0Ozwvc3Bh
bj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxzcGFu
IGNsYXNzPSIiPk9uIFdlZCwgRmViIDE0LCAyMDE4IGF0IDA4OjQ1OjM0UE0gKzA4MDAsIFNodUZh
bkxlZSB3cm90ZTo8YnI+DQomZ3Q7IEZyb206IFNodUZhbkxlZSAmbHQ7PGEgaHJlZj0ibWFpbHRv
OnNodWZhbl9sZWVAcmljaHRlay5jb20iPnNodWZhbl9sZWVAcmljaHRlay5jb208L2E+Jmd0Ozxi
cj4NCiZndDs8YnI+DQomZ3Q7IEhhbmRsZSB2ZW5kb3IgZGVmaW5lZCBiZWhhdmlvciBpbiB0Y3Bj
aV9pbml0LCB0Y3BjaV9zZXRfdmNvbm4gYW5kIGV4cG9ydCB0Y3BjaV9pcnEuPGJyPg0KJmd0OyBN
b3JlIG9wZXJhdGlvbnMgY2FuIGJlIGV4dGVuZGVkIGluIHRjcGNpX2RhdGEgaWYgbmVlZGVkLjxi
cj4NCiZndDsgQWNjb3JkaW5nIHRvIFRDUENJIHNwZWNpZmljYXRpb24sIDQuNC41LjIgUk9MRV9D
T05UUk9MLDxicj4NCiZndDsgVENQQyBzaGFsbCBub3Qgc3RhcnQgRFJQIHRvZ2dsaW5nIHVudGls
IHN1YnNlcXVlbnRseSB0aGUgVENQTTxicj4NCiZndDsgd3JpdGVzIHRvIHRoZSBDT01NQU5EIHJl
Z2lzdGVyIHRvIHN0YXJ0IERSUCB0b2dnbGluZy48YnI+DQomZ3Q7IERSUCB0b2dnbGluZyBmbG93
IGlzIGNoYWduZWQgYXMgZm9sbG93aW5nOjxicj4NCiZndDvCoCDCoC0gV3JpdGUgRFJQID0gMCAm
YW1wOyBSZC9SZDxicj4NCiZndDvCoCDCoC0gV3JpdGUgRFJQID0gMTxicj4NCiZndDvCoCDCoC0g
U2V0IExPT0s0Q09OTkVDVElPTiBjb21tYW5kPGJyPg0KJmd0Ozxicj4NCiZndDsgU2lnbmVkLW9m
Zi1ieTogU2h1RmFuTGVlICZsdDs8YSBocmVmPSJtYWlsdG86c2h1ZmFuX2xlZUByaWNodGVrLmNv
bSI+c2h1ZmFuX2xlZUByaWNodGVrLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0OyAtLS08YnI+DQomZ3Q7
wqAgZHJpdmVycy9zdGFnaW5nL3R5cGVjL3RjcGNpLmMgfCAxMTEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrPHdicj4rKysrLS0tLS0tLS08YnI+DQomZ3Q7wqAgZHJpdmVycy9zdGFnaW5n
L3R5cGVjL3RjcGNpLmggfMKgIDEzICsrKysrPGJyPg0KJmd0O8KgIDIgZmlsZXMgY2hhbmdlZCwg
MTAzIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKTxicj4NCjxicj4NCjwvc3Bhbj5XaGF0
IGNoYW5nZWQgZnJvbSB2MT88YnI+DQo8YnI+DQpBbmQgSSBoYXZlIHRvIGFzaywgYXJlIHRoZXJl
IG5vICYjMzk7ICYjMzk7IGNoYXJhY3RlcnMgaW4geW91ciBuYW1lPzxicj4NCjxicj4NCnRoYW5r
cyw8YnI+DQo8YnI+DQpncmVnIGstaDxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyIGNs
ZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1
cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPkJlc3Qg
UmVnYXJkcyw8ZGl2PuabuOW4hjwvZGl2PjwvZGl2PjwvZGl2Pg0KPC9kaXY+PC9kaXY+DQo=
--f40304354e0875d5bf05652d23ea--
