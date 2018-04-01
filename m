Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeDADlE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 23:41:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37323 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbeDADlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 23:41:01 -0400
X-IronPort-AV: E=Sophos;i="5.48,389,1517846400";
   d="scan'208";a="178012442"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "wakko@animx.eu.org" <wakko@animx.eu.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqIA=
Date: Sun, 1 Apr 2018 03:40:56 +0000
Message-ID: <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
References: <20180331015903.GA29398@animx.eu.org>
         <CAFLxGvzbA9XzXLsH56iyqYkitrSnBbOzD977u4266=w5zw0jNg@mail.gmail.com>
         <20180331221252.GA25573@animx.eu.org>
In-Reply-To: <20180331221252.GA25573@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0926;7:sljiSI0RG7XF171rWor6BXeG4nLU65Ze2U8cYh73psayc7QT5G6Idya8cXNoely8QeARaHKDXE8pbiV9dcWxt1DK4Y9gmKCCGfN+WBJAdsr42mts/KmhIO6dzdpFXZjLXxKUpAYQ+1zXrCUW1Q3hA3z2B0xioL0QCOY8ccx9FFR/I2S5uVSGdJGyAx49tmA8oRVJWRP4XFjXBVbyc3JEgYuTTU8x61HbidW+mOKozNTjHJF0Re52BYCuBES1Jx+T;20:t5RWPpt9ivqI/CT52v5rGpRCGIQZCSurSfsBeIZWLSUGVr27qaMCOPW4BY2llsQQnEEEhqNCJwmUKY7Bz+XiKxZHGwlskcoAOvoVbXniNNl7cnxCike8Up75M0NgbNvjmDp59qLAGcIvMkdHk9aOXzwqL8FAcu07/gygVO9wH/8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39f1e763-6eb6-4656-282b-08d597826078
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0926;
x-ms-traffictypediagnostic: MWHPR04MB0926:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB09264553193D10A793B7531B98A70@MWHPR04MB0926.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB0926;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0926;
x-forefront-prvs: 06290ECA9D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(346002)(39860400002)(396003)(377424004)(189003)(199004)(86362001)(6116002)(66066001)(118296001)(2616005)(11346002)(36756003)(97736004)(3660700001)(2501003)(26005)(2900100001)(5250100002)(25786009)(186003)(68736007)(3280700002)(72206003)(7736002)(305945005)(39060400002)(54906003)(99286004)(110136005)(4326008)(3846002)(2906002)(105586002)(486005)(476003)(486005)(8936002)(76176011)(8676002)(6506007)(53546011)(14454004)(81166006)(59450400001)(81156014)(6436002)(106356001)(229853002)(102836004)(446003)(6246003)(6512007)(6486002)(316002)(53936002)(5660300001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0926;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XZuimLLNyVsfqSHmXzoRE/IslGiFZGlyyVotUszrw2RH/zfQXri17t3H59lRnIZpPjQhup8LtMFGGwSEoUGkvZ7UqlN9+cCO1xevW9drC8fWoq0LiBzI4G4fDFCDFDUr481AkaPeQUy1ErXVI+cdG+KNoJ+P7jzx/eo0PqpfT+TA8KXighdlEi1UOSZw9Y9a6mLFUaLrUmTn/lHZegxGj80BpaEXExDXdJGQXyIVYQNlbc+dbJUClv5XwGSOgaJ6bIhj9S+kG75pT4vI/osMmPpb96KZmXQsX18FjQJR79Yz3PwHilnRboYLFU5f57kLqw/Ui97aPHHPqKQfZDeppRbfyYIp5Di0G0QJoU4L4+3VR/dU7Qd+3efrm/RvcwrzaVKqepo+4nJWC2DIM90zpf4savdfBX1h6qtaysPONEs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF6EA897B30A794E917E4EB95C6C1A26@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f1e763-6eb6-4656-282b-08d597826078
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2018 03:40:56.2041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0926
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w313f7Dm021755

On Sat, 2018-03-31 at 18:12 -0400, Wakko Warner wrote:
> Richard Weinberger wrote:
> > On Sat, Mar 31, 2018 at 3:59 AM, Wakko Warner <wakko@animx.eu.org> wrote:
> > > I reported this before but noone responded.
> > 
> > Because you're sending only to LKML.
> > CC'ing storage folks.
> 
> Thank you.  I wasn't sure who I needed to send it to.

Hello Wakko,

Can you share the output of lsscsi? I would like to know whether or not you
are using a (S)ATA CDROM.

Thanks,

Bart.
