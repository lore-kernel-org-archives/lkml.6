Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDRJiz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:38:55 -0400
Received: from mail-ve1eur01on0072.outbound.protection.outlook.com ([104.47.1.72]:21216
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751210AbeDRJiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:38:50 -0400
From: =?utf-8?B?VmljZW7Fo2l1IEdhbGFub3B1bG8=?=
        <vicentiu.galanopulo@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>, "robh@kernel.org" <robh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: Alexandru Marginean <alexandru.marginean@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>
Subject: RE: [PATCH net-next 3/3] net: phy: Enable C45 PHYs with vendor
 specific address space
Thread-Topic: [PATCH net-next 3/3] net: phy: Enable C45 PHYs with vendor
 specific address space
Thread-Index: AQHT1irwA9LHpJtrJUa6v4RwLP8kuKQFRycAgADf6hA=
Date: Wed, 18 Apr 2018 09:38:47 +0000
Message-ID: <AM0PR04MB411620E8DB3E7EF8E55C99B5EEB60@AM0PR04MB4116.eurprd04.prod.outlook.com>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
 <20180417090233.21548-4-vicentiu.galanopulo@nxp.com>
 <b62735bd-d411-2d21-16a2-f6cf7e5d7e4d@gmail.com>
In-Reply-To: <b62735bd-d411-2d21-16a2-f6cf7e5d7e4d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.248.107]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4018;7:L6fWn5kIpOB+lyinBdl1amk2Avz2iQzUeTAu0iY8rQ3ba4FwCETcXt+Fi7MIpt1UlF2fqvWblY3/+yrWxseRNJy8t3KnLYBNqD1/1stu6nYDUW4Mwc2oO//SCOX+AtqaaKewqxxRLi6G6MPZSG9KQyr4yIVvTZ6t4HK5/btW3oSsLfqWO0X2Ij408cdJ+z3XPsuwSgGY9DNF+BkUiIxv5g0mPVX80P9pdGsaX7a6lcYIGsG6bkqc0qckfIfCJ2mQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4018;
x-ms-traffictypediagnostic: AM0PR04MB4018:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=nxp.com;
x-microsoft-antispam-prvs: <AM0PR04MB40184C170C7B0B16F1A1A5F8EEB60@AM0PR04MB4018.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501368)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR04MB4018;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4018;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(4326008)(229853002)(14454004)(3280700002)(2501003)(3660700001)(99286004)(25786009)(5250100002)(5660300001)(85182001)(85202003)(3846002)(476003)(81166006)(186003)(11346002)(86362001)(7736002)(305945005)(446003)(74316002)(54906003)(2906002)(26005)(6116002)(66066001)(59450400001)(316002)(39060400002)(6506007)(2900100001)(6436002)(76176011)(7696005)(8936002)(8676002)(33656002)(9686003)(2201001)(102836004)(478600001)(110136005)(55016002)(6246003)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4018;H:AM0PR04MB4116.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: Tg+R3dIxrc1lIuqj/EkKjJM/fxta8wg1+Q9iCm24fBW81iiTF6yWdCI+yV5+1nb9rpQ+AM9NJ3wFjy48uaBMcGq9dQqGzfSdrxbysbYr8WeuygBqp5xBLOB6inQ+srgb1hG+loyRPb6SF+CLJoWYcwPs4l+AB9b7rIi2Av6BR6T/Ltj1ronz7nwEdpT+bM9c
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fbb72579-9426-406c-22ba-08d5a5102f92
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb72579-9426-406c-22ba-08d5a5102f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 09:38:47.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3I9cxAF018051



> > Having dev-addr stored in devices_addrs, in get_phy_c45_ids(), when
> > probing the identifiers, dev-addr can be extracted from devices_addrs
> > and probed if devices_addrs[current_identifier] is not 0.
> 
> I must clearly be missing something, but why are you introducing all these
> conditionals instead of updating the existing code to be able to operate against
> an arbitrary dev-addr value, and then just making sure the first thing you do is
> fetch that property from Device Tree? There is no way someone is going to be
> testing with your specific use case in the future (except yourselves) so unless you
> make supporting an arbitrary "dev-addr" value become part of how the code
> works, this is going to be breaking badly.
>

Hi Florian,

My intention was to have this patch as "plugin" and modify the existing kernel API little to none. I was thinking that with a #ifdef, ideally,  all changes could be part of a CONFIG kernel option.
Updating the existing code, instead of the conditionals, might run into just that, and the change could propagate across multiple modules. This is from my first RFC patch, review by Andrew:
        of_mdiobus_register(), when it loops over the children, looks for 
        the new property. If found, it passed dev-id to of_mdiobus_register_phy().
        That passes it to get_phy_device(). I think get_phy_device() can 
        then set the ID in c45_ids, before passing it to get_phy_id().
        get_phy_c45_ids() will first look at devices in package and can add 
        further devices to c45_ids. It will then probe both those found, and 
        the static
        one you added.
                                                                                              Andrew

        [Vicenţiu Galanopulo]
        Just to make sure I understand. Do you want me to change the signature 
        of all of_mdiobus_register_phy(), get_phy_device(), get_phy_id() and
        get_phy_c45_ids() and include the dev_addr parameter obtained from the 
        device tree?  (a propagation of this parameter across all functions 
        all the way to
        get_phy_c45_devs_in_pkg?) This will impact xgbe-mdio.c, fixed_phy.c 
        because get_phy_device() is used in these files. 

 
 The "catch" is to transport the dev-addr value from of_mdio.c (location of the  loop of the PHY device tree node which reads all PHY node properties) to phy_device.c (this is where you can get the PHY ID).
My understanding from Andrew's comment is that the key here is the c45_ids, and that these could be filled in of_mdio.c, first, with the IDs from dev-addr (he called them "static" as they are queried directly by using the value of dev-addr) and afterwards, in phy_device.c (following the lookup loop - in a "dynamic" way).
There's nothing more to this patch than some functionality from phy_device.c ported to of_mdio.c, to enable the extraction of the PHY IDs. 
I guess the code redundancy could be reduced (between of_mdio.c and phy_device.c) and maybe you or Andrew could comment on this if you would like to go with this patch approach.

Not sure I understand your comment about the specific use case and the breaking badly part.  
Right now I'm able to test because I have access to a PHY with dev-addr = 0x1e. 
But the whole mechanism in this patch starts to work the moment you set <dev-addr> in the device tree. If you don't set that, nothing happens. If you set it to a bogus value, no PHY ID will be found at that address. Besides that, the PHY ID extraction code is the same as what is currently working in phy_device.c. 
80-90% of the patch is based on what already exists in phy_device.c and of_mdio.c. Where is the breaking badly part supposed to happen? 

> And please, can you keep me copied for next submissions?
Yes, the "to" list was pretty long and I somehow missed you. Sorry.
 
Vicentiu
