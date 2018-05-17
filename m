Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeEQUKe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:10:34 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:56884 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQUKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:10:30 -0400
X-AuditID: 0a3aad15-a0bff70000007ca2-cb-5afde1bb223a
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v3] Input: add bu21029 touch driver
Thread-Topic: [PATCH v3] Input: add bu21029 touch driver
Thread-Index: AQHT6TN1hReU6D2Y4UWjnT8atFgViaQtoUiAgAS+JACAACeUgIAB06pg
Date: Thu, 17 May 2018 20:10:27 +0000
Message-ID: <7f0a4cb041354801b732c744ad695495@de.bosch.com>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
 <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
 <CAHp75Vf=eJbJPv5=y3fDKZapAnmABD0=v+WRhrBhMv+RSoBnKg@mail.gmail.com>
 <e514418e94bc4e0492512f7ba24170af@de.bosch.com>
 <20180516174357.GE21971@dtor-ws>
In-Reply-To: <20180516174357.GE21971@dtor-ws>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.73.12]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA21TfUwbZRzm7V3L0XHjuFL5CSviOZONraVslV2GURPJUqMu+8MsGf6hZdxo
        lRbWKwjEOMbQOYZIUAZrCeNruC8dK6jVsK12JHaMOBEWwCETtxnYB34gjIGAd1xZ+4f/XH7v
        8/ye53nf3/segdHdRBxhsTk4u82UwyiUuHLr5xpt19hChr5sQs5OVF1C7LHuH+TspeZxxHpG
        bmDs8N8zcrb/23oFe3ywT8a+f747/AXCeKbhDDI2OP248RvnL+FG96lDCuOUO2GHPEP5bBaX
        Yyng7MnPvak0n/APK/ImVYXfdU6Gl6CPosoRQQBlAFdTQTlSEjRVJ4Na12EkLboQ9Houh5ej
        CGFxH0HD/iSJ8CL4ufIaLhIKaiscbLuy3BRDJcPXrjkk1hh1BIODZVqxVlFbYN5To5B6WFi4
        3orE5BhqG3QOrBdhnHoaRu+WLFuSVBrU7m8KbKJRBudu3lomIigtnJy4sOyDKA20t1/FpKxY
        cP/+QC7WQFHQ2iXhQKlh4uZiAE8EX+mUQurXwVDNp4F6A7Q13cWk4Gi4fPQWXoVinSG2zhCJ
        M0TiDJE0IvwUUu/h9AXWlC2GFJ09k+OL9Sm63blWN5IuVu1BTU07fYgiEBNJtlxfyKDlpgK+
        yOpDzxAyRk1WLs5n0Kszc7OKzCbe/IY9P4fjmTgShYWF0apHMJ+fabXwvCXX5kNAYEwMub1I
        sCKzTEXFnD1XkvlQPIEzsWRF1rsZNJVtcnBvc1weZ19h0wiCAXKt8NDoaDuXzRXuseQ4VmhG
        I2U+FsqExsqICB/aTEQK2Xt/FbP5PJOVt2QH5I9LcnoFDUp70IvEvQ8qKjAat+XauLhYckHU
        U2KnOd/2aAdxa8jkWIFQhxBBlztoEAkzVJEzN4SeSOH/CWYD6VHV76KjA2BQtKlF0FCjq2D0
        j3hoKLWDv7oDwcXhfgQP+8pkcHbxPgb+KbcSZq/1kHDRVb0a5o7WRMF06VfCZ/ZCNExO12lg
        pLU2Ac7NdidAZ/9cAgwc/zERfppreQquOP9cB19UP1gPS6VLG8A/eUAL/0x/r4XxxT6dkOrS
        w+C9Pj182F21GUamew1Qf/Z8Kox7Z1Lh4e0hFipHb7N3hLHKhLEi77w4VofJ8T9jDaDBs8WV
        oNPeDs+/dbj75d2r1m4a1hl27tvxelrxun3b/NOk39GQ+F6jx/TEWM3YMfVk4WelhrSSV8yq
        t3a1ffnk868lkt41M6dtSXN7lwYYK3+YTm3+reOlvzSkC1Rj6fHtC8X12zuGPnm1t38g/UTP
        1ayNs13vpG+0HEpTj4yeHPmYtx2Iao5hcN5sSknC7LzpP45RQBbXBAAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4HKAedK007143

Hello Dmitry,

> > > > +static void bu21029_stop_chip(struct input_dev *dev)
> > > > +{
> > > > +       struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
> > > > +
> > > > +       disable_irq(bu21029->client->irq);
> > > > +       del_timer_sync(&bu21029->timer);
> > > > +
> > > > +       /* put chip into reset */
> > > > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 1);
> > >
> > > > +       udelay(STOP_DELAY_US);
> > >
> > > udelay() ?!
> > >
> > > > +}
> >
> > According to the datasheet disabling the chip will take 30 microseconds.
> > In the defines we added a buffer of 20 microseconds and thus
> > STOP_DELAY_US is 50. The function guarantees that the chip is stopped
> > before it returns.
> >
> > We think that it is ok to use udelay() here because in normal operation
> > the chip is not stopped. It is only stopped when loading or unloading
> > the driver, or when the system suspends.
> >
> > We would like to keep it like it is.
> 
> The issue is not with having delay here, but the kind of delay you are
> using: udelay makes CPU spin for given amount of time; you really want
> msleep() or usleep_range() here.

Understood and changed.

> > > > +static int bu21029_start_chip(struct input_dev *dev)
> > > > +{
> > >
> > > > +       u16 hwid;
> > > > +
> > > > +       /* take chip out of reset */
> > > > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
> > >
> > > > +       mdelay(START_DELAY_MS);
> > >
> > > mdelay()?!
> 
> Same here - replace with msleep().

Replaced.

> > > Instead...
> > >
> > > > +static int bu21029_suspend(struct device *dev)
> > >
> > > ...use __maby_unused annotation.
> > >
> > > > +static int bu21029_resume(struct device *dev)
> > >
> > > Ditto.
> >
> > OK, added.
> 
> You also need to drop #ifdef CONFIG_SLEEP. That's the point: we want to
> reduce amount of conditionally compiled code and use __maybe_unused to
> shut off compiler warning about some functions not used in certain
> configurations. We rely on linker to eliminate dead functions from
> executable.

Done.

Greetings,
Mark

 Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118 
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
