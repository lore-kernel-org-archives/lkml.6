Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2698004-1525359680-2-7321083063571292309
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
    1525359679; b=PZ5GOfAV4Lq7d7qk4erXwSRnDpqac2L4mfmIA/5LUK/xsjA7LN
    z4DOURbfv5GbP2Zv6zkcSoiUhY/XjvJPvkO+ZBY1yJ/S3Q/6eS6tfa/ap2oRer6V
    xsG+hCWLYnT6glolu4Bzy9sosfwXuRxJ6iL4LCorwgEguKFP5sK2QLxT+NhAEauA
    32WGsqbo9BITmDG63j3G2GqurS/b2w9AVB3NuK31CxCsoMf37K/5n8bzZ7w0jM1m
    sq+Va/Lf+zGLakgaHHLCEM+H7N8Y3B83Uvf+kfEueCsSXX2P0ynQz1bqvcDshLJ2
    oJxk22mgR+IJtRo0qtSNMzlAh9g3OXGLNF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525359679; bh=5XIhNiYmYg8oW6JbGr/kKS+zEXhtIvdzW+djZurz9Sw=; b=J
    IR4OmO+8pFw8R/c4H9HAXkYKTQppWhD8+pCtcDTnIAH/FmHlGtJjYNCcitI97mnQ
    RiDWIXJLtYdOs23NpJdcL/wepRsGqJl4YsC9Qvo9mOXBSqD5aZCDJfkUikh1MHiS
    iNxHFJNnZoNIO1MJ+KkkAYT/pL5NcgdJl1ZX8hiMy2V31XzXcFm0ZQ0MRqc61gXX
    Vh00sbx/w6SgvmqD3vz/c08fw0LquTmNyuIIFqyQO2GyYO/W2dYm3lKp9Lio6N1Q
    gOnpRU/JeMG4Gu383i4kWb+fUOw1HI0B0qPXiV4x+FbaZG0h/xizG5Qc/m/bkN7X
    347x6ocNWDuvLgkuMoF/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=QLxk8pU8
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
      header.d=microsoft.com header.i=@microsoft.com header.b=QLxk8pU8
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
X-CM-Envelope: MS4wfNzBZ0RopRMQvZuIQkLBPBTYu3XRNcfgBVEo9isDqcWmIfCGKt4R4+Ix7mGL77SMKIBfm9I0ml8DVD2eGCgQvKTUFdG9mtum0cyRfp+Kn8n4Us0BCf/7
    9tD8xS0F8qxDQ3ROpSJc5iUKk02BBW8VkTJX/BXT354+1RaogQ6Z6TBp3IP2YGtkaBJf/vjpisCN27fxb036ZtKgUIvVrfwHMLYtUU5hNi5ZsxL7LHgDXHqH
    Ef+KCFHw4gGZLDj0xLwhXw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=MZHan-Lz24lilt_EIHwA:9 a=QXDGB3rceZ8KTYqt:21
    a=g3KosiJKEa-2k-GV:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Willy Tarreau <w@1wt.eu>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAAAGkgIAAAoMA
Date: Thu, 3 May 2018 15:01:08 +0000
Message-ID: <20180503150104.GL18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org> <20180503144612.GJ18390@sasha-vm>
	<20180503145205.GD23311@1wt.eu>
In-Reply-To: <20180503145205.GD23311@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0970;
	7:emvfFdCpyn4PtDFylLkmGN8zYwwKVqjwDkyviSnXkrrgWs1iDAmUqjQi+cF1PV3EZtDel7dFTSo9EYVAw5ebNccWlGfzLLMcet+nrQMH02u4xky0PWVt5uJ9vNyGQ1hI3XRMTuBVsyeixf9O7EZsqs6rZp2W8skPnQ07/w5xA3SCeqx8cgnfZwyOrZrxLO4QIStymm1QQvwG9GWnpDxjdBBUMa+s4gGfqyUhXwNGZYik1R0oASPlcaIaFzp8pPLG;
	20:RxxqzYrZ08GV17ElImepbo5W6XuBMcBy+x90nlg0VwT2HKEUi1tIbwHNwCvJJzc7sWofmC7Kb0R33X89AEpLjyp/zGHQylX8wFKsyoPWtDYlJVLenTcueE+79ZPXuahZiK3OYkZbordvdXz6zA9GjbzgY0/kcAf4bgB2N8U6bI8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970CBC5F68EE06F90370CD5FB870@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:MW2PR2101MB0970; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB0970;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(366004)(39380400002)(346002)(39860400002)(376002)(396003)(199004)(189003)(6916009)(10290500003)(72206003)(11346002)(478600001)(476003)(446003)(6246003)(86362001)(81166006)(81156014)(229853002)(486006)(86612001)(316002)(2906002)(9686003)(25786009)(5660300001)(53936002)(8936002)(66066001)(93886005)(5250100002)(2900100001)(6512007)(22452003)(97736004)(26005)(6436002)(186003)(33656002)(1076002)(105586002)(33896004)(102836004)(6506007)(99286004)(106356001)(14454004)(6116002)(6486002)(68736007)(33716001)(3846002)(305945005)(4326008)(54906003)(8676002)(76176011)(3280700002)(3660700001)(10090500001)(7736002)(781001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0970;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: ej+UshidbMRYijE3+nEv+o4HCT0xrRnV6IgVxBGi62PDrCJJIP4ZFp3lW9XZezfEhnkZltrVAtpzdCVCjJBzKYcrTR2NBpOMhi8M/fCQogadLzU/B3ZjECHzvFqqBreYJpEaNaoP739bEVT2mNJllJxt+ySJxRxRPgQM3ti3gu+cv3j4dpiIZ/Yldto0VdAE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <55B9CE414D3E7D428BD0CEF05328F8F1@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ece5b2c6-79f1-49dd-3963-08d5b106b3de
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece5b2c6-79f1-49dd-3963-08d5b106b3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 15:01:08.6211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
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

On Thu, May 03, 2018 at 04:52:05PM +0200, Willy Tarreau wrote:
>On Thu, May 03, 2018 at 02:46:14PM +0000, Sasha Levin wrote:
>> I'll work on breaking up the 4.16 commits into categories, but one
>> interesting statistic I've noticed while starting the work is:
>>
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
>IMHO it's because it's the time it takes for users to start to trust the
>3rd or 4th stable release of the previous version, to switch to it, to
>face a bug, to report it, and for the maintainer to write a fix.
>
>I wouldn't be much surprised if you'd find that among those not introduced
>in the current merge window, many were introduced in the previous release.

Interesting. Here it is for v4.16-rcX fixes that fix something
introduced before v4.14:

rc1 30
rc2 87
rc3 51
rc4 68
rc5 23
rc6 113
rc7 61

So I'm not sure if what you described is really the case.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
