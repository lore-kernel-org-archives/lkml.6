Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeCHWLs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:11:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48972 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750824AbeCHWLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:11:46 -0500
From: Roman Gushchin <guro@fb.com>
To: Tony Lindgren <tony@atomide.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Michal Hocko" <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: Build fails with SLOB in next
Thread-Topic: Build fails with SLOB in next
Thread-Index: AQHTtwMDvA0rzbnS7U+AY8n1bb5R0KPG5rTG
Date: Thu, 8 Mar 2018 22:11:10 +0000
Message-ID: <6555B7D0-95F4-45E3-AF34-E75412718F33@fb.com>
References: <20180308172849.GO5799@atomide.com>
In-Reply-To: <20180308172849.GO5799@atomide.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.91.235.193]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO1PR15MB1000;20:lsc2F+p4AOgYmp7WFzF5Hsi2UiZIdkfC0RivC1jVulq20eRxCh4Gkb50lbIllNSB++i1soiNaiHVmtEo5DyvqZQYutXF5WHqa3C6Kps5UxzMrohdVfEsmZEvsFZZr0FaSw90nHtqJE5zx8lZ09IgBpMnSqCgOIgorPCUZmD+JkQ=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 68312459-8e1c-46dc-e8f0-08d585417fe3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1000;
x-ms-traffictypediagnostic: CO1PR15MB1000:
x-microsoft-antispam-prvs: <CO1PR15MB10008E7E7BD92E82471FE6AFBEDF0@CO1PR15MB1000.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(3002001)(10201501046)(6041288)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1000;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1000;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(3280700002)(33656002)(5660300001)(66066001)(97736004)(5250100002)(68736007)(105586002)(7416002)(106356001)(9886003)(3846002)(3660700001)(6246003)(229853002)(81156014)(7736002)(25786009)(8676002)(53936002)(81166006)(6116002)(305945005)(6512007)(6486002)(6436002)(36756003)(316002)(8936002)(4326008)(2906002)(26005)(6506007)(99286004)(86362001)(53546011)(102836004)(186003)(83716003)(54906003)(5003630100001)(76176011)(59450400001)(82746002)(2900100001)(14454004)(478600001)(2950100002)(6916009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1000;H:CO1PR15MB1077.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jqJyBylXIKu+dj0cNQNFDpWbaobRtzeGrRFRv2vmaHXepUT8/zzwIX2/YrSEzGq2eKcUgTBnFRcnLI7KsRMjPdzayoRtU3YmYqOt1wseax63HNIt/mwQARtFCVafubDQBSrmNq4QhAWfq8IR+eKYOVTCoBJpd89mr97nsWslGJoZlFICW0bR8L1Uz223yYCgsnVPwP0thTtSXJeRIfaPTL2VDUuJxaF9URsK40tvU9Y9tnMtUpFkspal6/BP3AraAVDjEfdFmL2Sr1ExiFYNTKVQ69p65JMv05b/tQQPKPQ6nS7b/MW9hQyhcZZlDKr8IVfy0iMcEL7H9d4jvMl6+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68312459-8e1c-46dc-e8f0-08d585417fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 22:11:10.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1000
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28MBsOf008455

Hi Tony!

As far as I know, it’s not fixed yet.
I’ll send a fix on Monday.
Sorry for the inconvenience.

Roman

Sent from my iPhone

> On 8 Mar 2018, at 20:29, Tony Lindgren <tony@atomide.com> wrote:
> 
> Hi,
> 
> Looks like commit 8b1747684ff8 ("dcache: account external names as
> indirectly reclaimable memory") caused build fail if SLOB is selected:
> 
> fs/dcache.c: In function '__d_free_external':
> fs/dcache.c:278:22: error: implicit declaration of function
> 'kmalloc_index'; did you mean 'kmalloc_ node'?
> [-Werror=implicit-function-declaration]
>        -kmalloc_size(kmalloc_index(bytes)));
>                          ^~~~~~~~~~~~~
> 
> Is this already fixed somewhere?
> 
> Regards,
> 
> Tony
