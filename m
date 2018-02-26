Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeBZQhe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:37:34 -0500
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:15280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751429AbeBZQhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:37:21 -0500
From: "Morton, Eric" <Eric.Morton@amd.com>
To: Borislav Petkov <bp@alien8.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
Thread-Topic: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
Thread-Index: AQHTrx9Bt3qWTg47lU2HKh4YY53v9aO2fUyA
Date: Mon, 26 Feb 2018 16:37:18 +0000
Message-ID: <0337DBEF-58BD-447A-A828-DE1A7CEF21E4@amd.com>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
 <20180223190950.GJ4981@pd.tnic>
 <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
 <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
 <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
 <20180226163102.GM4377@pd.tnic>
In-Reply-To: <20180226163102.GM4377@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eric.Morton@amd.com;
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1451;7:8Ikie5liLM0WHzgViTjjKeXQYJEiOiPDlHZV3NSXdE0Ah9Eiw25gOsEvx0Sm9MEDclS/deCt0dW8X8e7+iam4BYK3UK6lVtZJiNhpP/D7wNXU/beNU8uFfK1hG4mc6NojcUaIC5t6HKJ0CGe0Al+m+wQuo6PTq+DdzJInFKRG57ClHET3rLDc3TwcIW3ZXgSJkh4clPOpejVvgmXSwlfKMtftBdLWm+b88L31bgqOAQEJgVIgkC2BP9f5XI9atWu;20:5c4EZE8NYW2e8I8TBkuIff1PV8M84opn4+E+l7DKLtn/itdPs3fsri7yfr9IyzzzyixvQjT5PlGHIUZWDhBX2LMNDtkcw5sYYP/L35Enxtpky+2Jt7+GfUKBri8lRkDP1u4eFGboSvQejhqqKAhD9PnuJLg6i+gTt9ULsUphy99hpyicAa7buBgULyTEtsFf8vfTr+HtSNs9Bb1Tj0V1eLO+HYZYlhTmJ3p0YHcAFyfvd8TDqLCd/HA5rzEB7S4u
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(346002)(376002)(39860400002)(189003)(199004)(2906002)(3280700002)(5890100001)(5250100002)(305945005)(33656002)(68736007)(66066001)(93886005)(8936002)(81156014)(106356001)(2900100001)(81166006)(6116002)(7736002)(105586002)(8676002)(3660700001)(186003)(3846002)(72206003)(53936002)(14454004)(6512007)(82746002)(6246003)(25786009)(478600001)(36756003)(76176011)(99286004)(54906003)(110136005)(229853002)(102836004)(59450400001)(53546011)(6506007)(26005)(316002)(4326008)(5660300001)(6636002)(97736004)(83716003)(86362001)(575784001)(6436002)(6486002)(58126008)(2950100002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1451;H:DM5PR12MB1466.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 831025be-4540-4c7f-deb0-08d57d37339b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1451;
x-ms-traffictypediagnostic: DM5PR12MB1451:
x-microsoft-antispam-prvs: <DM5PR12MB1451A31EC1CCA922429814CAEBC10@DM5PR12MB1451.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501161)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1451;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1451;
x-forefront-prvs: 05954A7C45
x-microsoft-antispam-message-info: 1rmh/KgU2fQ7KuA/d3dagThWEkoeif6Ohwy3bpPc/dpEm+WwYgiSn+/04r/CSIzsdzJUdR4kVZSIPe/fEyuV/xw75Ht/eE4d/PpN9ky0BG/yvY8tP0vvAZbEAHaJxOQY5gpaZPBMDgONSUXwiNwta7TyF2ngevG2wnUtG1Md56o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AECB30397683314FAF345CEAECE7254D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831025be-4540-4c7f-deb0-08d57d37339b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 16:37:18.4538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QGbg1B013100

Thomas,

Yazen dug out PLAT-21393 as sounding like this issue. I haven't had a chance to digest it.

Eric

﻿On 2/26/18, 10:31 AM, "Borislav Petkov" <bp@alien8.de> wrote:

    On Mon, Feb 26, 2018 at 10:14:10AM -0600, Tom Lendacky wrote:
    > On 2/24/2018 2:59 AM, Thomas Gleixner wrote:
    > > On Sat, 24 Feb 2018, Paul Menzel wrote:
    > >> Am 23.02.2018 um 20:09 schrieb Borislav Petkov:
    > >>> On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
    > >>>> Borislav is seeing similar issues on larger AMD machines. The interrupt
    > >>>> seems to come from BIOS/microcode during bringup of secondary CPUs and we
    > >>>> have no idea why.
    > >>>
    > >>> Paul, can you boot 4.14 and grep your dmesg for something like:
    > >>>
    > >>> [    0.000000] spurious 8259A interrupt: IRQ7. >
    > >>> ?
    > >>
    > >> No, I do not see that. Please find the logs attached.
    > > 
    > > From your 4.14 log:
    > > 
    > > Feb 19 09:48:06.843173 kodi kernel: CPU 0 irqstacks, hard=e9b0a000 soft=e9b0c000
    > > Feb 19 09:48:06.843216 kodi kernel: spurious 8259A interrupt: IRQ7.
    > 
    > I think I remember seeing something like this previously and it turned out
    > to be a BIOS bug.  All the AP's were enabled to work with the legacy 8259
    > interrupt controller.  In an SMP system, only one processor in the system
    > should be configured to handle legacy 8259 interrupts (ExtINT delivery
    > mode - see Intel's SDM, Volume 3, section 10.5.1, Delivery Mode).  Once
    > the BIOS was fixed, the spurious interrupt message went away.
    > 
    > I believe at some point during UEFI, the APs were exposed to an ExtINT
    > interrupt.  Since they were configured to handle ExtINT delivery mode and
    > interrupts were not yet enabled, the interrupt was left pending.  When the
    > APs were started by the OS and interrupts were enabled, the interrupt
    > triggered. Since the original pending interrupt was handled by the BSP,
    > there was no longer an interrupt actually pending, so the 8259 responds
    > with IRQ 7 when queried by the OS.  This occurred for each AP.
    
    Interesting - is this something that can happen on Zen too?
    
    Because I have such reports too.
    
    -- 
    Regards/Gruss,
        Boris.
    
    Good mailing practices for 400: avoid top-posting and trim the reply.
    
