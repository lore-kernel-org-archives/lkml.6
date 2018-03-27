Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeC0OCX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:02:23 -0400
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:62240
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751046AbeC0OCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:02:21 -0400
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
Thread-Index: AQHTxTbYl0Ocyw67K0ebLpEvWOkqDaPi53kAgAAAvNCAAAmPAIABK29Q
Date: Tue, 27 Mar 2018 14:02:19 +0000
Message-ID: <DM5PR12MB191601AF532C84190049AD04F8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326193052.GJ25548@pd.tnic>
 <DM5PR12MB191603A2AACAE6F7F923C6F3F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180326200742.GF28372@pd.tnic>
In-Reply-To: <20180326200742.GF28372@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1531;7:bdi98jKHMRyJEcZjz9cKsgdimw30p/YQY6f81b8xCe1fmm3rRBlWv/gkLSO1Ui+dEcLriy7xWYifx6G/aO8SZeDA3DwE0aSf+vieDG9BiLFYXgvLZs86YKIQ6ZMMHyu9lUspRQH2tBp7+pDByVJemm6QoGWG+UJVdctV/wE4i9nbrzvuXravVYH+v4dRhTGD3gGZTHw0P9/kuT6yEHvhN792z9gfsHwKYp1D5TIFwQEf+//JmiRtZ9kO2tQUV4XG;20:XaC4ujSNHJWsm5AY1NIObuo3HSd76dfXn9U2rHuhMnOXByueBL7KH95Ygp+vrLS7p9kguxNOyf+lEAxhiqqTbs4rzyriJfNaxYQxE3lf7YEfsAQLt6BFx0b8lavy6C+/4V001cjrKmF1BuoPtNehbiEVRvYSNB6fENdfJlVaCKo5Gl4fS8GimJmcg7wHlYqaa3pS71b1Z1hGxwmORlcEz0MdDzsdNP0IppwYevTYh6WNbntN3tL6sgigzxbNDnIp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 987d12f9-fb03-4f3b-26d5-08d593eb5ac3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1531;
x-ms-traffictypediagnostic: DM5PR12MB1531:
x-microsoft-antispam-prvs: <DM5PR12MB1531ED69CD709C55CFC017BEF8AC0@DM5PR12MB1531.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1531;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1531;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39380400002)(396003)(39860400002)(13464003)(189003)(199004)(55016002)(54906003)(46003)(105586002)(33656002)(99286004)(14454004)(486005)(478600001)(486005)(72206003)(476003)(7696005)(186003)(53546011)(4326008)(102836004)(25786009)(59450400001)(9686003)(76176011)(229853002)(6506007)(8936002)(3280700002)(446003)(6916009)(53936002)(11346002)(6116002)(3660700001)(81156014)(81166006)(2906002)(93886005)(8676002)(106356001)(6436002)(316002)(2900100001)(86362001)(305945005)(97736004)(74316002)(5660300001)(7736002)(68736007)(5250100002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1531;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: oXAlxpwhZ20J1bqV8O/sxFM0cyP1H9HSWhfXZvijD4IuKyQykFapmuYaNJjTiqweMPxYb6pgZrGA3LQgzbMMjs3iBQ+tL9IjQqum19OD12vq6RO2jguXaAuwdfDo7S5Qbp7Cce294HbOKbJ5Mdv8IqoVjMG1xUySr044idjkWTL5Zl17fl2SmGOm0pOwjIiyG16neMXGrrFnxE2KJac+Y5zYncsXV/EqfVqTHvc87HgKpW6rK0qhDj+2QJVEu+CFqz8NJ+ogtgCGAKiotwAma8GZh1At/+yfyrrk39yCClNPDmeF+TP7so+DopdVtprGb0zjdy/wZgHq9nTGRbWdFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987d12f9-fb03-4f3b-26d5-08d593eb5ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 14:02:19.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1531
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2RE2QMF014245

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Monday, March 26, 2018 4:08 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
> valid bits are not set"
> 
> On Mon, Mar 26, 2018 at 07:58:51PM +0000, Ghannam, Yazen wrote:
> > So at a minimum, we should always save and report as much as we can.
> 
> Only on Zen or all AMD families?
> 

I'll confirm with the HW folks. I understand it as a change in philosophy
rather than a change in hardware.

Thanks,
Yazen
