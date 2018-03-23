Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeCWTdX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:33:23 -0400
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:59328
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752169AbeCWTdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:33:20 -0400
Authentication-Results: spf=none (sender IP is 129.98.127.170)
 smtp.mailfrom=einstein.yu.edu; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=einstein.yu.edu;
From: Maurice R Volaski <maurice.volaski@einstein.yu.edu>
To: Gabriel C <nix.or.die@gmail.com>, Willy Tarreau <w@1wt.eu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Did kernel 3.11 never work?
Thread-Topic: Did kernel 3.11 never work?
Thread-Index: AQHTwrRxo/jE6/QgLkSKKNwiuRVesaPeK1QA//++JQCAAEjFgIAACJuAgAAE5wD///ZqgA==
Date: Fri, 23 Mar 2018 19:33:15 +0000
Message-ID: <EE382DC0-D88D-4673-B59E-F148C60AFF9B@einstein.yu.edu>
References: <E513F076-24D5-4F67-A204-D2E6E1135FDE@einstein.yu.edu>
 <20180323145428.GF15012@1wt.eu>
 <8BF385DA-7EB8-446D-9005-64509D7C7CB8@einstein.yu.edu>
 <20180323151913.GG15012@1wt.eu>
 <CAEJqkgjj2dR4GLOEzsUJiWOsoqFWArioh32KW1We5xgp4qSb1Q@mail.gmail.com>
 <CAEJqkgjW6HbzVM9CosveTzwQJkOWaUVFd4MNrw2XTvvkUxDRqw@mail.gmail.com>
In-Reply-To: <CAEJqkgjW6HbzVM9CosveTzwQJkOWaUVFd4MNrw2XTvvkUxDRqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.c.0.180314
x-originating-ip: [10.49.98.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C63525EFC21A0D49BD87F4A61272B6A8@yuad.uds.yu.edu>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:129.98.127.170;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(376002)(396003)(2980300002)(428003)(189003)(199004)(13464003)(377424004)(33656002)(786003)(105586002)(109096001)(229853002)(7736002)(110136005)(58126008)(305945005)(106466001)(4326008)(356003)(6116002)(2616005)(316002)(966005)(3846002)(2900100001)(446003)(102836004)(39060400002)(478600001)(76176011)(6306002)(83716003)(82746002)(53546011)(88552002)(8936002)(50466002)(336012)(8676002)(436003)(26005)(186003)(47776003)(11346002)(2906002)(6246003)(75432002)(86362001)(5660300001)(2486003)(23676004)(93886005)(246002)(781001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0401MB0974;H:smtp.einstein.yu.edu;FPR:;SPF:None;PTR:aewexcph01.yuad.uds.yu.edu;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:egNNtzAdW1noS7Jg46wg0n5YLntLDe77Kt+XEmrA41XIMpU05HnTvjce05Y4BQM+6FiNPKmVQhHXfWMadL07M9v8FyLSzdo1+Yi4Hq27p8EX+sD7GjWQ5ZrD1qQAo8OK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2e647de-a560-4158-93b0-08d590f4ee22
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0401MB0974;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0401MB0974;3:GJNN3fACFjTgTFC8hY9gkNzA6VXKej1myMKVw4j1V8unQJGU6pLXXzq5MufEDHLN3BKNshPWaOwxmPf/v1kqP4XQKKvF6g6d2z/h18V4FnkPnX8J7BSLa3gHNt9qd8XqzM4w3yyQOdHYSbQ3HipkrTNNQzp7i5KTo9zQu+Hrshvofj3XMMpquclq5TAvW+a1rA1n9gJR+Ki1hljfmaZtwh8g2IVQUPRq9lLg44noVftZb/76fr21cSPQzAE45RgcP8vwGVqs7qnj0vgKuR9rA5Y9lLeO7zy5qz5gjw6MNUD50HOS3l0rhxsTe+8/7Rk72gVwTCgTFW+Tj1n8v1MwcR5uAXMWu84dLUNlEAY5SPQ=;25:IJvfRhVo9KgfDsDtY7WhGQazIbok6ku37Y91ufP5LwYHBvBG+jcSsYalMhjAH8Oi2GZP57zXrH8ej97p1ZSqmCDjTTnseN0D7P1uY87JFGMysYlbySVfib/0dVVVigAbSX5BqpRA5VMZ/G/hpT083B4FUAML433orREB6zOhERuZFsfSlFPX0soo/JIfCl31kvwQHQLJ0GwHxPCwCdO8u8Fi4b5N74z3iyRdJUlf2xUlcZSpSfNGnHDxBN0rR42k+docQI51jsh7G1GoXlF78Pr5sjzjlo7nXiswLrwVgrxTd0GCf1W7yNwEI33trIYn73QmjfMlFjVjSt+hQbuRyw==
X-MS-TrafficTypeDiagnostic: DM2PR0401MB0974:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0401MB0974;31:wrIpD/HDyUAochTS6tVG64RoKKsTIv9REobOfzLPKtzntbDUNMXNaaqPCvUMEDq5yRGZvLHZnBs6thGHTa24L91l+ZI0Lui/9khrSLE25TIRo48uH2/9b4QPkXaB7ZsOSBjSnn4wfD0kEfr4oWq79l67aIbA2USmyu820VlaVipiUodOf/ctwqSeBI7XUw0/SaB79GqWDXOMIoQjbJkBO3PjabX7nz2yo+1YR5k4ZGE=;20:6vf28BguhvAJVtGq4m1ecs4HvVJJwBRZJhLvIYJwU8In14Mf711YMDkH1G/BFUkNWIEKjwWzmO/5JyC5ywqI074gWOsTM/PwSIvXJgng9E9f3cCbXAoq6dZo9OUgX2EGdC4aBKIwmiCvCPaUj1hj4hE84IM4ynzOznsWQtxqrDDvCx81RsqAXS4gfAtyy1KFyTdgVTZlT6iKF0tfKVLjfW8FT9tIdVoCk6zt9+doWgrQbtbWP9MACuAnKE2hr9abw7/Hz91xNacvFWfumOJx1IQH8Wh65s0JB6sYz0gJvD3riX7u0NcC/0Ff5xNxoGFQclNyW1UQbYNAVmQA2BWW1Hdlxh+g2tDq/vyKkqha7aHwE7I83jvxmXFmT/0DGI9IcQuOrWYJ50mTjxa6iiiFqLJmWXzKgv9Y3WAzs80yLY8uh76rLV8lR4xbTlXpePR9b+XeH/F+VWwO5D+92gcGg1+AwuVFeQmXOgNZwH6u10irDS1X12XGJZT2Ucr+lS4/
X-Microsoft-Antispam-PRVS: <DM2PR0401MB09749F366479D5DDED634602AAA80@DM2PR0401MB0974.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(9452136761055)(85827821059158)(150496076066914)(5447422754597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR0401MB0974;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0401MB0974;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0401MB0974;4:eXVNxi9Ani1410joMONBABw57VTeXAHpRLy3I1l3FvAGeMfN7p7VxborzGwhahHreBywwzNoRJLFTrXlf5fPuuCBs1mZk8xZzCWJ4hla4bs4k6sj8CzauEX6fAucUsGF7rUi6VaBy+fdqVFhnkQvD441cASZTK/KkxDQ1/lgrcO8kFE/Wb/hB2IOxe6VkkMqm5Lt8341cwwFE3fVKDrwL/mF56wYi+UMNSBCq+uJVbh+Tm3iJfnbHEisIik7o6XNGgIBLSy9zP1oVgmY9pf3WMQvd3ZD791qjMW0AQk9S0dwlzbaZtUiI5dcdkb74ASnGV8UmnUEQ2LdgvNFn3jo6QWtgFo/H9hYZ+Oe7ld2y0kAH1e9G12FqvwdE1oNoBuggCzGCyrUVzLgHGDyKcXSLEcsud9Dq9IlU8jwtZRL9TZvvAs9wYa9ylRdwhl8pReF
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA0MDFNQjA5NzQ7MjM6Y3V4WUpJVXRkSTNFb2J1UUxKb3JCQkdI?=
 =?utf-8?B?Nzl6Y0UrWFhlR29RZTBrRUZYYnZBazFVZXh0ZFBRbmUyQUI5bGcwZGM1SDM1?=
 =?utf-8?B?OXVPMFhNMXFQaFVOcm1MYzdiZ3F2c0t5d0NTKzlOdXF2ZUNVd3JKL0R6bmRU?=
 =?utf-8?B?Y01NbmxLelY2T05GTzVFenVZbUhiKzFJdlZkenlCU3NuM0tSR3EvTHpHSXVV?=
 =?utf-8?B?T2lSV20zd2hGUlFxQnlxb3c2a0UrUXJlTHlhQ2RhNjdFU1A1c20vcGJzUk44?=
 =?utf-8?B?MXQ0ZE5SOSs4ajRhcUR0ODNiQzdSV1FFSjlvY0Zmd1p2UzhRM25UMTg3eHhr?=
 =?utf-8?B?OWZ1cFNVWUlIdk9YcnJNSzE4OExNMXZwc2pvL0htb1U4cXFnQkd4SUljYWVt?=
 =?utf-8?B?bGFVRjRyYmx4SEl5S1ZER2gvcHcxOFJTYWVGbXJ4UGlLZXRSSkErOG4zbkpH?=
 =?utf-8?B?Tll2Snh2WEdQSTk4WnZtZHVMWE9VWGZuRisxR054Ui9ucEpFUlMvMkd2aHM4?=
 =?utf-8?B?VHlEMzBCRXZsY2RLdzRONG1sYTdoemp4TXd6MysvTE82S0lPc3Fna3l6bUNU?=
 =?utf-8?B?ejI5clZ4d29jZzgvTmpEWDgzN0RnOWxPVFVQamhOUFBxVkcrL0JidWdGZlFj?=
 =?utf-8?B?ekZ2d2hlemFLT0lldjEwcmNlaEhhcDhWOVgrTUhZQWVHVFlBcVh0VmlPVUl0?=
 =?utf-8?B?UDJjQVpiMVY5MHg2RDBUNVZSeXhrZ3JDMnRiWGVlNkVxQ2ZXZEtGSWNVSFAy?=
 =?utf-8?B?MExsVXlIVGQ3SDVOTVNwZ1pVUkpCcm9qTXovcTdmVFBtTFphQXZlVTJuaXgw?=
 =?utf-8?B?TGIxVEZvVGdReUFOVHBjbk5hcGNOVitIdnBCdmh0SkQyRXFNZUt5dWVYYkNJ?=
 =?utf-8?B?MVp4UW5VdElpRXNFUWtPV1NwT1VCRmZTOFp5WDVrOWM5OFJER0NMazhPMHQr?=
 =?utf-8?B?ZE9DOFZjMllpMGkrV0JqTEg3WTZFVDY4YkYyT1U3emdTcE5ERkMwZjNBY3d4?=
 =?utf-8?B?NVN5aUZOS1AzVko3eUxBWkcxL2JrVThPU3lIOExEUFFXUnlJdWtzd3NTYm9l?=
 =?utf-8?B?T1lEa0l4aW9MZ1doUURicFJucE1HekMwYnhnZXpybEFDRDhXdG9HMFh6RFNW?=
 =?utf-8?B?UjBDSnJON0tLblFlOTJFMGxXUExGMUJ2dm1TWlVTQ2VWNk5RZlQzZ2ozak9F?=
 =?utf-8?B?Z3FPTU1GWm8wQnBQRkRNYlIvamlaOXNVOGpLTTlMOCtZRFJFZkVHUzlmSFp2?=
 =?utf-8?B?cW9ISWVLM29QZ2dRNXMwb0plc0lwQmhvVmVxd2R4bnJkY3Rsa2VQZXFEWHZ0?=
 =?utf-8?B?YXIxR1RYa25XQWVWQVZlczZwUExHd0Z5MDkwMVFhOGRjczlzU0lLdjJ4UFBy?=
 =?utf-8?B?WmN5cnZBMUNxUGVoWXFQWmJxaTRhMW5TWi9JZHhGN1FJMEYvMTIwZ04rOSs0?=
 =?utf-8?B?UUY1c2tGN2k3RVRCSjFkN1hsTEUxYmtKdFVPYVNMSjQ2ZTR0OTE3ODI0emFW?=
 =?utf-8?B?RkNPcWV3VEdjcjFMQVN0RUpnYVJmWkpTc3dKTE8wTXhHeHNRMk1xOW1LWFVC?=
 =?utf-8?B?VFdMUlpISnFrTjNJOEprTTQyb0lwU1V3TVprbUpRRDlIZUdmbWdHNGx4b2dh?=
 =?utf-8?B?RkxGcG9pZEloQlgyS2JQcTV6aEtmaG5CWThGMWc5bHNTamxtYzRrQUJQR0tz?=
 =?utf-8?B?aDllYWcvaWNTTXRDMStnRVB1VE9uL1NYdFhzbDhvRm9FT0dVV3Fya3V5TUJG?=
 =?utf-8?B?T0w3c2pQQ2tvdDg5Q0J0OWlBPT0=?=
X-Microsoft-Antispam-Message-Info: OrCHNZS4cXqBxiPfEaHC/yh4u6Cs2/SLVSnYlcJGmPBlcaW9D+CgKb1jOeT/+qCh5BrwOvE4RYkSG0iWmxHX4oMg7QlRCQyUrycyJOQNMQJQedIRerIcGQGyPKcFaIGb5vXsEpVvZGqI50xk93aXvfbJq3uA88vWZ19LG26669i3OycaNBlJ0wVqlSZ3AjmW
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0401MB0974;6:3+5eQyl79qJv0At7COo2fljpADyjKkCcCZsgrORHyZXN95TMsXxpsB6VXcLhe607Sm6IG65xN2c1zMkgcQqoHAPhfzma1a/yv9/hMA49ze99+5No5Z83LK6A16KkZHsh61vAFSrSkXDtKpa+xOpAy3K5QuA8frDNIrWnzH1Oed6RmKg5XA3fJOO9z8q86DQilgKPmHsRtp4ywjfjEELC7ioePYy+2H2nEi0AX/1nRoNd8N0OD/y+WABWMRbp0QZmwbn6smODDnGHLO1heUD1DPZuFCE7bkO61oqjrBVVIbJCYV+mXpv+drPq5gvUxc9sHJfwVYJp49cEBCjDL1SW9xJfo0rrdwW4beqdzAi5QGTjNkQRoDWMtvmvSuA/87/6F9/IEPzO0XctU5zV6SlXmh8tqAhGS7uzeV/BRb7bSGGxt0XmuqfZwERhretzSK8ZboRuMUwbqcc3vPOQkHYWwA==;5:9VhhiJRrP3n4sj4aYSDz+a/sA2AhsUpaGfe2aQoxHRhGNerF+3UZnIobFhquoc/PFagp6J9Q9T3h61lnkVjNg5oWvEfjvnqtLOzUulWI9FaU7NRR+2Aq0H9QP3VZ5A/iX4XeKrV+Dgjg3S55WGSC44xlVbMD+4frL0Dy72ZLtBw=;24:MH7w0NOtyw0tg6bFKTmMsMbf5oqQXFm1yyE+J2+UIhMevU+uGsP+kay+KC4g5dDV1PS9M5YQEFiFyG44WETqhJ/WFyNWhnmf3W7PL0OyMjo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0401MB0974;7:LRzCC3YCzu5/rngMKsK4j2QxkPKQ19At8GoAG30Of/+NNjTea4aCzvxF0df+DXlL6W6a3FyB2pQyC89I/LmuWQXIdOlpNQTRzgUBaJCxGMuW4sleCFf2VvKTroGcyRNdL1zvoEkOnFDr4QI782tKxRUV0yte7zXQwbdtyfKXgxRpJyJtP4ppdvX3g7CA7CLNh+eIeATvi8Gxos45VKqdLEiHwMIgW9H3KGxeGr3RtLnibXuSygPwyClrgz3GYarj
X-OriginatorOrg: einstein.yu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 19:33:18.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e647de-a560-4158-93b0-08d590f4ee22
X-MS-Exchange-CrossTenant-Id: 04c70eb4-8f26-4807-9934-e02e89266ad0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=04c70eb4-8f26-4807-9934-e02e89266ad0;Ip=[129.98.127.170];Helo=[smtp.einstein.yu.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0401MB0974
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NJXTZB005751

Oh, cool. Thank you. I would have never found this.

﻿-----Original Message-----
From: Gabriel C <nix.or.die@gmail.com>
Date: Friday, March 23, 2018 at 12:08
To: Willy Tarreau <w@1wt.eu>
Cc: Maurice R Volaski <maurice.volaski@einstein.yu.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Did kernel 3.11 never work?

    2018-03-23 16:50 GMT+01:00 Gabriel C <nix.or.die@gmail.com>:
    ...
    > Maybe have a look there ?
    > https://github.com/rapier1
    >
    
    Latest kernel there is an 4.10
    https://github.com/rapier1/web10g/releases/tag/kis-0.12-4.10
    
