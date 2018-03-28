Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeC1P7k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:59:40 -0400
Received: from mail-sn1nam02on0069.outbound.protection.outlook.com ([104.47.36.69]:19808
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753816AbeC1P7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:59:38 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes with
 enabled MCs
Thread-Topic: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes
 with enabled MCs
Thread-Index: AQHTwUjB15Zr4Ec/0kCFKsa6VxO+naPlpusAgAAUS3CAABlZgIAAApcA
Date: Wed, 28 Mar 2018 15:59:36 +0000
Message-ID: <DM5PR12MB191654AAE6FEDBA11521AEFFF8A30@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
 <20180328130028.GB20533@pd.tnic>
 <DM5PR12MB191699DD131B3EB4C11579DAF8A30@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180328154349.GD20533@pd.tnic>
In-Reply-To: <20180328154349.GD20533@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1674;7:p9E+YZfN3YaW4JB2LCDB9anxFGemfOEs1w5x37xPrQgUww2bHn0FQTH1X2Rd3fSY8KLA95alC8AU2+f9/7KaKfR3tIrsvjzad67QiYYzOFSe6qDuwQQmtZtXEpxijASgdVeOLcf2RtILW3O4rxk06CcZekqHAGROvKwRyRHMeC1BEllEyCmU+cLARr0l9p9ms1sKjYMb9V3UmuN0PSZECDy+DkANOfIe3Qo72xwB1aOZI4BwFoPo1lT/9rBgoQfp;20:RPqc23egVJjiStD5MLEfo2cpc9Xx+9TyKMuwouB3d6o4oKVBqNHO3oLnj8cvz8eruKELtmWcgnLdIY0uLmGQhvPEDr3ciqo9D60dSaseJ3PUStKjy8N6lt+wavYg4SMVpDwwE7nGrV8IKpYDJAT0ul+p+omKltZs0aY1ZbR7lBo1vHkyqBEJYZKsh2xPs7EuSAErbJCvF0Fvwd7p0ownWDOLVtmuPlNKBHh7iEFRjU1qnedCCxlDgIHRWJbN6Ubf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1055dbbe-53d9-4705-5c30-08d594c4e816
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1674;
x-ms-traffictypediagnostic: DM5PR12MB1674:
x-microsoft-antispam-prvs: <DM5PR12MB1674B7D4903AD1C8EB77CA5BF8A30@DM5PR12MB1674.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1674;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1674;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(366004)(199004)(189003)(13464003)(2900100001)(97736004)(229853002)(72206003)(478600001)(316002)(102836004)(53546011)(6506007)(14454004)(486005)(476003)(486005)(305945005)(7736002)(446003)(86362001)(11346002)(4326008)(6916009)(2906002)(6116002)(74316002)(25786009)(59450400001)(106356001)(33656002)(105586002)(54906003)(76176011)(7696005)(3660700001)(3280700002)(8936002)(5660300001)(81156014)(6436002)(8676002)(81166006)(5250100002)(46003)(93886005)(186003)(68736007)(99286004)(9686003)(6246003)(55016002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1674;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Sy/BE6fXcIZMH3fQU9vTMw5NRnnWQ4pc69rlvmwi40LeiXtmb92ketfWzrxk+dpuol31a2aVYmwEiiYdFHVF9/O9P/P1yYrfpaS2m9Lv30LrIdzeOYU6c4aWpPyUzqDyUTcT3Y235F9s9wV6g+pzOwQb0PvEInpPZ7eOg9SNV3VV5mCA6FzcuCwfyX32w1u72Th6SWTTDTPrg2Y32p3eg3KElNiie5SrEUMfDQc4XKFEMjrOIK2a4KWoGlaIPnJacK8e33HMm5ylXuM7J6LgvQ9cB+eFRFvTxvmncxIZl1MsPAwowjMCw2Yw+B9gDsWd2DPK27BHd6c4VgVQqyQsWg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1055dbbe-53d9-4705-5c30-08d594c4e816
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 15:59:36.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2SFxloU029102

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, March 28, 2018 11:44 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes
> with enabled MCs
> 
> On Wed, Mar 28, 2018 at 02:38:11PM +0000, Ghannam, Yazen wrote:
> > In either of those cases we won't get to debug_display_dimm_sizes*
> > because we won't initialize the instance.
> 
> So you move that code which accesses csrows up so that it has the
> required information to query DIMM state/presence.
> 

I don't think we need to look at the csrows. We just need to check if the
controller is enabled or not. A controller is enabled if there is a DIMM
behind it and disabled if there isn't. 

> >                 /* Assume UMC MCA banks are enabled. */
> >                 nb_mce_en = true;
> 
> Also, I don't like that assumption.
> 

I'll look into it.

> > This would work for Fam17h. For older systems I think we can look at
> > D18F2x94_dct[1:0][DisDramInterface]
> >
> > Or maybe we have a separate function to check for enabled memory
> controllers
> > before we check for ECC?
> 
> The best would be to have a function which checks whether DIMMs are
> present on the node and act accordingly. You can pull up some of the
> work of caching registers which are used in debug_display_dimm_sizes*
> and use that info to get the required DIMM state upfront.
> 

Okay, so I'll do a separate function.

Thanks,
Yazen
