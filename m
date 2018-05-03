Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2630857-1525358785-2-7499413176491476558
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
    1525358784; b=QM6+0ZGchzgGBOKVauW94l03zlIC+cHk3GWA/Jmh17qo3DgozC
    wopWrs5eJVdXYuLHQlp8AZSEu0vkzHvk5jyASP4rBmCqQc4eiClCAqA7p+Sn4vAf
    rFgcE9Tnc19tGZXoik164Z0V8SHGi4LnGw8yMvLoadsc7vn33ydWX9or0pe2+Sz7
    BrRn6dLQyb/KKxp0grXz4dXTPlc2+8ITn+ItC8Rh46i9RZz4g3nQEm+ItZYng597
    4TLhBasxTB6MMeGItwiwPj+SSJBn50ru+uOJMvkjIzIW3FzWHwTG9EYo9xiZ2ZIn
    1Zcixxs3ROKZU1+UmM+B66DZpxm8ebHlvLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525358784; bh=zBUGsNPi+ly6eiOKPZIo5h8DeukYAYsokKYnIwZWU8o=; b=U
    haPNkXv1OZNtznALU1BkGUF9a3z/3NtpA/i8iymfpL1lDeMhIemkHW24IUc+l5Wa
    H6LbdDPK2Sqi3UCktCcEE9diH3tEqAjMxb1uxPriRHAi4vmbMnovnWxpt9HvIrCd
    8n8b07E8AuwhRtMciMq2F9vUDPRQBX/3jSb2oFIwXMCxo1OFdHid3xZLS+o2E9Dz
    FVI//7/fjiDI0VD4DXebyrebERHcVe58MlwKNAWEZ1TbbVCJE00+FzBP5uvVSkcj
    yDxwJd3bcJa1pWxAra6ykoi3XcIMm6pGU0z5jJuHacB2f9BwyltnFuC5w8yPc7qQ
    cYygtnn47AFeD1pjB7gwg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=BzRxo80L
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=BzRxo80L
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
X-CM-Envelope: MS4wfMFxdDaXuzppS/8unIobstvi2cdqeQfiB6W+u6L0nEad9kaM0o0+3DH45UPmnx2dcM8BBPTwluCjr5iGEKE3OaZ6+lJ0e92db7MOSG6YbfXuMAOC+jJM
    4aygE0m0AxusdDLlIrjC6WNkhEeX0oKeoAiuKv43+z2/AI08w8mDo9ogTU6TykEF3wPEHUIEgJQIzecSH3hjjpG2j8eFEZj5ICU0ggRe8otkD9+9EKulyavC
    uZjV9bpsSECgjJ7yfumaaw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=aycAUhqqIodX2g6AjskA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "w@1wt.eu"
	<w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QA=
Date: Thu, 3 May 2018 14:46:14 +0000
Message-ID: <20180503144612.GJ18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
In-Reply-To: <20180503000620.GA29205@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0939;
	7:L5svxH1FBlvK1mizqekwktkyLevOt6zis/i7u0jsWe8lvnGKKTaIx1TEVjO9v63+FGjiRhwd6Pk3AptClouDsHUcquC7HvzS6Xc5GveNjGcuJYRXOKl5a2wYAt7VcaPAb8JsLZucgBJwCr6Pp0MGt87iK5YU/rFb/htW2lUfjxiGk0P/DDqtMY+ZVGC8HCQ5gJjVXAkBjYJjux9XuIlE53ydHnzHxyRQa3mIV3Ws2Iojbg9MnPpGwZK9f5HmISr/;
	20:vASVDcB6B4WeHybfHxp8eBHmD22NWYsUdp/pqFtU8Ll0UvAE7Fz6opqXFKCMgFm9RrCQcc70eM5EpWm7rpuMeDVpcP+2l6bAPC/vo3NjgOozQJHJXKQ/xkrGT7awiKFG6qBqlQrlUxiRiWXrtE2pDlcd9Cc3gyzW7qy6WGDI48w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
x-microsoft-antispam-prvs: <MW2PR2101MB0939CDDB4425B4B2282364F3FB870@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:MW2PR2101MB0939; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB0939;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(376002)(396003)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(72206003)(76176011)(186003)(9686003)(6512007)(10290500003)(2171002)(478600001)(53936002)(33716001)(99286004)(97736004)(6246003)(33656002)(6346003)(66066001)(14454004)(5250100002)(229853002)(2501003)(6506007)(26005)(6486002)(486006)(6436002)(2900100001)(102836004)(106356001)(33896004)(476003)(81156014)(8676002)(8936002)(3846002)(10090500001)(1076002)(68736007)(81166006)(93886005)(2906002)(110136005)(3660700001)(6116002)(5660300001)(3280700002)(7736002)(305945005)(86612001)(2201001)(22452003)(446003)(316002)(105586002)(11346002)(25786009)(86362001)(781001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0939;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: fpMaAxJGcoxEdANeRoElyqtsZkHR+ZKMhwWZw0Gp4x0gax2yahTREFpkqM4fGk73ukUF1LrEsnvFJSF46rWcSydkBgyzKOD8vD3MEUS7V403usRYrlKFYejnF7B7xAcXDHgtElNoUYZjXy0C5gnN6qTUxE4ruSLGvsqF/Dmpjt/64WnaLXD4NefxaaaNuCGD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <1CBCE5EEDA6104489DB9A376D817DADD@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aeb854f0-6c3b-43c2-6585-08d5b1049ef0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb854f0-6c3b-43c2-6585-08d5b1049ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 14:46:14.5458 (UTC)
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

On Wed, May 02, 2018 at 08:06:20PM -0400, Theodore Y. Ts'o wrote:
>On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:
>>
>> Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
>>   - 245 carry a Fixes tag,
>>   - 196 carry a CC stable,
>>   - 395 contain the string "fix".
>> (non-mutually exclusive)
>>
>> That leaves us with 200 commits not falling in the bugfix category.
>
>Some non-bug fixes are allowed in -rc2.  So perhaps what might be
>interesting is to look at v4.16 (which is completed), and look at the
>distribution of commits:
>
>	* regressions fixes (for bugs introduced during the current
>		release cycle)
>	* "normal" bug fixes
>	* commits which don't touch code (e.g., spelling or
>		documentation-only fixes)
>	* other commits (features or cleanup fixes)
>
>at each rcX level.  The historic "standard" has been feature commits
>in -rc1 and -rc2 (tolerated, but ideally should before the merge
>window), bug fixes / regressions in -rc3 and -rc4, and after -rc4,
>regression fixes only.  It would be interesting to see how well we
>have been holding to the historical ideal.
>
>It would then be intersting to use Sasha's analysis to see whether
>there are more bug fixes caused by regression fixes versus normal bug
>fixes, and whether or not they are common when fixes come "out of
>cycle" --- for example, a non-regression bug fix in -rc5 or -rc6.
>
>Because if that last is the case, then the prescription is very simple
>and not controversial --- bug fixes found post -rc4 should be held to
>the next merge window.
>
>If the concern is regression fixes which require one or two tries
>before they are fixed before 4.16-FINAL is released, then that's a
>"life is hard for AUTOSEL" issue, and I suspect Sasha will find that
>there is rather less sympathy for holding regression fixes for an
>extra week or two.
>
>If the concern is bug fixes that show up in -rc3 and -rc4, but which
>aren't hitting linux-next first, then holding bug fixes in linux-next
>for a week makes sense, and if that means that a bug fix found post
>-rc3 needs to marinate in linux-next for a week, and then it then
>misses the -rc4 "bug fix" deadline, we can have a discussion about
>whether bug fixes should be allowed in -rc5 after a week's marination.
>
>My personal opinion is "to hell with it, just wait until the next
>merge window" --- but this can cause more work for the stable
>maintainers since a lot of bug fixes would then land in -rc1.

I'll work on breaking up the 4.16 commits into categories, but one
interesting statistic I've noticed while starting the work is:

Fixes in -rc cycles:
rc1 68
rc2 147
rc3 88
rc4 121
rc5 40
rc6 193
rc7 98

Average days in -next, for a fix, per -rc cycle:
rc1 27.25
rc2 21.4286
rc3 22.5114
rc4 18.281
rc5 14.65
rc6 12.6166
rc7 8.70408

Fixes for bugs not introduced in current merge window:
rc1 40
rc2 113
rc3 61
rc4 79
rc5 25
rc6 139
rc7 72

So for some reason, there is a rush to push fixes for older bugs (that
were not introduced in the current merge window) to the point that rc7
commits that only existed for a few days are merged in to address older
bugs.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
