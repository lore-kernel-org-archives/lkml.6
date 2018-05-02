Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1256816-1525290406-2-17994876180910874414
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
    1525290404; b=l8qADbMbsUz8HoXYyDMCnKjCkdjpJLeAx0QIx9yZXjr0jykdTk
    r5HHXqLIJC5ufW5ohs8COMkBFwls45qGRuaJ9gPjTfrf4BAWKIyeZfAJ+1w5K8m2
    bWpsWvHLtjgJ+hQ3jqu6AZzsUfaR/H1onaMw5IuxMlvNCjoj2hwwFwKXf4YxtV4P
    ESnjB7eMZiXcszoamhfilxpafFQbz6HNSHewXNtV8QO46OeeBTwAUfxlZnVpEH0c
    O0AneuTRjH7yHnkyzXc1yExfIT/emBmekKB56rCdzdRiMlsa41BC3zLWfBchQ4kQ
    KgNsIenaQxaPLnlfDRy0Bs1KzhlHWe7AAcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525290404; bh=wYNjelggKHZeeL6ggIlYb13it5ux1eGwcnZuJMcV6NM=; b=S
    clFTnDnAoU9U2XH+AAlPgyqI9qzfmEmcZLR4lykN7DObx76XtduoHxOt64Cwfdwa
    UGshyTRqDfNoI3+6nj6sCgnpKeF9c3GEPmBuGmvWQRuF8SCRRLZV/EFosvVFsTla
    BVF4QwEtbYQCkFhV+Os0KS8hu2LYLKzRzcG1OnbfUo+o5qjI5SbIz2f6cvOJNZTy
    c0yXjKg+a8m+jinh3Cu8GFsLz9radJSERlMjkjw+j0nlWDjw/BmVxnBYhZAuXnZn
    XpFESL0R4M4TCYTWES2i+pYtZGM6XGAcGchQxkj6ana12kGoDZbXitG3ALcAjPrc
    zzOgxDUr+CIONSbD0pqxA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=GCp4cDse
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
      header.d=microsoft.com header.i=@microsoft.com header.b=GCp4cDse
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
X-CM-Envelope: MS4wfMXiYsMJ2h4SCIg1hFy+qrq35eOFX3vC934dRDIYrUWE+i9+WO8TuqWDGxzA54lVI77CLpZxG6+xfxWDxjcWSxdP5IvoAp/3qM1H4ZKxXGxXi/bgsW5Y
    kDOts9MejzkFTSKSiOWSkXQ6vpX4QEfolnFpIiZkIrOt7+1uT8gXPTapWW1t4xPGy+xZuy1kRptzwZazYURTl16hUP7aYp39tU89DWzQH55t3J5LyR5O/E11
    RMNQq9WyMEpIKW+PWj95jQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=8HAd48hW2Yy7c7zo9GAA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAA==
Date: Wed, 2 May 2018 19:46:34 +0000
Message-ID: <20180502194632.GB18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1064;
	7:X2zyCMwpHxafkcRj5wDeYWo3ND/awbMBNWFwvNujnZlff7AH9DTUvSNc3ecWBbuVn1arasunckRBd4QxpbtzreCWAhGHGMMuD0esSq20t6nKzk6Ee5qaVykiTtGDQcbAQuEmweId4UgSfvMeFKv8jYQ3LzfUvp9g/UyjiIdD3Y0WWPDMeYVv/nSfQ4t3WpRMx3Js5hku2MexYpm0QR4ZdqP3fVMR8+fYqUJ3JpevtDj+AuOYLTRaI+8kxwERoj0C;
	20:kCjYTjBEfV3TjwDeB70tcbdXxa3LwGOOoOYvLH3vzf7dSQZt92OGqt14ftUcQ/xk+FZaH0nfjX4KdillLISnJM4C+7Jc700+H4AP+g4PsZz1vtxFnoZkMAN+HpengHLmM7OZ8Dokq380ML7eMi1fHVxfBmulEA9IGIiye55IIhI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);
	SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
x-microsoft-antispam-prvs: <DM5PR2101MB1064AE839F1DDEC4A89E8A1CFB800@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:DM5PR2101MB1064; BCL:0; PCL:0; RULEID:;
	SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(39380400002)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(86362001)(10290500003)(2906002)(6506007)(102836004)(229853002)(33716001)(14454004)(8676002)(478600001)(81156014)(8936002)(86612001)(81166006)(72206003)(99286004)(97736004)(66066001)(10090500001)(68736007)(33896004)(6486002)(3280700002)(6436002)(105586002)(3660700001)(76176011)(33656002)(106356001)(93886005)(54906003)(486006)(5250100002)(476003)(6246003)(11346002)(446003)(2900100001)(9686003)(6512007)(53936002)(25786009)(316002)(22452003)(4326008)(186003)(1076002)(6916009)(7736002)(3846002)(6346003)(6116002)(26005)(5660300001)(305945005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1064;
	H:DM5PR2101MB1032.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: MozgvX1in3dgSMuypuMoLdfTmcHqrxN3fnrrheQi6AYNXUzPAEYssHjaJRWMwxkltplXW1njqE2Q0M7LL7wLr3HOZXU4BZOxQMjqbyxTexPyNftw53Crwg+9gLPPFgHM6+kPalI9qAVp/hH1z0O/baNYIeS5A04VHJoepWJoR5/V4n/q3hQAFLkxeUz5eYWl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <42CCEA0F85FDDB42A416F724FADAF4D1@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c75f2950-65b5-4bb3-d4ba-08d5b0656967
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75f2950-65b5-4bb3-d4ba-08d5b0656967
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 19:46:34.8500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Wed, May 02, 2018 at 10:11:14AM +0200, Daniel Vetter wrote:
>On Tue, May 1, 2018 at 11:15 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, May 01, 2018 at 04:54:48PM -0400, Theodore Y. Ts'o wrote:
>>> I do think it's about AUTOSEL, because when I'm dealing with a
>>> regression, I want to get it fixed fast.  Because the alternative is
>>> the merge-window commit getting reverted.  AUTOSEL seems wants perfect
>>> patches that it can cherry pick once, as opposed to a case where if the
>>> user confirms that it fixes the regression, I want to send it to Linus
>>> quickly.  I do *not* want it to marinate in linux-next for 1-2 weeks.
>>> I would much rather that *stable* hold off on picking up the patch for
>>> 1-2 weeks, but get it fixed in Linux HEAD sooner.  If that means that
>>> the regression fix needs a further clean up, so be it.
>>
>> We've had issues with the automated testing systems in the past where a
>> maintainer has had a policy of letting things percoltate for a week
>> before sending to Linus and there's been a bug that caused a substantial
>> set of tests to fail to run (generally it's something that had unnoticed
>> dependencies in -next so wasn't caught there) - we essentially end up
>> not getting the affected bits of test coverage for that period of time
>> which is not helpful.
>
>So much agreed. For our CI we carry a constantly rolling set of fixup
>patches to keep it working, because regression fixes sometimes take
>too long. And too long here for our needs is measured in days/hours -
>developers start screaming pretty much immediately when our CI is down
>:-)
>
>Ofc I prefer if all subsystems ramp up pre-merge testing as much as
>possible (and with xfstests and stuff like that I think filesystems
>are leading here, if not consistently). But given the huge scope of
>the kernel we'll never reach 100%, and oddball regressions will be
>inevitable. Once a regression has crept through it imo really should
>get fixed asap, with no unecessary soaking times - get a better
>CI/kerneltests in place if you feel like you need to soak stuff.

Oh I agree with what you're saying, if you have a good testing setup
this is (usually) much better than just throwing stuff in -next, so I
didn't mean to force soaking every fix in -next for a few weeks.

As you said, the regression should be fixed "asap", not "immediately".
It should go through some sort of review and testing the maintainers are
happy with, but unfourtenately it doesn't happen now.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
