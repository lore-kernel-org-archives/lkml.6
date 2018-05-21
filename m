Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeEUSjz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:39:55 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:12512
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751087AbeEUSjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:39:53 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "tytso@mit.edu" <tytso@mit.edu>
CC: "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sultanxda@gmail.com" <sultanxda@gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Thread-Topic: Linux messages full of `random: get_random_u32 called from`
Thread-Index: AQHT7kdToFVQBFTDwEKKqlsN6SNLmqQ0xEiAgAFWBgCAAAdxAIAEZ+UA
Date: Mon, 21 May 2018 18:39:50 +0000
Message-ID: <1526927990.31570.81.camel@impinj.com>
References: <20180427201036.GL5965@thunk.org>
         <1526606822.30073.64.camel@impinj.com> <20180518023209.GD15263@thunk.org>
         <1526684178.31570.26.camel@impinj.com> <20180518232256.GA23628@thunk.org>
In-Reply-To: <20180518232256.GA23628@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3756;7:hV321DN8skmPS1C6luiyFFyunHn2/61BdpKTYt/YEYowPali0SJHwiSTfrgxGiZYC7L0bo9ZgPLXbzFsGCp5GPE33Aw7s7xsCVQFda+5/KN56ODulRO9N3xgTnnqChH+o6YsmAN6HK7b5ggOqQ9+95AQaiq9gm5EdY7FupRBIDgImppODRXYPyBcPItkX2Ky/DESUrusgC131vVeUkvv2L3/wZo2Jp3f7y8UkZrkvww0pPAZNjxRg1jJ2Ijn5ALj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3756;
x-ms-traffictypediagnostic: MWHPR0601MB3756:
x-microsoft-antispam-prvs: <MWHPR0601MB37564E48E57C84DBCEBCB642D3950@MWHPR0601MB3756.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3756;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3756;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39850400004)(396003)(366004)(377424004)(199004)(189003)(2171002)(6512007)(6306002)(103116003)(186003)(3660700001)(14454004)(6246003)(39060400002)(6916009)(15650500001)(8676002)(1730700003)(81166006)(81156014)(8936002)(446003)(97736004)(66066001)(486006)(2616005)(2351001)(476003)(11346002)(53936002)(5660300001)(478600001)(54906003)(316002)(966005)(2900100001)(305945005)(7736002)(6436002)(99286004)(76176011)(59450400001)(6486002)(5640700003)(2906002)(6116002)(105586002)(3846002)(86362001)(106356001)(26005)(5250100002)(229853002)(2501003)(4326008)(36756003)(25786009)(102836004)(93886005)(68736007)(3280700002)(6506007)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3756;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8ZTMW857lCq+xCL+CDESlWtL5tI2Opsn8TdGUURguE54xH/rzYjvNxn0YIJZ+2Ob/4dBVCQV6yuZBZPKKlRP/9PZvB0bwuc3mm/rvEChZSl91bNrF1424CMTvKK9K4w+y5W5vwp18WF60Owzwo97P3VGlbun+G/aMhg0vF0Bu5nQBKGvNlwuhMVA3iqxFY4R
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F7D177694B4D4C804B9C4CA9476685@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 33ad705e-b0b3-4748-e6c3-08d5bf4a3cc5
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ad705e-b0b3-4748-e6c3-08d5bf4a3cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 18:39:50.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3756
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LIdxG2027639

On Fri, 2018-05-18 at 19:22 -0400, Theodore Y. Ts'o wrote:
> On Fri, May 18, 2018 at 10:56:18PM +0000, Trent Piepho wrote:
> > 
> > Let's look at what we're doing after this fix:
> > Want non-cryptographic random data for UUID, ask kernel for it.
> > Kernel has non-cryptographic random data, won't give it to us.
> > Wait one second for cryptographic random data, which we didn't need.
> > Give up and create our own random data, which is non-cryptographic and
> > even worse than what the kernel could have given us from the start.
> > 
> > util-linux falls back to rand() seeded with the pid, uid, tv_sec, and
> > tv_usec from gettimeofday().  Pretty bad on an embedded system with no
> > RTC and worse than what the kernel in crng_init 1 state can give us.
> 
> So what util-linux's libuuid could do is fall back to using
> /dev/urandom instead.  Whether or not you retry for a second before
> you fall back to /dev/urandom really depends on how important the
> second U in UUID ("unique") is to you.  If you use lower quality
> randomness, you can potentially risk getting non-unique UUID's.

Does it really matter how long one waits?  The fact that there is a
fallback that can be used would seem to provide a guarantee of
randomness/uniquness only as good as that fallback.

And here is the fallback, https://github.com/karelzak/util-linux/blob/m
aster/lib/randutils.c#L64

It doesn't seem all that great.  Can we say that the kernel, e.g.
urandom, can always provide random data at least as good as the above
without blocking?  If the kernel is always as good or better, then
what's the point of having the inferior fallback?

> If you don't worry leaking your computer's identity and the time when
> the UUID was generated, the application could also use the time-based
> UUID's.  There are privacy implications for doing so, it's not

libuuid will still ask for random data to initialize its clock file:

https://github.com/karelzak/util-linux/blob/master/libuuid/src/gen_uuid
.c#L281


> > It would seem to be a fact that there will be users of non-
> > cryptographic random data in early boot.  What is the best practice for
> > that?  To fall back to each user trying "to find randomly-looking
> > things on an 1990s Unix."  That doesn't seem good to me.  But what's
> > the better way?
> 
> We could add a new flag to getrandom(2), but application authors can
> just as easily fall back to using /dev/urandom.  The real concern I

I wouldn't say just as easily.  It's a more complex code path,
documented across multiple man pages and requires certain file system
access that getrandom() doesn't.  But it's certainly readily
achievable, so maybe that's good enough.  I think a flag to getrandom
would result in fewer mistakes in userspace code.

> have is application authors that actually *really* need cryptographic
> randomness, but they're too lazy to figure out a way to defer key
> generation until the last possible moment.

Would it be safe to say the the randutils code in util-linux would be
better off falling back to /dev/urandom instead of what it does?

If authors that really need cryptographic data use random_get_bytes()
or uuid_generate(), they'll get code that automatically falls back to
gettimeofday().  And probably not even know it.

I get your concern about lazy authors using an API that isn't
appropriate for their use case.

But we have this api already, in util-linux and code copied/inspired by
it, and it seems there are use cases where it is appropriate.  If we
make it better(*), then does the risk of it being used where it
shouldn't go up?

(*) Better: use the best available random data that can be provided
without blocking.


> There are other things we can do to add support in the bootloader to
> read an entropy state file and inject it into the kernel alongside the
> initrd and boot command line.  But that doesn't completely solve the
> problem; you still have to deal with the "frest from the factory,

This is problematic on a number of embedded platforms.

The bootloader might have no writable persistent storage to read/write 
this entropy from.  This requires drivers for the storage hardware,
ability to deal with the storage being in an inconsistent state, and
security of the storage.  Assuming hardware for writable storage even
exists.

So if I want u-boot to read/write an encrypted and authenticated flash
file system, there is a lot of code to put in the bootloader!  And now
we have to worry about that being exploited.  Maybe this means the
bootloader needs an encryption key that it didn't previous need have
access to.

Some systems have a limit on bootloader size and RAM.  Cyclone 5 is
64kB, which pretty much requires a two stage bootloader.  Arria 10 has
256kB and boots in a single stage, but bootloader features are quite
limited.  On imx23, it's possible to boot directly into linux with no
bootloader at all.  The cpu's rom can initialize the hardware enough to
run linux just from info in the mxs boot image format.
