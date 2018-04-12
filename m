Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeDLWje (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:39:34 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:37116
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752467AbeDLWjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:39:32 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "colin.king@canonical.com" <colin.king@canonical.com>,
        Matan Barak <matanb@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] net/mlx5: remove some extraneous spaces in indentations
Thread-Topic: [PATCH] net/mlx5: remove some extraneous spaces in indentations
Thread-Index: AQHT0ABnGm8VlzWAz0WD75y/5abvIaP9vjGA
Date: Thu, 12 Apr 2018 22:39:26 +0000
Message-ID: <1523572761.3587.45.camel@mellanox.com>
References: <20180409124336.29274-1-colin.king@canonical.com>
In-Reply-To: <20180409124336.29274-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [2601:647:4000:4586:49d:3af1:b700:d3ab]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR05MB537;7:UENoSjwBhevCOJ5fcnjeAlySzXgYvIoRBFbc4w2nvSyeykVkmbJ6Glc+0stCDDCx/a6pK6XswAfpx/f71Jr0eQdck4c6IIOpAjkIWfK4itCkUpKduKj3LTRHuXwi763RhCv8t+rsia9GhTF1IjGhXtLsldx1ss/MhXjpC/nVSztBruimXSMl4KtoD9vuvnxuK640D+3OuKY7pz7+/YgE3odfTJYJh7v29leTSoU8e6cJpl1yTSNdDVzjInmLSMwN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB3PR05MB537;
x-ms-traffictypediagnostic: DB3PR05MB537:
x-microsoft-antispam-prvs: <DB3PR05MB5376AA93B5C49FDF81E7A3ABEBC0@DB3PR05MB537.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB3PR05MB537;BCL:0;PCL:0;RULEID:;SRVR:DB3PR05MB537;
x-forefront-prvs: 06400060E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39380400002)(39860400002)(346002)(199004)(189003)(377424004)(81166006)(81156014)(53936002)(6436002)(8936002)(97736004)(186003)(7736002)(305945005)(5660300001)(6246003)(3660700001)(50226002)(6116002)(11346002)(486006)(446003)(3280700002)(76176011)(2616005)(6506007)(316002)(6512007)(99286004)(102836004)(476003)(478600001)(6486002)(229853002)(2501003)(5250100002)(54906003)(110136005)(86362001)(2900100001)(25786009)(103116003)(2201001)(4326008)(14454004)(105586002)(2906002)(68736007)(46003)(36756003)(106356001)(8676002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR05MB537;H:DB3PR05MB0859.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WozK0f1KtVx0dgn82b9txyVYJ1u8H+yfulBpWDAN9N9OvTFFXiGcg3vIKBYmxvQFgKHS7hIP1AI7StmPr03m7fmCbzxvfZhIU6hsysHnnnGi1R1Zhgy1NuE6ARsOJNEu4gQ2k1ctDvtclFyVc5u3mJbl5IUI3nymv7Tafpal6EEaKa95D66nZg503n+oPSgo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC75B43AF2142440B31F479CA9B4A71D@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e4f77d1e-9460-41eb-c5a4-08d5a0c63f9f
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f77d1e-9460-41eb-c5a4-08d5a0c63f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2018 22:39:27.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR05MB537
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3CMdded019727

On Mon, 2018-04-09 at 13:43 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several lines where there is an extraneous space causing
> indentation misalignment. Remove them.
> 
> Cleans up Cocconelle warnings:
> 
> ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:409:3-18: code aligned
> with following code on line 410
> ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:415:3-18: code aligned
> with following code on line 416
> ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:421:3-18: code aligned
> with following code on line 422
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 

Applied to mlx5-next, Thanks Colin!
