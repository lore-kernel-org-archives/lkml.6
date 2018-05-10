Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2396152-1525970857-2-5363580857096182393
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
    1525970856; b=ad0llQCitxQdt7hcqWzbLK6npY3KnCnIaVga+fIyHc6Qaqpb/J
    MuM4mSF7aao5zzWvnI3W31oIFHF7VgYKgAx4jgyYiAYjdL/yuMaZC7omLqZnIptw
    ylu/6Iqfz5LWXVlwXrAGR7UPCF2g5npFU5gCrYSSZlAK87XltWwDAQXqPPbdC4Ri
    olgU8qe/Qb4/RWu3mGN9RKGBztAL0q2p23lOrCLJ2oFRPJYVZhVgMvN09/p6k3rY
    cFDbpuXFoqBAijV3qFRxCjRMF55cQnHTmwG7MWGqeaV6hbDJZEyNBxYKnbUcIe6D
    /+TfI42W0Lgn+tngaoUWL3CNAiLOGMDh8aAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525970856; bh=tFzn6mwbznfSPFACNK9UMgdAhlQK/L68jP5+/RU93I4=; b=l
    9Qslztf8fMRKIMBkFFP+0xj15xYo55LzEIsIHO0TYlnhGrgge0AoY1B6eHiE8yY8
    RlkQ1ZBAsDLzmZG1ZDQ/RotCcWCpQbhG5UiJvz3AN94b8Y9o9yo9Za/KuxbZ3rPO
    Eg2ejpeuLf2xfafO0M4jmA3T88iCo8PF3TPtbCaFEGGc9nFevD4m0j4lH9u7Me4p
    AiW9MlY9llpwznPWThIrHZHX51zBKOccUkGh0X8TrnR1/KPZdPA0DouJEeaaOTGw
    /TBKqKEd9DshDZr/1l9UYDTXGZi25JTjfA1pGUVp9sZ3Zr6BkAQSQnnrURafqCU/
    60M1v4mR/ztoXQZjkoZbQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=mwZ3MWI9
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
    x-vs=spam score=300 state=1
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=mwZ3MWI9
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
    x-vs=spam score=300 state=1
X-ME-VSCategory: spam
X-CM-Envelope: MS4wfHPo2yvmECMmP2n2tZDQpcbtPS6TApcnCNtYL56aVO1X0LOvL8iSzKd2btujswhahcXhDwu8WsJERO20AgVgzYYY3JgSoDWJ8mV+iuVRm4WqSs5LQuUN
    aW6JnoQZCP4MZb1JTdDGte7FLY0KGYrVSNPJcTUcnpjOFg6N2N7OG59HYdtyahseY4z9L4/2HnocEq+4bEBdSwGEH89XiqlEem7S4X2/5CzTepgpv0ikYPPT
    Z0WEJ+AZrJtkzvX3OWFNkg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=RGvLkqSu5yflfZHFNA8A:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Jiri Kosina <jikos@kernel.org>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAAHfYCAAP7oAIAHfZEAgAAA6oCAAgv9AIAADEsA
Date: Thu, 10 May 2018 16:47:24 +0000
Message-ID: <20180510164722.GH8514@sasha-vm>
References: <20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0971;
	7:WFGn9bGKQeJoTvXt5S8vv4T4gvJoKABctKvYyy++mfi9a6LWNGmpg/eq/ywTO/KPfftVtndojyA6db5x0VyGkhBgZWtA/8EBFXbcxdp/znHiS8heqw19UxskL0bEL3lu2C2vBOWiNUOEo3JjEm3CcIJVcfSCWnHHVaYIFlvW4oT1pbZf7jTI3PR8ynvrDbq3T3kJ/Uy67drGfhfQ/bRm2AEGqbnasYITDP0mTAVK7GI9KwGg+F8ADAbW4tkmfRYW;
	20:Ugehq//sw7US44b/Vkha2AsGwD6pZuI0ySwAkBQfRhHCgpKjFAfqzfQ0sbs9STMomgZNheTjLWNcMsNOK13g8mX5L50JikHAmQALAFv2isF8d7OFs2D3shmKlEzn3dxbWhu5NkrhnIQZOrIkFLi9gI8/eOeNSGt/RvMbZfhmc3g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB0971;
x-ms-traffictypediagnostic: MW2PR2101MB0971:
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09714CCF9BFD1567AD21BC58FB980@MW2PR2101MB0971.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:MW2PR2101MB0971; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB0971;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(376002)(39380400002)(366004)(346002)(39860400002)(396003)(189003)(199004)(3660700001)(93886005)(6116002)(7736002)(97736004)(10090500001)(186003)(106356001)(105586002)(76176011)(81166006)(86612001)(81156014)(2906002)(8936002)(5250100002)(1076002)(86362001)(6486002)(68736007)(6916009)(8676002)(3846002)(6436002)(2900100001)(5660300001)(486006)(11346002)(9686003)(102836004)(6512007)(3280700002)(26005)(316002)(229853002)(14454004)(22452003)(446003)(53936002)(54906003)(6506007)(66066001)(33896004)(478600001)(10290500003)(305945005)(4326008)(476003)(99286004)(6246003)(72206003)(59450400001)(25786009)(33716001)(33656002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0971;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: wMPGDwIafjZJVk6Oehr7gr1AUj+oULv8YzT+te0A9QcUcD+2ISGt8qPEQmTxymsSbalJ/GOlSDZTGcm6CofbzZVRFNMjIWzjeEhGG4VlGrOy5xTwNbe2KLmqNNiKUV32ntzu/SwEulT94vD9aIuZFjr0a3LATq+kAGCTLUk1fKMghOVt31Fo/amV5+XRfLSL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <F842BC74018D7E4199421AA3BA4FC94B@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fa77a6d9-aeaf-4ea8-381d-08d5b695b4d3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa77a6d9-aeaf-4ea8-381d-08d5b695b4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 16:47:24.1666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0971
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
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

On Thu, May 10, 2018 at 06:03:22PM +0200, Jiri Kosina wrote:
>On Wed, 9 May 2018, Daniel Vetter wrote:
>
>> >> Then, why don't we have a pre-integration tree for fixes? That would
>> >> at least simply automated testing of fixes separately from new
>> >> material.
>> >
>> >> Perhaps this has already been discussed, and concluded and it's not
>> >> worth it, then apologize for my ignorance.
>> >
>> > I think this is an excellent idea, copying in Stephen for his input.
>> > I'm currently on holiday but unless someone convinces me it's a terrible
>> > idea I'm willing to at least give it a go on a trial basis once I'm back
>> > home.
>>
>> Since Stephen merges all -fixes branches first, before merging all the
>> -next branches, he already generates that as part of linux-next. All
>> he'd need to do is push that intermediate state out to some
>> linux-fixes branch for consumption by test bots.
>
>What I do for my trees is that I actually merge the '-fixes' branch (that
>is scheduled to go to Linus in the 'current' cycle) into my for-next
>branch as well.
>
>This has the advantage of (a) getting all the coverage linux-next does (b)
>seeing any potential merge conflicts early
>
>Is this not feasible for other trees?

When Linus tags -rc1, -next will start filling up with commits destined
for the next merge window. The resulting -next tree becomes very
unstable, and very difficult to test.

The idea behind next-fixes is to provide a tree that will contain fixes
for the current merge window, which will generate a much more stable
tree that users/bots could actually run and validate the fixes that will
be merged in the upcoming weeks.

Right now, with the method you've described, there is no easy way to
test your '-fixes' branch even though the commits in there will be
pulled in by Linus much sooner than your 'for-next' branch.

You'll still get the same coverage from -next, but if you provide your
-fixes branch seperately you'll also get more coverage for the fixes
you're about to send to Linus.

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
