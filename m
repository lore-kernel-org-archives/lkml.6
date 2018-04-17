Return-Path: <Alexander.Levin@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-2007354-1523975811-2-11071709842524399713
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.37.100',
  Host='mail-cys01nam02on0100.outbound.protection.outlook.com',
  Country='US', FromHeader='com', MailFrom='com', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Alexander.Levin@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523975809; b=P/36ZRtc7h2Nk+ytdj3Ix0BzxZ9iPW5Vg9CmA88IBnwCyWxmsd
    R0IF/XqmoxbDYiuZ1okQpqSzGC73sVqrrEcatKpYhjmFqU5k01LVN9MbW7fR5GVv
    WhQemuE8zqdgp5Kvb/M4+kKs8Lwl+cRVC/wioI3EOVSt20fxA4MPM1+SAdsjXFyY
    /UrFUPf/PdBXooNhNDr0+j0qDjWDqI4FgYtXMYtu+f0i5NMAVnY2dHYVK8v64cxm
    YxiFc4FUiphXmMlAmg+FaKV5gNCzw7m8sKFlt1FIaFehoAqjUoFaZzowI7WOEmgU
    ZlycdWHcqERfVxgIRt8emc98N0D/l6MASQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=fm2; t=1523975809;
    bh=pK1R4FGKOa0937aMjDix6wABn+3OQ9VlRRC02xHaoAI=; b=TtZa5QUJg+yh
    /TZamgEkea6kiKehRBd8xHF87rZ+EjD3w5rl0ieDUP5PiQtYOUNxAloXlxJqVpZG
    asb1/w1JzL8+pF+JTnxNjFahBDzCT95yphoLIAR0YSgLqeVPi/NFtPlcTyUmbPkv
    m29ymSdAl39QQ5nFdub6sVitFzx7O159IfcpkhhwRgU8OUVqEkBzJxz97ExgaXln
    6U8ezVBPOyBp0EOhtFNhvpSZ8kbYxBLklnkqnyuTjF5JyPj76svAmfNYRdQ8z2Au
    Xj6lsni5AZDfeMf17Y86frrSSLpDRxCvP6Ws90qkvHzs2DQMrpKqSTv1APKS7dfV
    90vx4gzr4A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TiKwxMYK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.37.100 (mail-cys01nam02on0100.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM02-CY1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-CY1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-cys01nam02on0100.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TiKwxMYK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.37.100 (mail-cys01nam02on0100.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM02-CY1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-CY1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-cys01nam02on0100.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHWvU7lmGkCKDHroeMIApoccbYlWQhoNzHvckr88wWt02Bef11t4cfr/w6lYElFfnpCjp+66ouqOnSdezjiYpmHzNLoYLFt51V9uLt7QI7cvRk0v01Q
    POXpyPBdio1QrWO3kIFeJc0wB4l7TQBgdMVYx+yPNQVkvT/u0Fy81Z4SRGTckOi1+RIt1Ue5vQqKz/W/yoCiGvvrwMF5PoHICxixzWMz/52hOiuTR/RSN/MA
    YE9uu1s/uVWQ/P8YJcuD7Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=ENVodV5vEat0xvru/pPgWQ==:117
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8
    a=D19gQVrFAAAA:8 a=B9MCPAVda64oPgiEUu8A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Petr Mladek <pmladek@suse.com>, Greg KH <greg@kroah.com>, Pavel Machek
	<pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Cong
 Wang <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Vlastimil
 Babka <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Jan Kara
	<jack@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tetsuo
 Handa <penguin-kernel@i-love.sakura.ne.jp>, Byungchul Park
	<byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAAJjAIAAAleAgAAEfoCAAAGdAIAAAgMAgAEp94CAABt1AIAABtkAgAAOAICAAAwWAIAAA+OA
Date: Tue, 17 Apr 2018 14:36:44 +0000
Message-ID: <20180417143641.GV2341@sasha-vm>
References: <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm> <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm> <20180416170010.GA11034@amd>
 <20180417104637.GD8445@kroah.com>
 <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
 <20180417124924.GE17484@dhcp22.suse.cz> <20180417133931.GS2341@sasha-vm>
 <20180417142246.GH17484@dhcp22.suse.cz>
In-Reply-To: <20180417142246.GH17484@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:AetOvqyzicx4qimOon94yKmvsAh16jiIupwj9g83Un0KuPH7n5ES6F6E3Sghdrz1TcRtER1IIGKt3BVGQ1KqcBUI15347ym1YwST9KeTYYHEZR9QcBzZj0JUq/YrrWc7lgwR5es22AhXCE6A7SKnEP/EpA2QfbERg2R3qF3HCkM6VESsj3Ljq2h5iKCaAph3KnuZ279Qf+TNgLc8Cn3PYkLSGHPfC+G4hrpP7rKn5IOhfHIJfkmsIRsHXArEw4Xb;20:gD+UeHzWER1BxXRad9DGtUhGNwkX7q5MHQCcosHFzf4EcMLpAdUqriJVh7Gr8zBKEQu1UoEofyEBRKenAKO7lOVbog20H50/j6xrnumwKw0La33uGQc+0fWCx7SnUGUEElUt44hpcvnV4kZmrAMa6t2wp8pMIAgTtF7R3zIAshI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072827F5FA6996482105A277FBB70@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(54534003)(189003)(199004)(377424004)(305945005)(6506007)(68736007)(316002)(2906002)(3280700002)(5660300001)(1076002)(59450400001)(105586002)(33896004)(446003)(11346002)(39060400002)(486006)(86362001)(86612001)(478600001)(10090500001)(4326008)(966005)(26005)(72206003)(476003)(10290500003)(97736004)(99286004)(25786009)(33716001)(186003)(8936002)(6246003)(6512007)(6436002)(81156014)(6306002)(14454004)(5250100002)(81166006)(9686003)(33656002)(2900100001)(229853002)(76176011)(7736002)(7416002)(93886005)(6916009)(3846002)(6116002)(54906003)(3660700001)(22452003)(106356001)(6486002)(102836004)(53936002)(66066001)(8676002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zn3rkckoa6an7RZ8V8U0ssfL92uDbYP5BOYHnk0hDDrFYLBr24OjL/Jx0v+7V0hOeJcZqMMPZIKCU0lrQhbNMQe60NFqHP9diczSev8sLFQQTySz6PyIwNQ2ghgcqBoAVrbSUXKHQUlMjiqBO93sSk9Gpn0vjncBuwJCx7ARO2ooe4J2RiZ454ItS4keMfNx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A72F5632B207064A8FD41BFF577BDC68@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 22453e05-83c5-4878-0f28-08d5a470a48d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22453e05-83c5-4878-0f28-08d5a470a48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 14:36:44.5512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 04:22:46PM +0200, Michal Hocko wrote:
>On Tue 17-04-18 13:39:33, Sasha Levin wrote:
>[...]
>> But mm/ commits don't come only from these people. Here's a concrete
>> example we can discuss:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dc61611f70958d86f659bca25c02ae69413747a8d
>
>I would be really careful. Because that reqiures to audit all callers to
>be compliant with the change. This is just _too_ easy to backport
>without noticing a failure. Now consider the other side. Is there any
>real bug report backing this? This behavior was like that for quite some
>time but I do not remember any actual bug report and the changelog
>doesn't mention one either. It is about theoretical problem.

https://lkml.org/lkml/2018/3/19/430

There's even a fun little reproducer that allowed me to confirm it's an
issue (at least) on 4.15.

Heck, it might even qualify as a CVE.

>So if this was to be merged to stable then the changelog should contain
>a big fat warning about the existing users and how they should be
>checked.

So what I'm asking is why *wasn't* it sent to stable? Yes, it requires
additional work backporting this, but what I'm saying is that this
didn't happen at all.

>Besides that I can see Reviewed-by: akpm and Andrew is usually very
>careful about stable backports so there probably _was_ a reson to
>exclude stable.
>--=20
>Michal Hocko
>SUSE Labs=
