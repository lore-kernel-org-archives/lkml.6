Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC2U5o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:57:44 -0400
Received: from mail-bl2nam02on0068.outbound.protection.outlook.com ([104.47.38.68]:38888
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbeC2U5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:57:43 -0400
From: "Morton, Eric" <Eric.Morton@amd.com>
To: Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gorishek, Frank" <Frank.Gorishek@amd.com>
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
Thread-Topic: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
Thread-Index: AQHTrx9Bt3qWTg47lU2HKh4YY53v9aO2fUyAgABmAoCAMC6UgIAAfSwA
Date: Thu, 29 Mar 2018 20:57:35 +0000
Message-ID: <F2FE7773-77E5-450A-BD27-CEF1A592D06D@amd.com>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
 <20180223190950.GJ4981@pd.tnic>
 <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
 <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
 <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
 <20180226163102.GM4377@pd.tnic>
 <0337DBEF-58BD-447A-A828-DE1A7CEF21E4@amd.com>
 <13724e9f-a6f3-ece2-b007-741e45ef3660@amd.com>
 <81178e95-6aa4-69c9-4557-ba8bf929c8ff@molgen.mpg.de>
In-Reply-To: <81178e95-6aa4-69c9-4557-ba8bf929c8ff@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eric.Morton@amd.com;
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR12MB1918;7:m3WI/WTy0OEzcYOASu8y2COlZsPHbIaWEPFfkPvJaW7hIk2GsP6M6n+cRbHFplBp1Yfqr+l8NYUHIQuod4SKGN/w9n2g6sVZzY2BYuZWhqhlluhLYZUsPZXWDGIupKAE3oiqreC3AAAkOzL59ZkeqCipy2SnX/uCraY/nwCFnj0SuMhxa6n0nYBZ3jvDSr2E8k5CQcqVNOrtU41ZU24LvTWf2Pp9MnBruVsIC4DWXzu0U8oi56Mp0iKuQQRb7kCi;20:YA+LipjP8E5HIqSyn/zGKVMRad04pYm/EHmslitBmorsf9E6jjAbxhPID/8yooLy+69goc96ZTus8HSlDqCU0ugzWGGndOiIR4NJ0Gx6eWdrExxzboeV4C26kh+4mAP6+mCjctusi76bXa2VL8Mj8ngVl54viekSdYhU4pOfoM16IWnhF5LOXEiY8QbbrH+0mppHq3rMexQ97UvDAdOTafTIrPDfB2yF3s6Z81AKEhbBp7ZWBfbOs62n5KoOqrYU
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(478600001)(2616005)(476003)(3660700001)(486005)(486005)(316002)(8676002)(81166006)(81156014)(68736007)(6246003)(25786009)(53936002)(72206003)(93886005)(6512007)(54906003)(11346002)(3280700002)(58126008)(110136005)(2906002)(97736004)(83716003)(86362001)(105586002)(8936002)(4326008)(82746002)(6436002)(14454004)(6486002)(33656002)(7736002)(446003)(106356001)(305945005)(3846002)(59450400001)(6636002)(229853002)(5250100002)(186003)(6116002)(5660300001)(99286004)(66066001)(6506007)(53546011)(2900100001)(76176011)(26005)(102836004)(36756003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1918;H:MWHPR12MB1472.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcee5693-a459-47e6-d845-08d595b7b2e2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1918;
x-ms-traffictypediagnostic: MWHPR12MB1918:
x-microsoft-antispam-prvs: <MWHPR12MB1918126DC53BF6E8E618FEFBEBA20@MWHPR12MB1918.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1918;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1918;
x-forefront-prvs: 0626C21B10
x-microsoft-antispam-message-info: bWf0KS9QaCghWWV2sT8sKopNLkcSeFq7zMBkaR1AX8QCHRbod3nJ4ICj0Z7LROp/zLsxu5iAHnxq5IB9YlsPXA+78cCdSGrgzgdnGjR2wvIZfMhSBZTSqbEQ/gRBortkXfEIJmy+rh1uWPuKYT4hVPsIMmc7TctRwEqULbIoOXLNvkmLUArQjC2HFCd/9e2pTWBorz5v/d5eqf14pTvOJo/1906qLZ5Nk7ScKYm6REE30WnR3PCSmsfm9ZNaiGRyqZExranSLk04S6nA0tVJtUAx+01poXF+BCBVBuFRP70FAVg06foUY3DmU7GwIBv03i3K5B2bWvXrJErU75YOrkErBYVpqu+XnigwuOStJGMdXHHwwBUJm6PhSd4R5ddJkUfs4cx9lWDKFl1YgxPqb5QXlw+ZA/itFe6oa8+wnvo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EF242C597592A48A216C3068ED13EB7@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcee5693-a459-47e6-d845-08d595b7b2e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 20:57:35.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1918
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2TKvp2w013728

+Frank G.

Eric
 
By reading this e-mail, you are consenting to agree with the opinions disclosed within.
﻿On 3/29/18, 3:29 AM, "Paul Menzel" <pmenzel+linux-irq@molgen.mpg.de> wrote:

    Dear Yazen, Eric, Tom,
    
    
    On 02/26/18 17:42, Tom Lendacky wrote:
    > On 2/26/2018 10:37 AM, Morton, Eric wrote:
    
    >> Yazen dug out PLAT-21393 as sounding like this issue. I haven't had
    >> a chance to digest it.
    > 
    > Yes, internally to AMD, that was the bug that tracked the issue I
    > was referring to.
    
    If you could point me to more details how to fix this in AGESA, I could 
    probably fix the version in coreboot to fix the issue.
    
    
    Kind regards,
    
    Paul
    
    
