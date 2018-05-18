Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeERB1G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:27:06 -0400
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:12258
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751839AbeERB1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:27:04 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "sultanxda@gmail.com" <sultanxda@gmail.com>,
        "tytso@MIT.EDU" <tytso@MIT.EDU>
CC: "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Thread-Topic: Linux messages full of `random: get_random_u32 called from`
Thread-Index: AQHT7kdToFVQBFTDwEKKqlsN6SNLmg==
Date: Fri, 18 May 2018 01:27:03 +0000
Message-ID: <1526606822.30073.64.camel@impinj.com>
References: <20180427201036.GL5965@thunk.org>
In-Reply-To: <20180427201036.GL5965@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3723;7:Kg2uaW+ZhX9dgueVp7A81YK+XSoEjqpFYl+pBp9sSAjibV4ZDf2MvHTb5zXyocKU4dk98Fzk+SAa9t1/e8E+h+9HAHe3qnGw+bVpZKco47WgpKTAocKzzgnzFLErFKMbPoGPfyegKey72fPb2rYIPc+dVSCkDrpqiyKvX1f5djGhPCEVDOLYVCcTritToXvcnU90gpZmW75GxWZnU1AYe+V+FiWnJeF2qg+BRYVdNn8qzMFC9AOi2Ckb2nMgAV9f
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3723;
x-ms-traffictypediagnostic: MWHPR0601MB3723:
x-microsoft-antispam-prvs: <MWHPR0601MB3723FC389B4AAEFBC965A7A4D3900@MWHPR0601MB3723.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3723;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3723;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39850400004)(346002)(396003)(366004)(377424004)(189003)(199004)(103116003)(6436002)(8936002)(3280700002)(6486002)(2906002)(316002)(6116002)(105586002)(15650500001)(14454004)(3846002)(66066001)(5660300001)(106356001)(7736002)(54906003)(53936002)(2900100001)(86362001)(110136005)(68736007)(102836004)(2171002)(6246003)(5250100002)(229853002)(8676002)(478600001)(2616005)(486006)(551544002)(26005)(25786009)(6506007)(2501003)(6512007)(99286004)(4326008)(36756003)(305945005)(3660700001)(476003)(76176011)(59450400001)(186003)(97736004)(446003)(39060400002)(81156014)(81166006)(11346002)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3723;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: z8Dd/r3dUuvMcO4tegCYOf6ZwrdR2qhar/s+z7+6WV5BzDeHu0gEuwFyn54j1By/YhR38KOZ7BzH5t6Ng3ZNgqJnM4z42U0pDZWcv/B3V0cRIeeQxScy/zgsF/3ATz9m3qu+FJj4IF82znb7BeXx06yDT//BFAVUfY6RMNe8SQn7qDhwLUxJpZdmk8M7Z2w5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EB99662EB35B443A510FA156852A4EE@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6f68de5a-f1c6-44f5-08b2-08d5bc5e75c2
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f68de5a-f1c6-44f5-08b2-08d5bc5e75c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 01:27:03.0766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3723
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4I1RCpa025580

Since I wasn't on this thread from the start, I can only find a way to
reply to message in mbox format on patchwork, and this seemed the best.

On Fri, 2018-04-27 at 16:10 -0400, Theodore Tso wrote:
> 
> 
> This is why ultimately, we do need to attack this problem from both
> ends, which means teaching userspace programs to only request
> cryptographic-grade randomness when it is really needed --- and most
> of the time, if the user has not logged in yet, you probably don't
> need cryptographic-grade randomness....

I've hit this on an embedded system.  mke2fs hangs trying to format a
persistent writable filesystem, which is where the random seed to
initialize the kernel entropy pool would be stored, because it wants 16
bytes of non-cryptographic random data for a filesystem UUID, and util-
linux libuuid calls getrandom(16, 0) - no GRND_RANDOM flag - and this
hangs for over four minutes.

Some things I've seen here don't work in the embedded world.

The user will not log in.  No one logs in.  There are not even user
accounts with a valid password that could log in.

The storage comes pre-written with a static image from the manufacturer
or is programmed from a static image via JTAG or some other out of band
step.  It cannot be different from device to device when it first
boots.  No saved entropy.

The bootloader gets entropy from writable storage to give to the
kernel?  Can't do that.  The bootloader has no access to writable
storage.

I understand that if someone wants cryptographic-grade randomness early
in boot when that just isn't available and isn't going to be available,
then that isn't going to happen and lying to the consumer about the
randomness of the data isn't the answer.

But I just want UUIDs for a filesystem.  And the systemd machineid for
the journal file.  It seems the util-linux authors thought, apparently
incorrectly, that getrandom() without GRND_RANDOM was a good way to do
get it.

What is the right way?  The fact that so many userspace consumers get
it wrong might be a sign that this is lacking or at least very non-
obvious.

I want random data and I want it now.  It's ok if it's low entropy. 
This seems to be a very real, and unavoidable, thing in early boot. 
And crng_init == 1 seems to be the intended way to do this.  What's the
way to get random data of crng_init==1 quality without blocking?
