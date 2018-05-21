Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AB8JxZoFKORgn5SmSoCu3Vs6l63HxoRthHoOsoEwjg8ZAZB1iF9nRHiUvHsJ79M4v+Zqrz/3Kcg9
ARC-Seal: i=1; a=rsa-sha256; t=1526916895; cv=none;
        d=google.com; s=arc-20160816;
        b=NZmKRKAXDUHs6pfmRW7BRwL7ykL6vQ9U6BFKP4PPjrqsVccAfagmWBEM4j1Ik6oy/F
         xKff5uXII/V4VK1CRlmeMtT8GgSDQ29DlWnClwkJmpeCRU+E56/aQ3Pd0SDWRg2sxxqV
         dBNIbgBRfRe3fq+e9SGyNaK2XiyqYGJyKf2OwzDyprTiP8c3DjcNA9yWOZjKjz45m5oO
         +z0ASc/k0Npit7o6zj982J4gYx8w193DGt+bh454BbcX8lICjIIyQw/sQfoJ5oi06R7m
         cXGvRF1ldoPs4T76b7J2h09G506ldOIVcQvSpI3LPZq66iaoESeN/IMmKrTOrZPtqPad
         KzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=ToprbB4Y8Gt8jB+3NbqHzBwwo44HQlITPwMVdO4IzR8=;
        b=OAJ41dUc41Xmdh8nDbsJgnuEVJ+g89Enh5fSA+tFMWovFJVRXJNafn7X46SE311cXN
         5HnyEwPqm5fp+GFx3jXFa3ygdehK3640YsCI9RNMzAwROsl6rkGQrewCtR85C2OkPFm6
         7dNmoPuJbCE4U2IqfaN3LLMtnO8PspF9VhS6K4dtcKdnl593X3R0PbkjRVLDav9BlGj1
         OBVijoj56CFUBBDzwzo7+OuFDQw1XlivsY6z7KW8qH+5oaKAskBo6wjgXk5/5ZAx22td
         xkmtuga7cU+UYEiwd+lN635LMai5NF443USEDTQJn/ZgEkFtXZFMh0fFLmT8959Bkd1x
         BANw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.230.132 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.230.132 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRWlGSWpSXmKPExsUSt3Opsa7cc6Z
  og9WfNCyaF69ns+havZPF4vKuOWwWi5a1Mls8WXiGyYHVY97JQI/9c9ewe+z83sDu8XmTXABL
  FGtmXlJ+RQJrxo7n29gL1klWLHp+lbWBcYlIFyMXh5DAUkaJf3O+sHYxcnKwCVhITD7xgA3EF
  hHIkpi8dTkTSBGzQAeTxIxN3WBFwgI+Ejffv2GEKPKVWPblM1SDm8Thk43MIDaLgKrEzc0fwO
  p5BQIkri3pYoPYdo9R4v7zf2AJTgFzie/T94E1MwrISnxpXA3WzCwgLnHryXwmEFtCQEBiyZ7
  zzBC2qMTLxxC9EgLyEtu//WaHsO0lXt97x9LFyAFk60v0NRZDhA0lVk07wAJhm0v8fPgMaryO
  xILdn9ggbG2JZQtfM0PcKShxcuYTlgmM4rOQXDELScssJC2zkLQsYGRZxWiRVJSZnlGSm5iZo
  2toYKBraGika2RgqGtkaqqXWKWbrJdaqlueWlyia6iXWF6sV1yZm5yTopeXWrKJERjDDECwg/
  HRt+RDjJIcTEqivP8KmaKF+JLyUyozEosz4otKc1KLDzHKcHAoSfAWPQPKCRalpqdWpGXmAJM
  JTFqCg0dJhHcHSJq3uCAxtzgzHSJ1ilFRSpzXDSQhAJLIKM2Da4MlsEuMslLCvIxAhwjxFKQW
  5WaWoMq/YhTnYFQS5u0AmcKTmVcCN/0V0GImoMUdh/5HAS0uSURISTUwOhTt/jVp6s8VGUfXb
  FFOV1EreL7Diotv5mUODnt/1jd+N/Puple9zT/603P6v3UMvk+s3OYdNxGqPMCimRikXa9xSj
  AoQmtehM2rk+Wv/b4s//9kWWD/g4fLzzeUV/V5zHHzyNE2ubr/n+uLpsSUl5F/5Woq9gYtnL/
  IbZKPQ00NU5FcShSnEktxRqKhFnNRcSIA/hYdElsDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-2.tower-308.messagelabs.com!1526916894!174862!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>
CC: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: RE: [PATCH] typec: tcpm: Provide of_node pointer as part of psy_cfg
Thread-Topic: [PATCH] typec: tcpm: Provide of_node pointer as part of psy_cfg
Thread-Index: AQHT7S8N3gxz/LUPbUW6fTotsuqmzaQ6IcgAgAAZMQCAAAFvAIAAGveA
Date: Mon, 21 May 2018 15:34:53 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1EE1C1@SW-EX-MBX01.diasemi.com>
References: <20180516160046.18FCF3FAD3@swsrvapps-01.diasemi.com>
 <20180521132016.GC10677@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1EE0EE@SW-EX-MBX01.diasemi.com>
 <20180521145534.GD10677@kuha.fi.intel.com>
In-Reply-To: <20180521145534.GD10677@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 21/05/2018 11:59:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600637056826731223?=
X-GMAIL-MSGID: =?utf-8?q?1601088410554048904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21 May 2018 15:56, Heikki Krogerus wrote:

> On Mon, May 21, 2018 at 01:58:16PM +0000, Adam Thomson wrote:
> > Hi Heikki,
> >
> > On 21 May 2018 14:20, Heikki Krogerus wrote:
> >
> > > On Wed, May 16, 2018 at 05:00:46PM +0100, Adam Thomson wrote:
> > > > For supply registration, provide of_node pointer of the port device=
,
> > > > via the power_supply_config structure, to allow other psy drivers
> > > > to add us as a supplier using the 'power-supplies' DT property.
> > > >
> > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > > ---
> > > >  drivers/usb/typec/tcpm.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > > > index 72996cc..e7c0b95 100644
> > > > --- a/drivers/usb/typec/tcpm.c
> > > > +++ b/drivers/usb/typec/tcpm.c
> > > > @@ -4500,6 +4500,7 @@ static int devm_tcpm_psy_register(struct tcpm=
_port
> > > *port)
> > > >  	char *psy_name;
> > > >
> > > >  	psy_cfg.drv_data =3D port;
> > > > +	psy_cfg.of_node =3D port->dev->of_node;
> > > >  	psy_name =3D devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
> > > >  	if (!psy_name)
> > > >  		return -ENOMEM;
> > >
> > > Would it be possible to use fwnode here instead? It would mean that
> > > you add a member for it to the struct power_supply_config, and handle
> > > it separately in power_supply_core.c. You could just convert it to
> > > of_node there for now.
> > >
> > > That is just a request, I'm fine with this, but it would prepare this
> > > driver for all types of platforms, so less patching would be needed
> > > once we add ACPI support to the power_supply_core.c.
> >
> > Would the following commit from Hans, already present in power_supply_c=
ore.c,
> > not fit the bill:
> >
> > [58a36bb06891ee779074db6ef84e98347c634d38]
> > power: supply: core: Add support for supplied-from device-property
> >
> > Or was that just meant as a stop gap for something more?
>=20
> I think the main idea with that patch was that it allows us to take
> advantage of build-in device properties, but I think we could actually
> improve also it if we had the fwnode handle assigned to the psy. We
> would not have to assume the parent has those device properties then.
>=20
> But ACPI actually defines a specific object called _PCL (power
> consumer list) for power source objects that we should one day check
> in power_supply_core.c. That's what I meant by ACPI support.

Ok, fair enough. Makes sense to me. Thanks for clarifying.

> > I have no problems adding something further, but I don't have a means t=
o verify
> > anything ACPI based, beyond a simple build test, so would ideally want =
someone
> > to verify that path through the code.
>=20
> This is not really about ACPI. By using fwnode handle instead of
> of_node, we would continue to keep tcpm.c agnostic about the type of
> hw description.
>=20
> So I don't expect any ACPI support to be added to the
> power_supply_code.c at this point. You can use to_of_node(cfg->fwnode)
> in __power_supply_register() for now:
>=20
>         psy->of_node =3D cfg->of_node;
>         if (cfg->fwnode)
>                 psy->of_node =3D to_of_node(cfg->fwnode);

OK, no problem. Will take a look and add that in.
