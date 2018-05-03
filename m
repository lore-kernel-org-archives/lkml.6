Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2687911-1525359982-2-12885255202613498672
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
    1525359981; b=S5hL9LwLyjw5LFnCvjSi+jihYTTeLj9tsnMH3ocoP7lTkOHH/T
    bVI5XeT8qxH9rF86eCK4PkCKtQpaW5u5WA/f26tV2Y3poWh02GWtLVE+3Fw4k6pP
    R7wLDhPu9FwbrEFQ9VFFUHJiCATAlTtdue/b/E/V2DeT1jAZAsdaNLzFXoE95X/N
    PN6mxf69LzekNyVWwSZS7L1enZazwKS+eDFFbaJA+CrObbYRkV1zHyxPHagQbtOZ
    mzhe12y57iE1V8YSY65cWD0yikjXWIGjmnCMC0il64MfNA01cjKssyqmUe/fuxkt
    YlvnRX5IuYTizuE6IV0b2Xgr11nXkDEuRjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:date:message-id:references:in-reply-to
    :content-id:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525359981; bh=NDG6fWzsoWCc2hjLzafAN1PC/CTXQNrjQQQhMWLevQ8=; b=e
    UNaBkVTFVMLxx41aKVWYlC4rHJNv/UDvWPIFHiRIU97kDBEzPzKoTl6WmXSwlMDM
    dWxjehX6oUW5jVmeRsV/0Rqw/yrikQ3WVTkWkeWaASiehylPZRm+s/NwRzvG034z
    2jwHnahkifwOLok8WFJGmpwCJO8SWR+Ody29DD+7lxMy5kyiC20+Xc6sQGQHP3Wa
    vO4NfpdQXOyzodGVvyM3X9u6HBiu2XnNywoTBUc03qnpUwdRcMb7lqPI1XLnJZM/
    T/PjsmNziY2KYVOqpdn/Nj1JRfxz+WGTRWXTi3oQAcK3UsK8DdQ5esIgL0c086TI
    Zx7niXXUDp2O+zsLtCzRQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=mfZkKuWt
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=mfZkKuWt
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
X-CM-Envelope: MS4wfJh0WAy6Yv7AjxPrzCrMeCxvEqEM7prdaXlYjchU/2R8iUOjK8o7jik+MHvD/U+ojiEnT0DvO+0XDBVQQs/r6wGMkpWFWphn3A74NuP4rfZnozeGpLIR
    c47MZQWHsBepwZ37SAMVfgWiy7HXeMeCpPXlvNjSoX5NGAW5Ocm3TNXL3GjqAYQFfiLHg4Zu30WGOcDuInfGpeCJ/uES60H75a+ToZswAXhgkRreFTJ8vCnf
    K4IRiQjxX3d/zIFqFfkKtA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=IiBf045SzQgA:10 a=5FDzULB0bt8A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ag1SF4gXAAAA:8 a=UWHrezc2wrgC4IuuXnMA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
To: Willy Tarreau <w@1wt.eu>
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIACgPOAgAA5DwCAAARoAIAABNUA
Date: Thu, 3 May 2018 15:06:11 +0000
Message-ID: <20180503150608.GM18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org> <877eol808s.fsf@intel.com>
	<1525357984.3225.12.camel@HansenPartnership.com>
	<20180503144850.GC23311@1wt.eu>
In-Reply-To: <20180503144850.GC23311@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1050;
	7:yFs+K/pMNlWg1dQDfgem3ywpasaOVUbsdAoWFSy+8h1+kLwvf/7ymRHGT/1lsi1W0a95ba0jRWyFzLLWB/1nfcuFIS/majmiPm6EeL5Dr3juouaVR+C3oxVWZQnFuMRhnu1cOqnRkI9vFnrJyYliZ6mydSiMjI9F5ga4dkvTpmeQoE9as1VVmMyq1cPkUQOuPIhvyjWlJ8zVxleioHo0ozNVBuy4F0ufdq5bIHqrnfzyS2KG/xBeFrdnTFH9QQ3G;
	20:JE3srd7Q+IB+qAdMIDomJMZR+o6eOrHK8aZmQWq8yK45JiM54n/s+jYC++YXuwS2hTlTlQabhq6mAPfnzp8nBPrZcUCYtjCRJmfdOS/EVUFN+QW1Ha6a/NXshCrbv4Q9wwZEfEma6ZKWBCxK246J/KEb1epC2PFhz7QC0F0QRZ0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
	SRVR:MW2PR2101MB1050;
x-ms-traffictypediagnostic: MW2PR2101MB1050:
x-microsoft-antispam-prvs: <MW2PR2101MB1050F9AF43B9A77FA9718F70FB870@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:MW2PR2101MB1050; BCL:0; PCL:0; RULEID:;
	SRVR:MW2PR2101MB1050;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(51444003)(189003)(199004)(476003)(9686003)(6436002)(72206003)(229853002)(446003)(33716001)(3660700001)(486006)(10290500003)(5660300001)(6346003)(102836004)(478600001)(86362001)(97736004)(186003)(3280700002)(6486002)(6512007)(86612001)(53936002)(54906003)(26005)(99286004)(81166006)(33896004)(2906002)(8676002)(1076002)(81156014)(10090500001)(6506007)(68736007)(14454004)(105586002)(106356001)(8936002)(305945005)(93886005)(25786009)(2900100001)(5250100002)(11346002)(6246003)(66066001)(22452003)(6916009)(33656002)(59450400001)(3846002)(316002)(76176011)(4326008)(6116002)(7736002)(3714002)(781001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1050;
	H:MW2PR2101MB1003.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: kqWEQ+qVZeS72OLym4H3HtAqDOePxBmRny2le8BnVGXdp/ioD/TBk4XT60/saWKn/DHayh7K3w9iSUIKVEyAnKT+M9WaSh4dcyZuZKUETFqQGGxXQSjDkqAwFMl4yK5eKY6hg4gFl5bHXgnllX4cO1xUexnNDxA8cuBonuNoNyHg1W6x3NYq7L7JyqpCfMsR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <97AF75791B08054BA7F36D57E227EDB7@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7ced881c-6f9a-436b-1573-08d5b10768ab
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ced881c-6f9a-436b-1573-08d5b10768ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 15:06:11.9691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
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

On Thu, May 03, 2018 at 04:48:50PM +0200, Willy Tarreau wrote:
>On Thu, May 03, 2018 at 07:33:04AM -0700, James Bottomley wrote:
>> They're definitely for bug fixes, but there's a spectrum: obvious bug
>> fixes with no side effects are easy to justify.  More complex bug fixes
>> run the risk of having side effects which introduce other bugs, so
>> could potentially destabilize the -rc process.  In SCSI we tend to look
>> at what the user visible effects of the bug are in the post -rc5 region
>> and if they're slight or wouldn't be visible to most users, we'll hold
>> them over.  If the fix looks complex and we're not sure we caught the
>> ramifications, we often add it to the merge window tree with a cc to
>> stable and a note saying to wait X weeks before actually adding to the
>> stable tree just to make sure no side effects show up with wider
>> testing.  So, as with most things, it's a judgment call for the
>> maintainer.
>
>For me this is the right, and responsible way to deal with bug fixes.
>Self-control is much more efficient than random rejection and favors
>a good analysis.

I think that the ideal outcome of this discussion, at least for me, is a
tool to go under scripts/ that would allow maintainers to get some sort
of (quantifiable) data that will indicate how well the patch was tested via
the regular channels.

At which point it's the maintainer's judgement call on whether he wants
to grab the patch or wait for more tests or reviews.

This is very similar to what James has described, it just needs to leave
his brain and turn into code :)
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
