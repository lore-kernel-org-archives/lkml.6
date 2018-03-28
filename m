Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbeC1OiP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:38:15 -0400
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:20939
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753290AbeC1OiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:38:13 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes with
 enabled MCs
Thread-Topic: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes
 with enabled MCs
Thread-Index: AQHTwUjB15Zr4Ec/0kCFKsa6VxO+naPlpusAgAAUS3A=
Date: Wed, 28 Mar 2018 14:38:11 +0000
Message-ID: <DM5PR12MB191699DD131B3EB4C11579DAF8A30@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
 <20180328130028.GB20533@pd.tnic>
In-Reply-To: <20180328130028.GB20533@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1195;7:MxHeicf/hiDArOMyDrICyZXcAW3W2UF7GaGAx+lPQAqlwfpfFA/alhtM41Khc2x6I8x+5+2kpmdUFispZCSOT840OZ6dQMmgiq5KIabO/dVe7VRH0SJQI/awCamd70s388eEyTMUnJBvhMrAVhJVRZ06MjwRVmnrd5RnJdxJWaHpfH7EHtrLgNkF1Xf7/p+XJiCsO/bL1eaYn4L0Y5Z/ZO6ZnEqXAex2IJNPbkc4HZQPYoENS5BdtVpg0WbTk2IA;20:gXATHZG+sCENZA7FfD+N2OrS8ifhwBX4Ludt4A8s9UzgosVtLkuM9tlaBrvmAXh/ghrbyRaLjiHfjCz6YJnCySHSaflP73NxEVqXKzmxbyAE5isuIiWn9mCeliflerkAUubtAJZ8qv8JOVa8vwQLo3UmLM5uyF/XI0f7hQkxfctZDu7f0jO2dHuknmT0TbNjL0/JphcaV9IDfPPrio7BmPXwaLvQjkZpxSbTWLVVjP4K72CR7OkQGhAaqsKkI7lQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45d492fd-b3f1-48ef-9139-08d594b98854
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1195;
x-ms-traffictypediagnostic: DM5PR12MB1195:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-microsoft-antispam-prvs: <DM5PR12MB1195B958724E20F8231E1A01F8A30@DM5PR12MB1195.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1195;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1195;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(39380400002)(376002)(13464003)(189003)(199004)(8936002)(105586002)(478600001)(2900100001)(5660300001)(33656002)(305945005)(8676002)(6506007)(6436002)(74316002)(53546011)(81156014)(102836004)(81166006)(6116002)(46003)(97736004)(14454004)(72206003)(53936002)(55016002)(3660700001)(186003)(9686003)(7696005)(3280700002)(59450400001)(6246003)(2906002)(76176011)(54906003)(7736002)(446003)(11346002)(86362001)(486005)(486005)(476003)(6916009)(106356001)(99286004)(25786009)(4326008)(316002)(5250100002)(229853002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1195;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ONOLjzR8RFqzrQnFVVJZ4ixm7IXgFlXkesLBcyXcB7KAaR9eEuspQsa0y1ij7gYeFOeyPh/w3BQb1x/WfB0PMpTjSAgnPlS1j6PFe/U//ClqwyLZ20i1xaBFOzoeumKKiOJa7pbXjQ2C+7waVVCUs8xczVsi10F7JfZqe6lHWZQnXbmyTZuL62gqDnz88wcHsUDdctbtCYZTbuABsw6MSahmoz2GSG4v4RLgNi8dzZ9mHZG+oZVrldqpBCT2IHpaScZbZ22ftrMVfnkyrGbrPln4GJXdZ9Fykie9sQVi88az2BVWQvIW4qxOw3qxse2HawBGpEiSENYTgvdPt7KccA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d492fd-b3f1-48ef-9139-08d594b98854
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 14:38:11.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2SEcJA5021753

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-
> owner@vger.kernel.org> On Behalf Of Borislav Petkov
> Sent: Wednesday, March 28, 2018 9:00 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes
> with enabled MCs
> 
> On Wed, Mar 21, 2018 at 02:13:33PM -0500, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > It's possible that a system can be used without any DRAM populated on
> > one or more physical Dies on multi-die systems. Firmware will not
> > enable DRAM ECC on Dies without DRAM. Users will then see a message
> > about DRAM ECC disabled on those nodes without DRAM. However, DRAM
> ECC
> > may, in fact, be enabled on the other Dies that have DRAM.
> >
> > Only print ECC enabled/disabled information for nodes that have at least
> > one enabled memory channel.
> 
> So if the only reason for this is make the error messages more precise,
> then let's not make it uglier than it is.
> 
> The right way to do it would be to push those checks down to
> debug_display_dimm_sizes* which looks at the CS rows and the chip select
> enable bits and there to differentiate between
> 
> * memory controller doesn't have DIMMs
> 
> and
> 
> * memory controller has DIMMs but ECC is disabled in the BIOS
> 
> and then print the respective informative error message. But not with a
> yet another boolean which kinda takes care of F17h only and leaves the
> old families as they were.
> 

In either of those cases we won't get to debug_display_dimm_sizes*
because we won't initialize the instance.

We have a message for "memory controller doesn't have DIMMs".
edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);

We can change the wording of this to make it more clear. Also, we can
make this a pr_info and return from here.

So something like this:

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 329cb96f886f..6e211ed6d419 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3061,10 +3061,12 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
                }
 
                /* Check whether at least one UMC is enabled: */
-               if (umc_en_mask)
+               if (umc_en_mask) {
                        ecc_en = umc_en_mask == ecc_en_mask;
-               else
-                       edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
+               } else {
+                       amd64_info("Node %d: No DIMMs populated on memory controller.\n", nid);
+                       return false;
+               }
 
                /* Assume UMC MCA banks are enabled. */
                nb_mce_en = true;

This would work for Fam17h. For older systems I think we can look at
D18F2x94_dct[1:0][DisDramInterface]

Or maybe we have a separate function to check for enabled memory controllers
before we check for ECC?

Thanks,
Yazen
