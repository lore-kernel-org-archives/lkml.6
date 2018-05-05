Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1214736-1525498052-2-12702303329827534774
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
    1525498051; b=nSE320cLpsLLAa7UR5oUD1Fh4psoxzBKCMtDQ/QLYUoHz+MC4P
    q9HXnGffy0UlGN3t1ERdhk4iwuhyH1mW1NG4+TySYcxcsB0S3JU6kJzmU/z0fqfS
    KVKrW7fB6cx41jKV1Gi4WB6gIAShTTcmFU+ewuR60/F615WxDd8qjdO/7dmBFC8K
    gJ55SGnXsVaolI77gJCH6JmconCNyfzQ6NYPOFDq88fMmkrhdA3KzSV1JXDNX2q1
    csBiTyDrgXhantbG2E6PBTXHcYzF5/pK/e7vKcaADIJGezEa7Bysx+vjR4wJ1wmv
    rpLVclcUo+uckxF6oo6FBsCVLpPCew1cuYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525498051; bh=GlbNuw2aC0grTNKvFLLbB9rk6lFjXpSexcKHKV0c+7E=; b=A
    Dd/qylZ/VRhdok297X0SLMqEdAPpEW2QplJAAcDt5J59l4jZUgpoNwRpo17WTXsu
    1Rtu6oC9oINH6gCkd9IsnxgZA0emJxleatV7GN0Z84wFJhJbv18BYoZOdzB6HOQZ
    X3/4h08eQeeAM6urvLllJuFzVhQx81B8y1ccDWJQnuNt3gkFeSndc/HRSQ/PdCT3
    MEBBCjLCplxVxD6btYzTdLgsy0ctKufACzagtxKawzejQojVNG8NNmgDrZrnEdAD
    lNHPiiMjWCiuy4L7AyvynFT76aaL9IqnX7mke2ovljU+DvqtRNZVJHU/arhbBvT0
    20wKH0w8t/9Zac/ayL3Sw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=F5eNAGUJ
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=F5eNAGUJ
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
X-CM-Envelope: MS4wfG/waReL9W9Teq2RsIxmjFV42Kz1tRErJBrbM+MSPtVkFs/vcMJsHvf1lWBUol2vP7CuarHsas/B/lC1AwckBxCokWUoPF3+6KKSwZ12qV8xuBjN8EzF
    pGQ7R9sfveQ9I6k8kTtjdZu7F+Xc/pBzbQFyyDFVyaBhrki4M5rls0U26ENfdItGZP/yMwP9C5C+IG4MLXye5EA3PWa0+t91LVoMN1qg/d0OXtNlKzoe5BYZ
    AETNA0guBbB0VTA6oKfdNA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=UkEo_MfV9TDym1oRhBcA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Greg KH
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAACPrAIAACxEAgAAM7oCAAAxCgIAA+ZwAgAAq2oCAAAqwAIAAS9OAgAA7VoCAAAbpgIAAA66AgAAdMwCAAGI7gA==
Date: Sat, 5 May 2018 05:27:20 +0000
Message-ID: <20180505052717.GY18390@sasha-vm>
References: <20180503173422.GR18390@sasha-vm>
	<20180503182039.GC30522@ZenIV.linux.org.uk>
	<8669.1525427874@warthog.procyon.org.uk> <87fu377gbu.fsf@intel.com>
	<20180504130932.GI29205@thunk.org> <20180504174055.GF4649@kroah.com>
	<20180504211317.GK29205@thunk.org>
	<1525469881.4114.5.camel@HansenPartnership.com>
	<20180504215111.GX18390@sasha-vm> <20180504233542.GM29205@thunk.org>
In-Reply-To: <20180504233542.GM29205@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1035;
	7:aVoX+YLY6NjGK08J9OKHy7LeDqR35Bs1H/dti3Rky8+RR+6v2FuKDEQ/y9kIX4F93PwZ/WtradbgFtBFixmyjTs5bujz2I0LDaO/QZx1xo7RsOD7DUgnQGjAQgF3lwaP387WPZmHo2/UWgXza65uFVUqgPtJQDUyqnYkDZDPUOu9uOWsjBY1K/eTcTee80FS+1DLNhA/CRjh8ZQBxG+e/GiCqFSfZePxWk0UqKATJ9d429nZACynIgxh26qkXL9L;
	20:vhGjQyPtL/IBvR3UZbLgm7pEiSor0To8SOMK/Sp1J8bfDKA1sX+S+6eBCK/PFdmy/TLId/asCGV1oHSaImWzEHT7sOX9h+GiYtvKoAhUC4lzC9xlAJTH2n1eZbjshbsU2g35l9Vxj0g8jopxbIzRbgrhNVm7qo6il5LebwqS6f0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1035;
x-ms-traffictypediagnostic: MW2PR2101MB1035:
x-microsoft-antispam-prvs: <MW2PR2101MB10350625DE5E92F8C1958BCCFB850@MW2PR2101MB1035.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149012)(150012)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1035; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1035;
x-forefront-prvs: 0663390E1B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(366004)(39860400002)(346002)(39380400002)(376002)(396003)(199004)(189003)(72206003)(93886005)(97736004)(86362001)(5660300001)(6436002)(2201001)(3660700001)(316002)(478600001)(3280700002)(10290500003)(6486002)(22452003)(86612001)(8676002)(7736002)(14454004)(229853002)(33656002)(2501003)(5250100002)(81156014)(2906002)(6512007)(66066001)(1076002)(102836004)(9686003)(6506007)(2900100001)(81166006)(26005)(6116002)(106356001)(33896004)(186003)(446003)(11346002)(3846002)(6246003)(8936002)(476003)(486006)(2171002)(53936002)(99286004)(110136005)(10090500001)(25786009)(105586002)(305945005)(33716001)(68736007)(76176011)(6346003)(781001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1035;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: PefAclfgZTPkBDMZr6PmvAAb7xh3V6Tt7V/C73Aydi32H8BtqgGu1UdjbMcPU5CBxZ7MNGbCr3Y8K8QMh4rHjbMTN/9vkj7zb5o97kaZYKtTw/+neamcwpEeRI32i3zfOrW11LUm4RhMAFKcTy6gI5wcFR8PtbW7OEdj7WciKfN7Tf/N8bFDIeOdsjFQjIFr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <BE6FE16E71934946B152AC6C5360239D@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cfc17dc7-cd84-45b0-e198-08d5b248dfa7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc17dc7-cd84-45b0-e198-08d5b248dfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2018 05:27:20.0629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1035
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

On Fri, May 04, 2018 at 07:35:42PM -0400, Theodore Y. Ts'o wrote:
>On Fri, May 04, 2018 at 09:51:14PM +0000, Sasha Levin wrote:
>> I don't have an objection to moving this to it's own tag. It will make
>> my scripts somewhat simpler for sure.
>
>It's not a matter "moving this it's own tag", but creating a new tag
>--- because what is in the docs is a lie.  It does not describe what
>we do today.  And current practice is the reality, not what is in the
>docs.

I'm really confused here. What do you mean with "not describe what we do
today"?

The doc allows for three ways to tag a patch:

1. Empty tag: "Cc: stable@vger.kernel.org"
2. With a version, quoting from the doc:

	Also, some patches may have kernel version prerequisites.  This can be
	specified in the following format in the sign-off area:

	     Cc: <stable@vger.kernel.org> # 3.3.x

	The tag has the meaning of:

	     git cherry-pick <this commit>

	For each "-stable" tree starting with the specified version.

3. With a prereq commit, which is in the form of:

	Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle

We expect this to be used rarely used, and indeed it's not used as much.

>As to whether we should create a new tag to support explicit
>dependencies, I'll leave that between you and Greg K-H and the rest of
>the stable maintainers.  :-)
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
