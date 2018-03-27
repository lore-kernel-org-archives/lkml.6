Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeC0G5r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:57:47 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:47038 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeC0G5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:57:45 -0400
X-AuditID: 0a3aad15-a0bff70000007ca2-c6-5ab9eb693352
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH] Input: add bu21029 touch driver
Thread-Topic: [PATCH] Input: add bu21029 touch driver
Thread-Index: AdPFmLCuuWcHIO+GQ4GRxNEfUInxQQ==
Date: Tue, 27 Mar 2018 06:57:42 +0000
Message-ID: <7ab56efbafd34c11968d8cef2369c6a5@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tb0wbdRjH+fX650CuXAuVhwo4a0gQlBUcoWPqcEZT44uNuJCMaLSMgzZA
        S+4KjsYXsxtsY4wAQoSDFguCEVnGUKDMNpCKhmHYXxM6ggEdUWjdItMikoBeezD6wjeX5/k+
        z+f7PPdcDsfkI7gSNxjNFG3UlavEUcKo3MtJLxj844XqfzuUmu6pGyLNtz0rSONcWMQ09x6t
        izR3r3WJNX1ztwWaWveUJE+iHbQPIq2dnRZqx9mfJNrhgQti7Z/DycdEhVEvFVPlhmqK3v/K
        +1F69199qNKhPNXyxargNFqNq0eROJAH4KzTj+pRFC4n2wXQs+aR8IkLQWfD5xifPEBw5/eP
        xXwyieDLX2axIC8mc+Fc/w+SYBxH7oexzs2QF0Y2YnD+1pYgWIjlhtR6WTHflA0Nkw0iPs6A
        6d/sIVhIpkD3fF1IJ8hDMLloC+mITIKhoZuhYRgZD8O//i3iFyfhMxevA6mA1fvbnI5z8TPQ
        1X6Eb88Ab1urmI/Tod/hx3h7GVzvWBY2IQUb5sqGIWwYwoYhnyLhAFKUUOrqisycA5kZdBHF
        WNSZGSdNFcOI/3oKJ3I4CjyIxJEqmrAsjxfKRbpqpqbCg7JxgUpBWJ7mJGmRqbhGr2P079FV
        5RSjUhIoIiJCHvtYZqqKKgwMYzAZPQhwTBVHlPVxHFGsq7FQtInHPOgpXKiKJxqKPyyUk6U6
        M1VGUZUUvVs9hOMqINp9HCijqVLqVImh3LxbViXxM58Mr4SPFeCRHvQiHs3NPhi0IJhKXQVj
        KN3BE3hcvqvuoTPoKL7uXqrDcOtS8Old8ddhcqHRZKSU8QQd9CKDlL7K+HgbZSKRPscVFGGF
        PUcfmkPcPWOJ1iAczf0we3sA4YztOiGX7Yh7UFYvx5CsFFw3j4PdSsN0y1cIJu7dRXBl+wEG
        9ocDYmBvT0hg3LMh4Toe4XDVejkStr0jBHR7NwjYGNwiwLWyTcBEZ4sUnLYxKaytBaSw2dEW
        AxOXbDHgvz8bA4GmGzEwOmSTQcB6Vgm2NbcSmm8tJMLC1UAyNM6wKdB+xpcCC7UbKfDjd92p
        0Lx9Lg3Ou0bTfdyJBdyJR63O4InNOvP/nHhH3Xs35WnUbEmukj13/efU3oLXDpe05TgOX0zw
        qvd9ksOcyc/6/sKUe75MvZln7v/63conUg++802NMDu3IP+icen59UCkIU/aejIhui/rzYTE
        12U9H9nfPuY+OkJe6R07cfzZO38sl6xey5+f9T18OS3f/Ra6JERNLW8ccSzSWzP7BP80vlof
        98GESsjodZlpGM3o/gMd0JM2yAQAAA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R6vrwd010901

Hello Dmitry,

> > +++ b/drivers/input/touchscreen/bu21029_ts.c
> > @@ -0,0 +1,456 @@
> 
> Please add SPDX tag for the driver.

We will do.

> Please use GPIOD API (and include linux/gpio/consumer.h instead of
> of_gpio.h).

We will do the change.

> > +/* HW_ID1 Register (PAGE=0, ADDR=0x0E, Reset value=0x02, Read only)
> 
> Multi-line comments start with empty comment line:
> 
> /*
>  * Multi
>  * line.
>  */

Will be fixed.

> > +	/* calculate Rz (pressure resistance value) by equation:
> > +	 * Rz = Rx * (x/Q) * ((z2/z1) - 1), where
> > +	 * Rx is x-plate resistance,
> > +	 * Q  is the touch screen resolution (8bit = 256, 12bit = 4096)
> > +	 * x, z1, z2 are the measured positions.
> > +	 */
> > +	rz  = z2 - z1;
> > +	rz *= x;
> > +	rz *= bu21029->x_plate_ohms;
> > +	rz /= z1;
> > +	rz  = DIV_ROUND_CLOSEST(rz, SCALE_12BIT);
> > +	if (rz <= bu21029->max_pressure) {
> > +		input_report_abs(bu21029->in_dev, ABS_X, x);
> > +		input_report_abs(bu21029->in_dev, ABS_Y, y);
> > +		input_report_abs(bu21029->in_dev, ABS_PRESSURE, rz);
> 
> What is the values of pressure reported when finger is touching the
> surface? IOW is 'rz' pressure or resistance?

Rz is pressure measured in Ohms. That is, it is a resistance which
correlates with finger pressure.

I fear that I do not understand your question. Does ABS_PRESSURE have
to be reported in a specific unit, e.g. milli Newton? We thought that
it is a device specific scale and that it will be converted into a
calibrated value (just like the coordinates) in user space.

> > +	if (of_property_read_u32(np, "touchscreen-max-pressure", &val32))
> > +		bu21029->max_pressure = MAX_12BIT;
> > +	else
> > +		bu21029->max_pressure = val32;
> 
> Please use infrastructure form include/linux/input/touchscreen.h
> so that you handle different sizes and orientations.

Thank you for this recommendation. We will check it out and send a new
proposal.

> > +	in_dev->name       = DRIVER_NAME;
> > +	in_dev->id.bustype = BUS_I2C;
> > +	in_dev->dev.parent = &client->dev;
> 
> Not needed with devm_input_allocate_device().

We will have a look at the other drivers.

> > +static int bu21029_remove(struct i2c_client *client)
> > +{
> > +	struct bu21029_ts_data *bu21029 = i2c_get_clientdata(client);
> > +
> > +	del_timer_sync(&bu21029->timer);
> 
> If interrupt comes here kernel will be unhappy. You need to either work
> canceling timer into devm unwid stream (devm_add_action_or_reset()) or
> somehow make sure that you shut off interrupts before canceling the
> timer.

We will work on a solution. Thank you for spotting this.

> 
> > +
> > +	return 0;
> > +}

> > +static struct i2c_driver bu21029_driver = {
> > +	.driver = {
> > +		.name  = DRIVER_NAME,
> > +		.owner = THIS_MODULE,
> 
> Not needed.

OK, we will remove the .owner assignment.

Greetings,
Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118 
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
