Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZrW6bxa417akX6kVzp00fBse1R+4pM9d3s765dB0gnx6m6Bo5g4ruGaCjEPIn8nF48pTsY4
ARC-Seal: i=1; a=rsa-sha256; t=1525204823; cv=none;
        d=google.com; s=arc-20160816;
        b=MSTZLFau1RoSpZlc/YbZjfZeWx9G3ypliWX+CiF0mX2J1o/HTjTU+KcTpWDijonXg/
         hcXs/LVV0B26rIUbP6TVMRqWUzTrDlH+2btGWcwfdHWhjL/BnzH84A4XzB6e/tyBoMk3
         ee/sd96zVVghen1tISO3mUCxpNdS9dzXIMcpRV0ETstmVq2xifFwFzI15O/idX95OG3R
         B8ZWtRUweTCwQxDd0kQCtXmUqCOZ/S9qZCAzTiqf17YXq7j79ElK3KJMpSNuU6WjkYLy
         59aZPleZDYtTpI97nSr9oAli7Q2x/W0VwaK/A6kc/wsWq4IZvMoyz+iVD4hVSzWRFA45
         JXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=CRsN6OynTmdy3HSmiLpEZhk6UgiaYa7wp9icW0SRyLk=;
        b=ht6bAyrpvFDqY0RYYGm7gCTpFOQwzRxp/2o+NIH0+cxnqjI2++yRCsOAzbOZCdKSFM
         DSxAIi0eM1Zde54aJ8x3wtTagI5xu9DYgRcA9Kbo1Szt4lRgSGv6ZDxFtt6CeVNtJE+f
         6KYuQtvGSeEeccEQnyEuNONn9EDeREuWGu75imnNt6k0falNe5cTMm9s0xbqvjSxkgDS
         FymuMR6QEK4vxzOC7wRytODdDcbEjIC1vLr455V6KZ4C6JWkV/uVsdYGIUrNDScDPsqt
         HMrOF550xpFq99MFPmnteyy750qMsUngYaPbEGBr28J/Qj4Rta0rPwNCrAwK/5k08TqJ
         itZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ggvUB/iq;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ggvUB/iq;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, Greg KH
	<gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>, "julia.lawall@lip6.fr"
	<julia.lawall@lip6.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Thread-Topic: bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4A=
Date: Tue, 1 May 2018 20:00:21 +0000
Message-ID: <20180501200019.GA7397@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
In-Reply-To: <20180501194450.GD10479@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:iJE5zyNG95IecMr8qIDuEBUSvutROE0IB3ZxXhLANRsaDWP8YAAVI3AL4uEYngJGGf5kXhKTPjNs+tWZCvXq5hshxk+XPZSoKoy4z9pw+me5EAV2ZsCODGfQglziS/tWvrbPUiWYD12PzD3wR0rhpzyFdlqKIV3yzeLF3lhrQa3l6yms6q8AgPdv3ppmV46hAFUrIHHvCmldqlorvxO42PFcd3KKmGBBliMcOmCZ1039M6Yzdk3WgMBhTvL0zQRm;20:0sEQBSywEW04JBuQrhC9EDNUyVtgUhvEHiHitjes18lzYcUlnOzn5EqWMzBm/iW9R3/0ppBKfEhbYgqtOvdkimlROVT/P693FvwtV/5wq4DCwnLt2nSNmAU+WiGfDUK49z+BjdxRcfRr3ahz1wg++nSgfdEnJTO3M52nssoL1Dc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
x-microsoft-antispam-prvs: <DM5PR2101MB1046A040EB4D177A3485D6F8FB810@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(39380400002)(396003)(39860400002)(346002)(189003)(11905935001)(199004)(316002)(2906002)(6306002)(6436002)(81156014)(76176011)(33656002)(8936002)(3480700004)(81166006)(99286004)(8676002)(486006)(3280700002)(2501003)(22452003)(5250100002)(3660700001)(6346003)(25786009)(229853002)(6246003)(105586002)(97736004)(14454004)(59450400001)(2900100001)(33896004)(9686003)(1076002)(6512007)(110136005)(2201001)(53936002)(102836004)(2171002)(33716001)(6506007)(6486002)(10290500003)(446003)(86612001)(6116002)(11346002)(66066001)(478600001)(26005)(186003)(86362001)(476003)(5660300001)(68736007)(106356001)(305945005)(3846002)(7736002)(72206003)(10090500001)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Y1xW3yFAZlcLIJL/83/orPMFuMrRrejIWmt6ouq8fVLGB+9N9BeGPcZSoeULKKAtsD6tR9gSMgaWzk5AE+SyIkgLgAJ+zZfcNCJemTPr5Jb+zn102IRbBhIrmI5MyWP/sXHalI/z8p7yA9tRQCS42+TmUhY+XhCSvdAuEr1nMhpiHqoml7LdN3U3IN4FjDTw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0D810EDB3AC5E42909AD519468BA73E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ad0571b2-7366-4d5e-9df0-08d5af9e2bfd
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0571b2-7366-4d5e-9df0-08d5af9e2bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 20:00:21.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599293173204304513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 03:44:50PM -0400, Theodore Y. Ts'o wrote:
>On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:
>>  - A merge window commit spent 50% more days, on average, in -next than =
a -rc
>>    commit.
>
>So it *used* to be the case that after the merge window, I would queue
>up bug fixes for the next merge window.  Greg K-H pushed for me to
>send them to Linus sooner, instead of waiting for the next merge
>window.  TBH, it's actually easier for me to just wait until the next
>merge window, but please understand that there are multiple pressures
>on maintainers going on here, and the latest efforts to try to use
>AUTOSEL is just the most recent pressure placed on maintainers.
>
>The other thing is that when there is a regression users who are
>testing linux-next want it fixed *fast*.  That's considered more
>important to them than waiting for one, perfect patch, just to keep
>AUTOSEL happy.
>
>So please understand that when you say that maintainers *need* to do X
>or Y, that there you are not the only one standing in line putting
>pressures on maintainers saying they *need* to do something.  And
>quite frankly, I consider keeping people who are nice enough to test
>linux-next happy to be **far** more important than AUTOSEL.

Ted,

I'm not at all asking to wait before adding the patches to your tree,
or to -next. I'm asking to hold on to them a bit longer before you
push them to Linus because I can show that patches that don't spend
enough time in -next are more likely to introduce bugs.

Yes, linux-next users want it fixed *now* and I completely agree it
should be done that way, but the fix should not be immediately pushed to
Linus as well.

I've just finished reading an interesting article on LWN about the
PostgreSQL fsync issues (https://lwn.net/Articles/752952/). If you
look at Willy's commit, he wrote the final version of it about 5 days
ago, Jeff merged it in 3 days ago, and Linus merged it in the tree
today. Did it spend any time getting -next testing? nope.

What's worse is that that commit is tagged for stable, which means
that (given Greg's schedule) it may find it's way to -stable users
even before some -next users/bots had a chance to test it out.

This is less about AUTOSEL, and more about asking maintainers to
improve the testing commits get before they are sent to Linus.
Linus would rant about commits during merge window that didn't go
through -next, but for -rc commits this rule is somehow forgiven,
which is what I'm trying to change.=
