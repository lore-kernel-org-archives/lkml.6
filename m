Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZoclRflElEOOLVjznEF6HjM33cLVn5vQ5IT/ntW3PXsIkaRIx1GUM6I5V2dPh3+Oj9RmK9J
ARC-Seal: i=1; a=rsa-sha256; t=1525746882; cv=none;
        d=google.com; s=arc-20160816;
        b=FxK1gaX5ZoR9RZc9AQlnrFFd315dbBc1mDO2BS5qv+67FDSKzfQoehm+rCesuvUabH
         /UHV/6smDuYhYHUzCXBIubI+9DLoG/mim6cMvSqnGa+o5qGPMrs7i9B//pcyPrlAfAw5
         Qzr9uxZ3bJ7XksbUA8BQeMA9sWzcWaDD1yynt6NjrCgkRK82ig9cS3IrOoMJT2GuL82u
         C6Hdqq1W6oVBU1XKiVf3We4LNd+eFIKGIhYBti1BhufdD9bM3/szt4QeuNutf5v7VjzK
         Vq1o666NXngXPZuRQ9rnv3txd40dimpQ/7mmsUz4c+5NUskJ++SGd3rQ5f2hvNU92VsQ
         wx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7AdxIkDHk0fOg9++UuE/73FJxKaah3RutN6+xror8K8=;
        b=x7QPCa6GkJyIxVzEt5+DzZ04zWhBu4Br5mw68c2Gcvb9UUmmo1TmzMNKYl1pxQ8rSX
         T/BKIzkX/kSZW+5OIoYyxv18MAojXVWRj4R4MbQtGe8JpQSxPb+KWXfPOuTfuoFhMDGu
         eWs1CYkeKxPzajd2edneFMUlTMV/HcOXYSnNbtsBc91ajMRfZUWCWxoEX7zfAbh6f+s5
         TRur4QlFEhTUd3PI0dUdPknyZOgbTrgnqaHMWEb/AeVw1xcTtwZiujiapcZ5LWi37yId
         Cgk5cQHkbRobJiVwsdSUDhj1ssicIyFX/9UUXuV7x8Kv6cNGJWZrU2waum4p/0UlpHZ6
         QWUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=O5Y5E6Wd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.113 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=O5Y5E6Wd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.113 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Tony Lindgren <tony@atomide.com>
CC: Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAAHfYCABoLCgA==
Date: Tue, 8 May 2018 02:34:41 +0000
Message-ID: <20180508023439.GA8514@sasha-vm>
References: <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org> <20180501211551.GI2714@sirena.org.uk>
 <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
In-Reply-To: <20180503230905.GA98604@atomide.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0972;7:wElzl2ghjDBLJsbB7ue1hKH8rT+hKzrsJeExl9vR8aPYKnHHiwZGwG3S7iTWRpQus6qwHexgh+JyaAf0yWhdEHYlNHQnccPStLsFXbkE9BMAPtzO3bRR/RO1m8qNuyKBELiVbScD2x73mg4u4iZldYvnWznHiEt+cCStv/doHjXEd/Lg0SH/PVRjNodsH11zniVcfXn8zjwCp5zwLAmDinOOpab3jpeV3PNdJn7/0HgVagE7DJowdcfRagDE+Dh5;20:nUIFnDwDgzcP3fGvDbu0gkq34HekXUemUQ47yA6Ulh0f1/yLFT6u0dh3aMiZQklYb+VHfVZKuPZW1zQdB3AY2L28iCXFyFDIYUokZGLyzXu9efZOnd58IdK6BBXDIFBOesGn3FC55ZKp68/NTGA7+4g6FMTDqkjW/aol8q5kneI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB0972;
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-microsoft-antispam-prvs: <MW2PR2101MB0972005460870A8F752C3268FB9A0@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(211171220733660)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0972;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0972;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(366004)(376002)(39380400002)(346002)(396003)(51444003)(199004)(189003)(102836004)(33896004)(6506007)(76176011)(26005)(81156014)(59450400001)(81166006)(8676002)(93886005)(5660300001)(8936002)(14454004)(68736007)(22452003)(316002)(7736002)(86362001)(3660700001)(6346003)(186003)(3280700002)(54906003)(97736004)(99286004)(2900100001)(229853002)(2906002)(6116002)(6916009)(86612001)(9686003)(305945005)(6512007)(53936002)(6486002)(3846002)(106356001)(105586002)(33716001)(10090500001)(72206003)(6436002)(33656002)(5250100002)(478600001)(486006)(10290500003)(6246003)(4326008)(446003)(25786009)(11346002)(476003)(66066001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0972;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: q1xdnv4FsC8F5AlQx9qZjscdHXrVoDrCrKD+ZzCxnIWPg/+IVySUWZbTE/E34WXlpBKbMu/hJ0p+VXO8QMuk5QtQG6Q4Qf42hlUx3jiaK/bnxNUmkxNmWuhA9h54WRrd3neLAzDLrrBMc0PTG0lBUahCZPmG41ZkpFWOsrrhbCRl4IGnXL30UGPOqAFgmoJt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6B1108CD5764A47BA8957C886ED814B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8ab3f2da-2c47-472c-4f63-08d5b48c406f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab3f2da-2c47-472c-4f63-08d5b48c406f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:34:41.1001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599861563385556474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 04:09:05PM -0700, Tony Lindgren wrote:
>* Mark Brown <broonie@kernel.org> [180503 22:44]:
>> On Wed, May 02, 2018 at 08:52:29PM -0700, Guenter Roeck wrote:
>>
>> > As for -next, me and others stopped reporting bugs in it, because when=
 we do
>> > we tend to get flamed for the "noise". Is anyone aware (or cares) that=
 mips
>> > and nds32 images don't build ? Soaking clothes in an empty bathtub won=
't make
>> > them wet, and bugs in code which no one builds, much less tests or use=
s, won't
>> > be found.
>>
>> You've been flamed for testing -next?  That's not been my experience and
>> frankly it's pretty horrifying that it's happening.  Testing is pretty
>> much the whole point of -next existing in the first place so you have to
>> wonder why people are putting their trees there if they don't want
>> testing.  I have seen a few issues with people reporting bugs on old
>> versions of -next but otherwise...
>
>Yes I agree testing Linux next is very important. That's the best way for
>maintainers to ensure a usable -rc1 after a merge window. And then for
>the -rc cycle, there not much of need for chasing bugs to get things worki=
ng.
>
>Bugs reported for Linux next often seem to get fixed or reverted faster
>compared to the -rc cycle too. I think that's because people realize that
>their code will not get merged until it's been fixed.
>
>So some daily testing of Linux next can save a lot scrambling after the
>merge window :)
>
>Users don't usually upgrade kernels until after later -rc releases or only
>after major releases so that probably explains some of the -rc cycle fixes=
.

Tony, I'm curious, how many users are you aware of who actually run
Linus's tree? All the users I've encountered so far on Azure seem to be
running something based on -stable.

I can't really get any solid statistics about that on my end both
because I don't have visibility inside user VMs (I don't actually have
prod access believe it or not), and even if I had it would probably be=20
confidential, so I'm just basing this on reports from user's I've seen=20
so far.

I think that a question we should be asking ourselves is whether we
should be basing our decisions here on the assumption that (pretty much)
no one runs Linus's tree anymore?=
