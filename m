Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDJQmV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:42:21 -0400
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:14608
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751630AbeDJQmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:42:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <20180410141125.4477-1-wsa@the-dreams.de>
 <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
 <20180410155250.rjrfd6v5unqlf25m@ninjato>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <29ab4b56-f857-a2d6-0b28-833896e9f47c@axentia.se>
Date: Tue, 10 Apr 2018 18:42:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410155250.rjrfd6v5unqlf25m@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR06CA0023.eurprd06.prod.outlook.com
 (2603:10a6:206:2::36) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb0244f-aaaa-449e-7a4e-08d59f0204cc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:yR2dXAzj04EQsDujvG+5fmES6LMqukxchM4XzRZEta8dkwMnpT49I3nA020+7Qc2+Kyq1FzxtC0Be/Gd4SJmPRXtY889+ncrVYpRLywdHtHmOlAlImMbsBHbsVr8RFrDTAbdOixKpjh9pcWzZX/SmNx1z6NKukIHyiktO79HlhNS4fpjEKaU+vpaqEjBK6j8rNkNaH+9vSv/u1qrT4mfMu8wYIEg8+HchYitPDzDtOHpZaLKAqqfqxc//rvw44RC;25:SAOzCM6ZwnCEqAecyop6BzQAHhH4zQEc3joLjs/qLtd6WV8euZaqaQmUb/qgLWo7/ApNg73eU2U/vUs8KqWrH4VgpvDzkH4a4g7xnT3oiXOM5ZhMzo8evwpsN6fW5bz5DYP99KKgzePd6gDDcRRFGhrlhQIMYTwDlYbblf2xnp2LXgmDHd+8oaD2HvomB2TY5DXZyVhOjpU5Wu0qbBxVHG8Rq9NSeLzlqSkRi8W3guL527T2l5NPAnIB6o9J1DW51B7Qpjj6yHwSQAU89sZ8Y5ug/+Of9igdiPzy/74LSiftf+vg/Q3SKIVkRDD0z3cYsUHH3z1aEwZ/EXVceCacIQ==;31:lFsM5cMHKyKQq8+zPGmPaxJ/1+6lGKMrJ457DRObRwhpPEVcpxht8Z4ygXRlM/kf75QvMQ+5cVInFU70XbS5r2rORjMrQHzaFxz/pcKMeNm/ArVcdwCn6L3pcWXZw8NWKoAkM6Pnj1nCswAKlBjaY2cUIaezdCP7XorrIwxyS0HePjYs5sgb84bEZseamf5AQgp64dZYeDWNf4002/Qa184L6wo3uk2CQvVoC+LLqR0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2780ACCEBD0A7FF48E3B22AABCBE0@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(15185016700835)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:qouksRIiJ+4Av1UuVTA7XHdQNvhijRqdGjPk0ddURsNsxVeMqTBRtZrol6lV7fblJEVNBUGvE8bynb2gXhUpS86+ESxOjojP8fQDZDFQEcsVXPb21aW9woQziKHX0QM6vNVNMCxikx6tcis9Eg6zouSa0F7rQfzQVQXTPt6Ne+IMa7g511ZsdY4BPGMVR6hybpZ8UjY6W9zP21rPXEYqapF23ABK793eUFS0lov9OeZEshcVxfIRUUmG6HdZpZt0uwP5M/u1Xm4U6GPloO1rDkhVqQ/Cm7XBkbr4G+sEBUR4H0LIgEHwdyiq4roOCXjvnZVlgpifHBf18YjRG8vrTUkjUBBRijPGHz4bq1NoemKFgphWm6SHug/wjLHa8Np3
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(346002)(39380400002)(39830400003)(396003)(377424004)(189003)(199004)(31686004)(8676002)(4326008)(23746002)(966005)(74482002)(65826007)(305945005)(7736002)(77096007)(6666003)(2616005)(6916009)(31696002)(16526019)(486006)(186003)(446003)(11346002)(81166006)(81156014)(476003)(26005)(86362001)(956004)(50466002)(97736004)(6486002)(229853002)(53936002)(478600001)(64126003)(6246003)(47776003)(36756003)(36916002)(52116002)(76176011)(58126008)(16576012)(316002)(3260700006)(105586002)(5660300001)(106356001)(230700001)(25786009)(117156002)(3846002)(6116002)(68736007)(65956001)(6306002)(66066001)(53546011)(8936002)(65806001)(2906002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR0202MB2780;23:EETYjEU6k7pW7/Fh9luVQFbV+LfwtKUpXVN?=
 =?Windows-1252?Q?0N3zTHS1ZiWPDjJ71SFjgzZE1EfJjzrozyQOZcMI6Y6SEnnHidapfDHw?=
 =?Windows-1252?Q?WZWUL3CKnNIcicsRuDLP2HtOw3/lvg7Z1y4FvxifN/EsDLYo77UfWxQt?=
 =?Windows-1252?Q?q5LV577sKzW1hkznb0ZakahoYln9Ed6nH9mrpdn59Z2oZNHd6SsYzIbi?=
 =?Windows-1252?Q?OV/bkZ/Qu7bKSfEoVa5BPywZ9jIxyt8p5QkKM1hPpVAe9OHiZ+CEW0G+?=
 =?Windows-1252?Q?NvKTLqTDRqcVPguiQTYlvOW2AnEnYorRfYKT2wmDbQOqaquLZyB9YSWP?=
 =?Windows-1252?Q?xFP4Y3NxtPvwO6EupYKBPtKNuElz6UyehYZSXqy1tOEJuGHRHAvqb09X?=
 =?Windows-1252?Q?5GJCqHIYUfVG/BL7mVpDcRb8nhDQ425Z+8ygUdVTBm/6gRxvTv8fEtEQ?=
 =?Windows-1252?Q?/E+pojirZ3YdPg+rS/t8ScVrpUWSB9DbH/j72121rJOB7rT4XyaoqSwo?=
 =?Windows-1252?Q?5boLqBsn2G1LnU1cbX0vI2xhhtbnybwT1oS5h++8oFsakHGks0m5n/KN?=
 =?Windows-1252?Q?AaSR/kBM3nGEsPJwvJEZ2mIN5u5VoJcRsK2vMrytn7MGm/G+ZFmGs63/?=
 =?Windows-1252?Q?qifqVoFRBtDC4ZgU577/Yvy1W+MC3ZNJNKD1xfSRKNBDHuCQFLN7SFXi?=
 =?Windows-1252?Q?1Ccp7aTdBNYtuYLpiH93YaStKeKI11l7ZQOmMHJv+mkXL6+e5m/ytyi5?=
 =?Windows-1252?Q?s45430FCXZyCv3bXk1Cm1x9+fEZF7/VO+8/r9vhdzJe8YS3qComcT4Ee?=
 =?Windows-1252?Q?0666jFsT06ducQgkP0M9zI+2sHDmpnrSerjBCxc8drhEVSdz+RpJ80/s?=
 =?Windows-1252?Q?AWDGn5UB52jp3rotzjE7MtD9sgd+ZNKy4TiHKDaNL/VGvAwmATVUSTiH?=
 =?Windows-1252?Q?ywu7cC0qmCbe+qcxcRrezQD7vshGeuQ+HtAyfsZxeIeeJWARiQB9HPuZ?=
 =?Windows-1252?Q?LN4AgeGFgQ8d+cQ15IxC/VJQ90VfPs/oMWr2wo+Gj/DBb7F+sZBTveEV?=
 =?Windows-1252?Q?FJxVaaChe2hcI9HYIpKEGOJWkV1qkfp6s9WnvdnTZGS8zWaBTOxw6Ap3?=
 =?Windows-1252?Q?s/1wzzfJgSJTjzMWunDnyV1z1PYIjy/1V3+IFJN7W0jtQlu/kSf3RTIA?=
 =?Windows-1252?Q?flvlV6FRFIUQwWQoXCJq2Z8r5gxjfrcOGcGPyGYwptlqMUxgOdyAO02v?=
 =?Windows-1252?Q?gcziDC95+XubNhU5VZ85cVJYSQIlF/iMGxBWNH0ggeP0BIWgmSs89NcD?=
 =?Windows-1252?Q?dyF+MeecC76eUga486DOdQW0/RsvNC9iBQ42+kpvIOQ60YW1TbvvZzo9?=
 =?Windows-1252?Q?QN/tFkUGdJoqrU1Vb52sHCFzuQFFq+VMFry+Q+B27yBK7UZMT/jaAUYP?=
 =?Windows-1252?Q?S97985lSw2aB3+qRHcMSWZ5URYVVgbToGAoDOwJmOER5N45Kx9xa/0bo?=
 =?Windows-1252?Q?wEOwnRKJdv4l7P18eUBWdg278ePNg4ISapP9Xx8yKDhFroyTxtOZ3/RJ?=
 =?Windows-1252?Q?f6WNc3meDXszX5i8cYg53SPV0MhMWGL5rKTPujItbYRNYlv99cInvDTU?=
 =?Windows-1252?Q?0WNWpnRjRuo0xYQhRCg9IMosFUnbqhbbPSJ56uMzX58Loq8aICFcJzQz?=
 =?Windows-1252?Q?42CX5TDfsdg=3D=3D?=
X-Microsoft-Antispam-Message-Info: HdB2fo9GQwYqvsSspKWENzNxXTobSKxcGvnztdFdP09vNPUFq/Z2RCOnuGdCo3ITs9cKZFRgGynT+ZPcw3N3gszs1WAACYk5lz2AhMIYGbuydlvL7rWojNY4vIJJSfdAtfUI6Ll1uC66laDdV59vrkzd9/V4GNQaFvl29M2TVvt7kRB6G/brUghjGD7E5GtK
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:+vCM1Ch3jhwOdDFDbCY0oJp/suPIg4XAXuxNR6grgComW9yqdp89lFb/AFxqIN/rhgc2ASZyo3cHgkhmL8Y5cqUedCZImaOrAyJxZw5Ib2PfJJgJeNhAoGNfjBupgoEBex2F/qsn9nX8YnwOJkV78u/KYqU5d6z4aNMGShEIIcnAclTRUiQm++mEb3uObV/d6wdThJbD43fXWRXlbvuSP8BDOQLOaW8/QHYOAeWXCr1U9Uef9carvC0xltRRw+lQQ+CPtU1tMzLx30Cioup4Lj0ci/lzBqNwxakAzgdlbQBBcKd9lsJPfAJEjZw4E8g6iWh59i3L9HXJndmTRCJ8ldb4XS2A+2ygPdd6P7JZokB5BaTEouvhYDjJpWYJz+e/acJh8DfNrsMTKhDUgnWqvYJcsb3jpjFi6ujo6TMCrgKDRNFU9MoBnDvf3YmX2HWJdCCs0RD8n+SjBp7SzjA3Tw==;5:CGgk9cE2ehxOIIJHe/5UVrvqv2OdM2D/yGpYMCqzqJif/25GXBMaS6kVaieEc9l7BS7urymrmgtq39lUrPYCN0CVJzvIRlPyky7SWXM3kJeDhtv072MHrDhfJkmKMmMOat3DNAD2dh59LJ1E0FxSqVJ18zceGpcTKLaqMihe5JU=;24:3qN17yUIRhKGLAKGGuuR2YvaFf8ztItxw5e27tfHXgVAUfu2o8h4GlS0pySOjP+56joJIhPQQyIpNXMs9VcmUZ7boZyzo8h1CY7FnKoozDQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;7:OTrVxvEYPQtrEfWZTM2QGcdy0LCazcQjtmrd+AH+E6JWytohdw2gh90tWnLILdkHaw7AKZF98Z1xUu3ESQ4TmcHF/vvzbt8U//HK6Qz1nMruEJGwsScwTU3sdcAkXos8k9+/eufAheQb1ssvLkDj2mbnC/gMbrHtkxXoz9fNos44H3bJwWOsmm+qZNMyDcNTeguFdXe4ky/PvU+Gd2Xb7J4n2jCTG87p2gn7GQsodOIki20YyEyQy13MK5NMqjYK
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 16:42:15.8303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb0244f-aaaa-449e-7a4e-08d59f0204cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 17:52, Wolfram Sang wrote:
> Hi Peter,
> 
>> Hmm, I think you are ducking out from the i2c-mux-pinctrl driver as well.
>> Was that the intent?
> 
> Oops, nope! Sorry, I just forgot about the demux (I think you mean that
> one) driver and will create a seperate entry for it.

Right, I meant the demux...

>>
>>> +I2C SUBSYSTEM DRIVERS
>>> +L:	linux-i2c@vger.kernel.org
>>> +W:	https://i2c.wiki.kernel.org/
>>> +Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
>>> +S:	Odd Fixes
>>> +F:	Documentation/devicetree/bindings/i2c/
>>> +F:	drivers/i2c/*/
>>> +
>>
>> And this includes all the other muxes, i.e. those that are "mine". Maybe
>> not a problem, but what do I know?
> 
> Sorry again, I really didn't want to dump something on you or leave you
> all alone with the muxes. I was just so focussed on the host drivers
> that muxes simply slipped through my mind :( I can add myself to the
> muxes section again, no problem. I'll let you decidei what you prefer,
> both is fine for me. You are doing a great job there!

No no, you don't need to add yourself there. I understand the mux drivers,
and it's pretty quiet, so no need for that. What I was worrying about was
this "Odd Fixes" fallback entry needlessly covering the muxes when they
are covered elsewhere.

Cheers,
Peter
