Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1997329-1525747187-2-13468125628840574920
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
    1525747187; b=crKSD9wcSkAlFAimfusgQruLH972r5j0el9jYwKd0BrI2BWT7h
    HTqzGvxmnKm5+SqJDAYsxiMBgPjusCuUNFm2g/BbjV1clPCTHnWmBtf1s+jtma/R
    tN/nWqCQEV7CJ5o4EEEUztgDHLuG4dLef8fgEZbjadhwGN3jGAl/g75lqyrticuE
    XYRd++Pt1uo4L+JTu4Ksss43yEDIpgJx/UUCWDalPMKtdWU30gd2c+3TT3bPVy/o
    7FUaUCxvFEOTHW8jZdKcgYzaqy7Z0qBm1hBXa9ZxJ9+LRjI6km0xZPIbVV/Ojv0o
    pdZKBs8ZgIo+DDU1SfWH2vvxRvwEPw4iGMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525747187; bh=euF6R2FPkdDeVzI8ANKEQ0J5y7bCvDpBaggfVJGwijo=; b=j
    6dn5P84Dl1brmNW2Trqsubh25+U56VpYRMf0KKi3Baf/rlYmQnoHadwfghMPUk/p
    kSbd8bu89PRwis8J54doixs3ceqvSryL9OWnF4Xzlwij61OUWSnXE86vmPnGeQII
    ty52vcOtSXjDIr47nNOvaveoCD3fJ5MFRFb64LNXY1kgU748OmtXnBh5favrZmLz
    GtkOOETebx/69ntTYVPf5p8f1z7AQ5/0dMbZESXIJQujiOI9z/BomRVdj7uPagSe
    E5e0+HYC/Znbje4H14BNkxVewSB//WugeV8ZrlI/lo4U3oE2JSNlOFTo28c+wCis
    AkGYh1VlEy/5kOneCSF0A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=gXY5om/D
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
      header.d=microsoft.com header.i=@microsoft.com header.b=gXY5om/D
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
X-CM-Envelope: MS4wfOK6ouRFcP/kBU/v4O8H0j70hXy2s+T13/+OTV6wcxSyM10sOOJvzcS5lWjvmG4ONjMRas4G/lvUQ4cM9koqFo7CuiCRjF1G9FXcfjmvLyP0ntYZ1Kxf
    v2DtBX7jOhiwlbfcY+Yn/KJ1m7UaL54lTwKe3LAxU1E7VnET43O5mMum5ZMDIW7TZE5zkqj7rVnaM10uvl04GGaGVlYAcwIQV/QIvZQ6tcHX5sZG+wEN5pG4
    fFezVUAKgEiQprxIlRFtsw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=wUGooPuT_INsgu8NwyAA:9 a=_NwNbCEiFi5yyeib:21
    a=9fS9uUi30qfPnmDJ:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Mark Brown <broonie@kernel.org>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAaLnwA=
Date: Tue, 8 May 2018 02:39:36 +0000
Message-ID: <20180508023934.GB8514@sasha-vm>
References: <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
In-Reply-To: <20180503224217.GR2714@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1100;
	7:nNnl7BAHEieiF5ToQkrqEGkr0e5QjGz7ArHs6DewHCIAJ0SZcUbAl1equn47tamg5jkph4qu/v4Zl5JcOKdrz9yXP8Kr2VZV215xuNaF7llbSo/V0Nt+zxeX1uWtn4F70kiEoT2M4D5iOxXHi8CARDA3bir6iF4ulNzDFSAdxVslH/EQpkdcrtMuUMP2ITKTd5qMl4IUFM+Hwfgy0OytV3irtuF0gEpD+1Ox/m43wFF2Ow2ViRsCuUAe26W/7jdz;
	20:7076O0BUq7muVVTSbLjrssYbKxPU+VVez0GGLtWQfMop2SfDbJpVTFKUNZdDApO4FPzCQhCVfOQaeuE/J/tOB8vYFM40RWQmag9l6SDjnoBS+wIi/FT8ZRFDgr87qYl+A9SWytqOj0xStqioRvseTsObioI8UC4vKU4fC2DGEPk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
x-microsoft-antispam-prvs: <MW2PR2101MB110044EABB057D3E19430984FB9A0@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1100; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(346002)(39860400002)(396003)(39380400002)(376002)(366004)(189003)(199004)(478600001)(25786009)(5250100002)(10290500003)(11346002)(446003)(33716001)(14454004)(99286004)(86612001)(9686003)(6512007)(106356001)(66066001)(305945005)(7736002)(86362001)(4326008)(186003)(72206003)(476003)(5660300001)(486006)(6246003)(53936002)(3846002)(3660700001)(105586002)(33656002)(33896004)(8936002)(3280700002)(81156014)(8676002)(1076002)(10090500001)(81166006)(229853002)(6916009)(2900100001)(68736007)(93886005)(76176011)(6436002)(6506007)(26005)(6486002)(6346003)(22452003)(102836004)(316002)(54906003)(97736004)(2906002)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1100;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: bQuWFqi3pYtgocdLBuj8Pv0k1bxKR7FP/UoApSJAzyaDnSAFX3zWI7ImlyLV7GTaEn2dRtXaYDQLhAtOmzQhcgAU+pgEDVmX4NXa0/IFlcHOlE/juzDJDxHfAXi5xc0D122pfMqxlY491/nnQjlPm0E/sxBaDEeDN4hrDu39tKJykUB31Tgl4t6my6sNhrTB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <E851300F49D9D54EA7E19779A19A7A12@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 734381d1-2ccc-4843-c34a-08d5b48cf048
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734381d1-2ccc-4843-c34a-08d5b48cf048
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:39:36.1264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
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

On Fri, May 04, 2018 at 07:42:17AM +0900, Mark Brown wrote:
>On Wed, May 02, 2018 at 08:52:29PM -0700, Guenter Roeck wrote:
>
>> As for -next, me and others stopped reporting bugs in it, because when we do
>> we tend to get flamed for the "noise". Is anyone aware (or cares) that mips
>> and nds32 images don't build ? Soaking clothes in an empty bathtub won't make
>> them wet, and bugs in code which no one builds, much less tests or uses, won't
>> be found.
>
>You've been flamed for testing -next?  That's not been my experience and
>frankly it's pretty horrifying that it's happening.  Testing is pretty
>much the whole point of -next existing in the first place so you have to
>wonder why people are putting their trees there if they don't want
>testing.  I have seen a few issues with people reporting bugs on old
>versions of -next but otherwise...

This is just wrong, what else is -next for?

FWIW, our (MSFT) testing folks should now be reporting issues they see
on our -next testing pipeline directly to LKML. There's not much volume
there given that the 0-day bot catches most of the issues anyways, but
we sometimes see odd regressions given that no one else seems to test
Linux on Hyper-V but us :)
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
