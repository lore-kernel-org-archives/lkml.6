Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeEOU3e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:29:34 -0400
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:55120
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752338AbeEOU3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:29:31 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC: Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 04/11] firmware: xilinx: Add query data API
Thread-Topic: [PATCH v6 04/11] firmware: xilinx: Add query data API
Thread-Index: AQHT0QO143ffVVfo7UWNtLCAgNhWHaQpL8cAgAadEVCAAPDrAIAAtsKA
Date: Tue, 15 May 2018 20:29:15 +0000
Message-ID: <SN1PR02MB375832594C7B5684888B213BB8930@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-5-git-send-email-jollys@xilinx.com>
 <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
 <SN1PR02MB37587E3AB2718E1DB510E35AB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
 <ab9632f5-882d-462d-d830-0316cad56baf@arm.com>
In-Reply-To: <ab9632f5-882d-462d-d830-0316cad56baf@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB1375;7:H36CTgvpAQUiUdeYWKb8fGdaUqmXkMoNbrmyCmlmOvie4cMm/2NjiEXthsEYdrX4AEOyqLn9+rLpKPVrx2tApWPhBwqguUBgKS/c0/hofugZ7IN2PsAULHn0G7rQIQg+o38WkiEkB+xukPSBPrtsXFnQTJ5Gf6xtVJaiU1NnDJfHYI0z++nGJjOkWgdF0MJY44cVhrlLnNRrEIdusVf/tPg8g7+jDegR0E6Fq08R+E0TampDMaQ1DQqCv1QQFwma
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(13464003)(478600001)(6436002)(72206003)(2900100001)(25786009)(8676002)(14454004)(8936002)(81166006)(81156014)(476003)(486006)(316002)(110136005)(446003)(3280700002)(54906003)(2201001)(2906002)(93886005)(86362001)(3660700001)(11346002)(99286004)(6246003)(305945005)(74316002)(76176011)(105586002)(106356001)(9686003)(7696005)(97736004)(102836004)(186003)(4326008)(53936002)(39060400002)(7736002)(26005)(33656002)(2501003)(7416002)(229853002)(68736007)(5660300001)(6116002)(3846002)(6506007)(53546011)(5250100002)(66066001)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1375;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB1375;
x-ms-traffictypediagnostic: SN1PR02MB1375:
x-microsoft-antispam-prvs: <SN1PR02MB1375D7B10D5A779C9F545B0DB8930@SN1PR02MB1375.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(155532106045638);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR02MB1375;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1375;
x-forefront-prvs: 0673F5BE31
x-microsoft-antispam-message-info: xnWAqOr1G1cmvVaKKK6hnpEemRajcT6gNqCxyaqBPBtDAC9F5xfkUgJ6/Ebu3EIta0yiOTQHJKh1PnmD+sh32aP4CkNmGvi8Y/suK8d2ZiVtWj0zU5rINrYfnDVRzFHkUBDvFockpxQwOqqxNqlgUdyzycqCXjqZQOqeRcHl71GyKtesZ91aN7bd3T7tTItq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 115d0245-de30-4641-8ce7-08d5baa28723
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115d0245-de30-4641-8ce7-08d5baa28723
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 20:29:15.6577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1375
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4FKTdeX021661

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Tuesday, May 15, 2018 2:34 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel@linaro.org;
> mingo@kernel.org; gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; mturquette@baylibre.com;
> sboyd@codeaurora.org; michal.simek@xilinx.com; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-clk@vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v6 04/11] firmware: xilinx: Add query data API
> 
> 
> 
> On 14/05/18 20:16, Jolly Shah wrote:
> > HI Sudeep,
> >
> 
> [...]
> 
> >>
> >> Can you give more insight into this ? How will be this used ? How
> >> this aligns with data we get from DT ? I am just trying to understand
> >> how is this information split between this API and DT for example.
> >>
> >
> > This API is used to get clock information from firmware and register
> > clocks accordingly in driver. In our case, firmware maintains database
> > of all clocks available on chip. DT will provide information for off
> > chip reference clocks only. This is to avoid duplication of clocks
> > data in DT and firmware both as firmware anyways need clock data to
> > manage them.
> >
> 
> I wanted to understand the difference with example. What kind of information
> you get from DT and what you get from firmware ?
> 
> --
> Regards,
> Sudeep


Below is an example showing PLL and Leaf clock derivation:

Input ref clocks->Mux->Multiplier/Divider->PLL*
Pll1/pll2/pll3/pll4->Mux->Divider->Gate->Leaf clock1

Here Off chip input ref clock information comes from DT.
Rest information for Pll/leaf clocks come from firmware using query API. For clock driver, query API is used to get topology, flags, parents etc information per clock.

Thanks,
Jolly Shah
