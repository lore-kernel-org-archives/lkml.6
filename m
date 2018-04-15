Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523803193-2-15360889418611763936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523803192; b=Bfb2vFllj4ege9BIppF3XuXGS883lZb3wE9thQQNK/TO/nMTsU
    CM6fUXQ8n3py7nu9UZgrAhex81x3RkNUTZfbOJuHWE9lKZW/Le2V/2IdtWMQytLD
    P/zMqYP9k0ban+flPM8Vje/DO9q3EgEg3x6yeRq1Np8DU1FjfwjX743qwKta7pWw
    j6Oc7vrnh6/kxM4l+uK2AHhj1VKVcc1Qj6lL4nI0FZepGL6EOflQkM0g1lnUtL1u
    3KU1l2DW4R7SiC9smZ0Kz71huh7rvzUSoxhAQFisH/qeb2OnQezEAfpi84cqzzEu
    +Jnx6zBg2NVqDzhFq1D9KFevQVhHHPQ7ckCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523803192; bh=a/YJ1B/1tQqNis0/ycjrSOvlF9s7Cl4bgBCGptC94mM=; b=
    DhXFwD1UkGpcxZUGvFDFgGZH08e0RAM4h1+zkLenZYMb/P5cpwY99sCx5mmJuN2/
    0wPBcpFhtc4xXOY0pl34NhR8q2WFV6vxW2jEh6azMmPc212SE7F3nD2Y/7M6ms5r
    Ky/VMpKUS8vSHX6uuKxPGO905jZDLTpt3M0Yj6Bk2gnPOe1uZ4jdy9iiHGNI5ESS
    J3BAqiijP2fSk/ad0fAe5aNbHS4rLq/RcXzS9nJRFvNcxtTJ9pfkBqE4bXlRADiE
    VZ9BYRhloouxjYrFI7OCxn6fozGD/aKSVsTWafgu8sMAi3infedObw1FfGJAz/+T
    7CGHzW/Ymaf4EmxQbLXwsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=itglF/LD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=itglF/LD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP5clme8RiUq56FkyNFbE0xIZiDXgquvKNEd+WrbkruEvxjhgpWFgCDfV9fPDvBvUsz/f2C4BBc/ajqfPrna95eqJi3pNDTZt7akCE2WqBuNmt21egEm
    ++lbiQ/lwLjFxNpNDsq742YUgn1LtEb1/9Qervo57cp8rbDQBceVxGriYvRLWRnPelh9t0lTPDbwn6HMBCz0xJ3nnInxD7sLF4qn0khhvvtrLN6OLT4aH8Ra
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ER_8r6IbAAAA:8 a=EG3PZvrjf4q4sxDUaVcA:9 a=CjuIK1q_8ugA:10
    a=9LHmKk7ezEChjTCyhBa9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeDOOjv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 10:39:51 -0400
Received: from mail-co1nam03on0124.outbound.protection.outlook.com ([104.47.40.124]:16549
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751890AbeDOOju (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 10:39:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: James Hogan <jhogan@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5git3dFULHUMUCcLZ/m4cWq6qP43woAgAkQ+AA=
Date: Sun, 15 Apr 2018 14:39:48 +0000
Message-ID: <20180415143946.GO2341@sasha-vm>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-48-alexander.levin@microsoft.com>
 <20180409201242.GC17347@saruman>
In-Reply-To: <20180409201242.GC17347@saruman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:p3v4Kvk9jR3u9F5dkb+KkDMxc+6rUm/uh5xkcBi9ujtG6JLCxARMf3sHgYpPp9YbpTD1MASyHBzVkupGO8f4KK50y1xA18BGNciSAgv7jIgdxcOnc17R2bfqBxQZPjpOBtVMA4RkvTOcJBO16+IQVQXqoMTAt5k0XXUUC80JRxcdgUCD9D79Rbi3vOA66MxLiCyslmJW2W/Hhen9O9XfmbPP/W8UrWea9XXubUxCQonTO7mQOBQJS0BMYTprJ+1N;20:QmngTDbFH5dP9jnl3YNkHJ5OEcXWasp+osUk4PJ+ATF2KkILbS2GBRRx46JQ2wumLa628PbQB8fJC61aNgZe7Q0l9jEtR9O/ViAjFWQbHwfezguZZ+qwNPCZJwBJ80ooE1xdIshzDNH5cfyPQStgJYm8a7qbWxUSQ+iEeHYl0Dw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104780C37742C2D294484C3FFBB10@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(199004)(189003)(69234005)(68736007)(5660300001)(97736004)(25786009)(26005)(2906002)(10090500001)(3846002)(86362001)(6116002)(478600001)(2900100001)(10290500003)(229853002)(14454004)(72206003)(6486002)(105586002)(66066001)(3660700001)(33656002)(3280700002)(8936002)(81166006)(81156014)(53936002)(1076002)(54906003)(9686003)(6512007)(8676002)(99286004)(76176011)(102836004)(86612001)(476003)(33896004)(11346002)(446003)(6506007)(6246003)(305945005)(33716001)(7736002)(4326008)(22452003)(486006)(6436002)(186003)(5250100002)(106356001)(316002)(6916009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lA9s4g9XKBO2PRO+jldiHCvF2MhJJL1+i+4uGeHuO7REHT3z+yJ1ZXxA19oruOJcWbQH8m8Ved6U8AgMDkm40Gh4Ue3LqVgmocfuz477AP4E1//cP6N3dvwN6qd3boy7GJq+jVFIl8AytgTraIktIVMLmU/kBHn7rDGOYoDH5BtnJ0pTRALxXARBZkrVzU5s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3BC5A9F59EBA94BAA52163265182304@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b5529759-6d1d-447b-b851-08d5a2debd31
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5529759-6d1d-447b-b851-08d5a2debd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:39:48.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 09:12:42PM +0100, James Hogan wrote:
>On Mon, Apr 09, 2018 at 12:17:24AM +0000, Sasha Levin wrote:
>> From: Paul Cercueil <paul@crapouillou.net>
>>
>> [ Upstream commit e6cfa64375d34a6c8c1861868a381013b2d3b921 ]
>>
>> Previously, the clocks with a fixed divider would report their rate
>> as being the same as the one of their parent, independently of the
>> divider in use. This commit fixes this behaviour.
>>
>> This went unnoticed as neither the jz4740 nor the jz4780 CGU code
>> have clocks with fixed dividers yet.
>
>FYI this one isn't strictly necessary for backport since JZ4770 support
>is new in 4.16, but its probably harmless too.
>
>Cheers
>James

I'll drop it, thanks James!=
