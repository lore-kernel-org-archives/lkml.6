Return-Path: <Alexander.Levin@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-1874849-1523972379-2-18122808587058362120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001,
  SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='104.47.34.139',
  Host='mail-by2nam01on0139.outbound.protection.outlook.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Alexander.Levin@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523972379; b=Mjkq1QnGfKFN+kzjHyHKiKVKyZTFRGURuAgYc4CnyQ+TgvbsF7
    6cgVataEc7v0p4cji1fSzwUDPXCIWgvH4pZQmeb7kGz2ZWO2TmPn7a63fe4a0LKJ
    vyVv9qDz4lZUhPqvVimbR2xXf6ul6PdFBJJltgwlVSFKyCC8xz41pYK9h2CUap8n
    GWlqO5I7yIDXMFpieLh66IAwlFoyXSnD6rdfS/yCL5crm+IY1Oz7mphI4mrIqjiO
    coDjb3NLvxm4J2htd3ImO3ZieONdlzNZjNtoYR/AtSmel4e2yEZZ3t7llOaaI6Uo
    kG0DIVsu73JIrvjLMHolyIqO+KaUEa2T+C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=fm2; t=1523972379;
    bh=UXaQ54o1u83i1yQPzMq+bJBjxOUa8llV/AhUa+PJVOQ=; b=LBUrfpQckhuQ
    meOCZwFhQOkjBJoQAT6zDW5oh0fDYaRbuNdKfg0jSnA4Riqzknuc1RDUhOT1IR68
    I6t0kHMx8/VP+MlskmiZy4KaFWEL75jWnhn7ldj1cj+UNybCo2kkEfYcYjUAO6VW
    M6doD/3IZnYNCkemGF7TV9uvh9dWckIJgd10CH+H1Ig+APLDYDJEcUvfUdd8seHL
    7qpaUiU1e2IkzUs3BSnqv2t++6KBeNOaXk2ib8j+erNPq1tcc41JZ1sW120Nuar5
    HMeijoXbYlOlcmRKT5x9B1QcyKZP8oxE7pLaQPmy1iH+vefmOHPut9v8X0Cu2pYZ
    kJcCm9riCA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cI7luNSd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.34.139 (mail-by2nam01on0139.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM01-BY2-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM01-BY2-obe.outbound.protection.outlook.com x-ptr-lookup=mail-by2nam01on0139.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cI7luNSd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.34.139 (mail-by2nam01on0139.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM01-BY2-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM01-BY2-obe.outbound.protection.outlook.com x-ptr-lookup=mail-by2nam01on0139.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDOUxFY0RP1cxo9efelT0R1sNo+11pSdANWPS064k+sTbwbhpq9WscYZH54LFynR0DOg9TxO9ZRTbR+HLHDRcV1e08YHMs2LMQ9r/jXrYxr/pDVe+p+p
    pxKCxuFfwo3yoVW3cnBp1qVucyo3yf2adR8xCpoIkv17sCpL3SUUwKR+1b0aRmm2Q8Xg79ySeh827D2utbwOjI0/gJnYlentrIm7KA9ZgTlqhobGTwnaRA6f
    YFZ3zKj/HDnhmVvm0y7+5Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=AkUIioKv+ezWNaP3nA1c/A==:117
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8
    a=UqCG9HQmAAAA:8 a=lK5mMpFVJcFElLME6QsA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAAJjAIAAAleAgAAEfoCAAAGdAIAAAgMAgAEp94CAABt1AIAABtkAgAAOAIA=
Date: Tue, 17 Apr 2018 13:39:33 +0000
Message-ID: <20180417133931.GS2341@sasha-vm>
References: <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home> <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home> <20180416165258.GH2341@sasha-vm>
 <20180416170010.GA11034@amd> <20180417104637.GD8445@kroah.com>
 <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
 <20180417124924.GE17484@dhcp22.suse.cz>
In-Reply-To: <20180417124924.GE17484@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:5cmpld4JXIO+mCCqWor5TBiItFN9H8zFBBU+YT1FOkdW1lnMASMyaNWi/RVwx1rHEe/lr5SIwDTvRTrwGjTIDjpuqKfaL/+mTtEx8MOAOZSyGB6TNTKXRLaCiCXgfbxYduIsXGPS8Lb6eszo7ijTYID+yXVtsAaaqIbp73DJWpLNnhQpZO7KhT+RxCjCqLa7chvOeonyYMH9bfqZ4Oy7ly9PybWMzNnnHqpIKBAXXhB5uIQu2MHwNhOFB8jhUR88;20:eQN3FUdiV8hPKivM/7rJ0ExeKXwm+RjGiv0r6Wy1VQ4Dvb3vJ9NkfM01/6ur3HMpnRyghRnqKy8iNKP9YoJf2em5HlDemngIu2hAisUMBgLcDUSJPG63z2m+p8Rmo5TWL/7/7OCDDKXIuL+s09PO+012Xs6n+dIYiouvrH/ntgc=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09840020902E054A2D2FEC77FBB70@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(42068640409301)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(51444003)(377424004)(189003)(199004)(54906003)(8936002)(10090500001)(2900100001)(66066001)(76176011)(33716001)(6246003)(6436002)(86362001)(4326008)(1076002)(575784001)(39060400002)(86612001)(99286004)(305945005)(33656002)(446003)(316002)(478600001)(6506007)(11346002)(486006)(25786009)(476003)(81156014)(8676002)(81166006)(105586002)(26005)(33896004)(6916009)(93886005)(14454004)(229853002)(97736004)(186003)(3280700002)(966005)(3846002)(7736002)(5250100002)(22452003)(3660700001)(10290500003)(106356001)(72206003)(5660300001)(7416002)(6486002)(6306002)(102836004)(6512007)(9686003)(2906002)(53936002)(68736007)(6116002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: TYjQCW3AT4H3hT0VuJrYbPoGPLizNwOKV5kBmNoZ8fJf3gIoZIBfoJOyvkcs+u+kgpyXXpNz4QQ4oeXs9tX+OLHjrjjQ0YlIKsHlXMHb07gdLQPg4Sb9qRUwK0ZoFkzQCfXo0x0NVhus2eL+t/mIW2m6U239Q6oRrei9F0So+PwmlpjAlZr0j/maAOXnw/3h
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DDD0234E682F2419DBE62CF9CA460FD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4394793b-7014-4fbb-1516-08d5a468a7c8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4394793b-7014-4fbb-1516-08d5a468a7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 13:39:33.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 02:49:24PM +0200, Michal Hocko wrote:
>On Tue 17-04-18 14:24:54, Petr Mladek wrote:
>[...]
>> Back to the trend. Last week I got autosel mails even for
>> patches that were still being discussed, had issues, and
>> were far from upstream:
>>
>> https://lkml.kernel.org/r/DM5PR2101MB1032AB19B489D46B717B50D4FBBB0@DM5PR=
2101MB1032.namprd21.prod.outlook.com
>> https://lkml.kernel.org/r/DM5PR2101MB10327FA0A7E0D2C901E33B79FBBB0@DM5PR=
2101MB1032.namprd21.prod.outlook.com
>>
>> It might be a good idea if the mail asked to add Fixes: tag
>> or stable mailing list. But the mail suggested to add the
>> unfinished patch into stable branch directly (even before
>> upstreaming?).
>
>Well, I think that poking subsystems which ignore stable trees with such
>emails early during review might be quite helpful. Maybe people start
>marking for stable and we do not need the guessing later. I wouldn't
>bother poking those who are known to mark stable patches though.

Yup, mm/ needs far less poking that XFS (for example).

What makes mm/ so good about this is that it's a rather small set of
devs who are good at marking things for stable. As long as the commit
came from one of these "core" mm/ folks it's almost guaranteed to have
proper stable tags.

But mm/ commits don't come only from these people. Here's a concrete
example we can discuss:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dc61611f70958d86f659bca25c02ae69413747a8d

This was merged in a few days ago, and seems relevant for older kernel
trees as well. Should it not have a stable tag?=
