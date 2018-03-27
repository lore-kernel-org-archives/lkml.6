Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeC0KCq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:02:46 -0400
Received: from mail-ve1eur01on0074.outbound.protection.outlook.com ([104.47.1.74]:50400
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750978AbeC0KCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:02:44 -0400
From: =?utf-8?B?VmljZW7Fo2l1IEdhbGFub3B1bG8=?=
        <vicentiu.galanopulo@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: RE: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Thread-Topic: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Thread-Index: AQHTwrh12sxKj/IcskaqaXmN5d5/daPjIqcAgACsaWA=
Date: Tue, 27 Mar 2018 10:02:39 +0000
Message-ID: <HE1PR0402MB3578ED389174C370C04F3321EEAC0@HE1PR0402MB3578.eurprd04.prod.outlook.com>
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
 <5726f7e4-49eb-e87e-8548-82fac6aa0452@gmail.com>
In-Reply-To: <5726f7e4-49eb-e87e-8548-82fac6aa0452@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0402MB3482;7:dIiNxZPcy/3ifcgH1DrYEfsyjWOAlHB74210EbjebRDgwoCYyiPftPiENHJrg61ESRqKouW2qLw5OsRIKlQ24h3yv0609gVqmOMIdPppzm85GaAPp8VosHeICysk1+Fuyce4gqhY5CGMJjdOI3wAA5TsS3fHBhE2Ghpg/ESPiENH16k3n4Y1v3aYoVLke9umVfD6HMYCNsNI0U6v37nCrri+vg/fILC461NVEEptFJVyYjDFX9AusYH0WtzdGTCe
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 319ba029-2b26-4b58-6e01-08d593c9e00e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB3482;
x-ms-traffictypediagnostic: HE1PR0402MB3482:
x-microsoft-antispam-prvs: <HE1PR0402MB34826B0A55B26D89EE649056EEAC0@HE1PR0402MB3482.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0402MB3482;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB3482;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(366004)(13464003)(199004)(189003)(7696005)(86362001)(6506007)(54906003)(3660700001)(33656002)(186003)(26005)(2201001)(110136005)(8676002)(8936002)(2906002)(97736004)(68736007)(81156014)(81166006)(14454004)(4326008)(486005)(486005)(102836004)(39060400002)(3846002)(59450400001)(6116002)(53546011)(105586002)(76176011)(99286004)(3280700002)(2501003)(316002)(229853002)(7736002)(66066001)(74316002)(6436002)(305945005)(25786009)(106356001)(85202003)(5660300001)(5250100002)(11346002)(446003)(478600001)(9686003)(6246003)(55016002)(53936002)(85182001)(476003)(2900100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB3482;H:HE1PR0402MB3578.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: CwSHF/VH/uG9wk5H7lSP9Zwo2iDZgoLStWIfuitsmeDStzREZQ6hsqLXp9mXBCom5PzFCTxVzJg6uNqdA+1w/kYK5oT9zQh2BChkZVn2YclFuzNoQBk1uiPoXyd7vSoGaUbPyuVgxtYn//np4uGkZC7jg4D3xHSjBQJ8Jr8SwKKsMAF9boZSDSfoSt0TexvJzgixNneAgksT2cJBfD8jp9hdsgBXzpH4QSGJDVH7koFoRZvDI5DChqKpcLI+7rKTK0+iIDAlM2Y/zDb4QZwiRCZxQ3FWbgPiFj1s4loR7s8HYN5Vd/wcjBU3cCgW2XuVDi3g2d7KAWOs9L4W01yHjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319ba029-2b26-4b58-6e01-08d593c9e00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 10:02:39.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3482
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2RA2vIk031355



> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli@gmail.com]
> Sent: Tuesday, March 27, 2018 1:45 AM
> To: Vicenţiu Galanopulo <vicentiu.galanopulo@nxp.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; davem@davemloft.net; marcel@holtmann.org;
> devicetree@vger.kernel.org
> Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>; Alexandru Marginean
> <alexandru.marginean@nxp.com>
> Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
> and dev-addr code check-up
> 
> On 03/23/2018 08:05 AM, Vicentiu Galanopulo wrote:
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
> 
> Correct me if I am completely misunderstanding  the problem, but have you
> considered doing the following:
> 
> - if all you need to is to replace instances of loops that do:
> 
>         if (phydev->is_c45) {
>                 for (i = 1; i < num_ids; i++) {
>                         if (!(phydev->c45_ids.devices_in_package & (1 <<
> i)))
>                                 continue;
> 
> with one that starts at dev-addr, as specified by Device Tree, then I suspect
> there is an easier way to do what you want rather than your fairly intrusive
> patch to do that:
> 


Sorry for the lengthy comment and sorry if this is redundant, I'm just trying to explain 
best that I can my patch: 
The loop goes through the devices_in_packages, and where it finds a bit that is set, it
continues to get the PHY device ID.
But, to have devices_in_package with those bits set, a previous querying of the 
MDIO_DEVS2 and MDIO_DEVS1 is necessary. And in the MDIO bus query,
dev-addr, from the device tree,  is part of the whole register address:
reg_addr = MII_ADDR_C45 | dev_addr << 16 | MDIO_DEVS2; 

Andrew suggested in his first comment that the device tree lookup could be done
in of_mdiobus_register(),  probably because of the loop which already checks the
<reg> property of the PHY.
My understanding of his comments was that I could propagate, as a parameter,
dev-addr, down the hierarchy call of_mdiobus_register_phy()-> get_phy_device()->
get_phy_id()->get_phy_c45_ids()->get_phy_c45_devs_in_pkg(dev_addr param existed here).
This is where the loop you're mentioning needed some altering, because the loop index is
actually the dev_addr parameter from get_phy_c45_devs_in_pkg(), and it's from 1 to 7 (num_ids = 8)

This worked for the other PHYs which had dev-addr in this range, but it doesn't work for the INPHI,
which has dev_add = 30 (0x1e).
After I did the extension of the  device_ids from 8 to 32 to match 
the devs (u32 *devs = &c45_ids->devices_in_package;)  in get_phy_c45_ids() :
 -	u32 device_ids[8];
 +	u32 device_ids[32];

I realized that dev_addr for other PHY vendors could be larger than 31 (just a coincidence that 
for INPHI is 30 and it fits), and that dev-addr should be a separate parameter, that still 
has to match the bit position from *devs (&c45_ids->devices_in_package) 

So, I didn't had to change the loop to start from dev-addr, just to let it check if the bit is set in *devs (as before), 
and if that bit corresponds to the INPHI PHY (dev-addr has been set in the PHY device tree node), use
dev-addr in getting the PHY ID.

The loop start index has to remain the same because other PHY vendors have dev-addr 1 to 7, and 
PHY discovering succeeds.

For other issues that I had with the above solution (plus Andrew's comment about the SMP), I uploaded 
a v3... probably slightly before you made this comment. Please have look at it, and paste the below 
comments if they still apply. I was not able to match them with my latest patch...

Thanks,
Vicentiu

> - patch of_mdiobus_register_phy() to lookup both the c45 compatible string as
> well as fetch the "dev-addr" property
> 
> - provide a PHY Device Tree node that has its OUI as a compatible string (see
> of_get_phy_id() for details), or if it has a specified 'dev-addr'
> property, use that in lieu of the default get_phy_device() logic
> 
> - pass both to phy_device_create() and eventually introduce a helper function
> that lets you populate the c45_ids structure
> 
> Then for each function that does the loop above, as long as you have a phydev
> reference, you can have phydev->dev_addr = 0x1e be where to start from, if it is
> 0, then start at 1 (like it currently is). If you don't have a phy device reference,
> which would be get_phy_c45_ids() then just make sure you don't call that
> function :)
> 
> >  struct phy_c45_device_ids {
> >  	u32 devices_in_package;
> > -	u32 device_ids[8];
> > +	u32 device_ids[32];
> > +	u32 devices_addrs[32];
> >  };
> 
> This looks like a fix in itself, so it is worth a separate patch.
> --
> Florian
