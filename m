Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeEPNY3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:24:29 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:41328 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeEPNY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:24:26 -0400
X-AuditID: 0a3aad16-be7ff70000000413-5f-5afc31062677
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v3] Input: add bu21029 touch driver
Thread-Topic: [PATCH v3] Input: add bu21029 touch driver
Thread-Index: AQHT6TN1hReU6D2Y4UWjnT8atFgViaQtoUiAgAS+JAA=
Date: Wed, 16 May 2018 13:24:24 +0000
Message-ID: <e514418e94bc4e0492512f7ba24170af@de.bosch.com>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
 <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
 <CAHp75Vf=eJbJPv5=y3fDKZapAnmABD0=v+WRhrBhMv+RSoBnKg@mail.gmail.com>
In-Reply-To: <CAHp75Vf=eJbJPv5=y3fDKZapAnmABD0=v+WRhrBhMv+RSoBnKg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22TbUxbZRTHeXr7ciFcfLil5VClW+80TueggNMKRBdjTBdJtiVqQk3UMq7Q
        2BbSCwTIPmxTN94kS2GkFALMsc3UvRS2YSVsDIaRlw6mqGMbbrI1E5YRkaWOAaL37sLaD365
        +T//c37nnOc8uSRBD5Ea0mIvYh12s5WRR0mj0k8mbpanLJv0J89mGGYOXkKG1oFRmeHSV9PI
        4Ju8RRiuzf8tM4x3N8sNR6/+KDF8cX5AsZU0nmg5gYwt7kGp8Tv3bwpjp6dSbnzQqd0hM0Vl
        5rJWSwnrSH7946h8f9MUUejJLH1w5ZR8DwqkV6FIEvDLEGhqUVShKJLGLgm0HqsgxEMPgjr/
        XzLxMIvgUXAGCQiNLyJoC64TtBynw4FjIzyuIONwMvSWCOkEbiDg4fxluZCixK/Cku/QYx2H
        DfDPjXYk6nSYWaxSCFqKn4PK7usSQVM4A6brvKt9RxCseC5LhUAk3gkV+4OPCyGcCF7vGCFo
        AsdD592HMvE6GNp7RB+wCmburPA+yWsdNLveFCSBX4DT3ckiqYP66imF2DYWhhoD0oMo3h1W
        1B0i3GGEO4xoQ1IPUnEWfYktVW9ITXLksFy5PiVpV4GtE4nPqvahz/py+xEmERNNJa1bNtEy
        cwlXZutHW0gJo6JqV5ZMdExOQW5ZvpnL/8hRbGU5RkOhiIgIWvnE5opzbBaOsxTY+xGQBBNH
        WSieo3LNZeWso0DE+tHTpJSJpwJb50w0zjMXsZ+ybCHrWItmkCQD1JfJ/AyxDjaPLf3EYi1a
        CzOJYk91eCS8rYSM7EdpZDTf+22hBMUVmm2cJW8VTxBxes0NocNoG3l/f00NQQbGG2oIWmov
        sLOaeGqjUAUL+fnF9idzaJ6hntc8MtGqsECo1j00gfhNKqk0PQ9H8/9QaAKgfMrmbDp21QxB
        qe08g4/T0LLPAYPOMwh6r40jWDo3hcD166IETq/MEjBU75VC44JTBkdO1UXDwi/DFLROLFDQ
        2+SMgdqbh2NgsfHQUxDc18V/Fi7EwuTcjTiY+HpQBT9N3FXBmYl5FfT6vGpwHRlTw8L92kS4
        tXc6EaZdXVq48vO0Fr6p+VMLZ8cXtXBzeG499Hz+uw4mO27roOnCceYev10Jv110UXhZrshc
        9D/bXXVDl9PsQX0bdqRSHxAdV0vby6PHMkD/feW5tq5NaZnn/6jeoL6j25k18O5rudm3PUrn
        W/PeUn9F1jtJWc8e8M85lS7fe/7d8c2N31r/bX0lgaya2j7rWe7Q1vRYN256aXT3tvmEEdP7
        7PU3cEP1D0c/3GvL3jXYtd0/mh6X4NzCBA9X9m2uX9/CSLl8c8qLhIMz/wfoRBtq3AQAAA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GDOZ6T005346

Hello Andy,

> > Add Rohm BU21029 resistive touch panel controller support with I2C
> > interface.
> 
> > +#include <linux/of.h>
> 
> This becomes redundant (see below).

Removed.

> > +#define STOP_DELAY_US  50L
> > +#define START_DELAY_MS 2L
> > +#define BUF_LEN        8L
> 
> No need to use L for such small numbers. Integer promotion is a part
> of C standard.

OK.

> > +#define SCALE_12BIT    (1 << 12)
> > +#define MAX_12BIT      ((1 << 12) - 1)
> 
> BIT(12)
> GENMASK(11, 0)

We are not convinced that we should use BIT() and GENMASK() here.

The reason is that SCALE_12BIT is actually not used as a bit but as an
input value for DIV_ROUND_CLOSEST. We think that the BIT() macro will
hide the meaning of the value.

MAX_12BIT is also a value and not a bit mask. Thus, we also think that
using the GENMASK() macro will hide its purpose. Also, the
documentation of GENMASK() says that it is a mask and not a value.

> > +static int bu21029_touch_report(struct bu21029_ts_data *bu21029)
> > +{
> > +       struct i2c_client *i2c = bu21029->client;
> > +       u8 buf[BUF_LEN];
> > +       int error = bu21029_touch_report(bu21029);
> 
> > +
> 
> Redundant empty line.

Removed.

> > +       if (error) {
> 
> > +               dev_err(&i2c->dev, "failed to report (error: %d)\n", error);
> 
> Potential spamming case.
> 
> > +               return IRQ_NONE;
> > +       }

You are right, we will remove the error message.

> > +static void bu21029_stop_chip(struct input_dev *dev)
> > +{
> > +       struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
> > +
> > +       disable_irq(bu21029->client->irq);
> > +       del_timer_sync(&bu21029->timer);
> > +
> > +       /* put chip into reset */
> > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 1);
> 
> > +       udelay(STOP_DELAY_US);
> 
> udelay() ?!
> 
> > +}

According to the datasheet disabling the chip will take 30 microseconds.
In the defines we added a buffer of 20 microseconds and thus
STOP_DELAY_US is 50. The function guarantees that the chip is stopped
before it returns.

We think that it is ok to use udelay() here because in normal operation
the chip is not stopped. It is only stopped when loading or unloading
the driver, or when the system suspends.

We would like to keep it like it is.

> > +static int bu21029_start_chip(struct input_dev *dev)
> > +{
> 
> > +       u16 hwid;
> > +
> > +       /* take chip out of reset */
> > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
> 
> > +       mdelay(START_DELAY_MS);
> 
> mdelay()?!
> 
> > +
> > +       error = i2c_smbus_read_i2c_block_data(i2c,
> > +                                             BU21029_HWID_REG,
> > +                                             2,
> > +                                             (u8 *)&hwid);
> > +       if (error < 0) {
> > +               dev_err(&i2c->dev, "failed to read HW ID\n");
> > +               goto out;
> > +       }

After de-asserting the reset chip takes 1 millisecond until it is
operational. We added a 1 millisecond buffer to it. Thus,
START_DELAY_MS is 2.

The following I2C read will not succeed without waiting for the chip
being ready.

> > +       if (cpu_to_be16(hwid) != SUPPORTED_HWID) {
> 
> Hmm... Why cpu_to_be16() is required?
> 
> > +               dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
> > +               error = -ENODEV;
> > +               goto out;
> > +       }
> > +}

You are right, it works but what we meant to do here is to convert the
chip's value (big endian) into the CPU endianness. We will change it to
be16_to_cpu().

> > +static int bu21029_parse_dt(struct bu21029_ts_data *bu21029)
> 
> You can get rid of DT requirement by...
> 
> > +{
> > +       struct device *dev = &bu21029->client->dev;
> > +       struct device_node *np = dev->of_node;
> > +       u32 val32;
> > +       int error;
> 
> > +       if (!np) {
> > +               dev_err(dev, "no device tree data\n");
> > +               return -EINVAL;
> > +       }
> 
> (this becomes redundant)
> 
> > +
> > +       bu21029->reset_gpios = devm_gpiod_get(dev, "reset",
> GPIOD_OUT_HIGH);
> > +       if (IS_ERR(bu21029->reset_gpios)) {
> > +               error = PTR_ERR(bu21029->reset_gpios);
> > +               if (error != -EPROBE_DEFER)
> > +                       dev_err(dev, "invalid 'reset-gpios':%d\n", error);
> > +               return error;
> > +       }
> > +
> 
> > +       if (of_property_read_u32(np, "rohm,x-plate-ohms", &val32)) {
> 
> ...simple calling device_property_read_u32() instead.
> 
> > +               dev_err(dev, "invalid 'x-plate-ohms' supplied\n");
> > +               return -EINVAL;
> > +       }
> > +       bu21029->x_plate_ohms = val32;
> > +
> > +       touchscreen_parse_properties(bu21029->in_dev, false, &bu21029->prop);
> > +
> > +       return 0;
> > +}

Thank you, changed.

> > +#ifdef CONFIG_PM_SLEEP
> 
> Instead...
> 
> > +static int bu21029_suspend(struct device *dev)
> 
> ...use __maby_unused annotation.
> 
> > +static int bu21029_resume(struct device *dev)
> 
> Ditto.

OK, added.

Regards,
Mark

 Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118 
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster 
