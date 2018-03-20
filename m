Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeCTVst (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:48:49 -0400
Received: from mail-eopbgr20120.outbound.protection.outlook.com ([40.107.2.120]:6961
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751456AbeCTVsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:48:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>,
        joel@jms.id.au, linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-3-peda@axentia.se>
 <e92c5457-20fd-1e6e-ab59-5ff53e647e89@roeck-us.net>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <23103b1d-8f33-7885-379b-384382953a42@axentia.se>
Date: Tue, 20 Mar 2018 22:48:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e92c5457-20fd-1e6e-ab59-5ff53e647e89@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0802CA0015.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::25) To AM4PR0202MB2771.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b900f73-1b84-48fc-ea15-08d58eac5a09
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;3:O2YHDV4BYwHiLHAu0hhgWoXabp70WVbve7YB8c/CK5PZMtUXOLmv3vJ0dtD6wuI/Sxwvp1J5ZbqEG24nSepCXFDcOAFgqsK8P5pkAQtLAahQe8gm4PGGeRRGSJge1/zvSIoZXL05SQdBmeUfZKSKV2b4aPKHtpG0Cevf9j/4c6UV0EHz7YVzvboLWfHnuonHaIVEKw1Vp1oLJQCkb+W7HEEozK3g2rxGEIdSVbWvD4AFxn60GjPE56xY2Bk5S5Y2;25:JDefoZw6M+CS9y5Uk0F93W8AcIvIHjLpmMZIOHejt0AR2Ey0QR9YS4p3Y7gW/5/sPQAeVJI9e38VcK5zQIT5lmd2Ik3cLwlEbpG3VuJJrqh4gm5zJKwWmto2OeRO+ZQWpEjpKkES/xiD3+EjdfKgOObCTzT+mzEP3f7DsdwuEuzqGtSU+NoXo44+cn7r1ORif33wXWnf9KgoaHzWUCN61WMm12h0k/3OTBct3DjzefTrBJcuulJpea1eKK8GJnZkC2NMFknkiJCbrTCdGvtANq/PCK+yoJd8q6TovpCE3brUi9pR+6FEWprP7jPT7z8MbEweKVKOFwbamzPWXmPSEg==;31:Hf0C7Yown+WMqA1HZDBRUXjmpYd43uKtDpk2HqVpIFA895lz+nSL8Da9DVTA01fDqNTODtHNoCLwYqWNg8PrY1XTiS1TqM9j10SpoCT31o60q1AfDibUaKfIdvPW+5hJrQrexOM1/AXXFIaQ3MzP/TsYYG0cd5Ji64vHTh682HcezvsIXsJwJ4m7a/i9jhxRsk09tx6D8JMRhCGdNbDCQh+8PZciHoyw26Er5PhaaQc=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2771:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27717DB176FD1E12F0D3AE9CBCAB0@AM4PR0202MB2771.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501315)(52105095)(6041310)(20161123562045)(20161123560045)(2016111802025)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;4:mJJ8TcnO0hzhWrz0L7H79aZmXLhL9urhVyyFjIbi7IXo/U16ROJDukAyzD4WIBVfDFPBDbR6LGbzruM8/rrhZxT7Dqg1CfnGghYFrASWLp2+zy5evJyh+hsiFDmX9UXWyanCYFF85EOMFr8SYdp9iGElTxdGg+KWCszoDpda7y/SwO+lO5da5qXesAYroNPDEEUvIkaOHsYek3z2/3XElBnV2B1TnIyQbJDmfkUXCZnW1zSEw1KBYdK0xkltl+ZJDfKdloL/ByxpXn+wIeeb/Q==
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39830400003)(396003)(39380400002)(376002)(346002)(377424004)(199004)(189003)(65806001)(66066001)(86362001)(230700001)(316002)(58126008)(54906003)(117156002)(93886005)(74482002)(53936002)(6246003)(47776003)(31686004)(97736004)(2950100002)(3260700006)(25786009)(6116002)(3846002)(68736007)(16576012)(65956001)(105586002)(478600001)(81166006)(81156014)(106356001)(8676002)(8936002)(7736002)(305945005)(64126003)(77096007)(31696002)(23676004)(4326008)(2906002)(6486002)(5660300001)(229853002)(65826007)(50466002)(36916002)(16526019)(52146003)(26005)(2486003)(53546011)(186003)(386003)(52116002)(36756003)(76176011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2771;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzE7MjM6SWRycmZvWVFNYlovL1FWR2hOdExZZ1Ra?=
 =?utf-8?B?V0NXZXZuZHVHV1F3WktWcnBxc2hYS3dFbG5LRm4zcy9FUUFpNnJJeWJBcHFY?=
 =?utf-8?B?bG5ZTVpVRnNidDgveFI1UUkrZFFXQW52NlNMdi9pNHE1VjFsMnQwNjlVaHBv?=
 =?utf-8?B?OUFLeDJqZjhRVFlka1Y1R2pZRkY0a0dyUElBeTZsQ0VSUmVoelRZTElWM0lG?=
 =?utf-8?B?Sy9VdFdGenkvYjBJbi94ZnhIdUM2NUVNSVdjWmFYR0hOSHl5N0ZKTFJrU0VK?=
 =?utf-8?B?OUdyZ0x6SXdlNU1HR3lPZDRkTFp2TnJMTU1nMkZaYjNUOUdDSkVWaWRTRm5t?=
 =?utf-8?B?RVNpTjZ3N095TW1QYnc3NysrRjErQkVUS0Fzam00NGkvL1ZTdkpmMHJFZ0l4?=
 =?utf-8?B?Wkh2RGt3Y0prUXRNZkxRL2Irak9xY0ExSFl1OUtacU1MaHhJUWp4OXAyRUxl?=
 =?utf-8?B?TzdUWk5KRFV6dUNIdTk4c1Z3OUExMmFQNTFyTWVnUGdRdyt1Z2FGTmlYcXQz?=
 =?utf-8?B?VWcwUWlUYTVoT2tEekZtbGZ2czNPWVlRSUpDdkpPdXB1UDBnSWp4TXF0UUJK?=
 =?utf-8?B?dGR3bVlvMDh1SEZwUTV3ZTVFeG91UkZYbERlMEFyU0dPK0dYMnFKU2JxV0Nz?=
 =?utf-8?B?MTFCSVowVzMzZ0NJZDNJQmFQV3hxTDNkRHhYNXpvcTBROEZ4ejZGWUhRVDdJ?=
 =?utf-8?B?TzY0L0lyRHZKb0dsUFVMc0lNRldJbzR5dng0S0ZvaUxvdjJ0WndEczJXYWN1?=
 =?utf-8?B?UHpvSnllbjFCaCtlbFFNdXhhVGdVRm93SDVBMmNVOVZRclQ4QmNyQTRORmNZ?=
 =?utf-8?B?TjJybFEybUZENHY1Zll1ZzlDNnpnU0ZMc2NvbzJwbTQxN2FNaWhIOVJucEZO?=
 =?utf-8?B?RXlwSmp1eUVrZkVOUWtPbWNVcVdUVlNIcWpMUUpxRld4bERraThha0h2Rk44?=
 =?utf-8?B?VmdrS1NoNFNzS2gxY3U4R05Vd2hRbmtSY2RoNUdvZmhqdEFnT2FHTGo4bm9Y?=
 =?utf-8?B?c1FIY2Y5anVLaWJjTmJGeFNidFUxOFlUL3dEUHg1bTFBdzNTemkycCtQOXpK?=
 =?utf-8?B?WE9Dak52WVovZnZrS0hpcG0vemNBeWc3cXdUdnQyUUZaZXpZa2dkQkl3Umpp?=
 =?utf-8?B?eSs3a2tYNG11QVh0dkNiZ080U3l6b0xMMzV4WW42Q3hHMnRIQWZBSVlZZVhG?=
 =?utf-8?B?cFVYMWNQcHh4U0JJZGxQQ2ppN0NTSWZkcE83RjVOVGZlR3FUVVBnWmpuWHNR?=
 =?utf-8?B?TG9NYndmcnlrdERXL0hZOE0wRnFhR0hSaHlUeTliaFliZmZEa2dXRjBRV2lK?=
 =?utf-8?B?ZDlSN3NKMklIRFVndjBibUlHVU4yNUY1TG1pNG9SeDFMSmVDVDNhWk1mZ3VL?=
 =?utf-8?B?dVFNRXZWYzZzK3h6UWdreUx5TDc4cmdnNThzUGM0WlBrekIrS3RLQTViRVM1?=
 =?utf-8?B?dGFwWmE5ekN0SVc1TmxndGdEZVNXTDhHd25uWGNKSTJaKytTUnZSSWEzVWRp?=
 =?utf-8?B?eXkvTXd6NHZwaHRFdEw3U2Vxc1FLSzFaSW94eThVaHU0Nk51UXI2VmttRFhO?=
 =?utf-8?B?ckVWRC9YZVdlSTJ0c0VUSXpPMy9VdDV3NlpiQWZlcDM1Y0podnB4K0xmbk5M?=
 =?utf-8?B?bXR0UmIxajZZaGptRUNlS1JxMEk4UUVlT2JQU1JKT29EV1FKMUxPMURKVUhN?=
 =?utf-8?B?eUpQWkpsMmJEdHlQWC8raEpjKytPdWp1ZGNKdmVaL0dCWEViV1dUNTJHSysx?=
 =?utf-8?B?ejZ4bjZpcjhxTlNqNEVPMDRQdHRGK1U2TUVlb09jQVc0bnRQdnE1R3UyOTRz?=
 =?utf-8?B?T1NKYUNHdGFla0FFMW9kcEFnZ0E5T0lNRjAydlBiUU1GS1I5WFp2R2RPekpv?=
 =?utf-8?B?UGc4cndKTVNud2phRHJxdFdIc00vOTNnWjNCWGNRSkNiMFQrTy9yaURVdjgw?=
 =?utf-8?B?MFZrOFBSTkNxTFhDaStEOWpaNmhudGhzUEJRQVN2cFg1NDh3T1JKdkZraStN?=
 =?utf-8?Q?mTGb+5wc?=
X-Microsoft-Antispam-Message-Info: 8Jc2yg+C7E2sXYLuwqEOEWxDvhXJrs4lyGC6ySMzFQcYlrss1WUYncbEcLyondLsC5GGcx64isypWISqQ8+hSmLayrZqmXL4lO39rwRxHKfSN6qan035uVOd1WtHuoukKYKIJZFsHUbkVX4Dbh9Cu2j4Ats2ucYLf1GJ03hv4MkYS1s08JuAQ2qB5PXBsUMg
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;6:3yb91k5dUkrW5K6JiNoDDevxNOskxy/fOJjbmVbapEe6QYti7LTddjUIKZ4vRFKBpxHkbhOcwC3xILV7emvhKwNaO3mE9gd6R77bJO40AxSh+Wnwosc4ufbB6H7rpYrmWFYX8uKTSqaAKqY5zK/ODbLR3N5xLOmlob/KdwPBI11NJFXLs/5ubA/J8rQ39bIsSqHEdkk5YSDyKx+YeT1T1P32MSz5PbJkD1E3yZz9htuHvvhDsVVekDZtCP82nxfbAdt2ucRbvrsKPrjkauKL7dzVt8+O+9VCthHvudxYvbAacL3BjirN5RLIio4kl4wGZCb/eoxxlLLkIheGZxEkfztx1CSV+V108nNooVVny4I=;5:5G7rL9PVaulOvHmTf3i+ClDLWRfrPaWmdF5LL19NEmZLahQX6UIig3gZr3wiNORqT6RVzvCpOPLhbYrmI0AGgrChgA8xS5vOeiYYyA3EqqgButDTdLys3UeQz/4ipUAgLzl/8HHkq2pLRA1NiScF4twDtCpRyUl0u/emTlie96A=;24:jHpcY1Ufc9/IvAEJB/UdGnHZqWXmEqY+SddizqwbjIxh6ZdrVCc9GKmFi2WBM0Kmcsg5KtXxAP5wFEvdTDImIhowIpTCoczMdKlpQUeWJsg=;7:jMBYa5UdJesyW9JqV570A0lH2QO/Irx98yoWju2k7R7CfF5I/ebuSF889Undxl15VvOyD10BfAen1Ztr0q5PQf/P8hYoEHEGzEP2JWz037uF1pFivJ87f5W3/26oHAjxWObqe3RLOT9VM+OB1qOrxIkg0MLynd1ZpKVijDzUlzeKBNOoW30lheDGeAkKLwTZDwbAkFw/gEwo0IBvqSRxZkWWAYn6h4Pc+h5UmjY1vT/l/YYF70bpwh9efzZ9jq32
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 21:48:43.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b900f73-1b84-48fc-ea15-08d58eac5a09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2771
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 14:20, Guenter Roeck wrote:
> On 03/20/2018 02:31 AM, Peter Rosin wrote:
>> +static int pca9541_mybus(int ctl)
> 
> bool ?
> 
>> +{
>> +	if (!(ctl & PCA9541_MYBUS))
>> +		return 1;
> 
> true ?
> 
>> +	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
>> +}
>> +
>> +static int pca9541_busoff(int ctl)
> 
> bool ?
> 
>> +{
>> +	if (!(ctl & PCA9541_BUSON))
>> +		return 1;
> 
> true ?

bool? true? Isn't that C++? Sigh, but you're right, and old habits
die hard...

Would it be ok to add your reviewed-by tag as I fix that?

Cheers,
Peter
