Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1342866-1525922116-2-1947796469331988595
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
    1525922116; b=K59lMLjWCg5P3nvD1T6GBo+e+YSCgLGhjK6uhy2cqwpkliTejC
    mmMVJ0FK43JciJF7mwgjQc43IUTobCn+H7bRFKkNqgPSNgZGT/M6Ck+XQLYgcXna
    RDbUlc7DFAE43sy2VFqFWHs0dOTE2mrJEia8iB6Yn9wh0Nb9kBNLw+APvtH4MWvn
    R/hduOptb7E0Pb1Ljl1Z43TFJsCJxBpUbi5eKnorF2tdJfJURqJcHODft3MOdBAP
    lmE6W17dvgGKzV6hG8qKsy7E/CnJ8KrTVqDeWNj0M7gB505idHTPIzvxIjEkKhOd
    kd0sa8az+Jdr/JYoQwXvrJ/uExduIlh8MbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525922116; bh=rTJ8TUtwEO0raNaz/9GjxPa3n1YuMmOpjRsM+jRvUP4=; b=X
    7QwjvBloG3MXZI61QV2onmW05S1mK45XV1YbQNBhQ77KYhb0F7qxiJlGkzV4ziie
    znor0ZMSyYLCXO8ARFZtSfzS2tx1zLabuCiYvAUyaYWWYak/DBNYJohRFTbQNdmT
    OL2KxHBApkDlUDElGzDzqdEg+c/eGY4FG8v9oq4XfZGBeDPILGndqna+XX6kJNQD
    N6R8htZUGgep1++EuSAsrOWjyTV0vfv4Kcf2e6uDT7f496/vIHdvHLuAlWTn7p1k
    gntVDS0raTsQx4Xc0OrJHT77sq7fH2e2AXw66BtJ8YH/RfqyUadR4iAkMsqVGt3h
    OKCGS29XcKwdZOkoDUVkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=WGA4pPw6
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
      header.d=microsoft.com header.i=@microsoft.com header.b=WGA4pPw6
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
X-CM-Envelope: MS4wfKoG+LqHKxGv/N9uUon5a6+VYerb2F04zDxS0Oz9cat35Wlfc2gSbxAocasTER2pYHeWsZkqNi0tqCNJb2fMhxeS3iz/YepMe32ATfbd+46/r9Vh98lq
    tG/QiUU5+rjS0vx2DSOyEKqDcfZGiGlnNhYLl9hW7gY+sJ4ZpyR0ltcF011p959emaw0sccP17I+I9UIRC6rlGe9Z/ZBKVOJHuhGimUpw1uYlwCGKUKlz49g
    Qh7U9+XBTMAMjZEmwnjv7w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=bwXz5zzo5W54L2uwuFYA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAAHfYCAAP7oAIAHfZEAgAAA6oCAAARsAIAAHPiAgAET7QA=
Date: Thu, 10 May 2018 03:15:04 +0000
Message-ID: <20180510031502.GF8514@sasha-vm>
References: <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1019;
	7:tKTNe0h3RN5kdKCY2wFfbPV6Wp0b2Mhax2VqZWAhNnBlnIlaFdg4MiNcaq03VhvO8eICMcJICPWJd3lYl60YBu0P5VqZR+uGMGV0cTRKlYDmGS5XKQTi5uP830Duz3IcwLi/W1ssoreMTbxhsfdJkwE9gS9emKbEQNmh3J6aKMaRVlvXNoc/zpvXcjV9uwzwM527eyuZhMbWN2tVlvM058VdfRnA+bdx6QVUdB8q6vh6u/BpKnDmSdFhy9aQeuAQ;
	20:ZE4IGAAgD9fnN/xTkM1iinr6N86wZoyOd/D6/hFHWdXusrMTR45B3KPaapBBbnuKXVFhrCgZ+lMfbgsHOTWUcjB7JQL/quoFbo2TMaAkYkvtXaiVH7FbZE0l/BwtjPDJ7q5+NZa8VtKnQKUIKy+l72dGDCnNmgbXVGEKXGXJ/pY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1019;
x-ms-traffictypediagnostic: MW2PR2101MB1019:
x-microsoft-antispam-prvs: <MW2PR2101MB10194162E1A8F6FF1A498D84FB980@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1019; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1019;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(39380400002)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(26005)(97736004)(2906002)(11346002)(9686003)(229853002)(6506007)(186003)(6436002)(86362001)(99286004)(86612001)(33656002)(66066001)(33896004)(72206003)(102836004)(478600001)(76176011)(3280700002)(3660700001)(53546011)(68736007)(25786009)(2900100001)(10090500001)(10290500003)(105586002)(6486002)(476003)(14454004)(106356001)(446003)(8936002)(8676002)(6916009)(53936002)(6246003)(81156014)(33716001)(316002)(3846002)(6116002)(54906003)(1076002)(305945005)(4326008)(22452003)(7736002)(5250100002)(81166006)(486006)(6512007)(5660300001)(93886005)(6346003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1019;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: H1RQbqACI9HyjiQPOEats920m/bP9Qoa6iHwOYhvX7VJ2TzoePOPpuCzRm1KheI6Ydhp0qshwOrKR2HTT0eBa4cLVVoLW4j1X56JMjac8vKMDJiN2PFLvntWuxD5faqbqkQwzCrk7arnDxr7kCGkP/yjiwsFhTBTFdj6lyTLq0zBIHuFIyQEcW14p6Qhj6Ys
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3F0A648CE2FCFC45A44A5B624EAB0DEE@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b267ba1f-0790-48f0-8f0d-08d5b62439be
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b267ba1f-0790-48f0-8f0d-08d5b62439be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 03:15:04.4317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
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

On Wed, May 09, 2018 at 08:47:27PM +1000, Stephen Rothwell wrote:
>On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
>> > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>> > > I think this is an excellent idea, copying in Stephen for his input.
>> > > I'm currently on holiday but unless someone convinces me it's a terrible
>> > > idea I'm willing to at least give it a go on a trial basis once I'm back
>> > > home.
>>
>> > Since Stephen merges all -fixes branches first, before merging all the
>> > -next branches, he already generates that as part of linux-next. All
>> > he'd need to do is push that intermediate state out to some
>> > linux-fixes branch for consumption by test bots.
>
>Good idea ... I will see what I can do.

This is very interesting! I'm curious how the statistics will look when
we'll compare patches that didn't go through this tree, patches that
spent minimal time in this tree, and patches that has spent some time
in the tree before being merged in Linus's tree.

Would this be something we would want to point actual users to, rather
than just bots? If every commit in next-fixes is essentially queued up
for Linus at some point, users might as well test out next-fixes instead
of -rc.

>> True.  It's currently only those -fixes branches that people have asked
>> him to merge separately which isn't as big a proportion of trees as have
>> them (perhaps fortunately given people's enthusiasm for fixes branches
>> that don't merge cleanly with their development branches) so we'd also
>> need to encourage people to add them separately.
>
>I currently have 44 such fixes branches.  More welcome!

I've tried looking at git for bigger subsystems, and a few branches that
would fit this description, and are not in -next are:

git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi/urgent
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
git.kernel.dk/linux-block.git for-linus
git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git fixes
git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-linux
git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git master
git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git fixes
git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git queue-rc
git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus
git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftrace/urgent

Would it make sense to ping the respective maintainers to ack the
inclusion of these branches?

There are a few other trees where the fixes branch has a name that
depends on the release, we can ask them to also create a simple fixes
branch so that next-fixes could merge it in?

git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-4.17-fixes
git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linux-4.17-rc1
git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git v4.17/fixes
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
