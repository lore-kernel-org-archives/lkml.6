Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3595654-1523895304-2-7164018635017203936
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
    1523895304; b=FbQbb6tSnplzDMlVpcP+iGPwzSFM1tsLWNXh+yIQavoALb9kYl
    8jrXnZscoDafG/0ES5Sen6kwwd0ZHcJGzn8yn3leKRVH1M2eyJpmNbpkLsgPO90L
    Emjyc1+znbQM8C/CBiGehN3nu46DfYCJO5bywRfky6IB9i6BXpCJdbL2UdK/iWFX
    KGaIGg6kWUejh4nF90jWTo5o9KN+sG6lSGEI7D4kspvoYMR8iq8AEwLXF0x6WThp
    7nCL4U6BCexpf1jHkLjcIFgx86z39HH3UODq0VVn0FpG1I/AGiAhfZlcPIplOY0/
    TUGl1LEInxalZt7iNIr7Ero8TMbHyQyU8bbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523895304; bh=2bbbiHIBxNT61EUx738r+LPfHp+H/Z+wZzbVWPty6aQ=; b=
    ZNJojwWkOSwXffyyTcKZ6QLbuY+bvh34dGAw49tXq4uTpZxOQ+prtL5wlbBqQyix
    lSugRh8RA7c0DGqKT1auEwzBb1/+781mwiKikgtj/gF6AnaeW6tUGsCHOjr1vRvC
    rKxiLdyzmpVOFHtMH2Kr6iEmepjavlSaEliad66MOOpRKOwmMmeFa+DdIh6wK/er
    5wrP8WbTe/aYTzOoC8icm1ufhTQ/sgb2Q+W9rGq+e0gIZVB4Hb68gKFnQj+cZREJ
    9fxWZhGM+jvTvI901dFXJZmSAwoL+ezE6KoEtVKayvDWPGJUDNszVujQ8WH4bLmW
    xJ3IUho4tMxpsXVhDW2Lyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqzxGbdW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqzxGbdW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP5BVzIIZfPQjAMdjVnyBqzqIg/HL9yqTRbyWjJU7MYSCdlWJdb4tc7uuZm59XHSapUDJvWMP9X7YA/l+/E4+5ZaQUfLIAFr8hNP5XTrhJUt9l8c/ycB
    vBKsjTu7A67CVWHj95CpjREyIgvYOuWhvv7JJmExxgtwcSeg0XXgBdv/s3AeLXOGtapsUTp1LERdkxDJCkV0OrwSTWrZ9kaRhRmy0nrIldIF74ueura2qYEl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=vBWpLKSSswuGw2bG4G4A:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeDPQPB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:15:01 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:52448
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752777AbeDPQOT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:14:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQA=
Date: Mon, 16 Apr 2018 16:14:15 +0000
Message-ID: <20180416161412.GZ2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
In-Reply-To: <20180416160608.GA7071@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:w9mrA5sAe0ZMUEQSTGEyMSdM4M0lT+PQMQ+geWxm8dxR89UcqNjGlaVNPNuinXoFtWxhEfczamKuSjVotLtJeMKGaXJkgHcSLrkb8+GZxXamsu/UtMG1q2lqBAgIGsWkCKwMdeN4iQzSsuV/lP7Vg+93bHePZXt/kotA2gVXajzx9O5v8144a85sjfaG2ZQjyw5sFnBK/kTtpzoN34K17QgU/H9Upswn1HGt5EBy6fsfCpucQZ2LaQViy9aTQI5Z;20:6aUdqYqauBYXYOdj/KU3hqEJr5H1xCxXnlr32KxvakuZ3oyI36zBE3tt6WkqvyVBWUOtdfc3cvXP2Wjhau/EvqytK5M8VJdn7EtJcg9T5e3eFKXVNAZ9roZ8MFUhE0f76heJErLOIYU/HSGUNuN60fhbW6kT8UxaQpRJqhWehnw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1126FE9A849F3F5EB91EDFB6FBB00@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501347)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(54094003)(377424004)(199004)(189003)(446003)(2900100001)(86612001)(316002)(86362001)(10090500001)(72206003)(6246003)(33716001)(8936002)(186003)(106356001)(66066001)(6916009)(22452003)(229853002)(10290500003)(3846002)(53936002)(53546011)(6506007)(6116002)(305945005)(6486002)(97736004)(476003)(6512007)(7736002)(6436002)(9686003)(102836004)(54906003)(478600001)(486006)(5660300001)(93886005)(7416002)(5250100002)(59450400001)(1076002)(68736007)(26005)(8676002)(33896004)(4326008)(105586002)(11346002)(76176011)(39060400002)(2906002)(81166006)(81156014)(3280700002)(33656002)(25786009)(99286004)(14454004)(3660700001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 72mD9BBHzMqWjxoDXReeapV4W5RmxgLF+N7nwgSL98n7KV5uZE3siAJJysWEapfIs3pt8QmYhZ4L+WUZ+lFtQwFF9CpVEwFDjUR04mVI45xKa3uQ3H6Mv18v1r77TC/s9wC+sZtHqB1V/03I7QC1itVlB72oo/Nw0YASHn0+3Psl4XbNSl/PdsFhX/rSYYYd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <484B7B48C36AD843B28BB9CEC90806E6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bd6f1c5e-b72e-4aaa-5400-08d5a3b5199b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6f1c5e-b72e-4aaa-5400-08d5a3b5199b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:14:15.5060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 06:06:08PM +0200, Pavel Machek wrote:
>On Mon 2018-04-16 15:50:34, Sasha Levin wrote:
>> On Mon, Apr 16, 2018 at 05:30:31PM +0200, Pavel Machek wrote:
>> >On Mon 2018-04-16 08:18:09, Linus Torvalds wrote:
>> >> On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>> >> >
>> >> > I wonder if the "AUTOSEL" patches should at least have an "ack-by" =
from
>> >> > someone before they are pulled in. Otherwise there may be some subt=
le
>> >> > issues that can find their way into stable releases.
>> >>
>> >> I don't know about anybody else, but I  get so many of the patch-bot
>> >> patches for stable etc that I will *not* reply to normal cases. Only
>> >> if there's some issue with a patch will I reply.
>> >>
>> >> I probably do get more than most, but still - requiring active
>> >> participation for the steady flow of normal stable patches is almost
>> >> pointless.
>> >>
>> >> Just look at the subject line of this thread. The numbers are so big
>> >> that you almost need exponential notation for them.
>> >
>> >Question is if we need that many stable patches? Autosel seems to be
>> >picking up race conditions in LED state and W+X page fixes... I'd
>> >really like to see less stable patches.
>>
>> Why? Given that the kernel keeps seeing more and more lines of code in
>> each new release, tools around the kernel keep evolving (new fuzzers,
>> testing suites, etc), and code gets more eyes, this guarantees that
>> you'll see more and more stable patches for each release as well.
>>
>> Is there a reason not to take LED fixes if they fix a bug and don't
>> cause a regression? Sure, we can draw some arbitrary line, maybe
>> designate some subsystems that are more "important" than others, but
>> what's the point?
>
>There's a tradeoff.
>
>You want to fix serious bugs in stable, and you really don't want
>regressions in stable. And ... stable not having 1000s of patches
>would be nice, too.

I don't think we should use a number cap here, but rather look at the
regression rate: how many patches broke something?

Since the rate we're seeing now with AUTOSEL is similar to what we were
seeing before AUTOSEL, what's the problem it's causing?

>That means you want to ignore not-so-serious bugs, because benefit of
>fixing them is lower than risk of the regressions. I believe bugs that
>do not bother anyone should _not_ be fixed in stable.
>
>That was case of the LED patch. Yes, the commit fixed bug, but it
>introduced regressions that were fixed by subsequent patches.

How do you know if a bug bothers someone?

If a user is annoyed by a LED issue, is he expected to triage the bug,
report it on LKML and patiently wait for the appropriate patch to be
backported?=
