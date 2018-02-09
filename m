Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AH8x2245uzl1iyKz1aG84iHXXRj/e4HycoY1w5kTvegume6GRRcaHvCpcu+z2gVy2G8SD3sLyyrf
ARC-Seal: i=1; a=rsa-sha256; t=1518192422; cv=none;
        d=google.com; s=arc-20160816;
        b=drsOmV8pc5ckfVvslQj/fcLMMUJ4FQdrNyCcTAoNEc7Ie551g06UggJSR/sTOZ23NK
         ANO5pKd8IwhJtVe0bOeANH7eZGBwdfOOVkhVBMql96HEdhiRkLaMA9U0eJpG5AgHVMNx
         Euzvqx2TeFe7vYfEi/lTjJNpzUH/+qlxsE6MlLoo9CtbPRfJDj485RVCZOyh6ZYn3Tbu
         LySH4wBGQINGuhVI+0YdswEdfoYdSa31iqphXvPwJgC2gHfTKOQb1jW+wz/BdSEPA4KV
         iq1r+9imVsFFzjd4IbMmlzy9wyPwF8IsZB6nvBJQeDrWfBVl0PTK9TVeoD0/lyWohiEk
         j75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=+YhwQd+lCUIL+KsJQnHggEP7nCSNU10+Smzr7bRB+fs=;
        b=iFWkGQtm0iy+OvERO1BSC/fB/y7kDVG7M3KzmbSocOFvSKT0btb/KFZVjWqLYhOmmi
         Dcj7WOiChvVyKV8cP2uFVirASAU85LxfDomhd/Yi3j7uxee8DSdigs1teX8pim3wMpKP
         FGl9ol22vt5zEiaXKgz8GzLPyDMVoGWGoptxaIn9iihnjFzDpMCYAFwTm7mriiygxyy3
         JAq0/zUtnsVUXaJ53dSGOJNTL5ASaLL0oWyWtgsai8srrRlq8j3sEOJdkqXMlPnlhrHV
         c/QyCWvZ4u82AqfNtpCsttMww33Ryiw31/R67HiygoTVfGhZ7uQiiaCmkR9rAcZAUtLs
         jSYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.149 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.149 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRWlGSWpSXmKPExsUSt3Opsa7q8do
  og9/nBS2aF69ns3hzfDqTRdfqnSwWl3fNYbP43HuE0WLRslZmiycLzzBZNC54z2JxeneJxZ/n
  t9gcuDx2zrrL7rFpVSebx7yTgR77565h93i/7yqbx87vDewenzfJBbBHsWbmJeVXJLBmrF7wm
  7VgtlnF84M9bA2MG3S6GLk4hASWMkq8OdPB1MXIycEmYCEx+cQDNhBbRCBLYvLW5UwgRcwCV5
  glpv9uZQFJCAvESMz5t5URoihWYsnfh8wQtpvEoZX9YM0sAioSjya9BKvnFQiQOP/mEjPEtkN
  MElcmfAFLcAqYSRw8fBhsEKOArMSXxtVgg5gFxCVuPZkPdpGEgIDEkj3nmSFsUYmXj/+xQtjy
  Etu//WaHsO0lXt97xwJh60s8evyIEcI2lFg17QBU3Fxi2pZXLBDzdSQW7P7EBmFrSyxb+JoZ4
  lBBiZMzn7BMYBSfheSMWUhaZiFpmYWkZQEjyypG9eLUorLUIl1TvaSizPSMktzEzBxdQwNTvd
  zU4uLE9NScxKRiveT83E2MwIhnAIIdjF/6nQ8xSnIwKYnyrp9VGyXEl5SfUpmRWJwRX1Sak1p
  8iFGGg0NJgtfkGFBOsCg1PbUiLTMHmHpg0hIcPEoivD+OAqV5iwsSc4sz0yFSpxiNOW68eN3G
  zDFt2Zs2ZiGWvPy8VClxXi6QSQIgpRmleXCDYCnxEqOslDAvI9BpQjwFqUW5mSWo8q8YxTkYl
  YR5HUGm8GTmlcDtewV0ChPQKXcdwE4pSURISTUwrnh4Uce7WczMofVYzjpDwylK1gXZpWx7L3
  PwOL7d19LNtMS0h+vSjQk/L1rI2HSIGDXs39ibbXAvulLkyEmpbo29glOllO1eXvN+JrSW751
  j166LPtfXle69U/q0NmOl0y916+dPJ2d1nExstYr9Ui/9Qocp4EnXMb0Ted8iCq8z9U/qt85V
  YinOSDTUYi4qTgQA6YLaAIQDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-2.tower-178.messagelabs.com!1518192421!108813357!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>
CC: Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede
	<hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva
	<rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Support
 Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 6/7] typec: tcpm: Represent source supply through
 power_supply class
Thread-Topic: [PATCH v4 6/7] typec: tcpm: Represent source supply through
 power_supply class
Thread-Index: AQHTg+F5XO5kK7PtjE+aSt2wVOZO/aOMj+2AgAsl/sCAAtYigIAB6qxg
Date: Fri, 9 Feb 2018 16:06:59 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C203F@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <e2cb104f53e20a01f3b44442068c549e5d0e1ac3.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130131131.GF14922@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1C1595@SW-EX-MBX01.diasemi.com>
 <20180208104517.GA7655@kuha.fi.intel.com>
In-Reply-To: <20180208104517.GA7655@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 09/02/2018 14:12:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588496439487842066?=
X-GMAIL-MSGID: =?utf-8?q?1591940137783986182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08 February 2018 10:45, Heikki Krogerus wrote:

Hi Heikki,

Comments in-line as usual. Bit verbose, and may have stated the obvious in
places, but trying to build a picture and aim for something sensible.

> Hi Adam,
>
> On Tue, Feb 06, 2018 at 03:51:26PM +0000, Adam Thomson wrote:
> > Right now there is no documentation for the generic psy class. The stuf=
f in
> > sysfs-class-power is device specific property information, and the same=
 goes for
> > sysfs-class-power-twl4030. The property usage can vary depending on dri=
ver
> > implementation, an example being the 'online' property which can differ=
 between
> > drivers, so the usage I have here is very much tcpm related. Also, the =
ability
> > to write to certain properties varies depending on the driver and HW, s=
o here
> > where we configure 'voltage_now' and 'current_now', the likelihood is t=
hat most
> > other psy driver implementations won't allow for this.
>
> The power supply class is missing documentation, YES! That is what I
> have been saying! The fact that even an attribute like "online" can
> mean different things depending on the driver is absolutely horrible.
> The ABI documentation FOR THE POWER SUPPLY CLASS needs to provide
> clear meaning for the attributes. It needs to also point out which
> attributes can be hidden, and it should also give some hints for
> things like which attributes can be expected to be visible for example
> in case of USB type of psy and so on.

There is some coverage under Documenation/power/power_supply_class.txt but =
it's
not necessarily extensive, at least not to the level you're suggesting. Wit=
h
regards to the psy class though, I believe this is meant to cover a range o=
f
supply types so I guess the original intention was to make it flexible to c=
over
those. Maybe along the way that's helped muddy the waters somewhat though.

As an example, a 'Battery' type supply would represent say voltage_now
and current_now, and those values would relate to VBAT and IBAT. However a
Charger IC reporting the USB side information (probably of type 'USB', but =
could
be AC, Mains) would report voltage_now and current_now, and those values wo=
uld
represent VIN/VBUS and IIN/IBUS. This example assumes that both sets of HW =
would
be able to provide instantaneous readings. Some only give averaged readings=
.
Just from this you can already start to see why that framework has evolved =
in
the way it has.

Covering the 'online' property, for Charger ICs this would indicate whether
they were externally powered or not (i.e. external charger attached/detache=
d),
so a positive value would indicate external charger presence and 0 would me=
an
not present. In drivers/power/supply/abx500_chargalg.c it goes further with=
 this
and the positive online value can differ based on what kind of charger was
attached (i.e. Mains, USB). Not sure if anything in user-space would behave
differently based on different values though and suspect a positive or 0 va=
lue
will be the only differentiator. For the Battery type scenario 'online', if
provided, is usually a repeat of battery presence information. Examples of =
this
exist although it's really just redundant information, so a guideline would=
 help
to avoid this.

So right now the only sensible method seems to be to describe property usag=
e
based on the main type, which brings me round to what you're suggesting I t=
hink.
I can start something, at least for common USB property usage scenarios, an=
d
maybe Battery as well, but I do think this needs additional attention as th=
ere
are so far 66 (including my new addition) properties to document, some of w=
hich
may require multiple definitions based on type specific usage. With regards=
 to
presence of attributes, that's going to be solely related to HW and what is
implemented for that device, I think. We can give preferred, sunny day exam=
ples,
but I think you'll be hard pressed to make one size fit all. Or do you disa=
gree
with that sentiment?

>
> We are talking about user space ABI for power supplies here. The user
> space does not know that its dealing with tcpm in this case, or some
> other driver in an other case, AND, the user space _must_ not be
> expected to know that kind of details. The behaviour and meaning of an
> individual attribute file quite simply has to be the same, always,
> regardless of the platform, HW, driver or whatever. Otherwise this
> whole ABI is completely useless.

Not technically true as decisions could be based on psy naming. Generic TCP=
M
usage of the power_supply framework would mean the naming of the psy sysfs =
entry
(or entries) are well known, just like using /dev. I believe 'type' though =
is
specifically used in Android to determine which properties it uses for spec=
ific
purposes. Personally I go along with this and think 'type' should be the ma=
jor
determining factor on expectation/usage. User-space needs to know the type =
of
supply it's dealing with to be able to act accordingly.

> To summarize: We can't just accept chaos. Instead we should organize
> the places without structure, in this case the user space ABI for
> power supplies.
>
> On top of ABI documentation, we will need driver API documentation as
> well. I'm not expecting that you would also propose something for the
> API too, but I just wanted to bring that up here. I would like to have
> some guidelines on how the power supplies should be used also in
> kernel.
>
> Right now it is possible for one driver to create the power supply and
> an other to take over the control of it. It is super easy to gain
> access to a power supply. You can request it with just the name
> without any control, and after gaining access, you have full control
> over it. That makes it really easy to have race condition where both
> the psy device driver and some other driver try to control the same
> things of the same psy.
>
> I guess the whole design of the psy class could use a little bit of
> re-designing. So IMO, access to the psy should be more strict then it
> is now, and also, even after gaining access to a psy handle, drivers
> that are not the actual psy device drivers should have more controlled
> access to it. So possibly separate API for them... OK, this is
> definitely a separate topic. Sorry, I'll stop here.

Actually being able to use psy's in other drivers is an approach that's ver=
y
useful, especially for monitoring & controlling charging using PPS. You are
right in that it's very easy to gain access and have control, but have not
personally experienced race issues. I guess that's down to the individual
driver's own locking implementation right now?

Anyway, based on all of this, and assuming I get no major disagreement, I'l=
l
try and come up with something as a decent starting point to better documen=
t
and fix property usage, based on supply type. It won't be every property, b=
ut
hopefully will be a decent first stab at this.
