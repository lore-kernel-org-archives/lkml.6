Return-Path: <hns@goldelico.com>
X-Google-Smtp-Source: AB8JxZo9R3b7tiCFLslPlJdAILKVY6NNleJWffFQx4UZZ2ZLFAbPaQGKX3l1KzIyNquspQ3BF/d7
ARC-Seal: i=1; a=rsa-sha256; t=1525435459; cv=none;
        d=google.com; s=arc-20160816;
        b=hUM8NlehzhKVJA/FR728vUCF+wWwVm3amppAlF9uKv5XENidwjXGB4jbuogyL7Vj3S
         NN4CuGRtbNIqNxFRzyX+Y74oH8pRgWpuxcIRZmB0gPIXVdxZL1Adx6kTc6Bf/pj5S0fe
         3o5ziY5bFxsrbd5FAnZzyr8pFqUAh9sMLnRzMEf5Vq8g/PK9t+13YNlo1FoqD3Sk3l9p
         Vq3lguCh6/q2Reu0nn1Wf5jfUXPrNPoLyQFM4NE+7B3IlFFN4WXc5Oq0jOTDwPbplSsj
         RVECWG3y++zOmGrCiYJ+RRCN8GwhbTUVI1f5PJ7IqjXdPvH3a5IBfQPynJRyyBzWTnJE
         tmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=Mx2mIqoNtfVm0FXmDOvXdi5ld33SamGjRjXIi1UNKrM=;
        b=vyWmSPg8dhm+eIhz3Q/mvI3uidzx7+/y9sVDIxb9YVd3us2socrM4uCJkw6UfffNbW
         NGswSXAAqdMWEGWhbb8+fpiK5OK+lTx3t5voabLHNwHuXjrKvo9/nCkxoO6MIRKT0u29
         Aj64pKYL18sQAQTC85jZN+md4PRKE44P/DmUE2IhO1q+oDBQ4SqZQxik/2bj0ahXIjyh
         EVnp/lhXkvPOCsy4TE2BxQimgwKjFXJ59tp2Cu+vvZPw8agCgHyLC7gNWX37MDgtBk37
         XSXPzosoLQGqmh7FeTR/F2h4JcY70z2L3ZP1gVbZUyF4/88ywwRFj3aMbd1SAQPE2vZ8
         xYlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=GjWy8ljY;
       spf=neutral (google.com: 2a01:238:20a:202:5301::6 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=GjWy8ljY;
       spf=neutral (google.com: 2a01:238:20a:202:5301::6 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN9EVM="
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180504114213.3xlzqxe74n55tk5s@earth.universe>
Date: Fri, 4 May 2018 14:04:15 +0200
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Johan Hovold <johan@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Pavel Machek <pavel@ucw.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC3D0AF4-66EB-48A9-8E81-EC78DE43E105@goldelico.com>
References: <20180424163458.11947-1-johan@kernel.org> <20180424163458.11947-5-johan@kernel.org> <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com> <20180426091018.GU4615@localhost> <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com> <20180502081637.GE2285@localhost> <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com> <20180503205037.7be552c1@aktux> <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com> <20180504114213.3xlzqxe74n55tk5s@earth.universe>
To: Sebastian Reichel <sre@kernel.org>
X-Mailer: Apple Mail (2.3124)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599535012357075905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sebastian,

> Am 04.05.2018 um 13:42 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
> [+cc Tony]
>=20
> Hi,
>=20
>> I think it does not need much more (if at all) than a gpio controller =
on
>> the OMAP3 chip (I think the clocks are active anyways for use by the =
other
>> UARTs).
>>=20
>> We had proposed years ago to reprogram the UART RX pin by =
pinmux-states
>> into an interrupt gpio but that was rejected because it was not =
general
>> enough and ugly in the device tree (an rx-gpios record where the =
rx-line
>> is already connected to the UART-rx).
>>=20
>> Then we did experiment with tapping the UART driver and finally the
>> serdev API was developed to solve this problem. Hence we use it now =
this
>> way.
>=20
> Having any UART active on OMAP results in the SoC not entering
> idle/off wasting energy. For normal (i.e. not connected to a =
peripheral)
> TTYs you can enable runtime autosuspend and configure the RX pin as
> wakeup interrupt. This will wakeup the TTY on incoming traffic, but =
you
> will lose the first few characters (since the serial device needs some
> time to wakeup). This is for example supported by the N900 uart3
> (debug uart):
>=20
> $ grep -A4 "&uart3 {" arch/arm/boot/dts/omap3-n900.dts=20
> &uart3 {
> 	interrupts-extended =3D <&intc 74 &omap3_pmx_core =
OMAP3_UART3_RX>;
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&uart3_pins>;
> };
>=20
> To get it working, you also need to enable autosuspend for the tty
> in userspace (echo 3000 =
/sys/class/tty/ttyS2/device/power/autosuspend_delay_ms).
> This is not enabled by default due to the character loss =
characteristic
> during wakeup.
>=20
> Having said all of this, serdev does not yet support runtime PM (at
> all). Tony is currently looking into it. Fortunately serdev allows
> us to enable runtime PM by default (once implemented), since we know
> the remote side and can (hopefully) avoid losing characters (i.e.
> with sideband wakeup gpios).

thanks for explaining this! We originally had similar thoughts when
proposing a w2sg0004 driver for the first time (years ago), but we can
not accept loosing characters...

Now, I could imagine a potential solution. The key situation why we keep
the serdev open and listening is if the driver did try to turn the =
module
off, but in fact did turn it on (because it was not in sync).

It should be possible to cover this by a timer that is started
in this case. If there is serdev data received after assuming the module
is turned off, the driver has detected the wrong case - and can safely
close the serdev until we want to have it powered on again.

If there is no response after turing off, the module power state is =
already
in sync and we can close the serdev as well - after the timeout (let's =
say
30 seconds). Then, the serdev UART can idle. We should open the serdev
and start this timer also in the probe function to catch an initially =
wrong
state.

But I think we should focus on the basics of this driver first. Then it =
can
be optimized later on.

BR and thanks,
Nikolaus
