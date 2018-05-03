Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2718050-1525363344-2-8526552006794043143
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
    1525363343; b=ELcV6xVHDsk46dfOEJWEOHaHrhm0cT+tfRYCLDFXbHRT92L5IQ
    0JkdI8NWpBqafobWBTgWol3DP1QXygauOzZv6dL+i8BAaw+CDTaVwglbnMgyRvGu
    bofEv9fOb3zCQENmtHUtyEd8zUq+Myw9sasmBYQUWfr86pRbbZ15XuTfXkQ8cb6Z
    wme9sOewJq7FBQouDtnloNzHnmRqmZDFseyGjwvuu8LOraf55Mtq1N0je1wA6fRY
    6p6Cbi+F/iKvnP5A0iC0JzV8x9DAYANpEV/sNMjmu8s1UDBYy9NCiXY22IBaglQs
    PMUh1rcnVg8d+FQ/GxD15wL3b/KdQdvAWJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525363343; bh=yUGsBqlysZpDAEcTrqauo0GCKGzcY6SYhMwiofuAofM=; b=L
    D+CDOC58+ceCWvKopcsSspwmblhYM9HKOVJ8UQLsyuAxMF6Sl11JuqquQjB+WsPv
    M0Sd+2fuJ43+58mc+UrDDdqEz5UzStV2x0WpolkcbT9xvgWM295jq3JA6XIbb+cZ
    Ib6xttApP0j0hpulKVVwccvZ3ozJE1ba6vdnfOyzD1d8d+m8Pjk1sNu3x6NChgq0
    oZxHcORdaG2NIIjr+ruqbwTUiaobw4ly9JcrI3tSJcGMUROvwWeKan3w2polLc7w
    wS81EYIk3vrNk4TdyEnYUISs52k6X+7Br3dPGQEqvN2vn8nEBVLgpEtOiSCTfebH
    PVzgoyqGUfiRGwk92rzCw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=kCeNhvQZ
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
      header.d=microsoft.com header.i=@microsoft.com header.b=kCeNhvQZ
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
X-CM-Envelope: MS4wfBO1NCQd1dY5jR5M6srMpAdFVk5RZIr+Ewa1sSj6JiwyfV98vxwYpDLajet0ixtNy7mGkGmRA7ZSjshI03Bviuno966nbL7FuardRMuQcXSxiAP9lufV
    Yd/dgdBmhxn8YFDl3YcUgPMVn1JKmzXvKEpPjJ7WV/h/X5EoRfiC0xMsY7yGiUYOhKXI+kuubqT6N2dRvRDoyJgy/aKSkElHDe1qJWnYfF9SmdpAO95odFaH
    BSYr3mZFads9FtS3zs2zsg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=nrPiXSZB5zn5WcPjNGsA:9 a=Aa9jdYCWyhVZaw8z:21
    a=sDGked6jfjYisKEw:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Guenter Roeck <linux@roeck-us.net>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAAI/wCAAO9ygIAADvyAgAADoQA=
Date: Thu, 3 May 2018 16:02:12 +0000
Message-ID: <20180503160210.GO18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
	<ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
	<20180503145533.GK18390@sasha-vm> <20180503154911.GA26754@roeck-us.net>
In-Reply-To: <20180503154911.GA26754@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1051;
	7:AwqnAwQFN+BfmiQViiKMLgwD6oBv/plDA97D1TQR5foL0iXFHw+No8HvQWXKSj14eEfrNYzQxoFcrel8EqXH/MQac01G5EZ7EbGIYbYwS6EMsqWHI47zT5qO125j7xVeKcArEyToAK4KQZRmkZHGIvr+DquO7yd+Vty3NS/+1DG6bcKtSWKm0g8o2lNQ7ZUiW6JIn12UoYv3hUlIYFTYFQ9k2ZTEsPqnOmPeZmG03WqY81Nu80WKEesD6tvzGg2/;
	20:Hp182gJx0rCU0F6199bLIaL34+6GA3XhOHUfV7vobo27vtB51sSFc+G7XpkkjuW1hnC3a8qVvReve48eWYq1ThzFzeQdnwaQgVZNRsXZGtyqR9BpaVm0i21Tbw0a3B9KtGNoaWzlwg5lLn+rV5mCQo1nvRnpde+I67BOxNw4R98=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1051;
x-ms-traffictypediagnostic: MW2PR2101MB1051:
x-microsoft-antispam-prvs: <MW2PR2101MB1051823DB26038F1021D6C9FFB870@MW2PR2101MB1051.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1051; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1051;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(376002)(366004)(39380400002)(39860400002)(396003)(346002)(199004)(189003)(51444003)(102836004)(93886005)(68736007)(186003)(10090500001)(6512007)(99286004)(9686003)(6436002)(33656002)(105586002)(10290500003)(2900100001)(25786009)(11346002)(316002)(476003)(22452003)(486006)(6506007)(76176011)(446003)(33896004)(106356001)(6346003)(86362001)(86612001)(59450400001)(5660300001)(26005)(81166006)(8936002)(8676002)(14454004)(229853002)(54906003)(66066001)(6916009)(305945005)(7736002)(81156014)(97736004)(33716001)(3660700001)(2906002)(4326008)(1076002)(53936002)(6246003)(478600001)(5250100002)(3846002)(6116002)(6486002)(72206003)(3280700002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1051;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: lDTjSwlrN4TD0VQBfKldKd0Fx7afdfrJLH25LNLSSQqKL06kRhwpk5z5JwfGY1VLpJiDPMVXDOjPC9SH4dgT2bylssmBBsz4md6Y9nooBHtMDovoikU2Dgcrkzl3mFY0SatGb2IiUSbuHEa6rl1HzSw+Hnq4fGMc/Yoa3XzwwtCZFXDg1FXlNnzfU7pre1JQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <A910F29274E2FD4C8E174CBFA990C819@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8ba1dd16-2a01-4d09-09ec-08d5b10f3bb2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba1dd16-2a01-4d09-09ec-08d5b10f3bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 16:02:12.5380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1051
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
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

On Thu, May 03, 2018 at 08:49:11AM -0700, Guenter Roeck wrote:
>On Thu, May 03, 2018 at 02:55:36PM +0000, Sasha Levin wrote:
>> On Wed, May 02, 2018 at 05:38:32PM -0700, Guenter Roeck wrote:
>> >On 05/02/2018 05:06 PM, Theodore Y. Ts'o wrote:
>> >>On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:
>> >>>
>> >>>Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
>> >>>   - 245 carry a Fixes tag,
>> >>>   - 196 carry a CC stable,
>> >>>   - 395 contain the string "fix".
>> >>>(non-mutually exclusive)
>> >>>
>> >>>That leaves us with 200 commits not falling in the bugfix category.
>> >>
>> >>Some non-bug fixes are allowed in -rc2.  So perhaps what might be
>> >>interesting is to look at v4.16 (which is completed), and look at the
>> >>distribution of commits:
>> >>
>> >>	* regressions fixes (for bugs introduced during the current
>> >>		release cycle)
>> >>	* "normal" bug fixes
>> >>	* commits which don't touch code (e.g., spelling or
>> >>		documentation-only fixes)
>> >>	* other commits (features or cleanup fixes)
>> >>
>> >>at each rcX level.  The historic "standard" has been feature commits
>> >>in -rc1 and -rc2 (tolerated, but ideally should before the merge
>> >>window), bug fixes / regressions in -rc3 and -rc4, and after -rc4,
>> >>regression fixes only.  It would be interesting to see how well we
>> >>have been holding to the historical ideal.
>> >>
>> >>It would then be intersting to use Sasha's analysis to see whether
>> >>there are more bug fixes caused by regression fixes versus normal bug
>> >>fixes, and whether or not they are common when fixes come "out of
>> >>cycle" --- for example, a non-regression bug fix in -rc5 or -rc6.
>> >>
>> >>Because if that last is the case, then the prescription is very simple
>> >>and not controversial --- bug fixes found post -rc4 should be held to
>> >>the next merge window.
>> >>
>> >
>> >Holding up even fixes for severe bugs for 4-6 weeks ? Seriously, that is
>> >unrealistic. Holding up the fix for the next SpeckHammer because it was not
>> >ready before -rc4 ? I don't think so.
>>
>> For severe problems, the patch usually gets more than enough reviews and
>> testing, so I don't see a need to soak it in -next more than some
>> minimal amount of time to get bot coverage.
>>
>> However, these things show up only a few times per year. Most of the
>> fixes even in late -rc cycles are for older bugs that aren't too
>> critical. We can't base our decision on severe bugs that get exceptional
>> treatment anyways (see PTI getting pushed in -stable).
>>
>> >Even when not counting severe problems, you are adding lots of additional work
>> >for those who do and want to rely on stable releases to merge in bug fixes.
>> >Sure, I am at times annoyed having to deal with a regression in a stable
>> >release, but it very much beats digging through various mailing lists for
>> >pending patches to fix CVEs, or for crashes seen in the field, just because
>> >they are held hostage by some restrictive process. Even worse, I'd end up
>> >picking the regressions anyway because I can _not_ wait those 4-6 weeks
>> >plus the time it takes for the fixes to show up in a stable release.
>>
>> I think that for -stable we don't have a good idea how soon we want to
>> merge patches in. On one hand enterprise distro folks complain we're
>> jumping the gun, and on the other hand folks like yourself claim we're
>> too slow :)
>>
>
>You are misquoting me. I am saying that it would be a bad idea to hold up
>bug fixes after -rc4, which is quite different to saying that patches
>don't make it into stable releases fast enough. I am perfectly happy to
>wait a week or so for a patch to soak in _mainline_ before being applied
>to stable.

Most bug fixes that go in at that point are fixes for previous released
kernels, what's the harm in keeping them around for longer?

I'm not saying that it should be some arbitrary rule for everyone, but
just suggesting that maintainers should exercise more caution merging
untested commits that don't even fix a current regression.

w.r.t stable, as you just said, you're fine with a week or two, the
enterprise folks (as well as Ted, to some extend, in this thread)
suggest that this should be a month+

>I am absolutely _not_ happy with the number of patches making it into
>-stable releases recently. I am especially very concerned that the current
>flurry of patches queued for -stable will destabilize pretty much all
>stable releases, and pretty badly, for that matter. I am seriously
>contemplating not to integrate the next few stable releases into ChromeOS
>for that very reason. That would be a different discussion, though.

For AUTOSEL, I'd be happy to learn of issues you encounter and address
them in my process.

I've been submitting automatically selected patches for over a year now
and the track record for regressions is on par with patches that are
tagged for stable.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
