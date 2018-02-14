Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3258100-1518627306-2-14166173778725625414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  HTML_MESSAGE 0.001, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.173', Host='mail-qt0-f173.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', plain='UTF-8', html='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518627305; b=R3N34StZYmfPsNvbe+tC/XpALlh6vRmdCHKSgR5B+rKvFbM
    5QcDF2q6xtscBiFKfMAt8XzXkDzXNq9Z1T8+Xg7a/OlD47UiODfXnX1JX0+Dz0ks
    M1GB1jH/E/j6I6pHqqqn1l0fT+/8pvfxEBCdAbZktU6N1/A785DmGvkYKNCYCaa4
    rnj9LbPeU0G34M3bfHKtFRm3j/PxDRf+TOQnJhKyuTvl9vFivf4MwJ5u9ANx8K7+
    PtK/BIsyak8zOeRT89oORZTU9DUKIk+gVRTYLQQ3i3MFVPPlUJ4ZV+aC+fSmjaD2
    Y966cVc+R4pfpIhzpV9V/du5un4kjlMsXA1eIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1518627305; bh=WHhoNB8BhCACh3S+zsh08TsWdy5f+Ny7o2ChE1O2/dY=; b=A
    TgxZvqx8I1hGRdi4Wn8U/O8mrPbn189rpX4GUusINfVqLyL8/cb1N6+VHYQInEgc
    R+gB7Ts75gV8VtscdDrDnKp8vVsYY4vBDxYhuAhDjxT7HXd4Lf3BGM9MHVr3IvA7
    UHUyDfQTo0fn0meI5rp6dPyy3hlD0UQWYHlUM32Da+FpoJDp71G64SCEb82cMEwY
    WGtwrtkF0BLSnPl7yQ/UwaCeaV0hD73BkrC2EOel1uRAawsvQP0rxnz4Cf5KlPX2
    Lhsy0cfQY5EFtIUCg0mztLD0i5kNaJ7y2rfH0AqnaowEXzR+Xra40Fa/1rquNEic
    hoFC3ln3OvAqACziL1jxA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W9AwuMe8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.173 (mail-qt0-f173.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f173.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h3npm44w;
    x-ptr=pass x-ptr-helo=mail-qt0-f173.google.com x-ptr-lookup=mail-qt0-f173.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W9AwuMe8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.173 (mail-qt0-f173.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f173.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h3npm44w;
    x-ptr=pass x-ptr-helo=mail-qt0-f173.google.com x-ptr-lookup=mail-qt0-f173.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x2244KOs22R8UnDiH4R3F/Q8vlWkgKLC2235YnipPmvhx9S22FF37sM9fmpo8okf05bUkHzJu2BqNuhdfHvkR6tk=
MIME-Version: 1.0
In-Reply-To: <20180214153756.GA2393@kroah.com>
References: <1518612334-24140-1-git-send-email-leechu729@gmail.com>
 <20180214125720.GB30479@kroah.com> <CAFaeLdQkCY5zTZrCLAszqZ5AaJxegGCRhsT9NXNJpEPH+rkeoQ@mail.gmail.com>
 <20180214153756.GA2393@kroah.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Thu, 15 Feb 2018 00:55:02 +0800
Message-ID: <CAFaeLdRHwqYP3-xbKUOmp-GxtD_uWAe+rCcLT_o38r9Zmm-29w@mail.gmail.com>
Subject: Re: [PATCH v2] staging: typec: handle vendor defined part and modify
 drp toggling flow
To: Greg KH <greg@kroah.com>
Cc: heikki.krogerus@linux.intel.com, Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, cy_huang@richtek.com,
	shufan_lee@richtek.com
Content-Type: multipart/alternative; boundary="001a113fd4b4f0194a05652ef8d5"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113fd4b4f0194a05652ef8d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gerg,

  Thank you for your time!

  I'll summarize the difference between v1, v2 and v3 below the --- line
and modify the format of my name in PATCH v3.

  For your reference, the detailed explanation of the difference between v1
and v2 is as following:

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


Change naming of structure of tcpci_vendor_data to tcpci_data
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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


Remove exporting the above wrappers like Heikki suggested.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



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

Add set vconn ops for vendor to do things before standard set vconn
operation
e.x. It is necessary for RT1711H to disable idle mode before enabling vconn
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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

Fix the type error
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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


As Heikki suggested, I export tcpci_irq so that vendor can register their
own IRQ handler and call tcpci_irq in their IRQ handler
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


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

Remove i2c_client from tcpci
Move regmap_init & request_threaded_irq to the glue driver
Note: request_threaded_irq may need to be done earlier, prior to
tcpci_register_port. This is still under discussion.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


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

Modify structure of tcpci_vendor_data to tcpci_data
Only declare tcpci_register_port & tcpci_unregister_port & tcpci_irq in
header file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



2018-02-14 23:37 GMT+08:00 Greg KH <greg@kroah.com>:

> On Wed, Feb 14, 2018 at 10:43:45PM +0800, =E6=9D=8E=E6=9B=B8=E5=B8=86 wro=
te:
> > Hi Gerg,
> >
> >
> > What changed from v1?
> >
> > The diff between v1 and v2 is as following:
>
> <snip>
>
> You need to explain what changed below the --- line, as is described in
> Documentation/SubmittingPatches.
>
> Please fix that up, and the text for your name, when you resend
> version 3 of this patch.
>
> thanks,
>
> greg k-h
>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86

--001a113fd4b4f0194a05652ef8d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgR2VyZyw8ZGl2Pjxicj48L2Rpdj48ZGl2PsKgIFRoYW5rIHlvdSBm
b3IgeW91ciB0aW1lITwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqAgSSYjMzk7bGwgc3VtbWFy
aXplIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdjEsIHYyIGFuZCB2MyBiZWxvdyB0aGUgLS0tIGxp
bmUgYW5kIG1vZGlmeSB0aGUgZm9ybWF0IG9mIG15IG5hbWUgaW4gUEFUQ0ggdjMuPC9kaXY+PGRp
dj7CoMKgPC9kaXY+PGRpdj7CoCBGb3IgeW91ciByZWZlcmVuY2UsIHRoZSBkZXRhaWxlZCBleHBs
YW5hdGlvbiBvZiB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHYxIGFuZCB2MiBpcyBhcyBmb2xsb3dp
bmc6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgi
PmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNwY2kuPHdicj5jIGIvZHJpdmVy
cy9zdGFnaW5nL3R5cGVjL3RjcGNpLjx3YnI+YyDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+aW5kZXggMzA1YTc1ZC4uOGJjY2FhOCAxMDA2NDQg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTRweCI+LS0tIGEvZHJpdmVycy9zdGFnaW5nL3R5cGVjL3RjcGNpLjx3YnI+YyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rKysgYi9k
cml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNwY2kuPHdicj5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPkBAIC0zMCw3ICszMCw3IEBAIHN0cnVj
dCB0Y3BjaSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxzcGFuIGNsYXNzPSJnbWFpbC1p
bSI+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIGJvb2wgY29u
dHJvbHNfdmJ1czsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgc3RydWN0IHRjcGNfZGV2IHRjcGM7IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PC9zcGFuPjxkaXY+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIHN0cnVjdCB0Y3BjaV92ZW5kb3JfZGF0YSAqdmRhdGE7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPC9zcGFuPjwvZGl2PjxzcGFuIGNsYXNzPSJnbWFpbC1pbSI+PGRpdj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjE0cHgiPisgwqAgwqAgwqAgc3RydWN0IHRjcGNpX2RhdGEgKmRhdGE7IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7C
oH07IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPjxicj48
L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPkNoYW5nZSBuYW1p
bmcgb2Ygc3RydWN0dXJlIG9mIHRjcGNpX3ZlbmRvcl9kYXRhIHRvIHRjcGNpX2RhdGE8L3NwYW4+
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08L3NwYW4+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgc3RhdGljIGlubGluZSBzdHJ1Y3QgdGNwY2kgKnRj
cGNfdG9fdGNwY2koc3RydWN0IHRjcGNfZGV2ICp0Y3BjKSDCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
PC9zcGFuPjwvZGl2Pjwvc3Bhbj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+QEAg
LTM4LDI5ICszOCwxNiBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCB0Y3BjaSAqdGNwY190b190Y3Bj
aShzdHJ1Y3QgdGNwY19kZXYgKnRjcGMpPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCByZXR1cm4gY29udGFpbmVyX29mKHRjcGMsIHN0cnVj
dCB0Y3BjaSwgdGNwYyk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRp
dj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTRweCI+LWludCB0Y3BjaV9yZWFkMTYoc3RydWN0IHRjcGNpICp0
Y3BjaSwgdW5zaWduZWQgaW50IHJlZywgdTE2ICp2YWwpIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rc3RhdGljIGludCB0
Y3BjaV9yZWFkMTYoc3RydWN0IHRjcGNpICp0Y3BjaSwgdW5zaWduZWQgaW50IHJlZywgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTRweCI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1MTYgKnZhbCkgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+
wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDC
oCDCoCDCoCByZXR1cm4gcmVnbWFwX3Jhd19yZWFkKHRjcGNpLSZndDtyZWdtYXAsIHJlZywgdmFs
LCBzaXplb2YodTE2KSk7IMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjE0cHgiPsKgfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTRweCI+LUVYUE9SVF9TWU1CT0xfR1BMKHRjcGNpXzx3YnI+cmVhZDE2KTsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRw
eCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+
LWludCB0Y3BjaV93cml0ZTE2KHN0cnVjdCB0Y3BjaSAqdGNwY2ksIHVuc2lnbmVkIGludCByZWcs
IHUxNiB2YWwpIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxNHB4Ij4rc3RhdGljIGludCB0Y3BjaV93cml0ZTE2KHN0cnVjdCB0Y3Bj
aSAqdGNwY2ksIHVuc2lnbmVkIGludCByZWcsIHUxNiB2YWwpIMKgIMKgIMKgwqA8L3NwYW4+PC9k
aXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgeyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgcmV0dXJuIHJlZ21h
cF9yYXdfd3JpdGUodGNwY2ktJmd0Ozx3YnI+cmVnbWFwLCByZWcsICZhbXA7dmFsLCBzaXplb2Yo
dTE2KSk7IMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjE0cHgiPsKgfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTRweCI+LUVYUE9SVF9TWU1CT0xfR1BMKHRjcGNpXzx3YnI+d3JpdGUxNik7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3Nw
YW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi1pbnQgdGNwY2lfcmVh
ZDgoc3RydWN0IHRjcGNpICp0Y3BjaSwgdW5zaWduZWQgaW50IHJlZywgdTggKnZhbCkgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjE0cHgiPi17IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4
Ij4tIMKgIMKgIMKgIHJldHVybiByZWdtYXBfcmF3X3JlYWQodGNwY2ktJmd0O3JlZ21hcCwgcmVn
LCB2YWwsIHNpemVvZih1OCkpOyDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+LX0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjE0cHgiPi1FWFBPUlRfU1lNQk9MX0dQTCh0Y3BjaV88d2JyPnJlYWQ4
KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjE0cHgiPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRw
eCI+LWludCB0Y3BjaV93cml0ZTgoc3RydWN0IHRjcGNpICp0Y3BjaSwgdW5zaWduZWQgaW50IHJl
ZywgdTggdmFsKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTRweCI+LXsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHls
ZT0iZm9udC1zaXplOjE0cHgiPi0gwqAgwqAgwqAgcmV0dXJuIHJlZ21hcF9yYXdfd3JpdGUodGNw
Y2ktJmd0Ozx3YnI+cmVnbWFwLCByZWcsICZhbXA7dmFsLCBzaXplb2YodTgpKTsgwqAgwqAgwqAg
wqAgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi19IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tRVhQT1JUX1NZ
TUJPTF9HUEwodGNwY2lfPHdicj53cml0ZTgpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5SZW1vdmUgZXhwb3J0aW5nIHRoZSBhYm92ZSB3cmFw
cGVycyBsaWtlIEhlaWtraSBzdWdnZXN0ZWQuPC9zcGFuPjwvZGl2PjxzcGFuIGNsYXNzPSJnbWFp
bC1pbSI+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08L3NwYW4+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxNHB4Ij48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxNHB4Ij7CoHN0YXRpYyBpbnQgdGNwY2lfc2V0X2NjKHN0cnVjdCB0Y3BjX2RldiAqdGNwYywg
ZW51bSB0eXBlY19jY19zdGF0dXMgY2MpIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2Pjwvc3Bhbj48
ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweCI+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5AQCAtMjA2LDYgKzE5MywxNiBAQCBzdGF0aWMg
aW50IHRjcGNpX3NldF92Y29ubihzdHJ1Y3QgdGNwY19kZXYgKnRjcGMsIGJvb2wgZW5hYmxlKTwv
c3Bhbj48L2Rpdj48c3BhbiBjbGFzcz0iZ21haWwtaW0iPjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCBzdHJ1Y3QgdGNwY2kgKnRjcGNpID0gdGNwY190b190Y3Bj
aSh0Y3BjKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L3Nw
YW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIGlu
dCByZXQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4rIMKgIMKgIMKgIC8qIEhhbmRsZSB2ZW5k
b3Igc2V0IHZjb25uICovIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjE0cHgiPisgwqAgwqAgwqAgaWYgKHRjcGNpLSZndDtkYXRhKSB7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNHB4
Ij4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh0Y3BjaS0mZ3Q7ZGF0YS0mZ3Q7c2V0X3Zjb25u
KSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8
L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPisgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gdGNwY2ktJmd0O2RhdGEtJmd0O3NldF92Y29u
bih0Y3BjaSwgdGNwY2ktJmd0O2RhdGEsIMKgIMKgIMKgIMKgPC9zcGFuPjwvZGl2Pjwvc3Bhbj48
ZGl2PjxzcGFuIGNsYXNzPSJnbWFpbC1pbSIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij48ZGl2Pisg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBlbmFibGUpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
PC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChyZXQgJmx0
OyAwKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCByZXR1cm4gcmV0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDCoCDC
oCDCoCB9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8
L2Rpdj48ZGl2PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIHJldCA9IHJlZ21hcF93cml0ZSh0Y3BjaS0mZ3Q7cmVn
bWFwLCBUQ1BDX1BPV0VSX0NUUkwsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9k
aXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVuYWJsZSA/
IFRDUENfUE9XRVJfQ1RSTF9WQ09OTl9FTkFCTEUgOiAwKTsgwqAgwqAgwqAgwqAgwqA8L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIGlmIChyZXQgJmx0OyAwKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QWRkIHNldCB2Y29ubiBvcHMgZm9yIHZlbmRvciB0byBkbyB0aGluZ3MgYmVmb3JlIHN0YW5kYXJk
IHNldCB2Y29ubiBvcGVyYXRpb248L2Rpdj48ZGl2PmUueC4gSXQgaXMgbmVjZXNzYXJ5IGZvciBS
VDE3MTFIIHRvIGRpc2FibGUgaWRsZSBtb2RlIGJlZm9yZSBlbmFibGluZyB2Y29ubjwvZGl2Pjxk
aXY+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PTxicj48L2Rpdj48ZGl2PsKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
L2Rpdj48L3NwYW4+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPkBAIC0zNTIsOSArMzQ5LDkg
QEAgc3RhdGljIGludCB0Y3BjaV9pbml0KHN0cnVjdCB0Y3BjX2RldiAqdGNwYykgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmV0dXJuIC1FVElNRURPVVQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PHNwYW4g
Y2xhc3M9ImdtYWlsLWltIiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPjxkaXY+wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2
PjxkaXY+wqAgwqAgwqAgwqAgLyogSGFuZGxlIHZlbmRvciBpbml0ICovIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PC9kaXY+PC9zcGFuPjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIGlmICh0
Y3BjaS0mZ3Q7dmRhdGEpIHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9
ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh0Y3BjaS0mZ3Q7dmRh
dGEtJmd0O2luaXQpIHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldCA9ICgqdGNwY2ktJmd0O3ZkYXRhLSZndDtp
bml0KSh0Y3BjaSwgdGNwY2ktJmd0O3ZkYXRhKTsgwqAgwqAgwqDCoDwvZGl2PjxzcGFuIGNsYXNz
PSJnbWFpbC1pbSIgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij48ZGl2PisgwqAgwqAgwqAgaWYgKHRj
cGNpLSZndDtkYXRhKSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmICh0Y3BjaS0mZ3Q7ZGF0YS0mZ3Q7aW5pdCkgeyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2Pjxk
aXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXQgPSB0Y3BjaS0mZ3Q7ZGF0
YS0mZ3Q7aW5pdCh0Y3BjaSwgdGNwY2ktJmd0O2RhdGEpOyDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2
Pjwvc3Bhbj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdiBzdHlsZT0i
Zm9udC1zaXplOjE0cHgiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJldHVybiByZXQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweCI+wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfTwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij48YnI+
PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPkZpeCB0aGUgdHlwZSBlcnJvcjwvZGl2
PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij49PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09wqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250
LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2Pjxk
aXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij5AQCAtMzgxLDIwICszNzgsMjAgQEAgc3RhdGljIGlu
dCB0Y3BjaV9pbml0KHN0cnVjdCB0Y3BjX2RldiAqdGNwYykgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
L2Rpdj48c3BhbiBjbGFzcz0iZ21haWwtaW0iIHN0eWxlPSJmb250LXNpemU6MTRweCI+PGRpdj7C
oCDCoCDCoCDCoCByZXR1cm4gdGNwY2lfd3JpdGUxNih0Y3BjaSwgVENQQ19BTEVSVF9NQVNLLCBy
ZWcpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+wqB9IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9k
aXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4tc3RhdGljIGlycXJldHVybl90IHRjcGNpX2lycShp
bnQgaXJxLCB2b2lkICpkZXZfaWQpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPC9kaXY+PGRpdj4rc3RhdGljIGlycXJldHVybl90IF90Y3BjaV9pcnEoaW50IGlycSwg
dm9pZCAqZGV2X2lkKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9k
aXY+PGRpdj7CoHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIHN0cnVjdCB0Y3BjaSAqdGNwY2kg
PSBkZXZfaWQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCB0
Y3BjaV9pcnEodGNwY2kpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rIMKg
IMKgIMKgIHJldHVybiBJUlFfSEFORExFRDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2Pjxk
aXY+K30gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+K2ludCB0Y3BjaV9pcnEoc3RydWN0
IHRjcGNpICp0Y3BjaSkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+K3sgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PsKgIMKg
IMKgIMKgIHUxNiBzdGF0dXM7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rp
dj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIHRjcGNpX3JlYWQxNih0Y3BjaSwg
VENQQ19BTEVSVCwgJmFtcDtzdGF0dXMpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PC9zcGFuPjxkaXYgc3R5bGU9
ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIC8qIEhhbmRsZSB2ZW5kb3IgZGVmaW5lZCBpbnRl
cnJ1cHQgKi8gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIGlmICh0Y3Bj
aS0mZ3Q7dmRhdGEpIHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZv
bnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh0Y3BjaS0mZ3Q7dmRhdGEt
Jmd0O2lycV9oYW5kbGVyKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij4tIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICgqdGNwY2ktJmd0O3ZkYXRhLSZndDtpcnFfaGFuZGxlciko
PHdicj50Y3BjaSwgdGNwY2ktJmd0O3ZkYXRhLCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBzdHlsZT0i
Zm9udC1zaXplOjE0cHgiPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtzdGF0dXMpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi0g
wqAgwqAgwqAgfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oMKgPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgiPi0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5
bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDCoCAvKiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4
Ij7CoCDCoCDCoCDCoCDCoCogQ2xlYXIgYWxlcnQgc3RhdHVzIGZvciBldmVyeXRoaW5nIGV4Y2Vw
dCBSWF9TVEFUVVMsIHdoaWNoIHNob3VsZG4mIzM5O3QgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250
LXNpemU6MTRweCI+wqAgwqAgwqAgwqAgwqAqIGJlIGNsZWFyZWQgdW50aWwgd2UgaGF2ZSBzdWNj
ZXNzZnVsbHkgcmV0cmlldmVkIG1lc3NhZ2UuPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0
cHgiPsKgIMKgIMKgIMKgIMKgwqA8YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgi
PkBAIC00NTYsNiArNDUzLDcgQEAgc3RhdGljIGlycXJldHVybl90IHRjcGNpX2lycShpbnQgaXJx
LCB2b2lkICpkZXZfaWQpIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6
MTRweCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqDCoDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4Ij7CoCDCoCDCoCDC
oCByZXR1cm4gSVJRX0hBTkRMRUQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2IHN0
eWxlPSJmb250LXNpemU6MTRweCI+PHNwYW4gY2xhc3M9ImdtYWlsLWltIj48ZGl2PsKgfSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rRVhQ
T1JUX1NZTUJPTF9HUEwodGNwY2lfaXJxKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2Pjxi
ciBjbGFzcz0iZ21haWwtQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+QXMgSGVpa2tpIHN1Z2dl
c3RlZCwgSSBleHBvcnQgdGNwY2lfaXJxIHNvIHRoYXQgdmVuZG9yIGNhbiByZWdpc3RlciB0aGVp
ciBvd24gSVJRIGhhbmRsZXIgYW5kIGNhbGwgdGNwY2lfaXJxIGluIHRoZWlyIElSUSBoYW5kbGVy
PC9kaXY+PGRpdj49PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09IMKgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj7CoHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyB0Y3BjaV9yZWdtYXBfY29uZmlnID0geyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgLnJlZ19iaXRzID0g
OCwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48L3NwYW4+PGRpdj5AQCAtNDc5
LDIyICs0NzcsMTggQEAgc3RhdGljIGludCB0Y3BjaV9wYXJzZV9jb25maWcoc3RydWN0IHRjcGNp
ICp0Y3BjaSkgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIHJldHVybiAwOyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj7CoH0gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+
PGRpdj4tc3RydWN0IHRjcGNpICp0Y3BjaV9yZWdpc3Rlcl9wb3J0KHN0cnVjdCBpMmNfY2xpZW50
ICpjbGllbnQsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi0gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IHRjcGNpX3Zl
bmRvcl9kYXRhICp2ZGF0YSkgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48c3BhbiBjbGFzcz0i
Z21haWwtaW0iPjxkaXY+K3N0cnVjdCB0Y3BjaSAqdGNwY2lfcmVnaXN0ZXJfcG9ydChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCB0Y3BjaV9kYXRhICpkYXRhKcKgPC9kaXY+PGRpdj7CoHsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIHN0cnVjdCB0Y3BjaSAqdGNwY2k7IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBpbnQgZXJyOyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+LSDCoCDCoCDC
oCB0Y3BjaSA9IGRldm1fa3phbGxvYygmYW1wO2NsaWVudC0mZ3Q7ZGV2LCBzaXplb2YoKnRjcGNp
KSwgR0ZQX0tFUk5FTCk7IMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgdGNwY2kg
PSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnRjcGNpKSwgR0ZQX0tFUk5FTCk7IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBpZiAoIXRjcGNpKSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PC9zcGFuPjxzcGFuIGNsYXNzPSJn
bWFpbC1pbSI+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gRVJSX1BUUigtRU5P
TUVNKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi0gwqAgwqAgwqAgdGNwY2ktJmd0
O2NsaWVudCA9IGNsaWVudDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+LSDCoCDCoCDCoCB0
Y3BjaS0mZ3Q7ZGV2ID0gJmFtcDtjbGllbnQtJmd0O2RldjsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48L3Nw
YW4+PGRpdj4tIMKgIMKgIMKgIHRjcGNpLSZndDt2ZGF0YSA9IHZkYXRhOyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoMKgPC9kaXY+PHNwYW4gY2xhc3M9ImdtYWlsLWltIj48ZGl2Pi0gwqAgwqAgwqAgdGNwY2kt
Jmd0O3JlZ21hcCA9IGRldm1fcmVnbWFwX2luaXRfaTJjKGNsaWVudCwgJmFtcDt0Y3BjaV9yZWdt
YXBfY29uZmlnKTsgwqAgwqDCoDwvZGl2PjxkaXY+LSDCoCDCoCDCoCBpZiAoSVNfRVJSKHRjcGNp
LSZndDtyZWdtYXApKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2Pjwvc3Bhbj48ZGl2Pi0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcmV0dXJuIEVSUl9DQVNUKHRjcGNpLSZndDtyZWdtYXApOyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PHNwYW4gY2xhc3M9Imdt
YWlsLWltIj48ZGl2PisgwqAgwqAgwqAgdGNwY2ktJmd0O2RldiA9IGRldjsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCB0Y3BjaS0mZ3Q7ZGF0YSA9IGRhdGE7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgdGNwY2ktJmd0O3Jl
Z21hcCA9IGRhdGEtJmd0O3JlZ21hcDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2Pjxk
aXY+wqAgwqAgwqAgwqAgdGNwY2ktJmd0O3RjcGMuaW5pdCA9IHRjcGNpX2luaXQ7IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9k
aXY+PGRpdj7CoCDCoCDCoCDCoCB0Y3BjaS0mZ3Q7dGNwYy5nZXRfdmJ1cyA9IHRjcGNpX2dldF92
YnVzOzwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+PC9kaXY+PC9zcGFuPjxkaXY+QEAgLTUxNiwxMyArNTEwLDYgQEAgc3RydWN0IHRjcGNpICp0
Y3BjaV9yZWdpc3Rlcl9wb3J0KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsPC9kaXY+PHNwYW4g
Y2xhc3M9ImdtYWlsLWltIj48ZGl2PsKgIMKgIMKgIMKgIC8qIERpc2FibGUgY2hpcCBpbnRlcnJ1
cHRzICovIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIHRjcGNpX3dyaXRlMTYodGNwY2ks
IFRDUENfQUxFUlRfTUFTSywgMCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi0gwqAgwqAgwqAgZXJyID0g
ZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycSg8d2JyPnRjcGNpLSZndDtkZXYsIGNsaWVudC0mZ3Q7
aXJxLCBOVUxMLCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+LSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0Y3BjaV9pcnEsIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PC9zcGFuPjxkaXY+LSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJ
UlFGX09ORVNIT1QgfCBJUlFGX1RSSUdHRVJfTE9XLCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+LSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBk
ZXZfbmFtZSh0Y3BjaS0mZ3Q7ZGV2KSwgdGNwY2kpOyDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRp
dj4tIMKgIMKgIMKgIGlmIChlcnIgJmx0OyAwKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDwvZGl2PjxkaXY+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gRVJSX1BUUihlcnIp
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDwvZGl2PjxzcGFuIGNsYXNzPSJnbWFpbC1pbSI+PGRpdj4tIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIHRjcGNpLSZndDtwb3J0ID0gdGNwbV9yZWdpc3Rlcl9wb3J0KHRjcGNp
LSZndDtkZXYsICZhbXA7dGNwY2ktJmd0O3RjcGMpOyDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+
PC9zcGFuPjxkaXY+wqAgwqAgwqAgwqAgaWYgKFBUUl9FUlJfT1JfWkVSTyh0Y3BjaS0mZ3Q7cG9y
dCkpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBFUlJfQ0FTVCh0
Y3BjaS0mZ3Q7cG9ydCk7PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoMKgPGJyPjwvZGl2PjxkaXY+QEAgLTU0MSwxMSArNTI4LDI4IEBAIHN0YXRpYyBpbnQg
dGNwY2lfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgwqAgwqAgwqAgwqDCoDwvZGl2
PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgaTJj
X2RldmljZV9pZCAqaTJjX2lkKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2
PjxkaXY+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBzdHJ1Y3QgdGNwY2kgKnRjcGNpOyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+PHNwYW4gY2xhc3M9ImdtYWlsLWltIj48ZGl2
PisgwqAgwqAgwqAgc3RydWN0IHRjcGNpX2RhdGEgKmRhdGE7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+
PGRpdj4rIMKgIMKgIMKgIGludCBlcnI7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgZGF0YSA9IGRldm1f
a3phbGxvYygmYW1wO2NsaWVudC0mZ3Q7ZGV2LCBzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsg
wqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCBpZiAoIWRhdGEpIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJldHVybiAtRU5PTUVNOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9k
aXY+PC9zcGFuPjxkaXY+LSDCoCDCoCDCoCB0Y3BjaSA9IHRjcGNpX3JlZ2lzdGVyX3BvcnQoY2xp
ZW50LCBOVUxMKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
L2Rpdj48c3BhbiBjbGFzcz0iZ21haWwtaW0iPjxkaXY+KyDCoCDCoCDCoCBkYXRhLSZndDtyZWdt
YXAgPSBkZXZtX3JlZ21hcF9pbml0X2kyYyhjbGllbnQsICZhbXA7dGNwY2lfcmVnbWFwX2NvbmZp
Zyk7IMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIGlmIChJU19FUlIoZGF0YS0mZ3Q7cmVn
bWFwKSkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm4gUFRSX0VSUihkYXRhLSZndDtyZWdtYXApOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAg
wqAgwqAgdGNwY2kgPSB0Y3BjaV9yZWdpc3Rlcl9wb3J0KCZhbXA7Y2xpZW50LSZndDs8d2JyPmRl
diwgZGF0YSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PC9zcGFu
PjxkaXY+wqAgwqAgwqAgwqAgaWYgKFBUUl9FUlJfT1JfWkVSTyh0Y3BjaSkpIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8
L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBQVFJfRVJSKHRjcGNpKTsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8L2Rpdj48c3BhbiBjbGFzcz0iZ21haWwtaW0iPjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+
KyDCoCDCoCDCoCBlcnIgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKCZhbXA7PHdicj5jbGll
bnQtJmd0O2RldiwgY2xpZW50LSZndDtpcnEsIE5VTEwsIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4r
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IF90Y3BjaV9pcnEsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8
L2Rpdj48L3NwYW4+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIElSUUZfT05FU0hPVCB8IElSUUZfVFJJR0dFUl9MT1csIMKgIMKg
IMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGRldl9uYW1lKHRjcGNpLSZndDtkZXYpLCB0Y3BjaSk7IMKgIMKg
IMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgaWYgKGVyciAmbHQ7IDApIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJldHVybiBlcnI7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2
PjxkaXY+wqAgwqAgwqAgwqAgaTJjX3NldF9jbGllbnRkYXRhKGNsaWVudCwgdGNwY2kpOyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2
PjxzcGFuIGNsYXNzPSJnbWFpbC1pbSI+PGRpdj7CoCDCoCDCoCDCoCByZXR1cm4gMDsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+wqB9PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj48ZGl2PlJlbW92ZSBpMmNfY2xpZW50IGZyb20gdGNwY2k8L2Rpdj48ZGl2
Pk1vdmUgcmVnbWFwX2luaXQgJmFtcDsgcmVxdWVzdF90aHJlYWRlZF9pcnEgdG8gdGhlIGdsdWUg
ZHJpdmVyPC9kaXY+PGRpdj5Ob3RlOiByZXF1ZXN0X3RocmVhZGVkX2lycSBtYXkgbmVlZCB0byBi
ZSBkb25lIGVhcmxpZXIsIHByaW9yIHRvIHRjcGNpX3JlZ2lzdGVyX3BvcnQuIFRoaXMgaXMgc3Rp
bGwgdW5kZXIgZGlzY3Vzc2lvbi48L2Rpdj48ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08L2Rpdj48L2Rpdj48ZGl2PsKgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
L2Rpdj48ZGl2PmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvdHlwZWMvdGNwY2kuPHdicj5o
IGIvZHJpdmVycy9zdGFnaW5nL3R5cGVjL3RjcGNpLjx3YnI+aCDCoCDCoCDCoDwvZGl2Pjwvc3Bh
bj48ZGl2PmluZGV4IGIxZmNiNGEuLmM4Mzg3MjMgMTAwNjQ0IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8
L2Rpdj48ZGl2Pi0tLSBhL2RyaXZlcnMvc3RhZ2luZy90eXBlYy90Y3BjaS48d2JyPmggwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqDCoDwvZGl2PjxkaXY+KysrIGIvZHJpdmVycy9zdGFnaW5nL3R5cGVjL3RjcGNpLjx3YnI+aCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoMKgPC9kaXY+PGRpdj5AQCAtMTIzLDE3ICsxMjMsMTUgQEAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+wqAjZGVmaW5lIFRDUENfVkJVU19WT0xUQUdFX0FM
QVJNX0xPX0NGRyDCoCDCoCDCoCDCoCAweDc4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPC9kaXY+PC9kaXY+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHgi
PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
L2Rpdj48ZGl2PsKgc3RydWN0IHRjcGNpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDwvZGl2PjxkaXY+LXN0cnVjdCB0Y3BjaV92ZW5kb3JfZGF0YSB7IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi0gwqAgwqAgwqAgaW50ICgqaW5pdCkoc3RydWN0IHRj
cGNpICp0Y3BjaSwgc3RydWN0IHRjcGNpX3ZlbmRvcl9kYXRhICpkYXRhKTsgwqAgwqAgwqDCoDwv
ZGl2PjxkaXY+LSDCoCDCoCDCoCBpbnQgKCppcnFfaGFuZGxlcikoc3RydWN0IHRjcGNpICp0Y3Bj
aSwgc3RydWN0IHRjcGNpX3ZlbmRvcl9kYXRhICpkYXRhLMKgPC9kaXY+PGRpdj4tIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdTE2ICpzdGF0dXMpOyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxzcGFu
IGNsYXNzPSJnbWFpbC1pbSI+PGRpdj4rc3RydWN0IHRjcGNpX2RhdGEgeyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+KyDCoCDCoCDCoCBzdHJ1Y3QgcmVnbWFwICpy
ZWdtYXA7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rIMKgIMKgIMKgIGludCAoKmluaXQp
KHN0cnVjdCB0Y3BjaSAqdGNwY2ksIHN0cnVjdCB0Y3BjaV9kYXRhICpkYXRhKTsgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgaW50ICgqc2V0X3Zjb25uKShzdHJ1Y3Qg
dGNwY2kgKnRjcGNpLCBzdHJ1Y3QgdGNwY2lfZGF0YSAqZGF0YSwgwqAgwqAgwqAgwqAgwqA8L2Rp
dj48ZGl2PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sIGVuYWJsZSk7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPC9kaXY+PC9zcGFuPjxkaXY+wqB9OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRp
dj4taW50IHRjcGNpX3JlYWQxNihzdHJ1Y3QgdGNwY2kgKnRjcGNpLCB1bnNpZ25lZCBpbnQgcmVn
LCB1MTYgKnZhbCk7IMKgIMKgIMKgIMKgIMKgIMKgwqA8L2Rpdj48ZGl2Pi1pbnQgdGNwY2lfd3Jp
dGUxNihzdHJ1Y3QgdGNwY2kgKnRjcGNpLCB1bnNpZ25lZCBpbnQgcmVnLCB1MTYgdmFsKTsgwqAg
wqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+LWludCB0Y3BjaV9yZWFkOChzdHJ1Y3QgdGNwY2kg
KnRjcGNpLCB1bnNpZ25lZCBpbnQgcmVnLCB1OCAqdmFsKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqDC
oDwvZGl2PjxkaXY+LWludCB0Y3BjaV93cml0ZTgoc3RydWN0IHRjcGNpICp0Y3BjaSwgdW5zaWdu
ZWQgaW50IHJlZywgdTggdmFsKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+LXN0
cnVjdCB0Y3BjaSAqdGNwY2lfcmVnaXN0ZXJfcG9ydChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4tIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCB0Y3BjaV92ZW5kb3JfZGF0
YSAqZGF0YSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj4rc3RydWN0IHRjcGNpICp0
Y3BjaV9yZWdpc3Rlcl9wb3J0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHRjcGNpX2RhdGEg
KmRhdGEpOzwvZGl2PjxzcGFuIGNsYXNzPSJnbWFpbC1pbSI+PGRpdj7CoHZvaWQgdGNwY2lfdW5y
ZWdpc3Rlcl9wb3J0KHN0cnVjdCB0Y3BjaSAqdGNwY2kpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj4raW50IHRjcGNpX2lycShzdHJ1Y3Qg
dGNwY2kgKnRjcGNpKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8L2Rpdj48ZGl2PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvZGl2PjxkaXY+wqAjZW5k
aWYgLyogX19MSU5VWF9VU0JfVENQQ0lfSCAqLzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TW9k
aWZ5IHN0cnVjdHVyZSBvZiB0Y3BjaV92ZW5kb3JfZGF0YSB0byB0Y3BjaV9kYXRhPC9kaXY+PGRp
dj5Pbmx5IGRlY2xhcmUgdGNwY2lfcmVnaXN0ZXJfcG9ydCAmYW1wOyB0Y3BjaV91bnJlZ2lzdGVy
X3BvcnQgJmFtcDsgdGNwY2lfaXJxIGluIGhlYWRlciBmaWxlPC9kaXY+PGRpdj49PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqDCoDwvZGl2Pjwvc3Bhbj48L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE4LTAyLTE0
IDIzOjM3IEdNVCswODowMCBHcmVnIEtIIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFp
bHRvOmdyZWdAa3JvYWguY29tIiB0YXJnZXQ9Il9ibGFuayI+Z3JlZ0Brcm9haC5jb208L2E+Jmd0
Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PjxzcGFuIGNsYXNzPSIiPk9uIFdlZCwgRmViIDE0LCAyMDE4IGF0IDEwOjQzOjQ1UE0gKzA4MDAs
IOadjuabuOW4hiB3cm90ZTo8YnI+DQomZ3Q7IEhpIEdlcmcsPGJyPg0KJmd0Ozxicj4NCiZndDs8
YnI+DQomZ3Q7IFdoYXQgY2hhbmdlZCBmcm9tIHYxPzxicj4NCiZndDs8YnI+DQomZ3Q7IFRoZSBk
aWZmIGJldHdlZW4gdjEgYW5kIHYyIGlzIGFzIGZvbGxvd2luZzo8YnI+DQo8YnI+DQo8L3NwYW4+
Jmx0O3NuaXAmZ3Q7PGJyPg0KPGJyPg0KWW91IG5lZWQgdG8gZXhwbGFpbiB3aGF0IGNoYW5nZWQg
YmVsb3cgdGhlIC0tLSBsaW5lLCBhcyBpcyBkZXNjcmliZWQgaW48YnI+DQpEb2N1bWVudGF0aW9u
Lzx3YnI+U3VibWl0dGluZ1BhdGNoZXMuPGJyPg0KPGJyPg0KUGxlYXNlIGZpeCB0aGF0IHVwLCBh
bmQgdGhlIHRleHQgZm9yIHlvdXIgbmFtZSwgd2hlbiB5b3UgcmVzZW5kPGJyPg0KdmVyc2lvbiAz
IG9mIHRoaXMgcGF0Y2guPGJyPg0KPGJyPg0KdGhhbmtzLDxicj4NCjxicj4NCmdyZWcgay1oPGJy
Pg0KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGRpdj48YnI+PC9kaXY+
LS0gPGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWls
X3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+QmVzdCBSZWdhcmRzLDxkaXY+5pu45biGPC9kaXY+
PC9kaXY+PC9kaXY+DQo8L2Rpdj4NCg==
--001a113fd4b4f0194a05652ef8d5--
