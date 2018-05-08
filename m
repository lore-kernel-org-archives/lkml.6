Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-3452210-1525815833-2-2184679900936672011
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
    1525815833; b=Voif3DeEsTVimrWDUwSXdlMVWTJVH3G3kbYLcD+KNTdDmAXlq0
    oAZ9Kyed6SsF8mzQQ8xWGBiqN3Be0xzr7GOfwKshChx/oYDZu2N3ee+FA+EifJAL
    ho2dQ4r/KS6ZCFWexQRcfI1EyvDSOpye9UzC6dxphuk48vmAE8V6wLIzJAMKvWq6
    wjQlKF1pyLoi/hd8e+j3+ohTZkVseQ1SxbnM8gmhM2zl5huL4OTb2prLCNRk81Pw
    Vg9BZQT7yu8vqG/xarWKM8RqYcvapIeCKx+h4El9Rqj07fIW4FwOyxTIS5adcWhM
    ylXpWkWo7SuHIGjie+n2Xa3E1s06ya1hMPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525815833; bh=PY8RUa/CJlYasWQHg8iOpg92H7yGa1iJd1aqP0J+Y38=; b=k
    31iDOArppJ587ZmWCXXG6Nc0pTKn8f5usuORUq3G4ppq8h1MfnFpHs3CWxHAyluq
    oMUnF/GtBNwZ7ZiFhc28JuWDjRBTALCjJQDYtdYyrGCCFxCXoAi+rnrTiyNFACJ9
    INsGAlb7z0b+hBpnO1sVcxDPmR1h5/jqBwUIYBJAZKpV0QfekJFhwgHDVbhfWBEB
    IoceVjHthqw0Opz3HUkOLhrDXDLMDrpflMTwACP+QSldtnKiWmGpYv+vbXgUyPq+
    DH8pNCPIxSfGACrWPTScQmLT7cA3oNGkUw/oSALxXG8wJ55GyZt+3rXfxSZFS0gi
    0CaSNb22wZdYC+t809dcg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=IdiFk+XR
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
      header.d=microsoft.com header.i=@microsoft.com header.b=IdiFk+XR
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
X-CM-Envelope: MS4wfO6Iner52ADA4NibBd53q6zOOqqUUP6XCbQtPs2UvEEO/zxfjFBpzGk1kvyDUQrQdMReoZaPZaYxu+Ykxy7N6ame8PzmMFGb0Jhws+K4jLSuVkxGW2eZ
    ou4cY0jKo/+7hzVwDWPjN0ulEEHn1KhzmmmCR5RDqNIL4Tz9vVWDAW3JYgLfHG3DOdNfmnxaYhjFOxJedV4axS+v5inyuYuUOOv0qGG0FLuvFYIWsJtmzckL
    tLv0NFeNMDLs+nV2e/E1bg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=x-8vb2v-I1Whnqm1RnEA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: David Lang <david@lang.hm>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAAHfYCABoLCgIAAFJYAgAEXpACAAAMHAIAABDSAgAABLgCAAAxkgA==
Date: Tue, 8 May 2018 21:43:41 +0000
Message-ID: <20180508214339.GE8514@sasha-vm>
References: <20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
	<20180508202912.GC8514@sasha-vm>
	<CAFhKne-aDcMKD8FjfROGZ-=ffmq3Xa+7n0dm8uvzKJ_7WO-qCQ@mail.gmail.com>
	<20180508205505.GD8514@sasha-vm>
	<alpine.DEB.2.02.1805081357451.31825@nftneq.ynat.uz>
In-Reply-To: <alpine.DEB.2.02.1805081357451.31825@nftneq.ynat.uz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1036;
	7:Orlg31t7OUM2A7RSqrczvORsSrzDW7udHRE5DblwOh+j2Ha6rg1496gHzm5SA6w6RWPVHbw4h01BNghZL4NsiKTVnx6gJAGQ9H5hg4ZQozytf9drbkRlD23ibbRjYojZd/gzWWmVR64r3dRRYFzouwcpcnwEnhMDjrB+g6Q3q7OCemDSq1EiRqZ+mGVLMNo0HZqUwXVWk0QPAc/lIkcaUKkPWypVSlt7GCElT9gXZAQRcsCsTtRi4Amv2HcZ+nd1;
	20:UxrRsZDwPUKYgiTDQhNxLno4LAC19pCbkyaXtCWS6U9r3FWeq2utU9pX0UMJZp+xGIwX745GK4hd4N9YVtLn2u7RTVROI4PnbIlCjAAyPxO4MX+ZbEbXUcsj2ZI5Tv+wZJUhTtLtiLFNILwTZ0CWClmxbzWkYJwthFuSTe9l5BI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036DAD0352468018E497B39FB9A0@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1036; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(366004)(39380400002)(39860400002)(376002)(396003)(346002)(199004)(189003)(6916009)(54906003)(106356001)(39060400002)(25786009)(6506007)(22452003)(93886005)(8936002)(316002)(5660300001)(6436002)(97736004)(86612001)(81166006)(33656002)(229853002)(26005)(68736007)(10090500001)(305945005)(102836004)(6486002)(81156014)(5250100002)(53936002)(105586002)(478600001)(33716001)(6246003)(2900100001)(4326008)(66066001)(2906002)(6116002)(8676002)(10290500003)(6512007)(11346002)(3846002)(476003)(14454004)(486006)(76176011)(446003)(3280700002)(3660700001)(33896004)(86362001)(186003)(7736002)(99286004)(1076002)(72206003)(9686003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1036;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: vITo8MRLBR/9ChvlRdjh3olzFAjXZaYkKlKi3kMnQnPJr97SEN0SV19xqpuOsx4eB0jJAJWV881seBGfekS+vXi44OageHfJN/scHR1ZRGcfWBD3dLo8V6BF5KAhEk1h7NU2e1xErQjqmEkTAcFcHmhHyoJtEgjRUaNpf84moSLvK0CRy9AEmZsmSEeKo4+H
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <88315B09AF26DC4C9BDFFC0D97704818@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e98fa8ad-5e9d-41e2-e4e2-08d5b52cc40a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98fa8ad-5e9d-41e2-e4e2-08d5b52cc40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 21:43:41.4248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, May 08, 2018 at 01:59:18PM -0700, David Lang wrote:
>On Tue, 8 May 2018, Sasha Levin wrote:
>
>>There's no one, for example, who picked up vanilla v4.16 and plans to
>>keep using it for a year.
>
>Actually, at a prior job I would do almost exactly that.
>
>I never intended to go a year without updating, but it would happen if 
>nothing came up that was related to the hardware/features I was 
>running.
>
>so 'no one uses the Linus kernel is false.

My point is not that "no one ever uses Linus kernel" but that no one
takes one of those kernels and plans to stick with it for 3 months until
the next one comes up, even if there are updates relevant to that user.

Yes, some users will use a .0 release until either Greg releases a
-stable, or until the next -rc is out.

What I'm trying to say is that there is that the .0 release makes some
people rush poorly tested commits in it even though the .0 release is
not significant in any way.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
