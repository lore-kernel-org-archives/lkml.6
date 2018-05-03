Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2891730-1525368582-2-7615675900077204086
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
    1525368581; b=OFIp/I8oLGIsLW7/boU/DMJxc3FDJrZLhpbqTm9zLdlKhfGqUL
    iU/5xp7DtttZJ22rjBsW8fVLeq+TmRVNmlWtHdLziEuEj2n5pcN0vwUIrvw3Syg6
    rmL/DzdmBMWRnjvI2Pmi4t4jMMs1LYJaN9pVjkLpCUz5BiCHcaiijzOhiikY2uP+
    XHpB09SKKhHadjgHJ1HiR82OUVGNT8QdkrxoQI/8Ar182+hMiPPQwMdb+AhV35id
    D7AaXhDiHsVpQBw0wt5Yds9JTqemAfHXwrvb5xLV6f4STTiTqafHk4eOcMv9r68V
    0J7JaVenioH4soKF21qOZWO+bDEKK30UmpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525368581; bh=hz+MAB3Kxw3GO+TU+sLAH3pIu/VRfZZjg3Ut9wWxwfY=; b=Z
    lJI5dmd2o5vlliTCcLitlXzoOUpNBONT6dljGmnLBAdV2pobHjI0IE0fkrD8n4mz
    EjfNW1fHtZ1qtnyMVJ9tzUk50xPVthKMGcuxoDUbcpnvfgJvgD+kYMLqecAvtpZC
    Bejj4hZaHgf7r4Ty1N6LJfafHVEdkLBCr6JysxqT0wPUkhXazCeIToXHlcW1j1Cd
    aMWYFu7Iaws1InQ4MOECcfMWCNeLaTdz7dE6TE84SAcv4ihIxUVseKBQYFfRhoqS
    qCTYPE5YkQIaQgFzHyP8nmbWPAMI1gycHu9q3b5aqHmUC7lUuqvO+76VFYKaNyWQ
    F5NEDwjsHaVXiyORWfsYQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=CvFRGcak
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
      header.d=microsoft.com header.i=@microsoft.com header.b=CvFRGcak
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
X-CM-Envelope: MS4wfMFaY2keL1LoiprTdQ8FiVhwJgY6m/US3WEOV4zT2jDHheU3gQ4DgxiH+FofgnYvjRMb1W105nBR24KPJjI2TZJgMXLAwFTbcscEb1HBovfz78Htw3Ht
    fCTzAoBYJ8UU5AOKRd3FlNyw+tmEHSW1DAhzK3uU0nROiJNim7bKBaNCQhPxetxMt5ha5+ybZqq3tKKe6/e+i4gUx+L+7VAHb05HOGvfr5XwLfVx/CoNMWlg
    SnqrG4RY8uRif0ltiofutg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=Kpo9clHUUqDtesIKJFYA:9 a=5JOe4Rjw1vjmCHd3:21
    a=ZJp7WeeAnEVlPERL:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Willy Tarreau <w@1wt.eu>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAAAGkgIAAAoMAgAAQrgCAAAPwAIAABbQAgAAPIgA=
Date: Thu, 3 May 2018 17:29:29 +0000
Message-ID: <20180503172926.GQ18390@sasha-vm>
References: <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org> <20180503144612.GJ18390@sasha-vm>
	<20180503145205.GD23311@1wt.eu> <20180503150104.GL18390@sasha-vm>
	<20180503160046.GH23311@1wt.eu> <20180503161452.GP18390@sasha-vm>
	<20180503163516.GJ23311@1wt.eu>
In-Reply-To: <20180503163516.GJ23311@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1017;
	7:rdZjgqryd7B4+jHvl5SSwFypLZ3O2dDc/ilZ/0Yh2UOstiekdTy+59OlpmMTFrXvMRietxcUOpWOZcv7teS3WCKaS4Iff7mZh5kJ14Zo989EpL5T9J2PRzq5K/jKMGjuk6isSg97tXTeA8LqZ7Iy1BeUVd+OKhK7iVwHmhtx7QJ8hNT68fU5orvtfphdIdxjQeCnonRfhSbSXRu7c8rpf72W0/fYfZ58CrO1mp3SUROSk4l8CQThU+TZAkYO8Zmr;
	20:Ok4OX+Fn5XKz/OEvDMPqEIjMdrtBK2Sr104PM0utQoKKI598mU1Oc0qozxfm0f1pxiH+MQd9+rzICbkUMVtnQmyxE4Bc77S9wtvRGAg/zgFx6cUc/duumQH9oo4rYZJ6AEPCZZgXq8yNrc4MLts5FAShJH4DdTNno1QyH5y7YW0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1017;
x-ms-traffictypediagnostic: MW2PR2101MB1017:
x-microsoft-antispam-prvs: <MW2PR2101MB10177820027F9C505CA88BF9FB870@MW2PR2101MB1017.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1017; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1017;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(396003)(346002)(366004)(39380400002)(376002)(39860400002)(199004)(189003)(97736004)(3280700002)(1076002)(8936002)(2906002)(316002)(54906003)(81156014)(229853002)(6486002)(6116002)(3846002)(81166006)(6436002)(8676002)(66066001)(93886005)(9686003)(68736007)(6512007)(6916009)(4326008)(105586002)(305945005)(3660700001)(7736002)(6246003)(53936002)(106356001)(22452003)(5660300001)(25786009)(476003)(72206003)(5890100001)(446003)(575784001)(86362001)(478600001)(11346002)(2900100001)(5250100002)(14454004)(26005)(10290500003)(6346003)(186003)(6506007)(102836004)(33656002)(33716001)(10090500001)(76176011)(486006)(99286004)(86612001)(59450400001)(33896004)(781001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1017;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ffv4DZSZlmVORk3G00dO3lPD7YqLvl8PgwtE+eqTbgvH+WwL8AubYOSoxWjWd94wDI0FLSYSiSA+0ZgT1/rnXXbLOFoAGrfQKFeT6CxFb/Tgz/kQCZ6aYAJRVUZQMjr4nbcuLSwSxs1CpoSmTg49rFB8L1AGMFDOv4X0ijZ5ahY18OSlXqVKN7QtY53vSbZ9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <0BBF3E15B859F5469B9261121E7ACFC7@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2fea6468-e9dd-4c80-3e54-08d5b11b6cfe
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fea6468-e9dd-4c80-3e54-08d5b11b6cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 17:29:29.2065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1017
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

On Thu, May 03, 2018 at 06:35:16PM +0200, Willy Tarreau wrote:
>On Thu, May 03, 2018 at 04:14:57PM +0000, Sasha Levin wrote:
>> I tried looking at a few commits that came in on -rc7, and I see quite a
>> few cases where a commit was merged to Linus' tree in about 24 hours
>> after it was authored. Or maintainers who just wrote it, pushed it in,
>> and shipped in to Linus.
>>
>> I've attached the data I used. The columns are as follows:
>>
>> 1. Commit ID
>> 2. When was it merged
>> 3. How many days it spent in -next
>> 4. What commit did it fix
>> 5. When was that commit merged
>
>> b6cdbc85234b v4.16-rc7 5 ca254490c8df v4.3
>> 82dd0d2a9a76 v4.16-rc7 5 8f58336d3f78 v4.2
>> 5807b22c9164 v4.16-rc7 5 6c8702c60b88 v4.9
>> f97c3dc3c0e8 v4.16-rc7 5 4c4dbb4a7363 v4.15
>(...)
>
>I like this (not what was done but the analysis).
>
>I'd argue that a small part of them there are very likely valid reasons
>(really obvious fix, security issue etc) but it seems there are quite a
>large number of them here.
>
>Now I understand what makes me uneasy with what I'm seeing here. As I
>mentioned, -rc is for people who want to see bugs before their users.
>-rc7 will ensure almost everyone discovers the fix at the same time,
>because the next version will be 4.16, the first of a stable release,
>the one that users are expected to trust.
>
>So probably that we have to educate/encourage developers *not* to submit
>fixes for old bugs that late in the cycle and to rather wait for the next
>version so that it cooks in -rc for a while before hitting users, knowing
>that these fixes will be backported to stable anyway once considered valid.
>
>Just like Greg has its "WTF" script to remind some developers that their
>patch is not suited to -stable, I think you could, based on your work,
>try to spot regressions introduced by late patches that fall in the
>category you've filtered and emit such WTF messages to the original
>patch's authors/committers.
>
>It's important to do it only when these patches cause breakage though,
>because we don't want to needlessly delay fixes when they're considered
>certain or well tested. Only when they cause trouble.

I tried pulling all the fixes that went in 4.17 (so far) for bugs that
were introduced as fixes in the v4.16 cycle, I got this list:

d65026c6c62e v4.16-rc7 5 6b1e6cc7855b v4.7   d14d2b78090c
63489f8e8211 v4.16-rc6 13 045c7a3f53d9 v4.11-rc6   5df63c2a149a
5dcd8400884c v4.16-rc6 6 0759e552bce7 v4.7   bd28899dd34f
0ef58b0a05c1 v4.16-rc6 6 0cf737808ae7 v4.14   a56d99d71466 7992894c305e 2afc5d61a719
8936ef7604c1 v4.16-rc6 6 6c8702c60b88 v4.9   a957fa190aa9
bbc09e7842a5 v4.16-rc6 6 65a206c01e8e v4.13   3239534a79ee
6a2cf8d3663e v4.16-rc5 12 d64d6c5671db v4.15   6d6340672ba3
859d880cf544 v4.16-rc4 14 b68a68d3dcc1 v4.15   8420f71943ae
e39a97353e53 v4.16-rc4 16 2a842acab109 v4.12   cbe095e2b584
a27fd7a8ed38 v4.16-rc4 19 f214f915e7db v4.13   bffd168c3fc5
0f9da844d877 v4.16-rc2 16 28128c61e08e v4.16-rc2   a95b37e20db9
7324f5399b06 v4.16-rc2 19 186b3c998c50 v4.14   51568d69407d
e78c637127ee v4.16-rc3 25 187d7967a5ee v4.4   e988867fd774
ca9eee95a2de v4.16-rc3 25 d717f7352ec6 v4.12   e988867fd774

So out of 755 commits, 14 have been fixed, that's about 2% and we're not
even done with 4.17.

>For me the rule seems simple to understand, every submitter should
>think like this late in the cycle :
>
>   "you're sending a patch that is going to be part of a stable kernel
>    in no more than 2 weeks, possibly affecting all users upgrading to
>    that kernel if you did something wrong. Are you really certain you
>    want this patch merged now, that it got sufficient testing and that
>    it cannot wait for next -rc1 to get broader exposure first ?"
>
>I'm pretty sure that most of the time it will be "sure I want it now"
>and there will be no problem, which is fine as it automatically reduces
>the number of bugs in releases. Some may reconsider their submission.
>Some may get caught by your automated script if a later commit fixes
>an issue introduced by their patch. And there public shaming is the
>only option (or maybe only the second time if you really want to be
>nice).

I'd much prefer to blame this on maintainers. Authors should be able to
submit a patch whenever they feel like it, maintainers should only merge
a patch in when it's right.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
