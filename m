Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZocmjW5YBjQQzncJVmtPbZhNPBFYAx5jTVFWS9BL264osih5bdsWqL7MIQmHOPodX+RY3md
ARC-Seal: i=1; a=rsa-sha256; t=1525192703; cv=none;
        d=google.com; s=arc-20160816;
        b=CZUTa1aRr0gad9W7/nFTB5s6rDLconAHqyybwjVZ/mLv4jJPooTUTwXK2R45WWDNuT
         cgWpP40ZykhiBpKLkI/D/9vXcSQkBKpbP32JJZV+Vdq0eg2tQhKLTd203mQwg6QPr+u2
         w9JfKFKutbftBw3EY2sixYUJjhhvZU5LtydnTGxbl4E5ojQhCKxlWvczQH1gHrcD+Gpm
         XD7rNylRK5R6dTLLHsj+haHhaVLlWUAhAUiVDBiyry/CeBQiZczgFEBHIvXPsRGIX2Wi
         WIygE0eR2z1Rq36PC/5x4IGSQRU+HH7ayQI7XPt3Y92QSer2CVinA8qZniDzqaLzXC15
         W0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:dkim-signature:arc-authentication-results;
        bh=c68QcStI/InYMz+DQLKZPgmWLmy4BF5bzZakWNO5WiE=;
        b=cM0Lsr6ARIKrcMA+cu7XTCItt66twFWYRB94hNVlkmZqMaGQyY8IfRN5yOo2LohCaZ
         Ezo6cO8RUMNcgfar+rloJQsZNiMtsS3STBpmYGocu/pb48sBN2NO6Ys+kVp4cwkT9r+h
         Z0GLTGsW9mZK8Moz3M9GBMJshHMZ+LpadhO33AOE5175ASuhdOHFoQwUrMU7X3XguEW4
         jwith3CZREvkU1xnHlCn4DQH9l6gR513RIA6c+4XCyNRkP2/mbpJWt3CyPzMTfmX+s6n
         nFJXnZYdinLYSC2p4B22lqMRpfOVLHw+aCuzRu9o3x9s5UK0e0ghwA8DIVnGyFrd0MfV
         0RaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=kcxse60j;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.121 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=kcxse60j;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.121 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
CC: Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: bug-introducing patches
Thread-Topic: bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0Q==
Date: Tue, 1 May 2018 16:38:21 +0000
Message-ID: <20180501163818.GD1468@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0887;7:Bgm020jiwvGFs1GvqRwWEMmbmiUJGvi/rEeNACVWeeLwZBIjTxcYI6MMeUUfGK+kAK1Qf5okgEKWziwbKPAcVezPjbFR5PL6rkc7/nRZYsjplaazEMHgU+7Y6iEjLCz65heIzqFX8nJHrvzq5HjdTRPZ0uxfVzZL32L5u8Tz3ZHEZ+Jx0WWlBBV8BFAfYsbX7NWSQQBb1Yn5FRqPzFZGemHBxKrdAQaWVYMqpxO61d07QsbjCHaIfHKwxbARBQos;20:SiXzO7q3P7L9H9rmmsSNf1xH8c31KDESBlGBanPmSQFSqVWCL8NA3G4sgb/mOP2zhWTyr2jVqDZG3FHCpkZvcolFwjSy5Ypr2vpjMaU+G3r9Vj24Cj8TFEi30umFC9VdG43/ThM9a/ItcZPu8EJHmZ7MiLCyqyZzZ5vB5g3prJ4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0887;
x-ms-traffictypediagnostic: DM5PR2101MB0887:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0887BAA08C319A666FFFB84DFB810@DM5PR2101MB0887.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0887;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0887;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(39380400002)(346002)(39860400002)(396003)(199004)(189003)(14454004)(10090500001)(86362001)(5250100002)(305945005)(3660700001)(6486002)(81156014)(81166006)(8676002)(8936002)(3280700002)(106356001)(72206003)(33716001)(105586002)(186003)(6916009)(2501003)(99286004)(10290500003)(478600001)(68736007)(3480700004)(7736002)(26005)(25786009)(316002)(6436002)(86612001)(53936002)(97736004)(6506007)(102836004)(66066001)(22452003)(5660300001)(2351001)(54906003)(486006)(33656002)(5640700003)(3846002)(9686003)(6512007)(6116002)(476003)(1076002)(4326008)(33896004)(2900100001)(561944003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0887;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qB24hqJRMBUDumg5jGcyNsn4aHbufp1Vu+4Ppnp5rxeyXuW3Kt33KHkQyCwSyo3hZtKgWXMasXvbV6sgXCc71ORKPMxVF3p/ATNKJfHaPfc69pq9vV8vU+wPteBDJWHXrPGbSxdoVCfs+0R+wPD2Zla8LhvHzz5Th2Cc7IzRdinW5ZUQ5N0BrME9FcPxwT9K
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <86E8C4986260EF4295B63073D067B2CB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 96aec977-70e0-4a4e-5d3a-08d5af81f38d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aec977-70e0-4a4e-5d3a-08d5af81f38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 16:38:21.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0887
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599280464106480109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Working on AUTOSEL, it became even more obvious to me how difficult it is f=
or a
patch to get a proper review. Maintainers found it difficult to keep up wit=
h
the upstream work for their subsystem, and reviewing additional -stable pat=
ches
put even more load on them which some suggested would be more than what the=
y
can handle.

While AUTOSEL tries to understand if a patch fixes a bug, this was a bit la=
te:
the bug was already introduced, folks already have to deal with it, and the
kernel is broken. I was wondering if I can do a similar process to AUTOSEL,=
 but
teach the AI about bug-introducing patches.

When someone fixes a bug, he would describe the patch differently than he w=
ould
if he was writing a new feature. This lets AUTOSEL build on different commi=
t
message constructs, among various inputs, to recognize bug fixes. However,
people are unaware that they introduce a bug, so the commit message for bug
introducing patches is essentially the same as for commits that don't intro=
duce
a bug. This meant that I had to try and source data out of different source=
s.

Few of the parameters I ended up using are:
 - -next data (days spent in -next, changes in the patch between -next tree=
s)
 - Mailing list data (was this patch ever sent to a ML? How long before it =
was
   merged? How many replies did it get? ...)
 - Author/commiter/maintainer chain data. Just like sports, some folks are =
more
   likely to produce better results than others. This goes beyond just "ski=
ll",
but also looks at things such as whether the author patches a subsystem he'=
s
"familiar with" (=3D=3D subsystem where most of his patches usually go), or=
 is he
modifying a subsystem he never sent a patch for.
 - Patch complexity metrics - various code metrics to indicate how "complex=
" a
   patch is. Think 100 lines of whitespace fixes vs 100 lines that
significantly changes a subsystem.
 - Kernel process correctness - I tried using "violations" of the kernel
   process (patch formatting, correctness of the mailing to lkml, etc) as a=
n
indicator of how familiar the author is with the kernel, with the presumpti=
on
that folks who are newer to kernel development are more likely to introduce
bugs

Running an initial iteration on a set of commits made two things very obvio=
us
to me:

1. -rc releases suck. seriously suck. The quality of commits that went in -=
rc
cycles was much worse that merge window commit:
 - All commits had the same chance of introducing a bug whether they came i=
n a
   merge window or an -rc cycle. This means that -rc commits mostly end up
replacing obvious bugs with less obvious ones.
 - While the average merge window commit changes, on average, 3x more lines
   than an -rc commit, the chances of a bug introduced per patch is the sam=
e,
which means that bugs-per-line metric of code is much higher with -rc patch=
es.
 - A merge window commit spent 50% more days, on average, in -next than a -=
rc
   commit.
 - The number of -rc commits that never saw any mailing list or has never b=
een
   replied to on a mailing list was **way** higher than merge window commit=
s.
 - For some reason, the odds of a -rc commit to be targetted for -stable is
   over 20%, while for merge window commits it's about 3%. I can't quite
explain why that happens, but this would suggest that -rc commits end up
hurting -stable pretty badly.

2. Maintainers need to stop writing patches, commiting them, and pushing th=
em
in without reviews.  In -rc cycles there is quite a large number of commits
that were either written by maintainers, commited, and merged upstream the =
same
day. These patches are very likely to introduce a new bug.


I don't really have a proposal beyond "tighten up -rc cycles", but I think =
it's
a discussion worth having. We have enough data to show what parts of kernel
development work, and what parts are just hurting us.

I'd be happy to gather more data if someone has an idea he wants to look
into. The data used for this work is based on:

 - v4.4..v4.16 (just becuase it's as far as linux-next-history goes).
 - "bugs" are commits that were mentioned in a Fixes: tag of a later
   commit.
 - "stable commits" are commits that made it to a -stable tree.
