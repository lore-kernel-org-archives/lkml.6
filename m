Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeEDTJv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:09:51 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:10458
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751794AbeEDTJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:09:46 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "davem@davemloft.net" <davem@davemloft.net>,
        "colin.king@canonical.com" <colin.king@canonical.com>
CC: Matan Barak <matanb@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] net/mlx5: fix spelling mistake: "modfiy" -> "modify"
Thread-Topic: [PATCH] net/mlx5: fix spelling mistake: "modfiy" -> "modify"
Thread-Index: AQHT4uONLEY4GFNIzUKW/OCNU3vxvqQeV88AgAGZTgA=
Date: Fri, 4 May 2018 19:09:41 +0000
Message-ID: <1525460978.2882.0.camel@mellanox.com>
References: <20180503133503.14508-1-colin.king@canonical.com>
         <20180503.144440.629738993491549851.davem@davemloft.net>
In-Reply-To: <20180503.144440.629738993491549851.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3097;7:AJg4LCKV0+5Mca7zHApVzh4pg0lkPD6DtbgXOJXH5uJYzm+SBmqqAp6fr8twv4g2GPkG+TojA4ig+86YCuVTgYEXqUnVJ5f9Aoohumuzs+xsav3rLeIy9L5H0xraigTl7DjxM1DvQTQggHFlInN3RGAq621bb84xPb//hONHH46gniIQN4VXCqatd0L0GKMAOUucXsX1/k1DBiFbGpi73IO3BJeQE2liZIMRE0SLIu6DP0ZtP489TNTt4ziGL4MC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3097;
x-ms-traffictypediagnostic: HE1PR0502MB3097:
x-microsoft-antispam-prvs: <HE1PR0502MB3097360908A300F7541F6669BE860@HE1PR0502MB3097.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0502MB3097;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3097;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(39380400002)(366004)(377424004)(189003)(199004)(68736007)(3280700002)(6506007)(6512007)(66066001)(50226002)(8936002)(305945005)(106356001)(7736002)(97736004)(54906003)(110136005)(478600001)(25786009)(105586002)(2900100001)(316002)(8676002)(53936002)(2501003)(81156014)(5250100002)(36756003)(81166006)(6246003)(4326008)(6486002)(14454004)(186003)(229853002)(103116003)(102836004)(3660700001)(3846002)(2906002)(446003)(59450400001)(6116002)(11346002)(476003)(26005)(76176011)(86362001)(99286004)(486006)(2616005)(5660300001)(6436002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3097;H:HE1PR0502MB2908.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uuYqqr1S+xoCcx7DqvPHv2FjD2A8EP26gzbLPtIdehJgGMVkPL0Zi6Y9hUqU2tyNzoZyvx4nASw9tsoI69q7ZIY39xHtyVg6C4YV7/akacG4NBB7gibcqQ+9FxC5EBJrA9ofUnzMvvb10YjIwB5Cc9TF3UVv6qEJ/R+W0D10j67Puk7U9vrUCpwofhw1r46a
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ACEC21FEE4BA64A9D7F73D9C9553FA2@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 353ec85c-61b3-4ede-a00b-08d5b1f2972f
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353ec85c-61b3-4ede-a00b-08d5b1f2972f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 19:09:41.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3097
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w44J9xk8006266

On Thu, 2018-05-03 at 14:44 -0400, David Miller wrote:
> From: Colin King <colin.king@canonical.com>
> Date: Thu,  3 May 2018 14:35:03 +0100
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Trivial fix to spelling mistake in netdev_warn warning message
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Saeed, please send this to me in your next pull request.
> 

Applied to mlx5-next, Thanks Colin and Dave !
