Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AH8x225sJMiz7mWPGNk0Zp/ETXHlOOn+uSSu8MVXY/OG4S/o/XUyIOZTW3WSVvg7ucgzcBtKEOn3
ARC-Seal: i=1; a=rsa-sha256; t=1518191020; cv=none;
        d=google.com; s=arc-20160816;
        b=pO3XrJXHFMW4nYEwa06SPTKAcmPYghix9h1uYhDAqMG61m/HwFsF/jiV2QF7snVfde
         jJHNXxOn+jszHr7GbX6spmsovqQ9O5SazHtf/33/O3GVVD9NCQDXhvFFc0V3GlmaLxw5
         dL9Il4LYTTUnW87hov7C/vnz2Z0C4Hr9Ymm8/WBAO4CwkYn43qebTiTGPkr39+bLfTP7
         nH6QAc5TwSLLL8sYtK2nKdc3blZ9QNYR0OAwHcOwKCCdh8zp+tbfkRhGozaICWpq1PDK
         i/hWptt7wRDi3itUnx4xNdMy7yJZjvPuyait23NFDWn9acj0bVVrwNyXmmwbL3QzPOnH
         yhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=+ztEYHiCTwV4L+EOCQ6GyhUqnTLVviQWsbGwnP+NJjw=;
        b=G91lDiskHBsJ7nkBCBSM7f82d/BuyM7lkngDDmg/4wFcx22KZQIcDNH17VWfHbZ9k7
         4p0m/malsCRG9NqsiQx6Zu4AAlmj2L7lrnrIGQUXjKWjQsyo2C6zoyQN++CEUTppp5Il
         B8VExyuEqc6zgIByM9HtTy9U5xg1f4PCr3HQxvjmIPO392DTAVQjmPkLfZqhkSVQEG0S
         Cy3o7dQSpiKDxRjxYgLdEtMbFpc9uXn9CNxb4MUXJGamKrO8A7r2ku5rjZ8nKcYfedcz
         tHQlHPd+uqzO0jry9logbULiEm9Zg8JxpUt55VhZv7JKGwsLua70+f9eaa7NvnrYla/U
         bWnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.3 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.3 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRWlGSWpSXmKPExsUSt3Opse6yg7V
  RBs/vy1g0L17PZvHm+HQmi67VO1ksLu+aw2bxufcIo8WiZa3MFk8WnmGyaFzwnsXi9O4Siz/P
  b7E5cHnsnHWX3WPTqk42j3knAz32z13D7vF+31U2j53fG9g9Pm+SC2CPYs3MS8qvSGDNWLj2O
  2tBj0jF9POTWBsY//J3MXJxCAksZZRYs7+ZtYuRk4NNwEJi8okHbCC2iEC0xIQ5h1lAipgFnj
  FL/N+wFiwhLBArsWnHelaIojiJzbtvMkPYbhL7u76A2SwCKhK9vZvBangFAiS2/d3LCrHtPJN
  Ew58HYAlOAVuJY/83MYLYjAKyEl8aV4M1MwuIS9x6Mp8JxJYQEJBYsuc8M4QtKvHy8T9WCFte
  Yvu33+wQtr3E63vvgC7lALL1JfoaiyHChhKrph1ggbDNJW4uf8YKMV5HYsHuT2wQtrbEsoWvm
  SHuFJQ4OfMJywRG8VlIrpiFpGUWkpZZSFoWMLKsYrRMKspMzyjJTczM0TU0MNA1NDTWNdY1Mr
  DUS6zSTdRLLdVNTs0rKUoEyuollhfrFVfmJuek6OWllmxiBKYEBiDYwTjhUOIhRkkOJiVR3vW
  zaqOE+JLyUyozEosz4otKc1KLDzHKcHAoSfDeOwCUEyxKTU+tSMvMASYnmLQEB4+SCK8kSJq3
  uCAxtzgzHSJ1ilGX48aL123MQix5+XmpUuK8r0GKBECKMkrz4EbAEuUlRlkpYV5GoKOEeApSi
  3IzS1DlXzGKczAqCfM+BpnCk5lXArfpFdARTEBH3HUAO6IkESEl1cDIzqIoEVByfr/R+bsL+n
  5/mhl022+mUsZ0p5KzH3UqvhcECRxzuXFPmrlfoZ/zTnvh0Sap1VtW3etcGhvOrhPJ7/oq83K
  b/6HGbxv+Vl9pmxv0w3OzuafS5h6H9BXbT9r0HzS2UD7hIOyjy3J/9rY3VT4rrgV7X96T4pBg
  /6rvTMy7tm/vz4YosRRnJBpqMRcVJwIAGxtBt48DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-40.tower-223.messagelabs.com!1518191007!1458531!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Sebastian Reichel <sre@kernel.org>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hans
 de Goede" <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, "Rui
 Miguel Silva" <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 5/7] power: supply: Add 'connected_type' property and
 supporting code
Thread-Topic: [PATCH v4 5/7] power: supply: Add 'connected_type' property
 and supporting code
Thread-Index: AQHTg+F4XZuNE7krHk+5wBw2HzfVcKObQG8AgADp4ZCAADu9AIAAC10A
Date: Fri, 9 Feb 2018 15:43:26 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C2030@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180208213054.oqgoktru3lzjiyyn@earth.universe>
 <2E89032DDAA8B9408CB92943514A0337014C1C1FDA@SW-EX-MBX01.diasemi.com>
 <20180209150148.624fb4qb34wuml6l@earth.universe>
In-Reply-To: <20180209150148.624fb4qb34wuml6l@earth.universe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 09/02/2018 09:49:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588496437968457675?=
X-GMAIL-MSGID: =?utf-8?q?1591938667150084068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09 February 2018 15:02, Sebastian Reichel wrote:

> Hi,
>=20
> On Fri, Feb 09, 2018 at 11:28:42AM +0000, Adam Thomson wrote:
> > On 08 February 2018 21:31, Sebastian Reichel wrote:
> > > On Tue, Jan 02, 2018 at 03:50:53PM +0000, Adam Thomson wrote:
> > > > This commit adds the 'connected_type' property to represent supplie=
s
> > > > which can report a number of different types of supply based on a
> > > > connection event.
> > > >
> > > > Examples of this already exist in drivers whereby the existing 'typ=
e'
> > > > property is updated, based on an event, to represent what was
> > > > connected (e.g. USB_DCP, USB_ACA, ...). Current implementations
> > > > however don't show all supported connectable types, so this knowled=
ge
> > > > has to be exlicitly known for each driver that supports this.
> > > >
> > > > The 'connected_type' property is intended to fill this void and sho=
w
> > > > users all possible types supported by a driver. The property, when
> > > > read, shows all available types for the driver, and the one current=
ly
> > > > chosen is highlighted/bracketed. It is expected that the 'type'
> > > > property would then just show the top-level type, such as 'USB', an=
d
> > > > this would be static.
> > > >
> > > > Currently the 'conn_type' enum contains all of the USB variant type=
s
> > > > that exist for the 'type' enum at this time, and in addition has
> > > > the PPS type. In the future this can be extended further for other
> > > > types which have multiple connected types supported. The mirroring
> > > > is intentional so as to not impact existing usage of the 'type'
> > > > property.
> > > >
> > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > >
> > > Thanks for the patch. I think, that it's a good idea to provide the
> > > subtype in its own property and just set the type property to "USB".
> > > I would prefer to name this "usb_type". Otherwise
> > >
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > >
> > > -- Sebastian
> >
> > Thanks for your review. I chose 'connected_type' as I thought this woul=
d be more
> > generic in case other main types would have some dynamic connection ele=
ment to
> > them and could also benefit from this. If we don't see that as being so=
mething
> > we want though then I can make this just for USB.
>=20
> If such a thing appears at some point we can add another property.
> I think usb_type is easier to understand from a user point of view
> and it helps to keep our enums clean.

Ok, fair enough. Will update accordingly.
