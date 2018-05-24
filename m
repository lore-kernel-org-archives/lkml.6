Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935436AbeEXBmy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:42:54 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:63552
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935109AbeEXBmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:42:50 -0400
From: Robin Gong <yibin.gong@nxp.com>
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1] dma: imx-sdma: add virt-dma support
Thread-Topic: [PATCH v1] dma: imx-sdma: add virt-dma support
Thread-Index: AQHTwbZRQFd8gKZYyk6iiiOUnMCFSKQ75psAgAIdB4D//4JEAIAALEiAgAFRgIA=
Date: Thu, 24 May 2018 01:42:46 +0000
Message-ID: <1527154959.3990.39.camel@nxp.com>
References: <1521735499-29138-1-git-send-email-yibin.gong@nxp.com>
         <20180522100948.6xsq3unhyyyd7zz3@pengutronix.de>
         <1527099973.3990.37.camel@nxp.com>
         <20180523105612.u4wbezh7fzkv4wfh@pengutronix.de>
         <20180523133441.GK20991@vkoul-mobl>
In-Reply-To: <20180523133441.GK20991@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB2983;7:yRu7cmlTJ6YQdM18IjKv/SEKrcOadZbUqjlK+m+Ivo7jHj46GcQLb12v4A/dNOVAzVIyjWMczsX5lDmj7L+3Qm1WHLHVui7WJ4cA5t4dvto+xM2S29J83/tnYR9zcCdnilt3DFsAtWhbGFqDuYQ2JtyHcgvr5Tp3voLvS9EoIMmlFHJJtVtOgzdyKyDBNksEmGJVaPudBRsBjdEVeIA5G9XgKcwCKdmJuZ7s+4x/xcIIY9I7ErWHsiI7vbGm20bt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB2983;
x-ms-traffictypediagnostic: DB6PR04MB2983:
x-microsoft-antispam-prvs: <DB6PR04MB2983360A8DBCB610401136CA896A0@DB6PR04MB2983.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB2983;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB2983;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(39380400002)(366004)(377424004)(199004)(189003)(3280700002)(2900100001)(6512007)(3660700001)(93886005)(50226002)(106356001)(105586002)(36756003)(66066001)(97736004)(25786009)(478600001)(5660300001)(316002)(54906003)(110136005)(305945005)(8936002)(81166006)(81156014)(8676002)(4326008)(14454004)(7736002)(86362001)(103116003)(76176011)(6506007)(53546011)(68736007)(6486002)(229853002)(6436002)(6116002)(3846002)(2906002)(6246003)(99286004)(2616005)(476003)(5250100002)(2501003)(486006)(53936002)(11346002)(446003)(26005)(186003)(102836004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB2983;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-microsoft-antispam-message-info: gAfeIy9Gdrxl3wu+9GGpDINCzIVK577k6ClikkW+qViZDq1bpUpSOVis5QQ0GMXAY6Z8QbYNe8dIf+sraOPV9XtxcFwTUDlBML07ZYK4gMh7y6BJEur1sEc+4ShBwVF5ULFuG/RshBEFGtYsoCseRw1hQtkHwo/3YzS5nOYlOJdErm90GAJL9oVGD3LiIkfu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E13BF6CE668B6C4D9B18F3DAE34BC907@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9964651a-b370-4d97-e8c0-08d5c117a690
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9964651a-b370-4d97-e8c0-08d5c117a690
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 01:42:46.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2983
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4O1hNK6011600

Okay, I'll try to split it.
On 三, 2018-05-23 at 19:04 +0530, Vinod wrote:
> On 23-05-18, 12:56, s.hauer@pengutronix.de wrote:
> 
> > 
> > Well, it's somewhat related to virtual dma support, but that's not
> > my
> > point. My point is that this patch is quite big and thus hard to
> > review.
> > If we find ways to make it smaller and to split it up in multiple
> > patches then we should do so, because it makes it easier to review
> > and
> > in case you break something here we raise the chance that a "git
> > bisect"
> > lands on a smaller patch which is easier to understand.
> > 
> > Please try and make that a separate change. I haven't really looked
> > into
> > it and it may not be possible due to reasons I haven't seen, but
> > please
> > at least give it a try.
> That is something would help me as well. I have reviewed the patch
> and am not
> sure I fully understand the changes, so breaking up stuff would
> definitely help
> in the review..
> 
