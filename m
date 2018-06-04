Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeFDIfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:35:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62717 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDIfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:35:00 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="182872661"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: "gwendal@chromium.org" <gwendal@chromium.org>
Subject: Re: [PATCH 2/7] scsi: ufs: Add config descriptor documentation
Thread-Topic: [PATCH 2/7] scsi: ufs: Add config descriptor documentation
Thread-Index: AQHT93m1h4s9issfuU2nyts5S8A3DqRPzuCA
Date: Mon, 4 Jun 2018 08:34:57 +0000
Message-ID: <aa1a00fa24f982051af496d527b626049185edca.camel@wdc.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
         <20180529181740.195362-3-evgreen@chromium.org>
In-Reply-To: <20180529181740.195362-3-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0431;7:gebCsagwkzZF6VS+N2DjBLLsXQotVWwuJKq2dxQMMRhSBQ4W9gJ+YyhBsJBwBij+aOMGr3t3vtCJQAYnxOhV6PwPFyrIzSkL8XvSVNfYlpVG7Z2tYb4FsrcEORJf3HIlK6YPSZC3MpiqPGOSvBWg3K/ri1OF1qyH0xMoh0B8oZ/xOxOK+IOk+iqOGhQmMF92+uDxznIs1h3D+nBGR89H4PC5dNkKwnIGnCRLuk5nLvgRKWW6LlD539er9ESw8B6R;20:M9DE/YeQCuvFThMgaEB3yvdvfJqdrvnwH8RNMRQRS9xIYTUTGib7LT4ejmRaJOaVYZ5yG5NQkkCmJZPVIluWR9fLMfeWeXSMrPRq154mnE79N1S1/+4SIAxGvKjXPjT3ETVxsKBFAbvZMFYfIs1v/Nz3VVHo13IQPL1sHphv2Q8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0431;
x-ms-traffictypediagnostic: MWHPR04MB0431:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB043126CFDFEA33D06F19580798670@MWHPR04MB0431.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0431;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0431;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(199004)(189003)(478600001)(53936002)(11346002)(6636002)(8936002)(2616005)(476003)(446003)(110136005)(6246003)(186003)(3660700001)(25786009)(6116002)(2900100001)(7736002)(305945005)(118296001)(3846002)(14454004)(6506007)(26005)(72206003)(5660300001)(3280700002)(316002)(66066001)(486006)(6512007)(2501003)(99286004)(558084003)(6436002)(102836004)(97736004)(5250100002)(105586002)(86362001)(2201001)(6486002)(36756003)(2906002)(8676002)(76176011)(39060400002)(81166006)(81156014)(229853002)(4326008)(68736007)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0431;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dBuX41UKKToltp1o93ZOKuYFaxU5+PteeQd8Ln9lQBIuLEa0pJ5Qxj0avjuf90GkMxHfg/1jX3mXOBTy6wjrdU9/P7eLsv0HnezRCwmBUXx+oK9PVZe/rgsNikcjVvAWVuc+mflelhsMVnu1lvFllWxShsolc8goVW6Y0Md1Fy+nauK+DkZRRIrnFW7WJLau
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAEFACE06615FF45B115173E97887DFF@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5b372ce8-b9e1-4c6c-c6d1-08d5c9f60de6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b372ce8-b9e1-4c6c-c6d1-08d5c9f60de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 08:34:57.4065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0431
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w548Z8fH028708

On Tue, 2018-05-29 at 11:17 -0700, Evan Green wrote:
> This change adds the documentation for the new sysfs files plumbed out
> for the UFS configuration descriptor.

Shouldn't these changes be merged into the patch that adds these attributes?

Bart.
