Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeDXQ0e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:26:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38596 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDXQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:26:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,323,1520870400";
   d="scan'208";a="179710566"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "pmenzel+linux-block@molgen.mpg.de"
        <pmenzel+linux-block@molgen.mpg.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFJlZ3Jlc3Npb24gNC4xNy1yYzE6IFNTRCBkb2Vzbsq8dCBwcm9wZXJs?=
 =?utf-8?B?eSByZXN1bWUgY2F1c2luZyBzeXN0ZW0gaGFuZyAoTlVMTCBwb2ludGVyIGRl?=
 =?utf-8?Q?reference)?=
Thread-Topic: =?utf-8?B?UmVncmVzc2lvbiA0LjE3LXJjMTogU1NEIGRvZXNuyrx0IHByb3Blcmx5IHJl?=
 =?utf-8?B?c3VtZSBjYXVzaW5nIHN5c3RlbSBoYW5nIChOVUxMIHBvaW50ZXIgZGVyZWZl?=
 =?utf-8?Q?rence)?=
Thread-Index: AQHT2+j+aAndgYhoQEux8zOPnMS7EQ==
Date: Tue, 24 Apr 2018 16:26:27 +0000
Message-ID: <67ffdf0050a04bf3615c3d8a3a90b0c9c2aeb1ad.camel@wdc.com>
References: <59ca6556-11a6-4f77-76e7-d51c7175eb32@molgen.mpg.de>
In-Reply-To: <59ca6556-11a6-4f77-76e7-d51c7175eb32@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [198.233.165.212]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0863;7:2QoR6nFGX+8TvI7KgaVBcX0I7exoZpnMJUYGRqUrhV/klzTWCJxmmVQLnlA/16F4DFWZdE/89PY8cXmWwSBdCzMyBtk20bYX2+Q/kr1mOirMEnDCA9tb3ULmpJDz5f4ofNoNhiUZdNUtIMGDajGhdEMPx1LJ2A2+skxWWbBvlOwIyljB+r2zh9EnDF80Ze2RWcpacmUIwllpDlfnv14HdBie2sF6+S9sI3DhlF48+jKnN3pyWb9nIv93BQoAHs2X;20:lSXrQkACCCN2UGhpODI3TJSaQziJzAz5mFwQgjKPz653He2jooquqyfIfJEl0ESdoXusPqawuQ+Odr3eOwxdH2iKmfgyDoqFDHZFqL0o9V2k11Uq/CxlOlz7uzTlsM8JURw2/75Dj78lqSnQX+Jru7TEHYZPDkkUpZM2fK2LMg4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0863;
x-ms-traffictypediagnostic: MWHPR04MB0863:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0863D905BD4B393DF3A59CAC98880@MWHPR04MB0863.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0863;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0863;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(39380400002)(396003)(376002)(377424004)(199004)(189003)(6246003)(6512007)(4326008)(54906003)(316002)(53936002)(110136005)(2900100001)(3280700002)(2906002)(7736002)(305945005)(106356001)(68736007)(224313004)(6116002)(224303003)(6436002)(105586002)(118296001)(2501003)(3846002)(5250100002)(8936002)(66066001)(14454004)(2616005)(81156014)(81166006)(72206003)(478600001)(25786009)(97736004)(6506007)(11346002)(476003)(446003)(76176011)(486006)(229853002)(86362001)(5660300001)(186003)(36756003)(6486002)(99286004)(26005)(102836004)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0863;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: w/BIfVX1Neqhch3Kd38cFpUDns9dmcgQ2cx+RMgn5Dm8Sg51ZAzp1xaU4F+YsBoVJMyCnSwD/QlbV+dcACEYaXbmv0pHWda2H5E1GZbcZLHQIorFJlQqWNz0xh6SewX7ttxO5qROJMTic4wR3e5e0p7O2mqKwWsgnNZbmvoc5GaywHCdGaFRpZAGdQPme6TI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F77C461EB2E7694D95E4AA008FAC679D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 52418e85-fd81-4ffb-3ad9-08d5aa002124
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52418e85-fd81-4ffb-3ad9-08d5aa002124
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 16:26:27.3975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0863
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3OGQccJ016161

On Tue, 2018-04-24 at 18:14 +0200, Paul Menzel wrote:
> Since Linux 4.17-rc1, resume from ACPI on the Lenovo X60 fails because 
> of a NULL pointer dereference. As the drive doesn’t come back, messages 
> can be seen on the display, but the system cannot be controlled anymore, 
> and has to be forcefully shut down.

Are you using scsi-mq or the legacy SCSI core? If you are not sure how to
answer this question, please share the kernel config and kernel command
line parameters.

Thanks,

Bart.
