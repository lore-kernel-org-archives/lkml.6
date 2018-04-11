Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeDKSXu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:23:50 -0400
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:11072
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750734AbeDKSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:23:48 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "colin.king@canonical.com" <colin.king@canonical.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: Matan Barak <matanb@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] net/mlx5: remove some extraneous spaces in indentations
Thread-Topic: [PATCH] net/mlx5: remove some extraneous spaces in indentations
Thread-Index: AQHT0ABnGm8VlzWAz0WD75y/5abvIaP6pbMAgAABPICAAT17AA==
Date: Wed, 11 Apr 2018 18:23:41 +0000
Message-ID: <1523471018.3402.42.camel@mellanox.com>
References: <20180409124336.29274-1-colin.king@canonical.com>
         <20180410232254.mg7stooh5tytv6m2@ziepe.ca>
         <20180410232719.qzaltu7hu57aqps3@ziepe.ca>
In-Reply-To: <20180410232719.qzaltu7hu57aqps3@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR05MB0617;7:QeTI00UlkdFCLipVEy4KP+5LUyQhwEdFFuHD6xka2M2wmwhGV9D2bO7YmL4kX/xjAJ1Ad24AQPanqRmO13GKpMxFisMxVldHLLW5oVvpZRU85ImMbCPgBSvVjMTRzPDK1uWdaW4DSeAX3Jw17728NPHZzl7ShShRQcDZi/QPJjvyCiqeQRcOp8IHgJa+DKlGArWKavf7A/CMplI0BuDxY53/Jkdqho5wDtIZuMHJY8PAZjP5ztxQ/o55nPg4BTeS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB3PR05MB0617;
x-ms-traffictypediagnostic: DB3PR05MB0617:
x-microsoft-antispam-prvs: <DB3PR05MB061718E069576E3598C48D94BEBD0@DB3PR05MB0617.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB3PR05MB0617;BCL:0;PCL:0;RULEID:;SRVR:DB3PR05MB0617;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(346002)(376002)(39860400002)(377424004)(189003)(199004)(26005)(66066001)(8676002)(99286004)(6506007)(103116003)(81156014)(25786009)(186003)(53936002)(81166006)(106356001)(110136005)(3846002)(11346002)(54906003)(6116002)(478600001)(446003)(2616005)(6436002)(76176011)(102836004)(6512007)(6246003)(8936002)(50226002)(4326008)(105586002)(2906002)(316002)(5250100002)(68736007)(5660300001)(3280700002)(14454004)(86362001)(2501003)(6486002)(3660700001)(229853002)(7736002)(305945005)(97736004)(476003)(2900100001)(486006)(36756003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR05MB0617;H:DB3PR05MB0859.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: TYiQkeXtXLyZOgZUAuYidAZOjACSr81GL7HynuVt+MtRhOo2himegM3nDRFWftIrvAAFtENuH2GcWmwgxvI+larb7tXlhTaaBpxTpylAaDgAL1T2ecPl+BzjSxZovUsfSo9FlAFQ7Ureqi4p42iRHrWGDhQ1SB9pV5QZ7XsbkMGWYEe1jEI1XieMo+xjgm2wWCcpQQYYcQStzAeR1hk+XLFF0z4S2wvtsSPln+I8Xd1KlAtlJF05MPHfPE46u4v1Hqt9weP1HYHWQ3TN0tSoFNl9kLsxKT5GUWxl9CwS7f/D8bCkrewfHmOtgwgdbCmaUqbHqPMz5qaEn2ZFtDE4XTFMoPdZ6lhP9BlBzkFCZX/wEpE9VYFPoKm82lcxeBETjii70836aZkXc85Yl61O1wBCOXJP1RdhFQIHJBRxZg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB24063FFF44D746A35DF335E6ADAA62@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dda90833-3677-4bfb-7f58-08d59fd95a57
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda90833-3677-4bfb-7f58-08d59fd95a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 18:23:41.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR05MB0617
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3BINvHq008854

On Tue, 2018-04-10 at 17:27 -0600, Jason Gunthorpe wrote:
> On Tue, Apr 10, 2018 at 05:22:54PM -0600, Jason Gunthorpe wrote:
> > On Mon, Apr 09, 2018 at 01:43:36PM +0100, Colin Ian King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > There are several lines where there is an extraneous space
> > > causing
> > > indentation misalignment. Remove them.
> > > 
> > > Cleans up Cocconelle warnings:
> > > 
> > > ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:409:3-18: code
> > > aligned
> > > with following code on line 410
> > > ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:415:3-18: code
> > > aligned
> > > with following code on line 416
> > > ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:421:3-18: code
> > > aligned
> > > with following code on line 422
> > > 
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > >  drivers/net/ethernet/mellanox/mlx5/core/qp.c | 18 +++++++++-----
> > > ----
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > applied to for-next thanks
> 
> Oh wait, this is for netdev, not rdma sorry. Never mind, DaveM should
> pick it up.
> 

net-next is currently closed.

Dave, if it is ok with you I would like to apply this into mlx5-next
branch so it won't cause any issues with our next pull requests to rdma
and netdev.

> Jason
