Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2718050-1525362236-2-5538923366449022663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3,
  SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525362235; b=aK32qA5CCkGEkovP/kQPwkfz64Ct+xGC2yc79EymARsMc8jCR5
    37+6ckvsqapZKYT9d4FY6ebDHZ//Cbhono71wUAXyVmJeu4uIiHk15JMtzutfTLZ
    9ViFxN9NwBd6csE3YqxzabkcqcMa/J5+nvm0aK3viPNDIGRPi+0ZvVBKWb0LTckq
    ijlqpC/bf+miRM4vZ21cwkY9jBtYrp75YzxKY0Gb7we+ria0Gr15P+jNzSXNYLta
    9tMH6pbwzd1vRV/xhUhcaSwlTsbeG4I/NWFtqxvDltmNGHkxWwlIs6E+4oEHb5VB
    Ymdp71frsKG7obmc7VhR1oJwTUQizsXl+3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525362235; bh=QxXUUDTNTXyZllbbemVY4iT00420qKbBgo0g7ZnXq6I=; b=P
    UXoq9pjnFI1K7zhbkwUE5YpSyed7pZIlohSLbKGWUzlc4BzzKRZUYBauUWBUvMPJ
    Xy/QvTBYN14HT01X9K7UtpOOU+Nko1Y+cCtD4IgyNxetnJbVXOGi9BNBQEkXKUTM
    eFfYGoUNh1Um/uJswkciqk3YTGtSVlr4KV+OwMRrhbe6jBEkncotZoH635/DLQAy
    81/yaR/8LJA1TbuCmyJm7XROYDB09Od6u/nFL5WadX6JCp+YHL2s2IEg2N2kVCSN
    mPyqkgEQ8Z/reC5rz62+Nwbw4t2WnCOc78wpXH97nbM0fg7jYT44AoaPPWt+vOL9
    Uev04kcOWSyHRpUaYHZVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=h4EP5mGl
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=h4EP5mGl
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
X-CM-Envelope: MS4wfIYKqIb7rGLfF9l320JRMDLNh+ClG8yPy85WTcjow7NZ/I3vpwPjdQneh+VB3q673orQvTwD/ohVSYKMDLpr/vgU4xObG24ry81uHf7OnifNWXoOaYYW
    0q1Q3KznPpwhTEKlkRWjsDMfj0grWy+I+6eBBF976ayHQXMQIWkb929sV42+nlmyJRqJUVyOMfkgpAzujZExJB12SLMYoc1svhNdcN4EBJ50MnDIxqxHJuC9
    +DbfdgIw+lfDdS73iX5imA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=U9FXQ-s5As2x2E2md9gA:9 a=wPNLvfGTeEIA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIACgPOAgAA5DwCAAARoAIAABNUAgAAGDgCAAARxAA==
Date: Thu, 3 May 2018 15:43:44 +0000
Message-ID: <20180503154342.GN18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org> <877eol808s.fsf@intel.com>
	<1525357984.3225.12.camel@HansenPartnership.com>
	<20180503144850.GC23311@1wt.eu> <20180503150608.GM18390@sasha-vm>
	<1525361268.3225.17.camel@HansenPartnership.com>
In-Reply-To: <1525361268.3225.17.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0924;
	7:qRnuRII6YiMfn3N1vVQ+djZbMmKYevZYKED7kVE2X0zjJzvEErTufdb+wmifoR1fmDn6VjLLgoOgo8BHLPBhtNrtkA/9ddaRZ86/wk01FUhgI7M6Hy7bfEKbcunuHGEU/Qy6rCRf2Y1mGV8KaSNmlud7k/j8ppHg0Q0sUyZ/tuQZB/MIe61IIIVmcTbLQ5YcFDayZVxtb+6ueb+QKqMtxneY6lB8hsooXFaBFYbqxwD5QiH1fcQv9fllySBLx+S8;
	20:nc9EHc3RTwgWGIhnkBgca3jxMkSnfDnk5bzMqchLXVZS68yxN3+R90B0PbjohbuZ6zvM7Q4P5zyirc7Mc1GjIZAU85VTn3wikEMXKIL+5SPIansySodLMASIWVmxcE5kdaqrGyWJzjyoeH+RKzTUyJ85VNaFw9KJE9MH2wZ7oTc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);
	SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
x-microsoft-antispam-prvs: <MW2PR2101MB0924B1D739BEFB636A0D4B0AFB870@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:MW2PR2101MB0924; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB0924;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(377424004)(199004)(51444003)(6486002)(4326008)(93886005)(486006)(6436002)(6246003)(316002)(22452003)(86612001)(68736007)(86362001)(8676002)(8936002)(81166006)(81156014)(105586002)(7736002)(305945005)(1076002)(6116002)(3846002)(5660300001)(54906003)(11346002)(229853002)(476003)(97736004)(106356001)(33716001)(6916009)(6346003)(446003)(2900100001)(72206003)(33656002)(53936002)(10090500001)(10290500003)(2906002)(66066001)(6512007)(3280700002)(9686003)(478600001)(25786009)(99286004)(26005)(33896004)(76176011)(5250100002)(102836004)(6506007)(14454004)(186003)(3660700001)(59450400001)(3714002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0924;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: uSgdORvn1Gy9vDHl6GC/RYnlF0OUt/gJj2Fz9hAbKeesWthh9SfcF9xphKCbwVCWzR1xD/cTT0IC60+T/RpFbESRNqP1IdUq6MZOsXsn1ziahasQtS9lfDJywedh3mFJ2Z7M+mXLmTu1Mquw2ygdHvQ8QmdRGo/Kt4ZXxtMXl5Mp4dU1EJYBULFKqOMPuKgB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <E351D48CCF52AB4EA795D833AF51862D@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3a39017e-c919-4655-c256-08d5b10ca75a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a39017e-c919-4655-c256-08d5b10ca75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 15:43:44.6072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 08:27:48AM -0700, James Bottomley wrote:
>On Thu, 2018-05-03 at 15:06 +0000, Sasha Levin via Ksummit-discuss
>wrote:
>> On Thu, May 03, 2018 at 04:48:50PM +0200, Willy Tarreau wrote:
>> > On Thu, May 03, 2018 at 07:33:04AM -0700, James Bottomley wrote:
>> > > They're definitely for bug fixes, but there's a spectrum: obvious
>> > > bug fixes with no side effects are easy to justify.=A0=A0More complex
>> > > bug fixes run the risk of having side effects which introduce
>> > > other bugs, so could potentially destabilize the -rc process.=A0=A0In
>> > > SCSI we tend to look at what the user visible effects of the bug
>> > > are in the post -rc5 region and if they're slight or wouldn't be
>> > > visible to most users, we'll hold them over.=A0=A0If the fix looks
>> > > complex and we're not sure we caught the ramifications, we often
>> > > add it to the merge window tree with a cc to stable and a note
>> > > saying to wait X weeks before actually adding to the
>> > > stable tree just to make sure no side effects show up with wider
>> > > testing.=A0=A0So, as with most things, it's a judgment call for the
>> > > maintainer.
>> >
>> > For me this is the right, and responsible way to deal with bug
>> > fixes. Self-control is much more efficient than random rejection
>> > and favors a good analysis.
>>
>> I think that the ideal outcome of this discussion, at least for me,
>> is a tool to go under scripts/ that would allow maintainers to get
>> some sort of (quantifiable) data that will indicate how well the
>> patch was tested via the regular channels.
>>
>> At which point it's the maintainer's judgement call on whether he
>> wants to grab the patch or wait for more tests or reviews.
>>
>> This is very similar to what James has described, it just needs to
>> leave his brain and turn into code :)
>
>I appreciate the sentiment, but if we could script taste, we'd have
>replaced Linus with something far less cantankerous a long time ago ...

Linus, IMO, is getting replaced. Look at how many functions he used to
do 10 years ago he's no longer responsible for.

One of the most obvious examples is -next, where most integration issues
are resolved before they even reach to Linus.

This is good for the community, as it allows us make the process better
and scale out. It is also good for Linus, as I'm not sure how long he'd
last if he still had to edit patches by hand too often. Instead, he gets
to play with things that interest him more where his is irreplaceable.

>It's also a sad fact that a lot of things which look like obvious fixes
>actually turn out not to be so with later testing.  This is why the
>user visibility test is paramount.  If a bug fix has no real user
>visible effects, it's often better to defer it no matter how obvious it
>looks, which is why the static code checkers often get short shrift
>before a merge window.
>
>A script measuring user visibility would be nice, but looks a bit
>complex ...

It is, but I think it's worthwhile. Would something that'll show you
things like:

 - How long a patch has been in -next?
 - How many replies/reviews/comments it got on a mailing list?
 - Did the 0day bot test it?
 - Did syzbot fuzz it? for how long?
 - If it references a bugzilla of some sort, how many
   comments/reviews/etc it got there?
 - Is it -stable material, or does it fix a regression in the current
   merge window?
 - If subsystem has custom testing rig, results from those tests

be a step in the right way? is it something you'd use to make decisions
on whether you'd take a patch in?
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
