Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeDPUnr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:43:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54237 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbeDPUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:43:43 -0400
X-IronPort-AV: E=Sophos;i="5.48,460,1517846400";
   d="scan'208";a="179160328"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "beanhuo@micron.com" <beanhuo@micron.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rajatja@google.com" <rajatja@google.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVwUmBGJhhKEdfRWiDz1LGRhoC8wAAk8gA
Date: Mon, 16 Apr 2018 20:43:39 +0000
Message-ID: <51067460c8f403cceaa6fa6c6f6a6b61e78cb018.camel@wdc.com>
References: <5b2fdd1b29b54590889194eba90debfb@SIWEX5A.sing.micron.com>
In-Reply-To: <5b2fdd1b29b54590889194eba90debfb@SIWEX5A.sing.micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0910;7:27sJwvcLyvCBDQUmH4lyuwdBZeHDAryFQl8pzp/0utrfNgo4+5KWJbGCTzVvh8EJ6CCK8YcLMoDlMp37jD0jyYYc9uyshSg6siUh/sD0SZej1iTOEIL+XyfiEz2nieOBSDF1o5vEqQ/yJ3xhd479KzDB+dPjUAuHzgjf1Vx+A1+YqB2dfuvM15zglQhjri71y5Hj7XJ50i4QK1v/vKJ144N32IGDSwYYA+/G7zUY+BhOwCIvoAdSr6PnlPh6Yluc;20:U3KjyZofe0b07Lie2g/KOX2Tvz8sjcCPADM2FISHtCtIZO7Fa5qa1/zgTGztHzAa6ae2aVcg4WqR8b3nOxCk3fbF1J6lgym/e6D8JGseB4qOhbOKxYgFVTmxGGaZqGzf+oci+LXGwh0l3kuPnJLlqpH4mrbLyfDWkgpHxPbuSos=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0910;
x-ms-traffictypediagnostic: MWHPR04MB0910:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0910519992635A96193B21D298B00@MWHPR04MB0910.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0910;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0910;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(39860400002)(396003)(377424004)(199004)(189003)(81166006)(54906003)(110136005)(105586002)(68736007)(36756003)(81156014)(316002)(8676002)(305945005)(5660300001)(2906002)(478600001)(7416002)(7736002)(76176011)(2616005)(14454004)(99286004)(72206003)(186003)(8936002)(66066001)(102836004)(446003)(59450400001)(11346002)(6506007)(97736004)(26005)(6116002)(53936002)(118296001)(476003)(25786009)(106356001)(486006)(4326008)(2900100001)(2501003)(5250100002)(3846002)(5890100001)(86362001)(6246003)(229853002)(3660700001)(3280700002)(6436002)(6486002)(2201001)(6512007)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0910;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7+KCi+uZ5VQf3t2nlRUVJA7+OFxZMKJOFrN6lIHoenBVJtH8a2/jy7HU7//5vR1eB6HxzuR9MvDwzReG22XmDVSxADh4wO6wE/r/PHMOnf1w+4xEEeIS1ApRhgR/WeLYf8pqKMpdBYHMeR28GavTwv5+brLvk/dZosVR266wBeY7T7NrRV+Dmu8DTDBesDyS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <21FF2013C60E83438AC474891086B1D1@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c122efcd-6f13-41ee-482b-08d5a3dabc17
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c122efcd-6f13-41ee-482b-08d5a3dabc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 20:43:39.4289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0910
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GKhs4k009950

On Mon, 2018-04-16 at 20:27 +0000, Bean Huo (beanhuo) wrote:
> By the way, these patches are not to add new feature, they are just to
> add print tag along with the other exist printed request parameters.

Are you aware that there are two tag fields in struct request, namely "tag"
and "internal_tag"? Are you aware that how these fields are used depends on
whether or not a scheduler is attached to a request queue? Have you verified
that the "tag" field contains a meaningful value for blk-mq for every blk-mq
tracepoint?

Thanks,

Bart.
