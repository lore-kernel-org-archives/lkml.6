Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeFDIf7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:35:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42042 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:35:57 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="176440399"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: "gwendal@chromium.org" <gwendal@chromium.org>
Subject: Re: [PATCH 4/7] scsi: ufs: sysfs: Document attribute writability
Thread-Topic: [PATCH 4/7] scsi: ufs: sysfs: Document attribute writability
Thread-Index: AQHT93mJap5+rdaofEWVkox+NoZ9qaRPzyGA
Date: Mon, 4 Jun 2018 08:35:51 +0000
Message-ID: <c16dbf5a23c32a090cc84544f7a83f7dd0283d73.camel@wdc.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
         <20180529181740.195362-5-evgreen@chromium.org>
In-Reply-To: <20180529181740.195362-5-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0431;7:wXAvSw8b+j2mgLOdLBhbKCT9LTUAAhgI5+/imIab7kJyAQBom8cNIoxLNMp0P+FtZPgo1yzquaiRT3fw1EQ0LMPWQKgc+eaQvNm6lBGqER5cZgzhGmsnQykp0L4a4PumXwpm5sAgmx5edy1enjWfQ829POMiGXKlEmjY9tqVgnCPQu905EENERzKjYsHsJTNAUCV8KTbqWlyHJdk8zbzkWjIixE6d46weHTd0ntnjaEr2uc+HwPeA9kyluukngr3;20:R+cq4k3el8FI1kksISOUKxRgpseIqdU6sfBHTPRW4z7zrazEC09szDDqeC0mU/Iaqx+a8k21ypFU7d9+J2SdVCoosLZm1VW19snvBGpgurYQNWzJzmgUdOyhhpOZ4be8CvgSzcKWDK3qDgD/N+SqAjM/7rBCeWehLKi/uAOmCKg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0431;
x-ms-traffictypediagnostic: MWHPR04MB0431:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB04316A65453EC03ADB21F91298670@MWHPR04MB0431.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0431;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0431;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(199004)(189003)(478600001)(53936002)(11346002)(6636002)(8936002)(2616005)(476003)(446003)(110136005)(6246003)(186003)(3660700001)(25786009)(6116002)(2900100001)(7736002)(305945005)(118296001)(3846002)(14454004)(6506007)(26005)(72206003)(5660300001)(3280700002)(316002)(66066001)(486006)(6512007)(2501003)(99286004)(6436002)(102836004)(97736004)(5250100002)(105586002)(86362001)(2201001)(6486002)(36756003)(2906002)(8676002)(76176011)(39060400002)(81166006)(81156014)(229853002)(4326008)(68736007)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0431;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: PM31X3vn527HspGuONkSuAgrPiFl8zSQKuNecVpEvyAD2bQI2kAtaQhgsv8AtdGO4tggpPER41ZRFbR63JY2wqMC45swl/eaPnJ64uNLzQhGt15qeT9FWnxOzgPZaeAobvPkqig96s1BhRkpPP6iVSe3asYFDaQr8U8mi3tNcWXw6uMdhzN9cNIKWMozxt1o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD24CB2BE71CE34A92307EA2A6C389A5@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3e8f5775-e9bc-469a-45f7-08d5c9f62e71
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8f5775-e9bc-469a-45f7-08d5c9f62e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 08:35:51.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0431
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w548a49j028718

On Tue, 2018-05-29 at 11:17 -0700, Evan Green wrote:
> This change removes the read-only clauses from the documentation
> for UFS attributes, which are now writable.

Also for this patch, why is this a separate patch instead of having merged
these changes into the patch that makes the attributes writable?

Bart.
