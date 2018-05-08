Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-3380544-1525811368-2-13581228857402395773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3,
  SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525811367; b=TPVKjc8qTDRjZiyPtcdl8/MaSXHnFLIYJwh2EGgjPRMFaI4WIR
    iO5KCTEg6czmSFs2OdBzfMUvzO+YPyYpBKzsgUYj4INTT20yQOR+/1hxxYO0SbAh
    4EonAcpHWHWOdzoVCRWdOTIaqvbQ2+Aah9D0oWTvKbYd+S2ZmFcgmt5+DdJMW1r+
    ASZhZiDk6luh3pH7wOUpMp6TorAvaqmCIfnb+mtzQ9n6gbcLqAWY82w8L9GLHtgZ
    PmjiRRS+6RGo37JEDF5qWE118QJSdS8P5anbOf5WR3m9RUtTGuk0E9Viihi61eSv
    gXqYvzO1SnemNmz8cKoRisj6GV2uqzQ6RH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525811367; bh=c9vXvvmEAPxIo//PMT8B3Wb4RGCoRuPp3RrRXiSfXeo=; b=c
    OXyKaDjv0ihOuOonk/I4WFhaMDfzaKQN2kJ08dvgzOv+PKiQxZAg74zt7QixZGPf
    uXUqc+8YonXDaJN3LaYtEbpofCBfzGx3wGfFvt8g0ntJuARTCV/wQPXzOerTolGk
    /SczuCNBqn1p6a9DVwZL5knyTYEq7CBdzGAeC5ww13RGNfaZDmijRrv+jsR2hNpz
    N/niA+u9SNco+ZMTPo8TP7oIoOnsr0rAq4Xx11Km+c6RK1C7JyF+VmjmzyVsiZE2
    Uze9+D7GEuaT917TB7MrCDEg2SLmczvoynVvm7A/SFU2r2Vg3qkPVt5gBwgHwVWJ
    z0db5WAyq6dA7+0a4gPqw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=O1eEk9sc
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=lists.linuxfoundation.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=lists.linuxfoundation.org
    header.result=pass header_org.domain=linuxfoundation.org
    header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=O1eEk9sc
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=lists.linuxfoundation.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=lists.linuxfoundation.org
      header.result=pass header_org.domain=linuxfoundation.org
      header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEbXTKh96ZkHrlHZNmbxz8I7qIv8odCRdPHngcPg6NVodaSblKzP3B+Pm21wYdJ8cgU8hGbN8KsZrgJab4Nhp31weFFEEi10Z0yEDLMwN/YbN6wUDyZX
    wyzA4TzenpWXfTkS3XmSlsSl8/O1HkFG5YSL+5vsyI1byrwGHdrahMynSzxbfLX65GNr+dZzEuAy5QEj9wzuyz4jouHaBcM3wJBEzAIo4zaVoogGfvQ1us4N
    rCjJpJv9xmNTHWzsBhaueg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=JJQRklT086CtHC-DC4MA:9 a=UUfk7xIMaEQefmOf:21
    a=1S4tLEA0oVtO3WPs:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Tony Lindgren <tony@atomide.com>, Greg
	KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAAHfYCABoLCgIAAFJYAgAEXpAA=
Date: Tue, 8 May 2018 20:29:14 +0000
Message-ID: <20180508202912.GC8514@sasha-vm>
References: <20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
In-Reply-To: <20180508034820.GE999@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0939;
	7:uQzoTezht1WfFTl3t3r06WeM7eFCYNxbIr+doIDkUgL+hpaabRV/R2Kvciionukq8q0GQfbDCxO7C48bAiNfE9BQF/5i6TuVpxzksbFQG/Bmq+t2HFuIq5FRrlgjfpAZTKkjy9vNwaFrvm5RQ112f/kBC/2u/s4KU1n4PgRr8kQPLOd7nVbDgswbgbFwE8ytLTm2tJ1jdn5ToY9BqE/qs6G0pHuTmscFQ70lqzQxoZEVWn585Ib9/dxsSFAgW7W7;
	20:5bw+H8Ks70GQO8qTWFxFg5nUVoZxiMSnWwNgm89xXqhoj+cCkVGqXewI1XwnCSCHBHWm3ShO8tjhEzvh3QmKxFwbh76h7niBy8sVTpaAeQBvlOZdeLRO2wMcGET2KRiVfuh6ApraAYplaND23QwnpuSXA0bio48aBR/xiPENVxc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
x-microsoft-antispam-prvs: <MW2PR2101MB0939A31E9B57580C52337CA7FB9A0@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
	SRVR:MW2PR2101MB0939; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(39860400002)(39380400002)(346002)(396003)(366004)(376002)(189003)(199004)(51444003)(3660700001)(14454004)(1076002)(33716001)(72206003)(59450400001)(81166006)(6506007)(105586002)(486006)(5250100002)(8936002)(33896004)(2906002)(2501003)(8676002)(3280700002)(229853002)(478600001)(2201001)(5660300001)(76176011)(9686003)(106356001)(97736004)(6116002)(86612001)(6512007)(10290500003)(476003)(3846002)(99286004)(6246003)(53936002)(81156014)(86362001)(2171002)(26005)(93886005)(10090500001)(6346003)(68736007)(110136005)(305945005)(102836004)(11346002)(66066001)(6486002)(7736002)(2900100001)(6436002)(22452003)(186003)(446003)(25786009)(316002)(33656002)(781001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0939;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: jjDi8AhG6iN8usLb0qvqySLr+5ddlNHf6KeXPMNUT/7lEkA4AyT3XpcFjwgTf9BgvRDbldYWr9Hoi6sT2lLrl1xLfcqBeUQya0/uvnIANZwi0yzeuiWmt7qLrdm0o7zHU2USFJOkjHD4EYhRr7G3jYNk1AV3xz+dqYO3JOjpb15IqBYs8dHwlp0NGjW2cilx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <C71BF657BE9FED458B00B2D7705208E7@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b2ef8cd9-e07a-4b23-6253-08d5b5225dc4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ef8cd9-e07a-4b23-6253-08d5b5225dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 20:29:14.7272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
From: Sasha Levin via Ksummit-discuss
	<ksummit-discuss@lists.linuxfoundation.org>
Reply-To: Sasha Levin <Alexander.Levin@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 11:48:20PM -0400, Theodore Y. Ts'o wrote:
>On Tue, May 08, 2018 at 02:34:41AM +0000, Sasha Levin via Ksummit-discuss wrote:
>>
>> Tony, I'm curious, how many users are you aware of who actually run
>> Linus's tree? All the users I've encountered so far on Azure seem to be
>> running something based on -stable.
>
>The people who run Linus's tree and test -rc kernels tend to be kernel
>developers and individual users who want to run bleeding edge kernels
>and who generally are technically clueful.  If you were talking about
>SLR cameras, you'd call them the "prosumers" segment of the market.
>
>It tends to be more on desktops and laptops, so it doesn't surprise me
>that you don't often see them in a hosting environment where you have
>to pay $$$.  (And where you do see them in a hosting environment, it's
>probably for things like gce-xfstests.)
>
>> I think that a question we should be asking ourselves is whether we
>> should be basing our decisions here on the assumption that (pretty much)
>> no one runs Linus's tree anymore?
>
>These people *do* exist, because as a maintainer, I get bug reports
>from them.  (And sometimes as a user, I send bug reports when running
>-rc kernels to other maintainers, such as the i915 drivers and the
>Intel Wireless driver folks.)
>
>Such reports are incredibly valuable and precious to me, since it
>allows me to find problems that weren't picked up in my own testing.
>(In the case of Intel Wireless, a while back the IWL team didn't have
>Aruba Enterprise Access Points in their test hardware library, so I
>found a regression after the merge window because I was running -rcX
>on my laptop, and wireless access to googleguest network broke.  If I
>hadn't been running -rcX, they probably wouldn't have discovered this
>problem until after that particular kernel had been released.)
>
>So keeping those users happy is a good thing; since they tend to be
>very technically clueful, they can do bisections for you, and they are
>able to give a detailed and useful bug report.  If they report that a
>regression that was introduced in -rc2 is fixed by a particular patch,
>I want to push it into -rc3 immediately, and not let it stall in
>linux-next.  If the reason why is because you don't trust my patch
>because it "only" got tested by the technically advanced user
>reporting the regression, then don't take patches from -rc3 into your
>stable branch right away!  Let it bake in Linus's tree anfor a week or
>two, instead of demanding that patches stick around in Linux-next
>before flowing into Linus's tree.
>
>Because I will guarantee you this --- there are more real users
>running Linus's tree than linux-next.  This is because Linus's tree
>tends to be far more stable than linux-next, since after -rc2
>linux-next starts getting the first set of experiments for what will
>be going into the next merge window.  So while I am willing to run
>something based on -rc2 or later on my laptop, there is no way in heck
>I would be willing to put linux-next on my laptop.  That's just way
>too exciting for me....
>
>Would I pull down linux-next, and fire up a VM running gce-xfstests?
>Sure.  But that's not a real-life use case; that's just running canned
>test cases.  And more often than not, linux-next will be broken while
>Linus's -rcX tree is just fine; which is why I do most of my ext4
>testing using patches based on top of -rcX, not based on top of
>linux-next.

This is interesting. We have a group of power users who are testing out
-rc releases, who are usually happy to test out a fast moving target and
provide helpful reports back. We also have a group who run a -stable
kernel (-stable build/distro/android/etc) who want to avoid having to
report bugs to us.

What we don't have is a group of people who use Linus's actual releases
(not the -rc stuff, but the actual point releases). Power users will
move on to the next kernel, and -stable folks won't touch that release
until there's a corresponding -stable.

Even rawhide, like Josh mentioned, will just fill back with the merge
window commits after the release of an older kernel.

So the problem I'm seeing is that since a merge window is open only once
every 2-3 months people will sometimes try to push poorly tested code
just to make that merge window. Additionally, as later -rc releases
start showing up people will again merge poorly tested fixes just to
make it in time for that release.

For both cases, people will push poorly tested code in the kernel just
because they want to make it in time for a kernel release that no one
will actually use.

What if, instead, Linus doesn't actually ever release a point release?
We can make the merge window open more often, and since there's no
actual release, people won't rush to push fixes in later -rc cycles.

We take away the incentive to push poorly tested code. Maintainers still
free to commit anything they'd like, but there's no reason to commit
code they're not confident of just to make it to a random release no one
will use.

Merge window will happen more often, so there's no real reason to rush
things in a particular window, and since -stable releases every week
there's no rush to push a fix in since the next release is just a week
away.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
