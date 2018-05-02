Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1258495-1525290710-2-603017045801291484
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
    1525290709; b=Jpa/bCZpCj6lL1iETXpSJcsBHrmVjUFxqNqmK/r/VWOULjkzGt
    S7vWWbsJIDNbwD+dxJ7IUWeEtL8jkI3fHpP3d8gwd8o9i8YR2rErw6/DztzkL7j8
    0WCqM5hZWzWMUMZkemy1QmWE6fFpC/4lcMtXbUaPZdnCyMvOpr4F+7hSdgUpTpaD
    3bFz6JuLhsUGLureYabBZtFpo3MVZqhFD3IsM/FpxqaANWRAGDD+HeQI67ZBOAW3
    gey3PdsOmUkcr5Xg1zY3+WicsAlVD6K2gUDUsCrxQHWLeAusuqXp/G3YjS/rjklf
    cliqoTSxTpSW5V3o0MApqRCWyjiRNVgXiFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525290709; bh=yjxDe6AtBEKFZ3xybcVSQKNLthwX0Bu6GmldKmIUA7k=; b=F
    mRUiqxomQvIYPZM13htM8OwtFj65t7xt/LiiQ1VZoRtsNWQJk6VxXcSolH9rGzw4
    2mbfGNlp7+61DZG7lWJcsC+tt8l66w1IOx6UTMToHVUaCJ2bwL9x7fk2g2DodVmT
    2a/4dKX7oJewE+qs+IsiNm3KHX481cTu6DaovgP9i425dicgSlh5XMCuw1nEsXZU
    Isu4n61CWkht2NZ2ZgFrk6LhGpq2Os+XWMGszExpBb1H1o5gn5DCkv+tAKDOPO1/
    UkB86xmTOTEomiMp3IuVHgfqm4yRnJ5EzgDHugA0L04hJjLd54RL/hWuylJ44XYL
    UsBlbE3HtYxVIwapXdZow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=mx+EUSx8
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
      header.d=microsoft.com header.i=@microsoft.com header.b=mx+EUSx8
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
X-CM-Envelope: MS4wfCgZq5Ktgp+qnRbUjdfn+WUVxxvMKPT8OQb31eygli2Sj9VgA0gnoHIq2eQpSm+GTmuFnFXFVQQIa72523BxVx/CPwC8zszwUJV035tYe4r9XlJlvNAj
    GtGyh0+dq0Vh1FzkUqJirS2F3MKp0paRXPjIY/li2Pe1etPEvA5osNyiLfx/oac4/bLRfy7LrpqlX8JZihI3Q0bPDq8DrdFsA6jPL400qvH3TRbuRTgh5m+/
    JnZlaiillEdq1Y/5VRRb/g==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=n71_mWegFS3LJH1NAE0A:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Thread-Topic: bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgA=
Date: Wed, 2 May 2018 19:51:40 +0000
Message-ID: <20180502195138.GC18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
In-Reply-To: <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1014;
	7:x8nHxiu8OIgwlNLgSmJijql/8hXbAMsB0qWfF4olbfYSsGvA1Z6IW9MKXAU0aUPsPi35eM+ifq8dvUQQGAz9KCuVh4Xcl8+HZPK0X3B6VvQCR7d1rGUskm3S6XZUmS7oLd3/lsRisP+mw7s6UeFl8Z6eHnf4zTezb8jecVlbtsshAhdOtJC7zGbYxwW0f4Ud7aG19rvPdo6OpNUg2ox5xNSURKXxdtGmEEpQPelHJloTHD3Evl//Svfiufc91V+M;
	20:kHbSzS76DvyM9TqgEwteWPFOuW9JX6LTL/uIM964y65Epy4drwICpntfFC0f8qjUn/vgz18JzFs3D43mlt6a4qS5bBj8rlLhUPEljUVi+DW8djx0lNJ1c5LuhFsIZLFHn4m1A/EVslstF/nr4ej72cZoA9It23mORsh2jGJLgSI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
x-microsoft-antispam-prvs: <DM5PR2101MB1014F374C6DAEDC8F6FE640CFB800@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
	SRVR:DM5PR2101MB1014; BCL:0; PCL:0; RULEID:;
	SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(51444003)(199004)(189003)(105586002)(33656002)(76176011)(66066001)(33716001)(106356001)(6506007)(22452003)(33896004)(54906003)(99286004)(102836004)(3280700002)(3660700001)(446003)(68736007)(6246003)(97736004)(476003)(316002)(11346002)(4326008)(486006)(26005)(81166006)(53936002)(9686003)(6512007)(2900100001)(186003)(25786009)(6116002)(3846002)(1076002)(6346003)(229853002)(6486002)(14454004)(7736002)(81156014)(305945005)(6436002)(8676002)(10090500001)(2906002)(8936002)(10290500003)(478600001)(6916009)(3480700004)(72206003)(5250100002)(86612001)(5660300001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1014;
	H:DM5PR2101MB1032.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 1VuOvnCypxkohMr4wZBP7d36qNWGO5YnIzFBrSFnY7wy6PByTbOcFsSk7wL54Y1MHux6Jdz1QKpNbOI8cXetN1XkalszEm2cKJuyhW95Tx6jYI5SMpHYt+k/yPqKtZRqrPO5wliFtyfZax+u4wsbKCyc5OUE7ViMqAPi9tTmW4yb13KJLV2iN0EfRc5bFEQv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <ED092787459212418105336FAE18C961@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 47df7b31-29e3-4a0f-adec-08d5b0661fc9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47df7b31-29e3-4a0f-adec-08d5b0661fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 19:51:40.8796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
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

On Wed, May 02, 2018 at 05:32:37PM +0200, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Tue, May 1, 2018 at 6:38 PM, Sasha Levin
><Alexander.Levin@microsoft.com> wrote:
>> Working on AUTOSEL, it became even more obvious to me how difficult it is for a
>> patch to get a proper review. Maintainers found it difficult to keep up with
>> the upstream work for their subsystem, and reviewing additional -stable patches
>> put even more load on them which some suggested would be more than what they
>> can handle.
>
>Thanks for your work!
>
>>  - For some reason, the odds of a -rc commit to be targetted for -stable is
>>    over 20%, while for merge window commits it's about 3%. I can't quite
>> explain why that happens, but this would suggest that -rc commits end up
>> hurting -stable pretty badly.
>
>Aren't more -rc commits targeted for -stable because they are bugfixes?
>Ideally, new features are supposed to be merged during the merge window,
>while -rc commits fix bugs.

new features can only be merged during a merge window, bug fixes can 
be merged at any point.

>So they can be categorized like:
>  1. Plain -rc commits,

What's this exactly? -rc commits are only supposed to fix bugs.

>  2. -rc commits fixing a bug:
>       a. in the same release cycle,
>       b. in a previous release.
>
>2a assumes the bug was backported to -stable, too, doesn't it?

Bug fixes for features introduced in that release cycle won't be
backported to stable.

>Do you have statistics for which categories are most buggy?

I haven't broken it down to subsystems for a few reasons:

 - My dataset is based on the Fixes: tag, some subsystems use it less
   than others.
 - Maintainers change, so even if one subsystem is being awesome about
   it today, it might not be the case in a year.
 - I don't really want to point fingers at a particular subsystem, I
   think that this is an issue at the kernel level.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
