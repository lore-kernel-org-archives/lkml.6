Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-3007441-1525375040-2-10500534086256819736
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
    1525375040; b=h641YsFMm/TvksnX75IQqGG1FwaKq+rcpQ9ThLQFH/uKva87AE
    RSFPLRRuXEUlCtAT8cjE4pAEGMluAnKDTFQMoKfFP5sU58NobiRGtycrZGk8ZOv1
    5ZwnbRjgRuiv3M6GkgxB5fRi9Jl7PAscC18whrlViN+3QRjNZvWmV00zxC0Oz+Dw
    EHGIg1U+nucfHZCAEwbgRdDmsevJmnp0G5wlHV7I77hXiPbALyB9Xf6wdoahIxpo
    dEZhlpUNny5gIlwqrd7jn96oyXtY8iYZ4iM2ATYULLFsZ/dhehtdt5FxG2UmwFNF
    1gBOdiSecG6BXtyCIljn1Lg0i1DJKssHTvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525375040; bh=8AqlJX/a2KQrJHKZpnV+2lirxW4ci6hWQNzrL7wQWjU=; b=D
    AjlftUPAK2nPBHQsQc3ksCjZiP5sX89aUeUpEacOj3vRuLxAQyP89ZjZuB34dkwq
    Rc2h9UC6fUCfXCDp2NkV919JAob9iMR4zZGdmqpAkeNdRT3wuo1Tu+PwQMyIwWCB
    DkJHwIScNy4KhyypTN9a5Zp2nFnhagk2Vqyxfds1rvBr7se1fqKnNH2asi3V/pQX
    Aw4AD/BCDcsUanPDcHqnQ3Ui1hWwuSqnbkEoEEE3SEuzEj0o9N69njrXVYoz2can
    sCxF7A8MfvKWi/fxsAM5IVceJi+baYpC2l5Tl+4ru6Eiq+egnLSEo9+B1cz9v5AK
    9ZVWulRs7iSH8dns9hAzQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=nYfBTTyn
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
      header.d=microsoft.com header.i=@microsoft.com header.b=nYfBTTyn
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
X-CM-Envelope: MS4wfNEfkIhYG7dXPtrBivWCKPeT0naA0mpgDG2bJlcXo6oLgUcNjNGOAAdRwilPdQfhAFe2hqrwVHAu+e607+v6KK2DQ/l+gZPk/XzaLFg1swk9fy/eGHDB
    ejnmacIMxyc6Ghfbf6u6MsnlDNTDLxVNhNHukoKNGzl01orwPOzO9obnXT/kNTGmkilpaU4Gi9wpKCnST9mBNq+ks+4xfOYQo8KIlZ0z0fHf4ei5lvsp/BmC
    hMGYqcDMWtGxAK0ujM7Tbg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=2m6hs8-NUZZd2Rh1we4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Willy Tarreau <w@1wt.eu>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAACPrAIAACxEAgAAM7oCAAAm8gIAABTKAgAAA2gA=
Date: Thu, 3 May 2018 19:17:10 +0000
Message-ID: <20180503191708.GW18390@sasha-vm>
References: <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org> <20180503144612.GJ18390@sasha-vm>
	<20180503165446.GB30522@ZenIV.linux.org.uk>
	<20180503173422.GR18390@sasha-vm>
	<20180503182039.GC30522@ZenIV.linux.org.uk>
	<20180503185529.GB15247@kroah.com> <20180503191405.GC23467@1wt.eu>
In-Reply-To: <20180503191405.GC23467@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1002;
	7:WEgPYUdo54yaixeqBdq9vBl1bApfLQ+PnfnoNa5q41O4cCNeJXQoMI8nHBEOkHDAYcdY6C2+AnRzHThvl12q85J0G85CITdlVx0s2N05lVxVeZ2MI/koueJQ1XtuZ8hRNGNfg7KUO+Tpruz8EhjTXMAjrBcc2bN8Z+hKY6V9PZxhiBlfj7JH5rjhopaVUU1KjS1StCpje6buHfIlJGLMOW+7lj92p8kptruCCbP0KRnmll3pjVSoJPX+HA6ZZl+A;
	20:RAdC8vmFJibcZe9BcNBFb/+GXLPYs8V1H4MH0nvgGfxzKA8qMiHu2iJ7H+XNIWXYHwJJYucAAwK1tvBI2R3i8h4b0y8HXC6Z62qiYgRqN6M/xLUORBDUbEeF5+yXM10EfJxe6ubRDCpEu7qJr/+6LoNLXF9R1L2kK0ViHTtREb4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1002;
x-ms-traffictypediagnostic: MW2PR2101MB1002:
x-microsoft-antispam-prvs: <MW2PR2101MB10023880606A408876E9A5E7FB870@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1002; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1002;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(396003)(366004)(376002)(39380400002)(346002)(39860400002)(199004)(189003)(72206003)(68736007)(6486002)(6346003)(26005)(3280700002)(102836004)(11346002)(2900100001)(6436002)(229853002)(97736004)(6916009)(86362001)(446003)(99286004)(476003)(25786009)(81166006)(8936002)(486006)(966005)(2906002)(33896004)(8676002)(10290500003)(81156014)(53936002)(305945005)(76176011)(6506007)(3660700001)(5660300001)(66066001)(105586002)(14454004)(6246003)(9686003)(5250100002)(93886005)(186003)(7736002)(86612001)(10090500001)(478600001)(316002)(106356001)(33716001)(6116002)(33656002)(54906003)(6306002)(3846002)(4326008)(1076002)(22452003)(6512007)(781001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1002;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: kSmO3uuwBy0M50IjvKroBCkHkQfjUye039luIhqdkuXZGqLrLjmKiu6UwZ5Nj3h5gu2FwzlPh8qgkG0JuN7nXafGevfaYD5HiAnCDaQSorMgKhH/Ub+TFPL3FVi7RvOm4PVONkG7Vfyzj79mCvQn5h6Tk5lNQT52cUqRKmEXF7fA8zjgRExR/LAhuJVkDcz3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <CD35F29F3EE5334BB0C9886691350C4C@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c8f75da9-da2a-4d4e-46bb-08d5b12a7845
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f75da9-da2a-4d4e-46bb-08d5b12a7845
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 19:17:10.5779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 09:14:05PM +0200, Willy Tarreau wrote:
>The dependency chain however matters less because once you start fighting
>with a small patch set for 1 hour you can spend an extra minute testing
>several combinations or figuring the dependencies in mainline.

https://git.kernel.org/pub/scm/linux/kernel/git/sashal/stable-tools.git/tree/stable-deps

:)
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
