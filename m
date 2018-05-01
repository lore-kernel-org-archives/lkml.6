Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZoaOJ8TTrHfRQhGBvhCNEeRJ3YB8VsF/eR9WrmPXUdei+RcdD+APQQVFmSr5PGlfn2WfkJW
ARC-Seal: i=1; a=rsa-sha256; t=1525191862; cv=none;
        d=google.com; s=arc-20160816;
        b=TyBNvwF34EJ1CoZkeJam7UfNYHGJrVaqLwtGIbdywD30wngAqljD7sfGbUywQ8Xe/T
         WHaEC+968Yl/gp6CgN5e3JHNlN6agvLZFUb1yaCfi99KE3c75w3Y4uVxzEGxynBS+dEy
         uA7G2ov34LJpsh48QSdpqRKu2HbtPZSCdc/x8fa311PMjQFmKLf7j+d1wPhXIh0IZ+Oe
         93pR8EL6ACWiZAU0Ih8D595UinQ/zdtYrLSPWAxZYsrXzPjr9gMHJ2F+swZYNIlphPF7
         eQtRwFMvKuwK1LevxZ+kxTHyjekfniA20I0RLzdrwR+cRkQZYgNLMFJg6RzIPa3z5Y2s
         rhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=LDewU8cX6UwX5IdlMz5DCoJu0Zq/P5vtDnXZQStM2Ow=;
        b=nfKTaWfRRShfCGeWD8pj/IQKupYctTAgtw2TLWuOZnr1jEv3L4n8FfV3Sxi3jrT0mW
         RBxw2GIMgsO1KOrh7I+hulEgd3hwkS1zoSkEH+S+pLGkw21GVMP6ErxoYon17RQXLwp2
         VsscrZacWcLjuGvThZBiwr0LdwzUQf8JQcPsBoQokLX5efNz/iWqDRYTnwbGWLXVlqNW
         BDO6pSuytGXlMiMnHhbvzIalzC+TsMEvYW016OXf5jO0FzLBAHPMTU8L/UG5MD7S3V7a
         7bUekkuDH3lzhXNcrbqgHIHYwHsYYB1Yge6srxdrEPdV+kLN7gPyGhAaB/CmyGszrPea
         QYtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=M0hZzQVL;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.93 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=M0hZzQVL;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.93 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Julia Lawall <julia.lawall@lip6.fr>
CC: Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches (or: -rc cycles suck)
Thread-Topic: bug-introducing patches (or: -rc cycles suck)
Thread-Index: AQHT4KzY5hZ/zYBxbECTHPKrktWH/qQZrOoAgAFjcQA=
Date: Tue, 1 May 2018 16:24:20 +0000
Message-ID: <20180501162418.GC1468@sasha-vm>
References: <20180430175829.GB1544@sasha-vm>
 <alpine.DEB.2.20.1804302109140.2269@hadrien>
In-Reply-To: <alpine.DEB.2.20.1804302109140.2269@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:sLQpC62G5SoN9Rea4CnKIFeAkUZyRnSVA6k5NXHg19/w4RVADPzS9BzIUtwopFJJizVPA6fvws09/aeZv32WZJcNygjUHpDMHiNwlZm9pS5QB4FdVbV8soytvFBWCKwA2kwQoGZ4InsBWw7I5gOuMAgucI3ult64BO7JryFf5JScKGcJksTXArI8svyGcJp35C3eQqicnpsuPI7myHow3Pqnasd09LC+Yc9h6eSOqlaSvGI71e6bpVyx7SokEjXm;20:QuTLqAzQNO9VnAwpFevNX3Yv41RcVCjgkbq7hdIQ4O9MtT3pVDybcopFnC/Tiuc/pOik3LRFRukEB7uT0phH0DlwoeG1ZrvWfxj7y/TZzZ/ZtITdGw4DUstmoMET7ua+L0tR6gkHVZbBFloUyp+5mgAZw3cXG2L77ibEvEL/qwo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
x-microsoft-antispam-prvs: <DM5PR2101MB0725616CCFAB7D8FA191A609FB810@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(6116002)(3846002)(6486002)(54906003)(86362001)(106356001)(486006)(3280700002)(7736002)(53936002)(1076002)(3660700001)(229853002)(2906002)(5660300001)(97736004)(10090500001)(5250100002)(6346003)(8936002)(4326008)(22452003)(68736007)(476003)(102836004)(72206003)(316002)(81166006)(66066001)(25786009)(26005)(6512007)(81156014)(478600001)(2900100001)(11346002)(9686003)(105586002)(446003)(59450400001)(33656002)(305945005)(8676002)(6436002)(6916009)(76176011)(186003)(6246003)(10290500003)(6506007)(86612001)(14454004)(33716001)(99286004)(33896004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: gzgWCSHTiW4zig0Cl91q40qEZ4CbWUvHug3xG0rG5u9HpOA0pSHaLO9LAXgTAUp2WZdB/qO3/yYyHAjoZMLEb9wQDsbJXzYTf85a08w7O45HbgBnpx347QHufIbDi4P2WbISV2bpv5REzqiy2/QuBM8hanLgYhyG8SFIKygvU7ia7fC9C78vqN2gEBljiobt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A545604DAE4364FAC0AD5D17A236BC7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 65b88113-45fc-40ad-3a04-08d5af7ffe83
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b88113-45fc-40ad-3a04-08d5af7ffe83
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 16:24:20.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599194910340136485?=
X-GMAIL-MSGID: =?utf-8?q?1599279582939181117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 09:12:08PM +0200, Julia Lawall wrote:
>
>
>On Mon, 30 Apr 2018, Sasha Levin wrote:
>
>> Working on AUTOSEL, it became even more obvious to me how difficult it i=
s for a patch to get a proper review. Maintainers found it difficult to kee=
p up with the upstream work for their subsystem, and reviewing additional -=
stable patches put even more load on them which some suggested would be mor=
e than what they can handle.
>>
>> While AUTOSEL tries to understand if a patch fixes a bug, this was a bit=
 late: the bug was already introduced, folks already have to deal with it, =
and the kernel is broken. I was wondering if I can do a similar process to =
AUTOSEL, but teach the AI about bug-introducing patches.
>>
>> When someone fixes a bug, he would describe the patch differently than h=
e would if he was writing a new feature. This lets AUTOSEL build on differe=
nt commit message constructs, among various inputs, to recognize bug fixes.=
 However, people are unaware that they introduce a bug, so the commit messa=
ge for bug introducing patches is essentially the same as for commits that =
don't introduce a bug. This meant that I had to try and source data out of =
different sources.
>>
>> Few of the parameters I ended up using are:
>>  - -next data (days spent in -next, changes in the patch between -next t=
rees, ...)
>>  - Mailing list data (was this patch ever sent to a ML? How long before =
it was merged? How many replies did it get? ...)
>>  - Author/commiter/maintainer chain data. Just like sports, some folks a=
re more likely to produce better results than others. This goes beyond just=
 "skill", but also looks at things such as whether the author patches a sub=
system he's "familiar with" (=3D=3D subsystem where most of his patches usu=
ally go), or is he modifying a subsystem he never sent a patch for.
>>  - Patch complexity metrics - various code metrics to indicate how "comp=
lex" a patch is. Think 100 lines of whitespace fixes vs 100 lines that sign=
ificantly changes a subsystem.
>>  - Kernel process correctness - I tried using "violations" of the kernel=
 process (patch formatting, correctness of the mailing to lkml, etc) as an =
indicator of how familiar the author is with the kernel, with the presumpti=
on that folks who are newer to kernel development are more likely to introd=
uce bugs
>
>I'm not completely sure to understand what you are doing.  Is there also
>some connection to things that are identified in some way as being bug
>introducing patches?  Or are you just using these as metrics of low
>quality?

Yes! My theory is that the things I listed above are actually better at
identifying bug introducing commits than plain code patterns or metrics.

To some extent, Coccinelle, smatch, etc already deal with identifying
problematic code patterns and addressing them.

>I wonder how far one could get by just collecting the set of patches that
>are referenced with fixes tags by stable patches, and then using machine
>learning taking into account only the code to find other patches that make
>similar changes.

This is exactly the training set I used. I didn't try looking at the
code itself because I don't have a good idea about how to turn code
patterns into something meaningfull for ML. Code metrics didn't prove
to be too useful for AUTOSEL so I sort of ignored it here (I only used
the same metrics we use for AUTOSEL).=
