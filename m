Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2839629-1525368907-2-13632062135066112626
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
    1525368906; b=h3/1vt5t5jBxdF51HVoDR+o4cZ93aw2HLV2T6aojWoPrlNqZ6i
    ApCDHJrNcMc34cnMtKZkyW3fMhjpCuVPLa+qSprqrILFEVRjx6/+LNx1m8YUCpV4
    Loo028qkjfsiejWdyZ/DgGsvTdMDAhNAPkNSNJesMh/q3F7co91wPHd3w/7l1fj/
    IuD6QbWfrzkCsX4mpl/5k4sGDG53KSaXbbcdLvbsY9rU/dhdbAXxxI/+lExO2ruw
    9IX7IOLurUwr09/EcoeQ0ch5C5qPmA82Am2Bq+LHeVvYTb5VVz7mvQpgNtWr+dhU
    m0K/embdSOjm5Sks9X25Rdbb1c+GdbCC71sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525368906; bh=I9m+0N/1lAFJzzLKFyKK8CuBW2vVs/6cugAhVtFkKRo=; b=X
    3GQ5pP7KWZDe99ZybePmJyZ7Q4t5w2a9bc+qJ8VKXqR/HCEgyVTPxFJpFuie3rdN
    4h4o6uRKjImnfSJfWM54IB3dZsy65tm5QYIbvNIWH/oeq6HF/q3pG1ESFPTibsgU
    QQWJxHSH/72JmJl/w+AarhW5FKyZKJNojG2mKbIxH/JUjcOGazmxoa/aCOoL9f/b
    WkiCVoy941RqBqyb/IUbq6bl8BNmPtFgWkrHXe4pvI0oDhmfrmn1KRGGkKuOtNse
    uo/VuKLXcszuIN95HVbm9gmP+bzGD0L2z1lhdefnYj51ekB3pa+Z28yqsneR+lB7
    /aBx0ucv6L3RxdZmerVaw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=R6YGMhWT
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=R6YGMhWT
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
X-CM-Envelope: MS4wfBJW9uOKdzWwoxvyVQjgVSkzprp9Unip49vNjy+daahPNhFLnVAE33DgDp79ozZV49o40LW8a58+8Xp5DleBSBlNzXVq1ECeNoCAhpYpBUMkAV7uQHIR
    NMdp/4MynOtyDNqPjgbwVOj//tLjUBhpUm8SvyFxoDW9VmlEoNmVSS+/oHypf83OgSf+DHTFImmgXaDd+5SACiGH+ePjSW0si+kwtwz0xSypxHyoy2UKUPg2
    B0WKgJHfZen1vcUBFMHj4Q==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=vmGQvcxNLzj5WE2EdRIA:9 a=6ADq_4WqW_ZRir-m:21
    a=Z3cc-zK9QDPhr9al:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAACPrAIAACxEA
Date: Thu, 3 May 2018 17:34:24 +0000
Message-ID: <20180503173422.GR18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org> <20180503144612.GJ18390@sasha-vm>
	<20180503165446.GB30522@ZenIV.linux.org.uk>
In-Reply-To: <20180503165446.GB30522@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0921;
	7:3pVsFdJVYgvgqBueCs+XrU49MRuqTUOUPwKnwPj5+YEY9i2vXM6Rl8VcQpBgdmuWXW0Iw2UN9YIjbcHO0Ix4/9qT4d4BbMMedf3YNF1Mkvz/9Kaod1whXwVxyGoi55Ip9UdeQK7GzlfmZGzmc7CQwv4Th2U74U2lTbZOmcJj034Bmt+IOvhhTuabD277TWGDSIGxA+Il1RHKd8rYJa7+jA7vNSKy7Hfd/49LIuE4stWsges0Ur6VMPkiz2P5IKMJ;
	20:FSzp6nO9f3DKAbYSWTLBlJOKgaqH705L9r+Zi/E2e20OsDyoC8dQn8xyT4fmB8dqHqgkvzb6QJIR7SMffOdwrG6+icmriL1On9+MuZp9C/d8dPvOVgIsSb2DZiSX0plPWaUIursCvjl0kGt9zhmEBceSgQVagwt2R9KsSmw37sM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB0921;
x-ms-traffictypediagnostic: MW2PR2101MB0921:
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0921AD99B30E354A048D3784FB870@MW2PR2101MB0921.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
	SRVR:MW2PR2101MB0921; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB0921;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(39860400002)(346002)(396003)(376002)(366004)(39380400002)(189003)(199004)(43544003)(86362001)(575784001)(72206003)(305945005)(86612001)(10290500003)(53936002)(105586002)(9686003)(2900100001)(106356001)(478600001)(66066001)(10090500001)(33716001)(4326008)(6512007)(6246003)(25786009)(5250100002)(5660300001)(97736004)(1076002)(14454004)(81166006)(81156014)(8676002)(3846002)(8936002)(6486002)(6436002)(3280700002)(6116002)(446003)(476003)(486006)(3660700001)(11346002)(6916009)(229853002)(68736007)(54906003)(33656002)(26005)(76176011)(59450400001)(186003)(102836004)(22452003)(33896004)(316002)(2906002)(93886005)(99286004)(6506007)(7736002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0921;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: Hwc0GBZ3FMXaWtP8toQW8Guy3iAPxGFOFIR+wRkh7o8VGggrScewMKl02Pnh/6PYA7JvINwzQW9/mbphFYSISdtgBVC1gZU4HW9B0/tNN4tFN0V/ISk3pCzXIRc4QbnMoD7DUEXHEf5BXDF6nPUE73zdetrnLkJzeTIpQwC7U4XudQLiO+t973BKKWJdoWiE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <30FD635C725D2C4CA6CA4F76831D91D5@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3fde22ef-43ae-4dff-ff95-08d5b11c1d03
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fde22ef-43ae-4dff-ff95-08d5b11c1d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 17:34:24.5545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0921
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

On Thu, May 03, 2018 at 05:54:46PM +0100, Al Viro wrote:
>On Thu, May 03, 2018 at 02:46:14PM +0000, Sasha Levin via Ksummit-discuss wrote:
>
>> Fixes in -rc cycles:
>> rc1 68
>> rc2 147
>> rc3 88
>> rc4 121
>> rc5 40
>> rc6 193
>> rc7 98
>>
>> Average days in -next, for a fix, per -rc cycle:
>> rc1 27.25
>> rc2 21.4286
>> rc3 22.5114
>> rc4 18.281
>> rc5 14.65
>> rc6 12.6166
>> rc7 8.70408
>>
>> Fixes for bugs not introduced in current merge window:
>> rc1 40
>> rc2 113
>> rc3 61
>> rc4 79
>> rc5 25
>> rc6 139
>> rc7 72
>>
>> So for some reason, there is a rush to push fixes for older bugs (that
>> were not introduced in the current merge window) to the point that rc7
>> commits that only existed for a few days are merged in to address older
>> bugs.
>
>I really wonder how accurate your interpretation of Fixes: is.
>Consider e.g. the situation when an old bug is found and partial fixes
>applied.  Then we find that those fixes did not cover everything and,
>come next cycle, add more on top of those.  Where should Fixes: on
>the incrementals point to?  Original commit?  But they won't apply
>without the first batch.  The last in the original pile?  But it
>would imply (by your metrics) that original fixes had *INTRODUCED*
>bugs.

It's vaguely close. Beyond the things you mentioned, some commits don't
have a fixes tag, some mention what commit they fixed in the body rather
than a tag, and so on.

This is just an approximation.

>Moreover, what the hell do you suggest in situation when
>	* foofs_barf() is b0rken in quite a few ways.  There's an
>easily triggerable memory corruptor that can be fixed locally as well
>as something else that needs a change of e.g. ->mkdir() calling
>conventions to take care of.  The change is mechanical and fairly
>simple, but it's already -rc4.

I'm not advocating to forcefully block people from submitting patches
after -rc4 (that was Ted's suggesting).

I'm just saying that as a maintainer, you should use your brain and
figure out how critical the bug is, how good is the fix and how well was
it tested, and decide if you want to merge it in or not.

If it fixed the bug and didn't introduce a regression, great! If it
messed something else, you'd have some input on how to address it better
in the future.

I'm trying to come up with a tool/system to help maintainers with
this task because right now it's not working too well. I'm not trying to
introduce arbitrary rules to make your life miserable.

>Even though the whole thing is well-understood at that point,
>we *can't* apply all 3 - it's too late in the cycle for the
>calling conventions' change in the middle of the series.
>
>Should we apply the first fix that cycle, or should it slide to the
>next one?  We can't apply #1 + #3 --- #3 won't even compile without
>#2.  We can't apply #3 without #1 --- they can be transposed, but
>it's nowhere near a mechanical transformation.  So WTF should #3
>have in "Fixes:"?
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
