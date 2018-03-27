Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeC0IKr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:10:47 -0400
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:5408
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751246AbeC0IKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:10:43 -0400
From: =?iso-8859-2?Q?Vicen=FEiu_Galanopulo?=
        <vicentiu.galanopulo@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: RE: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Thread-Topic: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Thread-Index: AQHTwrh12sxKj/IcskaqaXmN5d5/daPjHSiAgACcozA=
Date: Tue, 27 Mar 2018 08:10:35 +0000
Message-ID: <HE1PR0402MB3578B3D33160EBE59C2FD7D7EEAC0@HE1PR0402MB3578.eurprd04.prod.outlook.com>
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
 <20180326222509.ppt5aqzqdarhm44d@rob-hp-laptop>
In-Reply-To: <20180326222509.ppt5aqzqdarhm44d@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0402MB3322;7:+OQF+aqyZxSIUyM0/vLWBwgM7MM8gRplARhVmGYPpvsfsjsFqK2iUPtlDozKusVSKzpnSXCVQDO0xvoNyl8vZAJ1aZ0XS7ISInJUaXTLrdTd559ueDH8mpF1iCGHMBYVyV40ix5WOgPhoHU7vH1yDCgjX239INEChl8PhYmezIR4kN1s8YpR7hm+3nr8GlMnOl8cf7MXDv5z07Q9pTPG0RG2Sa0R6La+B7z4djWanRvWIuzw7gaK1HpGihZMHjRa
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b935425-8410-4470-3765-08d593ba38fb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB3322;
x-ms-traffictypediagnostic: HE1PR0402MB3322:
x-microsoft-antispam-prvs: <HE1PR0402MB33224A10F7A3340B170E0CC6EEAC0@HE1PR0402MB3322.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0402MB3322;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB3322;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(376002)(346002)(13464003)(189003)(199004)(97736004)(68736007)(59450400001)(76176011)(81156014)(102836004)(81166006)(33656002)(6506007)(6246003)(7696005)(66066001)(2906002)(55016002)(5660300001)(476003)(8676002)(14454004)(53936002)(54906003)(106356001)(105586002)(4326008)(3846002)(2900100001)(6916009)(9686003)(53546011)(478600001)(3660700001)(3280700002)(74316002)(5250100002)(86362001)(25786009)(229853002)(7736002)(26005)(11346002)(186003)(305945005)(316002)(6116002)(6436002)(446003)(99286004)(8936002)(486005)(486005)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB3322;H:HE1PR0402MB3578.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +J3PBj4T6EIkza0GVw2FsDmVLXiBcLGLXTLXLb8pC7Q+RFio2KNM1v4VLwOFwOkdP0B9r+J1zFFjs+h+JRRuPJMqnOtmHuQ/fgydj0oua5Gj4rZzxq4qtSkxVBW//h2UglOxAyfYhrBwNe+Sm74NvwR7IgUq2jpEwR9+4/Sbjpr8CgwQO2aMEEwVnCeUf24DEZbpiXwsecdXF5H8d/OT8Dqx3F7Hyadtr4INf+w2+Mz9smXhLassjaIdA13gtWP84r11IVvZh+FIeFjRx/NRyXWjAoHD3kEZjCsFVupCZekryV1dhEUCuO68XxP3Hs5vCajn9BwYi+KMHWB1ayMRxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b935425-8410-4470-3765-08d593ba38fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 08:10:36.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3322
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R8AtD0023664



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, March 27, 2018 1:25 AM
> To: Vicenþiu Galanopulo <vicentiu.galanopulo@nxp.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> mark.rutland@arm.com; davem@davemloft.net; marcel@holtmann.org;
> devicetree@vger.kernel.org; Madalin-cristian Bucur <madalin.bucur@nxp.com>;
> Alexandru Marginean <alexandru.marginean@nxp.com>
> Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
> and dev-addr code check-up
> 
> On Fri, Mar 23, 2018 at 10:05:22AM -0500, Vicentiu Galanopulo wrote:
> > Reason for this patch is that the Inphi PHY has a vendor specific
> > address space for accessing the
> > C45 MDIO registers - starting from 0x1e.
> >
> > A search of the dev-addr property is done in of_mdiobus_register.
> > If the property is found in the PHY node,
> > of_mdiobus_register_static_phy is called. This is a wrapper function
> > for of_mdiobus_register_phy which finds the device in package based on
> > dev-addr and fills devices_addrs:
> > devices_addrs is a new field added to phy_c45_device_ids.
> > This new field will store the dev-addr property on the same index
> > where the device in package has been found.
> > In order to have dev-addr in get_phy_c45_ids(), mdio_c45_ids is passed
> > from of_mdio.c to phy_device.c as an external variable.
> > In get_phy_device a copy of the mdio_c45_ids is done over the local
> > c45_ids (wich are empty). After the copying, the c45_ids will also
> > contain the static device found from dev-addr.
> > Having dev-addr stored in devices_addrs, in get_phy_c45_ids(), when
> > probing the identifiers, dev-addr can be extracted from devices_addrs
> > and probed if devices_addrs[current_identifier] is not 0.
> > This way changing the kernel API is avoided completely.
> >
> > As a plus to this patch, num_ids in get_phy_c45_ids, has the value 8
> > (ARRAY_SIZE(c45_ids->device_ids)),
> > but the u32 *devs can store 32 devices in the bitfield.
> > If a device is stored in *devs, in bits 32 to 9, it will not be found.
> > This is the reason for changing in phy.h, the size of device_ids
> > array.
> >
> > Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/phy.txt |  6 ++
> 
> Please split bindings to separate patch.

 
Thanks Rob for your comments. I was considering doing that after I reach a more stable, non-RFC version of the patch. I also added a v3, before
your comments, I think... so in the next one, v4, I will split the binding to a separate patch.


> 
> >  drivers/net/phy/phy_device.c                  | 22 +++++-
> >  drivers/of/of_mdio.c                          | 98 ++++++++++++++++++++++++++-
> >  include/linux/phy.h                           |  5 +-
> >  4 files changed, 125 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/phy.txt
> > b/Documentation/devicetree/bindings/net/phy.txt
> > index d2169a5..82692e2 100644
> > --- a/Documentation/devicetree/bindings/net/phy.txt
> > +++ b/Documentation/devicetree/bindings/net/phy.txt
> > @@ -61,6 +61,11 @@ Optional Properties:
> >  - reset-deassert-us: Delay after the reset was deasserted in microseconds.
> >    If this property is missing the delay will be skipped.
> >
> > +- dev-addr: If set, it indicates the device address of the PHY to be
> > +used
> > +  when accessing the C45 PHY registers over MDIO. It is used for
> > +vendor specific
> > +  register space addresses that do no conform to standard address for
> > +the MDIO
> > +  registers (e.g. MMD30)
> 
> This is a 2nd MDIO address, right? Can't you just append this to reg property?
> 
> Rob

Yes, it is a 2nd MDIO address which is coming from the PHY vendor. This address cannot be obtained by querying the MDIO bus, it's specified in the PHY datasheet. The current kernel implementation was relying on the fact that this address is in the decimal 0 to 7 range. That worked for the PHYs which already have a kernel driver, but for the new Inphi PHY, which I'm trying to add, it didn't.  
If I were to append the dev-addr address to the reg property,  I would have to fit two 32bit variable into a single one... in my opinion the code is clearer having the two addresses as distinct variables.... And so far, the comments from Andrew or Florian didn't go in this direction..  

Vicentiu
