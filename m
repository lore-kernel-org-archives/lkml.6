Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeEDNQw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:16:52 -0400
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:21928
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751107AbeEDNQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:16:51 -0400
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH  12/17] powerpc/8xx: Remove PTE_ATOMIC_UPDATES
Thread-Topic: [PATCH  12/17] powerpc/8xx: Remove PTE_ATOMIC_UPDATES
Thread-Index: AQHT46jF2jZowMfZVkO5P8GscNBirKQfjPuA
Date: Fri, 4 May 2018 13:16:47 +0000
Message-ID: <ed9a24137444d3af46031e95a5930bf085e121e7.camel@infinera.com>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
         <3ece8e0d69f3016111cdb9d643dfc4a158849ae0.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <3ece8e0d69f3016111cdb9d643dfc4a158849ae0.1525435203.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR10MB0465;7:/ZiaYMm4VF41j9EM0xwhz0hm1uhV3Vjws05LgN0qy2JYWh3gSTqTWyA9zCAddSt9QqglcszYi1OkzPCM++/MsLA8GG5xYuC9iJgMiJYMjFAnni1s67lziyom79g/ervcQ+VdUvfSHRuDrlY7H3STMzNd6GIjH9cGbnIGyMqmzQOkYLgJSYfMrF6/ra3c+acJeDte3Q68GAEbkTPqvnPDRbSVFLqHF58E0enLGmGX6jWAfzUO9uuQ6pmL/PHR/5Z+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR10MB0465;
x-ms-traffictypediagnostic: BLUPR10MB0465:
x-microsoft-antispam-prvs: <BLUPR10MB04655E942F9E91D603CC38B3F4860@BLUPR10MB0465.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BLUPR10MB0465;BCL:0;PCL:0;RULEID:;SRVR:BLUPR10MB0465;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(377424004)(5250100002)(2501003)(5890100001)(6246003)(2616005)(486006)(2900100001)(4326008)(105586002)(11346002)(106356001)(446003)(476003)(68736007)(66066001)(36756003)(5660300001)(8936002)(2906002)(81156014)(118296001)(8676002)(81166006)(76176011)(102836004)(53936002)(6506007)(59450400001)(6486002)(478600001)(26005)(7736002)(186003)(6436002)(72206003)(6512007)(99286004)(97736004)(305945005)(14454004)(54906003)(25786009)(3280700002)(3846002)(6116002)(3660700001)(86362001)(2201001)(229853002)(316002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR10MB0465;H:BLUPR10MB0098.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: //n0RfGEAqCe6aMTIYlI4Wdt/zgf9g4nI4NJI1yodrBfT+EYhTV5uOI23f5U4bHuWHPbMOIwUElBJLWjx04VVV/Vil5P/6CpvCkjzXlRvZhdOGpkNdEn9TUEdIfV1qu/U6SmaIsqb7X/ji/OpcUgwv5jTyZ5bzy0sTeLRGmCWky/JPnLrai6dTDR9JDvXw52
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D9424A2A555D34792EE1B54EC09BBE5@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a28a30ea-146f-4a5a-1678-08d5b1c14a8c
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28a30ea-146f-4a5a-1678-08d5b1c14a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 13:16:47.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR10MB0465
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w44DGwdj030558

On Fri, 2018-05-04 at 14:34 +0200, Christophe Leroy wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> commit 1bc54c03117b9 ("powerpc: rework 4xx PTE access and TLB miss")
> introduced non atomic PTE updates and started the work of removing
> PTE updates in TLB miss handlers, but kept PTE_ATOMIC_UPDATES for the
> 8xx with the following comment:
> /* Until my rework is finished, 8xx still needs atomic PTE updates */
> 
> commit fe11dc3f9628e ("powerpc/8xx: Update TLB asm so it behaves as linux
> mm expects") removed all PTE updates done in TLB miss handlers

Is that my 7 year old commit ?

> 
> Therefore, atomic PTE updates are not needed anymore for the 8xx

About time removing atomic updates then :)

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
