Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCZT6z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:58:55 -0400
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:13050
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751116AbeCZT6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:58:53 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if valid
 bits are not set"
Thread-Topic: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
 valid bits are not set"
Thread-Index: AQHTxTbYl0Ocyw67K0ebLpEvWOkqDaPi53kAgAAAvNA=
Date: Mon, 26 Mar 2018 19:58:51 +0000
Message-ID: <DM5PR12MB191603A2AACAE6F7F923C6F3F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326193052.GJ25548@pd.tnic>
In-Reply-To: <20180326193052.GJ25548@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1740;7:F+1iO+8CzbCPRyCaw9zzL2E99/f/S2Y17zwwdFwDUlu1J9tGJDvDZ3PjR6wfnMRDatcnZPeSn1oD5eBKlJMer1qz1xFJbhyFj7TbwFmNOQoiZJ11x2nNYq4xA+9yjG8mGjmRlSaeRE5UrwOblQr5n0+frTynXFHwagQLr2wEEDIqn7YXprnaalhgzMQVT6fdi7WAKEYqNRaaQNYcVypR+iBEmjIYQ8yj9cyp+bkHWr75Gh7WKdVYcXkLFXChvz14;20:X/WD9EwqRrrr/HZdJ94AJPPi5YRVPdm3KiG+2wTPjUU+IXIG9a5g+aun44e4yYqTwT9V0yUfJVZsqoBazAWCM1kiTO1825vD3b96tikg5RykTPC55M18TbLjSmmlmiLaRkrtEmThzZMp7+5HZ620/aCCOYGAid3mjY+wIbqsHmULu4Q7h+N6WJnflX8pSfRHc9Um9HhP+Xo1sf8DpPeoTQ71nP/rUkE+iDIEzMpCUtumV/PDp4ly8PAxyhmniezQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e02a9737-87ca-433e-ee5e-08d59353ff2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1740;
x-ms-traffictypediagnostic: DM5PR12MB1740:
x-microsoft-antispam-prvs: <DM5PR12MB17408C3BF18F8CDEA77A1A96F8AD0@DM5PR12MB1740.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1740;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1740;
x-forefront-prvs: 06237E4555
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(13464003)(97736004)(72206003)(2900100001)(7696005)(2906002)(76176011)(14454004)(53546011)(316002)(6116002)(446003)(25786009)(6506007)(4326008)(478600001)(11346002)(106356001)(105586002)(86362001)(46003)(54906003)(476003)(99286004)(305945005)(7736002)(74316002)(3280700002)(3660700001)(8936002)(53936002)(68736007)(6246003)(6436002)(9686003)(55016002)(5660300001)(81166006)(81156014)(8676002)(186003)(5250100002)(102836004)(6916009)(33656002)(229853002)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1740;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 5HrkhotRs5/qzBWfCBjTDZ68Usx2Ke6n2eB1MR1hXmnIruY3uwPtoCCZstlzV5yv5MlczZ5q1fFVVvpRVjuci36cds+ROfrV7K86495R+P6HnqNQzSgFM716lxZQHfASpLFTb32T8CbHpHYJF3X64kgZUex6jDT/GMxxTc/PIMM5KPaLkPjcUJWhA82JEiwu0Ay/6gjtvjX+lW9XbvICp2dQIHLtSbgqHMMuIG3mM1ojm6UgMXYYqtj6vdEnArxhMWpeKVrmbxWfIVvm5Umsmc3AoKKyci/zputK8W+ErSV+O2XLreXI69+BtJa0lD7u2lT9gqw+KKONpTIBK39EiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02a9737-87ca-433e-ee5e-08d59353ff2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2018 19:58:51.4806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2QJx2R8008060

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-
> owner@vger.kernel.org> On Behalf Of Borislav Petkov
> Sent: Monday, March 26, 2018 3:31 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
> valid bits are not set"
> 
> On Mon, Mar 26, 2018 at 02:15:25PM -0500, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > This reverts commit 4b1e84276a6172980c5bf39aa091ba13e90d6dad.
> >
> > Software uses the valid bits to decide if the values can be used for
> > further processing or other actions. So setting the valid bits will have
> > software act on values that it shouldn't be acting on.
> >
> > The recommendation to save all the register values does not mean that
> > the values are always valid.
> 
> So what does that
> 
> "Error handlers should save the values in MCA_ADDR, MCA_MISC0,
> and MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
> MCA_STATUS[SyndV] are zero."
> 
> *actually* mean then?
> 
> It is still in the PPR.
> 

We should always save as much of the error state as we can even if we
can't act upon it. Basically, we don't ever want to lose information in the
case of some unforeseen issue in the reporting mechanisms or something
else. There aren't any issues that require this change at the moment. But
I think the Design folks are being more conservative in ensuring that all
possible data is collected.

So at a minimum, we should always save and report as much as we can.
But we don't try any recovery actions unless we're sure the data is valid.

Thanks,
Yazen
