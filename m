Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeC1QtV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:49:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42735 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeC1QtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:49:18 -0400
X-IronPort-AV: E=Sophos;i="5.48,372,1517846400";
   d="scan'208";a="74730347"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH][scsi-next] scsi: core: remove redundant assignment to
 shost->use_blk_mq
Thread-Topic: [PATCH][scsi-next] scsi: core: remove redundant assignment to
 shost->use_blk_mq
Thread-Index: AQHTxrPBa/O5TS+15UC/ei7gjm8COqPl3AGA
Date: Wed, 28 Mar 2018 16:49:16 +0000
Message-ID: <322332967046adbc933b27c9d5660e3527b6ad2e.camel@wdc.com>
References: <20180328164142.27201-1-colin.king@canonical.com>
In-Reply-To: <20180328164142.27201-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0783;7:jfT2mfC465F+Ieelnm84MBv+3qn/0t79ZEm8GqOlaY7wjmSBJ4ei/QxXkknoW6ocrGf/lkEA92jYewgXv5LhHg7HqPG3gWRYUGMSeCI9SQhM6Ybdm+VIwhHLqeyNl4rCaoilexIIuW+HZ6rAMgo/UrzCfJm7CEHiK1azEOg018uoV397RfF5ft0OC/lieVGAYTSmjb/iQDajNazalSk8b8HGr9hfBJyYTtLnKQlvWWMDaPMrK25pzUPMJ/ugBU3H;20:h6cYLs3juFEqz2lqHC79CemSoFzhbMlaw/mvCnsLq5PLbySs1NjGsEX4JlHfJxPnwLxdST4fNVAMSkG0cY1HlgSB2H3A4C1AAjr+/++ZsKJjDz/2pqe+v7KtT6InZrFQwy4fjYp0dqAWp7mAV5WPV6lXlYTMlm/L5kah/amHnH4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 883a0836-ccb8-4899-e929-08d594cbd810
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0783;
x-ms-traffictypediagnostic: MWHPR04MB0783:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0783E796DB795A98769F9E5298A30@MWHPR04MB0783.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0783;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0783;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(377424004)(189003)(199004)(2501003)(81166006)(229853002)(446003)(6436002)(6246003)(54906003)(53936002)(305945005)(68736007)(5250100002)(2201001)(316002)(86362001)(486005)(6486002)(118296001)(8936002)(486005)(106356001)(558084003)(11346002)(3660700001)(66066001)(7736002)(8676002)(6506007)(81156014)(110136005)(3280700002)(97736004)(6116002)(72206003)(26005)(478600001)(6512007)(476003)(99286004)(76176011)(2900100001)(5660300001)(186003)(105586002)(2616005)(102836004)(4326008)(3846002)(14454004)(36756003)(25786009)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0783;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ps2+jkrzblaSAZvv179wVz8sxoGPAB9KRj5nk9fmL8OsdfW2qpLg7XYzT77Bv54/1frTMcVoeRcsH1y9z5ckOh8DExWCoxRX54nqFr0gUUhhCya1bNu65hTPA3v7E0bLFOdO+AoVs+CR252TFQK1XoB3DKFUgSzI2Jll4B+VE7V8BRFfSD9PLr+kFsBO+eaUTS6RWdASiZhnR0Dco9wSp02+k/7KtSVAcm88YSv3GsK6EBuaSJw6WbldnG6kg7WdGptib6vbpi0r5poAPh+EkdGeBZKjtbWjIZ6dbQrCAM2pXHyltgeyz1U3H3Sxuv8moO2PhWS2Ia6888pkDMZCEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F86702B28FDFEA4BA54EAFEA14EB5D5A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883a0836-ccb8-4899-e929-08d594cbd810
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 16:49:16.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2SGnPVS032767

On Wed, 2018-03-28 at 17:41 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The first assignment to shost->use_blk_mq is redundant as it is
> overwritten by the following statement. Remove this redundant code.
> 
> Detected by CoverityScan, CID#1466993 ("Unused value")

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
