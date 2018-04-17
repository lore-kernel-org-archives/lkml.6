Return-Path: <decui@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-2367869-1523986984-2-12802314045274438380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.126.113',
  Host='mail-pu1apc01on0113.outbound.protection.outlook.com', Country='KR',
  FromHeader='com', MailFrom='com', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: decui@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523986983; b=akVFiRSWC4uWoeZw/bB6Uf7WoVVmzcZZZXxJ2KwYFrSNOrdKzv
    iJ6/JiZvkE5U/KTy3rAe9SCdWtydOgCF94ZqcBdtAmiXIcQoMPUdOz5d4X/Laxuv
    lF5C3yMKIS20RigDAaNSnITC5T1LDuDYuMb0XhJpY5e2H7BCY5avkTmq3QTswZoB
    zITVuBA8/9DAwqT/JMCfD9snXqphyPooTrEO+RWxujG+NDGMqrFgRxGsEWA9Hny/
    VFePXV4PDHCk9k9m6OTXhd/Lrj+MkmxJwQdxFFRyfv+5lB/DjtE6Jsxu0KLYZozv
    Sd8nePFBD1ivhl//4y5s+0uDEQzru4OtoM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=fm2; t=1523986983; bh=WLSGkWNEz2l7zv4770kUAutbA
    L488lo85XOVAJYf5fs=; b=Lv0B74nmnEm1GjaP7oDYntTE9LL+9ezP//uBOITwJ
    nQiJ2hdGAAD0BBlaq+GN9cWfoU0i3LTsyqcKn4dWNLMWj/WQ/G2+RmPffADJV8Hm
    zRWwFVPrA+oiNZ3dl6hF+XDuzDhvRqjtocR6IhTId4yAeQ2As/umaHezsL5qeViM
    xMxjOT+MV+cEh+POjl8Nnutlwv343vj1O5NG2qylFVKy2j12k1axfuQhFBC/sAVV
    lhXuq4+Hf1+f1mq5NB+kXN9gaL3hkfa4BVLiVsruvGUW/a7fvUGNEB9qgRApy4Cl
    kpTQzp+CIMXLvr43rZLyPR0TA9wAVes7tsOpJosc2Ma6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RmbcQH5y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.126.113 (mail-pu1apc01on0113.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=decui@microsoft.com smtp.helo=APC01-PU1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=APC01-PU1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-pu1apc01on0113.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RmbcQH5y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.126.113 (mail-pu1apc01on0113.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=decui@microsoft.com smtp.helo=APC01-PU1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=APC01-PU1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-pu1apc01on0113.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLKg1VEr9cn0mHkaHEg15thchJTJ19XyY9GdBgg/1uZd5bnqGbc5gCWRcfKE1QDgz+Xx/0SSjuql/IITq6jCS1K7/GCf85OqY2uOxUGkfbSfyGBU+Kbp
    QK04NKSC7xjZVydwdzeVXzZyOVBRO0TmOZSa22poagfo9htUDdDYtk6T7Q3lPUKfv+w1+2dMoXL+/um3H/nPp/u5ZJ+I/pgtTtPnZFhmMgKeI1T0aD366BC+
    7ywCFjH8IY1Jy5vEIS19Rw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=Ml2tYN84j5X0jkfrTR1hCA==:117
    a=R4fxTKrshSIA:10 a=F-eafH2JolcA:10 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2C6YHBdLAAAA:8 a=zhjNs5w5nfpf7tkiirsA:9 a=CjuIK1q_8ugA:10
    a=yxGMNg53M24zlVSZdvMH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Dexuan Cui <decui@microsoft.com>
To: Greg KH <greg@kroah.com>
CC: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, Pavlos Parissis <pavlos.parissis@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "jack@suse.com"
	<jack@suse.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: RE: kernel panics with 4.14.X versions
Thread-Topic: kernel panics with 4.14.X versions
Thread-Index: AQHT1YZ2Fl4TtFRnH0qUyqkfz/cZJ6QDdryAgABq8lCAAOJjAIAAdoGw
Date: Tue, 17 Apr 2018 17:42:38 +0000
Message-ID: <KL1P15301MB0006AE4B63A9C92C43348DBCBFB70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <KL1P15301MB0006B378757EC8F6B4D87BBBBFB00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180417103344.GB8445@kroah.com>
In-Reply-To: <20180417103344.GB8445@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-17T17:42:37.0656210Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:a::1e8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0053;7:Ug3uwiL2g69s8utKpm+8QnJ1Tv0zfbIUDRA0tGDQExsHszyp9V9TSqchEqTtwADiI50wu6F3Yy9QNjf7PiIb1fOuADkLXIlsCz4m3pUQULoHEO5iFWfj8byuNN9F1OVS7GWmSWQDxhgpPnLaagiZmAEnWJ3+ibbFxbmbiYTWNeCPtQg3Bg/ajQmWT5eRo+2OoA+HFIq93qFfE9GAaEAcdEYziF6ehm75t0XUVckgTSoJZxFQvw8QI1nu3dn/Euyv;20:D9ARFMVcVKqo3eBb7p86naXdaxpHNFgB9zf22cMbpjXAZ489DEsGLhMLURKnGylkQMgtdfhezMA/KCbTGPeMmrUbdYTO2MwFxDkDCyxLv0+6FF3SnoTFDNJFFnC8W+TZZYt0BavAaqLKkD4ALtFmJ1oI29+n8BVnFzqSBA63GFE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:KL1P15301MB0053;
x-ms-traffictypediagnostic: KL1P15301MB0053:
x-microsoft-antispam-prvs: <KL1P15301MB00532A968590BA9A02C89B07BFB70@KL1P15301MB0053.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0053;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0053;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(5660300001)(25786009)(33656002)(93886005)(11346002)(22452003)(46003)(486006)(446003)(316002)(476003)(105586002)(81156014)(2900100001)(81166006)(10290500003)(6116002)(97736004)(7736002)(99286004)(8936002)(3660700001)(3280700002)(478600001)(74316002)(10090500001)(305945005)(102836004)(76176011)(2906002)(6506007)(8990500004)(106356001)(7696005)(229853002)(4326008)(77096007)(14454004)(6916009)(39060400002)(9686003)(6246003)(68736007)(186003)(53936002)(6436002)(86612001)(55016002)(54906003)(86362001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0053;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /LJ3GPwMAAdWto8aLyDVzRw9nQx8ZbL2TDm2NE1Exzl4SQeh3DwjzMguGjUCzpF/sIcc9Z6U8NS8e6q8Qq8+JNn/HlTb5rJld/AXTXUOyujxR+oSyAhqUh6mAn8anh8PqwCD92iP/Jg+CbPDW32gMrXYVILuNmCfDN4P6PAYrJu17NaOXXVCrm0FDliJx5gy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2f62918c-fb0d-483a-b000-08d5a48a9cde
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f62918c-fb0d-483a-b000-08d5a48a9cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:42:38.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0053
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Greg KH <greg@kroah.com>
> Sent: Tuesday, April 17, 2018 03:34
> On Mon, Apr 16, 2018 at 09:10:35PM +0000, Dexuan Cui wrote:
> > > From: Jan Kara <jack@suse.cz>
> > > Sent: Monday, April 16, 2018 07:41
> > > ...
> > > How easily can you hit this? Are you able to run debug kernels / insp=
ect
> > > crash dumps when the issue occurs? Also testing with the latest mainl=
ine
> > > kernel (4.16) would be welcome whether this isn't just an issue with =
the
> > > backport of fsnotify fixes from Miklos.
> >
> > It's not easy for us to reproduce the fsnotify() lockup issue, and actu=
ally
> > we still don't have an easy & reliable way to reproduce it.
> >
> > According to our tests, v4.16 doesn't have the issue.
> > And v4.15 doesn't have the issue either, if I recall correctly.
> > I only know the issue happens to v4.14.x and 4.13.x kernels
>=20
> Any chance to run 'git bisect' between 4.14 and 4.15 to find the fix?
> greg k-h

Sorry, I'm afraid not.=20
It was only reproducible in a customer VM with a specific workload and it t=
ook
days to hit the issue. The customer VM doesn't exist any more. And we even
can't find a way to reproduce the issue with fio tests + programs that test=
 fsnotify().

-- Dexuan
