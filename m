Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeDKLwf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:52:35 -0400
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:18493
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751819AbeDKLw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:52:28 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 2/7] iio:dac:ad5686: Change license description
Date: Wed, 11 Apr 2018 14:52:12 +0300
Message-ID: <1523447532-13170-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
References: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(26005)(336012)(426003)(106466001)(126002)(476003)(2616005)(72206003)(4326008)(446003)(486006)(11346002)(478600001)(2906002)(2201001)(47776003)(49486002)(59450400001)(76176011)(6666003)(7696005)(51416003)(8936002)(106002)(110136005)(54906003)(16586007)(48376002)(36756003)(8666007)(50466002)(50226002)(305945005)(7636002)(356003)(316002)(5660300001)(77096007)(246002)(107886003)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2482;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD007;1:HKGEXqFhwz6CeFiNc3xRCgG8dQ4+HQXokHlRF/0akwVNWVp8J95Yhafg1TRCAkqxb0Aoj0yABRB/5nPifRXFV/dHwfnb0MKJosNfzYP+OAKlqDvLQ7Aj721ZuMmD22WY
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB2482;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;3:Z5e/CYFAM84+p7Ik+cwUlYf7KDSY/5G0ss4j6YuDCuYWbEuP6I5oYZixUXBXEeoOzGhEMJcXlEacs4QCS/t5X0f27peLqQaVuIP4XaV4zhpIZNCkVg3dpWuQxQjewi2PSW1aJUPj1lUwgszPZQIiIQiasCNz34+26EPLAlEmdduQ4/0r53E+rKqTR1H6JSQruXHuaxm75fg5nV/23UBMIof1/S/FDk43YNLKhAmTiNLWHTb4BpwsPZHnxI+3oG6lT7TmfhWm/uotkti/mGD0Wi60NgmzfqI5hPY8w5nIh1rrdBtKERH0XGJ4a/nKPYvdV6ncqeJ+1y+Sj0/VbnFePg==;25:aU5NJYP+2+spl/7ua2zcCLi1jM1x+XEWNloSYFZqifH0EQBW2HSJN6sm4ccIkSfEI7tEbyNYX3SYf076tDD58NEE78D0vUSvRo+rtP8OIgBEjGmDR8f/bCwvPC8zucFG5l+De7DM9brdEj216/n9yEEqKP3kmY4dze8W/FffXATAVd+DcwV/AUXTQP6ufgfUys9s58kaLiFdpWwPuuXsy9H7hSE+yFc0WakR79IfPHOvdgHglkwwrRN3GIuW/UsE+p1SAEH22G5S4IZ38g4095YBxDTpBzqRu2D1l2e6dkGngfvIet8gfSuswXou7wBLe4J//m8KK1mRm3ps2pl36A==;31:7UZgMGIkUWx3vmlq1mCuWbaCetpQpm6y0oZjMiLHi/wEK2CelAJESEaePc/8de1F0GElz+pyYh0B5XAgVBxEJ7hPtZlnbaPvvMELPL4MSLzn+OpcucmSMiC9GUbW1JCI7JAsfkh8iP6Y62+96qxQ2hjZ+gWh9rOh+gUPuNfQkd2WJSB6vJPgykuKlNJVK+BJwI3AfmfHPDBBmUIOofrNlkamdHrFcUO3evuvykaypkw=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2482:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;20:e+wz+uZtstWzcKwmlYe+LO4gJALi1RHEweP4F3vlBB3/eJd/wemTGrtoNrnqanSUw6su022JVDvztPDMWUfSynNf69zhUfi7bFa5VHiJ3W8vgAz2hAfzYoKAPfQbAUyn8TOc139GmOJYGzN1ViZZja+PzJoCjTOCWgERowy7h0iF5qG0Gy0VC212RJ4IAL1w40QiUX+oVGquI9SWlxnwtrDjHhqyM5cB5/rs1zUXkFac5JD1UQcq4nDJF9TobYKyw4c3hVJfueakQBT4lVLqx81OeIULN3D2Si3kVetHSOs5VhuoktozLgFrKrneCzvesu8646ItauvTgc+HKQV5wH4ftEZZ+JrMba2jtrT3nT6e3cXtARIHrzd9NYPo27Vm3qtCIwixoOl/vVKvpc6sf3QCq79UQMZzDQyIMDt8uXYFO8DmT2y1096qpUYvftPzO3zqtpmK8omyYaclNie5iVztkIVkVuFaue/xV+b43a0khM/0UOWikjw/1V6SSD7h;4:DGAlKpItBZUOaq06z/ev3j8VxNI12JA9hcDnko+90V4tNHP2Q4xSiLTbpwIKGabkXRXVpNE48s04WchKjzcJVdgdv5KU51rhmb7dlD0xTkbwzxaHhHryos2mHCI9zWaz9aXBdWAzrhkOzSPOwPvcDba0x6QyfCkxv/IAERU/Mm2JD1AZWZebJu2GIs5tcXOUGSUihRJr8dxVH9bZ7ZUZ1UL5lSdjWQ+H+B6WrLIe7832vyZXDBEOc2J1VBPCpPUNZEg1F7mnQkH16mtxxtTXdrOkUok49xQ4ulNdSG1msWaYQbqcYFXethZvYPNV1K6Y
X-Microsoft-Antispam-PRVS: <BN6PR03MB248236F30574AF6EE8ED9E5D9DBD0@BN6PR03MB2482.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR03MB2482;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2482;
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2482;23:MrApWbthFqGdGs08+vpzLKgTsecFglQ0RK8fe02nx?=
 =?us-ascii?Q?u7u5zbdGayXWV/8OCdq4GLTX9h0vX5MJrlkb3pBsV+Rwx0cUC3gF2OFt5vtu?=
 =?us-ascii?Q?gdAD9mWm7zhHg3TRZTB8EF+Zj2yaHUagofknlCw8/ZoXaxkyO5aCytjUPht6?=
 =?us-ascii?Q?w1drLZXyRLzmJ27STgqWpOhMPSTF3m68+VNz83PHJXqmmtjjLfDOEulqVNa0?=
 =?us-ascii?Q?uEeYqsCfASIaqbzv4jrAK3Wu5pWNbr3TfUiXYfCQIeRdZkIW9BKn40sEk/1o?=
 =?us-ascii?Q?6AGuf1G3M1NtimUl/J+23HYMuEPM/Geeye0cZeqv1m2YI+/fE4ihrDBt8/DQ?=
 =?us-ascii?Q?TkdiJI7EVTAEaUAenQXum89FdZEkDcwHTLWYjbrmwyAEET67W4Ctr8fE+Lni?=
 =?us-ascii?Q?noTtfjcrGiaVGmznKCoy0bCWTZNeKnr61DuL63KkgXv4DRKKZ3kULhyMoOUA?=
 =?us-ascii?Q?nTPT1qp+9MbXfee+LGCuE3thE+WyfcvBflandaNqjxI8Tmb0dezp7DhH2U+R?=
 =?us-ascii?Q?hDN8SaGEFITNUZGvs/rGtNd2q+rWkvrErSQgYUuFSYlSttJI9zyc+Zlj208O?=
 =?us-ascii?Q?hN+rDlM7ImjTH1b46XGpPP8Mx13oGq/01YVruwslXIKNNFUtcOA3nJVYPFWW?=
 =?us-ascii?Q?08p1MiRVZM7hjJ2G49PD+jpCgDPpb9DSKweR3yGL7DkJUlj0ODrQfV5n5VLl?=
 =?us-ascii?Q?XpbPhVmircIP0jyLUwjiR+d0ZN/xyTucqEYk2/+ByHmunR/c861tVx8OHhgP?=
 =?us-ascii?Q?ErZbLstFIff/9tIif+nzre30yKto2PQ7ZkbRmdA+2yjE0UXDAkduRRxf7+Ev?=
 =?us-ascii?Q?NxxiGIBVhUUG1HS4/m2ODU7H0IUeSNMwgrbhC6qVbPhOVCB8xQGclLh+mn9E?=
 =?us-ascii?Q?EegoEo1AArlffCDB9fOBmcJ14ZlWiqDRd2OtWqYsASE1OvLGohloO7PfWO0C?=
 =?us-ascii?Q?IR/Cs6zNflFOD7+2uI/i4BQkAtgzapMdTvsnnYXmah6Mzzq8NglL9vZ1dIRy?=
 =?us-ascii?Q?JRWOWAyVA5ILt62wTWcecQ73cEf/ZMkqCWmC4uKs8ELtOgL3Ze/2xaWyNc5+?=
 =?us-ascii?Q?sJh99D4Q9wdyqFR2eQguAscC0SJrGVVufGdWTo2eOWiwxlotFjGuabCayPrr?=
 =?us-ascii?Q?VYTj5tFqxQeGPGRxTdigfrq8hAqB9yn?=
X-Microsoft-Antispam-Message-Info: V4XtCyE6cJEq7xKFCLlx4Q70JdKmzqBM3RZTA4AhOB9bpKqwpxRY0OnN0g/ACeJX/GXAFpTsqUkYbFd2tLfTLIoDOrT1Y67RREWx6ZBmWzuhTKB5NycdTc6yya58cR+H27V6lM3JoFTG6IEkU4XddRMU8gDCBlsbuuIN/blBpSSnk6tVTV27KUAByFGxYtkx
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;6:nv1W8qUeC99I7tMGYcWexrEazN2T2h9yJZJc5dXmyWxrfX0T15KTrRvcmXLXjxIf82gLPdpL3AY64iqzSCa4YSfLFuCy7CBxPhL+wLhwWsoaJMaqM1RWCtl6qKSN/1r32SHZHrfu3eea7mvxr+VfO69lqfgSDfNOiNjrhFzxdltMByXrBqOVqmTnskkyMS9d/Lpp2qZtjCEoUIvlZcXefU2yvazLV9qCeHsPEr9gttMexrJjWusqBHq0o8zrzrFurIu0ECuaoIBpWHhWqnuhN44lDx+Du+nvmVBQWmYsrVgpt2ZWmnnlMdkUYJ775jtsuZJCGXWf6orAe6NuEY923MqEc1mE10Ky4v6Ld5un3WRc5BITvZiT+2VSkeuwdE18nQ7xB8Q9TnnEnc0Yav0fU/qi2qw0SaXaMfn38/V+jqTvbRM/kycuhgDuVVwc8/LTQnWL/X31q/wTpcC1+cAHvA==;5:WD/DgqpGswls76G7y62YFYsoQeisvnCwcn+KCHVwBDLHdfRd1dPxZkhWSriw4m8Lsogu92qOUmFAIHhtmO0NclqIgr5Ps0vFavbCMBbMnQZkXQwMKVIapPTV/DVIr9B2Bz29AwKt7pZzU/kC5/UvoOqJRw6pfqe/q6MPfcgh+UE=;24:k4YFcgl/GPCcqWsPUNYxXUvSRpmvhsHS4sYpAfZGM3TMx7uXJChvKOdRiHFBxnRqEcdIiFZALUmi0OB5PXazeOjcC755LZFiwXlUWYZIbDg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;7:w4i2OQHSfS6ldaOtf1rggXTZ/6/IeZHDwzv66GppzIzs9ZYcRxa6SCDmccmed8pP5Xj4Gr72YzaRWdo2YUgJ9k09Mb9IfRcy5kJmxDLuupf/WfZIOnBRyZ/0EI1+NpkMcE0Yw5GSvLzwjCgOYhIErWbBoAUavJkVJInbiC9EBzlubOTXpTusmokfAYUo4HW4R8zIUEVD6q8WIDM7VBToIjWk0HFbWxpJ3M0top5MN8tPDO9Vi6m+tkMHAYH/HDTd
X-MS-Office365-Filtering-Correlation-Id: a3cac988-e12e-4fc7-ea29-08d59fa2b1a3
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:52:25.5529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cac988-e12e-4fc7-ea29-08d59fa2b1a3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2482
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPLv2+ SPDX identifier and remove license notice to keep the whole
purpose of using an SPDx id.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v3:
	- Created a new patch to use the SPDx identifier

 drivers/iio/dac/ad5686.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index f7f975c..e328513 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
-- 
2.7.4
