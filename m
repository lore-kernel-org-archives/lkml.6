Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeCOJcp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:32:45 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:63104
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751751AbeCOJci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:32:38 -0400
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Camelia Alexandra Groza <camelia.groza@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/5] DPAA Ethernet fixes
Thread-Topic: [PATCH 0/5] DPAA Ethernet fixes
Thread-Index: AQHTu5m2rZZdOwvlR0SivUagXyxizaPQEW6AgAD37kA=
Date: Thu, 15 Mar 2018 09:32:35 +0000
Message-ID: <AM5PR04MB3267BC402A80D9E772BC8903ECD00@AM5PR04MB3267.eurprd04.prod.outlook.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
 <1521052994.4790.148.camel@infinera.com>
In-Reply-To: <1521052994.4790.148.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR04MB3234;7:lUhUGZH5MuxIz+0mOwqD3xXx6T8H06VuM/18aFHfJ0NeFY0T7k2eZFr/d/MuH1BAdT10ZVBGB8z1XE1RVQGXgLA/Y/NAPWI6b+EZw+5pkNOU75RVYG+Eq20CeB9njBk2A0yiR815C/zExsl94FrYnGiyEBAlsljP+cyJdLsiqX+6duLhlp++dR2kDVpvltn2Q1ZkdL3Y8n0ZQCSmJIBAg9LEmk2yJLC5hXFUK3Fn54zjQJuNL0R/LUlhTV+B9mlV
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90070be6-0de2-493c-9bb0-08d58a57afde
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3234;
x-ms-traffictypediagnostic: AM5PR04MB3234:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM5PR04MB3234CC298527AA510E355A94ECD00@AM5PR04MB3234.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501270)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR04MB3234;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3234;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(377424004)(13464003)(478600001)(3280700002)(8936002)(305945005)(105586002)(4326008)(229853002)(66066001)(33656002)(76176011)(7736002)(86362001)(6246003)(74316002)(5660300001)(99286004)(97736004)(316002)(2950100002)(7696005)(14454004)(3660700001)(6116002)(106356001)(9686003)(53936002)(8676002)(6436002)(54906003)(53546011)(59450400001)(3846002)(2900100001)(26005)(110136005)(68736007)(186003)(102836004)(5250100002)(2906002)(81156014)(25786009)(81166006)(2501003)(55016002)(6506007)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3234;H:AM5PR04MB3267.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 5Yo8822pREYsFdyfxgcL+LJ2qUm9GGRr84oWdVZ+p/awyisLMs+QQvFwNGFP3LfWqHMnHvHl9p/bB3DJ9B0DKdOM/OltMG7GqrkfUU/om6AZqNtB1EJUVR9QDf1mqTaFOSNzPAmtmxCom4OPLGrJ4mD2qrx+y9k5Yhyd5FsfgQGCHiQeKpcWYGe7gUIzwHVqOwS0enBDG6xMfBhA3W5vALPKOu2+99MO7dHwK5ocMCgUU51dikCbsdYAmKj/6ar629Ta8rjaGEFESh2z6N+YCyyxid0oz6xf4X3wvNRawMo9TJYb0JMUzzEbK4BZ8vyoRZ+owd7OwWpr+ICNWB3xSw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90070be6-0de2-493c-9bb0-08d58a57afde
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 09:32:35.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2F9Wskd011600

> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> Sent: Wednesday, March 14, 2018 8:43 PM
> To: davem@davemloft.net; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>
> 
> On Wed, 2018-03-14 at 08:37 -0500, Madalin Bucur wrote:
> > Hi,
> >
> > This patch set is addressing several issues in the DPAA Ethernet
> > driver suite:
> >
> >  - module unload crash caused by wrong reference to device being left
> >    in the cleanup code after the DSA related changes
> >  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
> >    module unload
> >  - a couple of error counter fixes, a duplicated init in dpaa_eth.
> 
> hmm, some of these(all?) bugs are in stable too, CC: stable perhaps?

Hi Jocke,

I did not check that, they should be added.

Thanks,
Madalin

> >
> > Madalin
> >
> > Camelia Groza (3):
> >   dpaa_eth: remove duplicate initialization
> >   dpaa_eth: increment the RX dropped counter when needed
> >   dpaa_eth: remove duplicate increment of the tx_errors counter
> >
> > Madalin Bucur (2):
> >   soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
> >   dpaa_eth: fix error in dpaa_remove()
> >
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  8 ++++----
> >  drivers/soc/fsl/qbman/qman.c                   | 28 +++++---------------------
> >  2 files changed, 9 insertions(+), 27 deletions(-)
> >
> > --
> > 2.1.0
> >
