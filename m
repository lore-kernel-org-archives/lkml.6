Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCMO5C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:57:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7434 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeCMO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:56:59 -0400
X-IronPort-AV: E=Sophos;i="5.47,465,1515427200";
   d="scan'208";a="176571297"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "martin@lichtvoll.de" <martin@lichtvoll.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "tj@kernel.org" <tj@kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during
 runtime and could not connect to lvmetad at some boot attempts
Thread-Topic: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during
 runtime and could not connect to lvmetad at some boot attempts
Thread-Index: AQHTusxi6QO7Xok2wUi2UJFBoytR86POOqAAgAAG0oA=
Date: Tue, 13 Mar 2018 14:56:54 +0000
Message-ID: <1520953013.2638.2.camel@wdc.com>
References: <27165802.vQ9JbjrmvU@merkaba>
         <f6e73c8e-1186-744b-c856-2c56ceeeab10@redhat.com>
         <2276139.2HCKFmVDEL@merkaba> <20180313143222.GA10883@ming.t460p>
In-Reply-To: <20180313143222.GA10883@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1169;7:/mQqdhJh+1ZT95UBbLplhuuBTCJGzKVdAyPteq7E+OuJ8kCNe1OeqraOImdsLw45FXb+Byu36AnZjX9/5REgbuY+Qlns7x5uBNh+ypq+Xbb3Q8SfsquakBY1PMcH3wNiPY/fQUyhiffRshlF688p5fx5ZZDicGkYKeQOIR/oozKjeJKtxEu74Cp60oTFIHmVwPWgGXpQCx1/aPRqFMpwtocJjkygoCaC/Cun6BXPv4i3gYh+4tCIQ3nUNVvuLaqF;20:srgxRYfmybpMVrxEo0Dp8TFxzX7JvuDvTVuyciN0rOXBFepV6hMZMFNguyPJer/Q+GJStMqKC9LMMyoPOUKJLEfkmP/f6O/suA9yl2z4K5JmqDdC45L+2geIgSe7MAcUa1EUQPEohmRWPEeBotudj6LZs/yRjm1/LZlVXG4hrWM=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e7c554c-d663-4d59-7cd1-08d588f2a9af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1169;
x-ms-traffictypediagnostic: MWHPR04MB1169:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1169CDB26EAC8FA40C8CBDD698D20@MWHPR04MB1169.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(278021516957215)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB1169;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1169;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(346002)(396003)(376002)(377424004)(199004)(189003)(51444003)(6506007)(305945005)(105586002)(81166006)(99286004)(8936002)(110136005)(2900100001)(3280700002)(6116002)(3846002)(2501003)(186003)(5660300001)(103116003)(4326008)(6486002)(76176011)(7736002)(5250100002)(7416002)(54906003)(8676002)(81156014)(2950100002)(97736004)(102836004)(53936002)(316002)(25786009)(3660700001)(66066001)(26005)(86362001)(478600001)(68736007)(14454004)(72206003)(93886005)(36756003)(6246003)(229853002)(106356001)(2906002)(6436002)(6512007)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1169;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uMMP/EbJaLrkQNwrGFVKZO0vTt3A6i5zhlPMAM272B16zgU/kmF+iXaMxiG08cgGdOUDbKe3jPSB8njPhAmdmbDEzKHXH1wgK7FHkKq4qFMFQZemySlQy08PR7i6wLhztcym5z6h8YSDcu07Bg8el3L5VP2bI1tLvDitjvukIRlkHkItMA7QbNAZ5eWjJI80gEriklWFtyt7NkbJxrQWZ1t/3xgMj4fvlGrX9vQV9EKWPLSrt8cRvBflVqEMGEuNYQbs2AlRS+NDvcNbawb4r+qTcPEPcsqoFUP1a6bBZ+6NlJkRvfR75Pt1t88FOdHInEfAtguSXNYyq2m9EY0n9A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E181F7746399F40BF913AF4688A9890@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7c554c-d663-4d59-7cd1-08d588f2a9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 14:56:55.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DEv8nT015751

On Tue, 2018-03-13 at 22:32 +0800, Ming Lei wrote:
> On Tue, Mar 13, 2018 at 02:08:23PM +0100, Martin Steigerwald wrote:
> > Ming and Bart, I added you to cc, cause I had to do with you about another 
> > blk-mq report, please feel free to adapt.
> 
> Looks RIP points to scsi_times_out+0x17/0x1d0, maybe a SCSI regression?

I think that it's much more likely that this is a block layer regression. See
e.g. "[PATCH v2] blk-mq: Fix race between resetting the timer and completion
handling" (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18338.html).

Bart.
