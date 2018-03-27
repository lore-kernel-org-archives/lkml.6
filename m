Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeC0QAD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:00:03 -0400
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:20736
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeC0QAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:00:01 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if valid
 bits are not set"
Thread-Topic: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
 valid bits are not set"
Thread-Index: AQHTxTbYl0Ocyw67K0ebLpEvWOkqDaPi53kAgAAAvNCAAAmPAIABK29QgAAfYjA=
Date: Tue, 27 Mar 2018 15:59:37 +0000
Message-ID: <DM5PR12MB19162C0D9FF144D311ADC22FF8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326193052.GJ25548@pd.tnic>
 <DM5PR12MB191603A2AACAE6F7F923C6F3F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180326200742.GF28372@pd.tnic>
 <DM5PR12MB191601AF532C84190049AD04F8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB191601AF532C84190049AD04F8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2567;7:G1qlRT9UxtvdlIzkMm/oJ/HNdpTO6AH1DjqXRpECUWIjCyi2WqeP1XI6pwF0qWFeyEfvj9uGJUZ0vRGHbuaH6EXpAmmNtYPyDYLTAwUmJ1wdzIssiXcG3bPZErEJIZ0zP9yBvGRrIVRywM1I1U+aBL2jO6OORdJNcgQKlDDEBf+Bwo7LKtu4GXRF19+QgLCZDWeaTXTYb3SiQuJHzjspKLB4sNjXkPZMgZR/glDcCcn0lIiMsXja+uG6wJZGhg3G;20:mPbwn73t1C62SkbxyITgtXQ11E/4lVNvFcChiGTKVN5kLF12GlCczYQj47tb9cRe0jPlyJ95mUIBkxkM3SWZZfpBl1EfE72eKxlpHVBMTkWWfLjuVK5xgXL+/Anpz86dJd225c/LqFyco+yKSUhiaJsiF/cA4TCrlUoN/mNRxSS+ZBJucxjmbLeuqUxDjhFnR4zukReNhBcVsK/sENslkTwHu3OlRAiVmRbEN3R3FoJV9vDMmGogFAMSeeczaAXz
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(13464003)(199004)(189003)(53936002)(11346002)(53546011)(6246003)(8936002)(3660700001)(3280700002)(14454004)(59450400001)(81156014)(6506007)(68736007)(8676002)(478600001)(486005)(86362001)(9686003)(486005)(97736004)(5660300001)(74316002)(55016002)(76176011)(2906002)(106356001)(7696005)(93886005)(446003)(229853002)(2900100001)(6436002)(54906003)(99286004)(110136005)(316002)(105586002)(5250100002)(2940100002)(102836004)(7736002)(72206003)(6116002)(4326008)(81166006)(476003)(25786009)(33656002)(46003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2567;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fc51e04-dc4a-4eee-70bf-08d593fbbe3b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2567;
x-ms-traffictypediagnostic: DM5PR12MB2567:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-microsoft-antispam-prvs: <DM5PR12MB2567D3EE7756958183B07723F8AC0@DM5PR12MB2567.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB2567;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2567;
x-forefront-prvs: 0624A2429E
x-microsoft-antispam-message-info: ZMF0L5BZw9bhl3JQ6f4/6QY7A0tYy88HfmMYjVgDIHToCTE6BTsshe8x9X0pyVTrwGdMcHfFgsmqdvLQAnjQQSLUZUBLoKf6PSIKa+jnLFspnDwsq4L1PeudzIru5fyUT02VNIAFP7TkG64h3fsJc+12Gqp7jG0d2KN6SWCRnBl1DynmF+X1c7tjmE3qZ/GrB8AbBKNpe3d4Mx3mq4vXO/AjTIxSCFZAtR/hFVQdywB58FIfZ9HOi+UqmuAnQZ8uIVZUQEeqbf4/T2Od5wGBuEnYZv5SatQJsA5IOPA91AWzJ8yCKdUvFnG6zSPaseuNWY5bAK7eWDZkl+17vClE9A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc51e04-dc4a-4eee-70bf-08d593fbbe3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 15:59:37.8715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2RG08HL022212

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-
> owner@vger.kernel.org> On Behalf Of Ghannam, Yazen
> Sent: Tuesday, March 27, 2018 10:02 AM
> To: Borislav Petkov <bp@alien8.de>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> tony.luck@intel.com; x86@kernel.org
> Subject: RE: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
> valid bits are not set"
> 
> > -----Original Message-----
> > From: Borislav Petkov <bp@alien8.de>
> > Sent: Monday, March 26, 2018 4:08 PM
> > To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> > Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> > tony.luck@intel.com; x86@kernel.org
> > Subject: Re: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
> > valid bits are not set"
> >
> > On Mon, Mar 26, 2018 at 07:58:51PM +0000, Ghannam, Yazen wrote:
> > > So at a minimum, we should always save and report as much as we can.
> >
> > Only on Zen or all AMD families?
> >
> 
> I'll confirm with the HW folks. I understand it as a change in philosophy
> rather than a change in hardware.
> 

So this recommendation could apply to all families, but it's okay if we just
apply this behavior to SMCA systems. That way we don't need to worry
about changing things on legacy systems.

I'll write a new patch that abstracts the register reads and applies the
different behaviors.

In any case, this patch should be reverted since faking the valid bits will
cause the downstream code in the notifier blocks to process errors they
shouldn't.

Thanks,
Yazen
