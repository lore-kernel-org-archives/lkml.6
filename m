Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeERW4X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:56:23 -0400
Received: from mail-sn1nam01on0121.outbound.protection.outlook.com ([104.47.32.121]:11435
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751851AbeERW4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:56:22 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "tytso@mit.edu" <tytso@mit.edu>
CC: "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sultanxda@gmail.com" <sultanxda@gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Thread-Topic: Linux messages full of `random: get_random_u32 called from`
Thread-Index: AQHT7kdToFVQBFTDwEKKqlsN6SNLmqQ0xEiAgAFWBgA=
Date: Fri, 18 May 2018 22:56:18 +0000
Message-ID: <1526684178.31570.26.camel@impinj.com>
References: <20180427201036.GL5965@thunk.org>
         <1526606822.30073.64.camel@impinj.com> <20180518023209.GD15263@thunk.org>
In-Reply-To: <20180518023209.GD15263@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3644;7:U2r5LnbvzocgdVXFJA6DoHWNjaFwj9p57F9LHfOiYJilbB/1GXfgN8/MFbttTu4D41DAbuymkOfCncEWb4VGhlJHRlMQuDjbWjjj2Ej5IyE31jEzNfY0HRKwtniAe5kFqCVZikIaosXXGTUzIk5As+ogSfPYFEdDNTG2u083qZje7x8cW56IuVwUhENmuNO+L9nudPDTp+6qiq8gDG+cLOD+exVaFLW2zmLzSLdi60tkNeI3UJig5yaRS+oxDLe6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3644;
x-ms-traffictypediagnostic: MWHPR0601MB3644:
x-microsoft-antispam-prvs: <MWHPR0601MB3644C779F3EE863803AA704CD3900@MWHPR0601MB3644.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3644;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3644;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39840400004)(376002)(346002)(366004)(189003)(199004)(377424004)(3660700001)(6512007)(8676002)(81166006)(2906002)(53936002)(68736007)(6486002)(106356001)(105586002)(229853002)(316002)(97736004)(5640700003)(3846002)(6436002)(8936002)(54906003)(2351001)(6116002)(3280700002)(81156014)(1730700003)(25786009)(76176011)(5250100002)(6916009)(66066001)(2501003)(5660300001)(14454004)(2900100001)(4326008)(103116003)(86362001)(26005)(478600001)(39060400002)(476003)(36756003)(2171002)(305945005)(11346002)(186003)(99286004)(102836004)(2616005)(446003)(6506007)(486006)(7736002)(6246003)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3644;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EfDzgba+H31ry7sdiQr8MSn+79W1ASVL4hLWbcByh4dUcJJObKdx2xUj1J4cq28Z+315FcFc1ejK1xj8kVpDwYPbCuuC3NtNdmyEJDMI1dl8F18T2DFOxqa/pEPeCAZEvD/qFy84jMs4yGqknze4e7p04hNmGCXJZIs27uZesMHSML6ClN1Lm1hZ19QLNMKw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D378EFCD4C8A648B26B80538AC38788@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cb4795eb-dd3b-4861-f619-08d5bd129161
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4795eb-dd3b-4861-f619-08d5bd129161
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 22:56:18.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3644
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IMuTQv029354

On Thu, 2018-05-17 at 22:32 -0400, Theodore Y. Ts'o wrote:
> On Fri, May 18, 2018 at 01:27:03AM +0000, Trent Piepho wrote:
> > I've hit this on an embedded system.  mke2fs hangs trying to format a
> > persistent writable filesystem, which is where the random seed to
> > initialize the kernel entropy pool would be stored, because it wants 16
> > bytes of non-cryptographic random data for a filesystem UUID, and util-
> > linux libuuid calls getrandom(16, 0) - no GRND_RANDOM flag - and this
> > hangs for over four minutes.
> 
> This is fixed in util-linux 2.32.  It ships with the following commits:

I feel like "fix" might overstate the result a bit.

This ends up taking a full second to make each UUID.  Having gone to
great effort to make an iMX25 complete userspace startup in 250 ms, a
full second, per UUID, in early startup is pretty appalling.

Let's look at what we're doing after this fix:
Want non-cryptographic random data for UUID, ask kernel for it.
Kernel has non-cryptographic random data, won't give it to us.
Wait one second for cryptographic random data, which we didn't need.
Give up and create our own random data, which is non-cryptographic and
even worse than what the kernel could have given us from the start.

util-linux falls back to rand() seeded with the pid, uid, tv_sec, and
tv_usec from gettimeofday().  Pretty bad on an embedded system with no
RTC and worse than what the kernel in crng_init 1 state can give us.

What took microseconds now takes a seconds.  We have lower quality
random data than we had before.

Seems like two steps backward.  Can't we do better?

How about adding a flag to getrandom() that allows the kernel to return
low-quality data if high-quality data would require blocking?

It would seem to be a fact that there will be users of non-
cryptographic random data in early boot.  What is the best practice for
that?  To fall back to each user trying "to find randomly-looking
things on an 1990s Unix."  That doesn't seem good to me.  But what's
the better way?
