Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeEOKO7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:14:59 -0400
Received: from mail-bn3nam01on0049.outbound.protection.outlook.com ([104.47.33.49]:41349
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752379AbeEOKO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:14:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 18:14:07 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: berlin*-dts: use SPDX-License-Identifier for
 berlin based board
Message-ID: <20180515181407.1848452b@xhacker.debian>
In-Reply-To: <20180515181216.6d82f7fc@xhacker.debian>
References: <20180515181216.6d82f7fc@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0182.jpnprd01.prod.outlook.com (2603:1096:402::34)
 To DM5PR03MB2635.namprd03.prod.outlook.com (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:zySQUoXIKtXhBjFWIoNNkuhwN1FSymHyk8zyQfm2z/ZgsnA0UwCzTqyQTireDzgX7J5lKREiI59nlzLJxmBXf76ms1s02neqY0i/orY07OdQMDMBhKMCVPmFngJGEJIvkAsHxsiqjsRGhlpEDTiJrZHiG46TSoYdAOgisfWj+UwmOZWpUz9SzJnK+DguYZMeJpiNatqMg3GhLhODrKhcvgoK8P/DZEQAyOWni1ufveiAaS9mJrhU+PfAtA+AI1zb;25:L22MsrZLKRFVkj/hnjPuaw0TkzlexLnK6A/c1gcOmzS++1b7qRBqhx4SvxXM8U+yT+DKLp1Rw/7cWtp+c8/nLELw1KfYWlwXTrd8iHSHfBwaKnGGlSvs4QcYxI6cKNHzGv0sMjwD1smARNSfupgiqyDepNsB4I82SnmE7nZrMTeVbcDp+RdB7oD5afeuZcjzsMVm7bktZw3PXyzvNFu4PRli69Wo5mHWeKmmoAb1Aoe1bJOZVK4jcGQyhJNV0v01Ga0bbbfRCHr5McSrp4mcHKKCenqsKdSM5sfXIDnA1BowhQCzbyqP6qO4a12qDvsRv8/zMsqUcUujP1ebYJMRSg==;31:m7E4eNEi9AWY9gp6eMpC/GdZpdI0b1LUyd3hrkIik5asHYdCM2QycEWeX9hFrgRJ9v0UajZMU8KZvVrMMIsrjyCaP1C3VjwQvWVFjVDkQTWH+1KAcxAgx3sy2rYsok5ZDn1tofw6u/6Wmmv7PnwrJxSg/fI7Cwq9/ziOEq0y2HNJbfRiV5OMMNahViX5Xrd0ygbf/LVZCgVxUje3pB348jsJXnisaopmCUYj1Qz9uF0=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:MZpuMOrPLvctDf/xNDgFFLXuxAlyL/DVbVFqT3q3PvuCsere1t5lq9bBf3Lj0BtOpwUA99VZLIC3g7Sqc2pgaEL9MSmO9GVQnNbl3k99/p44RsdELZs076oLL9sbsYQynRDAIm0CkEzNJZHt1gKNQ2JJ9UAA6i6UKuOq6HzaMQSH/RarXPVpkWUO3YEGrTOWe5x+YbAlxM80qTV4GTQx1jMylGk5MMwKXTqqdpHjJyzM14uiMrG+ed2X8AJwURnaNWtxT/5nM7qyWXMYjSxE5FRvM2sU0ZRE7lqyB+nAPIHTePaSRCtyVv9Y3koDQz5s0I2H+pcRn3lcEoz/y+re7QguJH2td5VdMQh/kBRJ2P9L+JHhp9PF0JSsHfjj5+QqYlv7y75/YAP1oYbdEpkoxaxzz7h8DK7hlJ7RjJ+2BOkZtT8DJaKSvm76RuKb4WHTEEMJEtNrGeqCkrjI11bDoq3sKLN/d6J8qni8wy+vZR4icC5HnOUXbDxy1L1StTBK;4:H/cdXQMxAn+97FwGkRB/owCxaU7cZMCgOnXPcUfy10/bsbmTc3hEY3XC17P/w5gn9JlDaY5uC+IRfswsn7zsO5NcNimjamAh+5QpPZqWZOVI6iaWdekzZfwxujUrPWC7bdVJmTSIgph0HYZ7JtZK1P3EfMogeYNeVzIvhvJMwty19lGi0J3SW5FZRCG6WWU7Spq1yePpg0V8HcXIGzoSoSQzDn/tRW0ZpO/pU45u0Z+RkGfyLbRJAm+bhmknZ+9wcF+sn6mwXQjk/Gw2bpiTFhQDyIXYXkE4atnBVeEsDaWDBbxinBN5v5u+DonBpWU0UpzXZv0s+k5wDBO1ZyqBzUZRMdeGGpSoYPydzsFVf5k=
X-Microsoft-Antispam-PRVS: <DM5PR03MB2635458275CC07FA3415AE2DED930@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(58145275503218);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(6116002)(386003)(6506007)(97736004)(59450400001)(7696005)(53936002)(55016002)(6306002)(47776003)(316002)(110136005)(9686003)(33896004)(72206003)(476003)(966005)(3846002)(1076002)(575784001)(52116002)(478600001)(956004)(446003)(11346002)(86362001)(26005)(16526019)(76176011)(486006)(186003)(23676004)(81166006)(8746002)(81156014)(7736002)(8676002)(8936002)(4326008)(2906002)(6666003)(106356001)(25786009)(5660300001)(39060400002)(68736007)(66066001)(50466002)(50226002)(305945005)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIyNjM1OzIzOlhtcXRxTEY5dzJwUDM0QWlNT00xMmVRWVkz?=
 =?utf-8?B?Tm5GUmZVUWliY3pQN1laa1MvZVEzOVRhOVhZUXVKbk9PeVZyc1lNc0tMTCtU?=
 =?utf-8?B?cG5GcmxOcjV1U0hhaGNFam1rVW5SZDl6R1l0bXI5cFdaenh2Y21BQm9EMEwy?=
 =?utf-8?B?SFZ4NjRIUEtieHRBSVJ5S0licEoxRzB4RER6RERHanpvNmJXMXNKVXlBV3ll?=
 =?utf-8?B?UUlnVGo2QXo3KzdPUGlvdjBWbGdPOXBWcUtEdGNUcWh6aTNhekF5YkpwWHc2?=
 =?utf-8?B?ek5wWWJQbkg5WUUyOFlkRERMMDlYV2J0YzRvWmcrblNTNSs1eEFTbFE2OTZ2?=
 =?utf-8?B?aC9RdWwyaWtYTTFhY091UzMzUjNHbFdXOWtmamovcUpMZDJmQVJDT2JNcGti?=
 =?utf-8?B?d1prUEZQQmxzZm5nbFRxVTN2NkRqVjRna0ZteXlVSGRnWE5VdUNWUGI1K2pD?=
 =?utf-8?B?dWh0VGFZaW0vVlV4R1pBSnI3NjRhZE9MUVN1dEZ2UmdpNHRxU2poZjNXcEpn?=
 =?utf-8?B?SVNZYmszUzhCMlRjTjlQcUp2R3E2RGoxZ0NDeXdMUmtVeVNFdENzYkp6NS9P?=
 =?utf-8?B?OEhzdzJpT0ROVndvNVFEUTZWOFczRkQ0dk1rNnE0YkV4UUxpM2NnajgzNGpq?=
 =?utf-8?B?dlhNUkFuK09sLzFURDNHSlRHMmtqV0xRcG1xSW1FTmVrYzh3dy9FSWxYbTQ1?=
 =?utf-8?B?OVhra3Y3NkJXVmVoakNnWUh6TzkrUEdjMHlEa09QYmpFYW9FT3lLZ3I4VVV3?=
 =?utf-8?B?azFZdEM4NWR5Wm9oSXZmekZQUm8vQ1I0R2p5S2FIdFlNZ2FvallvSjNDY2NP?=
 =?utf-8?B?WFJ6c2tSdjdxbGlpekxvRnU5dG40Z0xkTW1yTWNtcWEzTUttUldacmJVK2s0?=
 =?utf-8?B?c25pZWxOUERsTmNoZ1NuZGp4cnpvelFsL3doN3ZYdzFhbFhQZmxzVGY4eVFm?=
 =?utf-8?B?azlJRjA2aTNpVElEblpwMDd2aUFGOW00UkdST3B2eW9ZNDY0aWJVZDlPME5j?=
 =?utf-8?B?RXN5cFJCb2gzZXhsaHNIWGE1OWtwWFRQcUNad09makROaHE0Tk41Vmo4dDhD?=
 =?utf-8?B?YnJlTG1qbFFybllMNDM2TW1zU3pjcGMyMkFIVHZobWtDbFlXeS9BcDUvckJY?=
 =?utf-8?B?a2JLQk5JbG9TWDZlNEdpZWFxYmJTVWkvTUFmT3c4dDZYVkxudTFGb0lqMDFE?=
 =?utf-8?B?aUhkNTQ4dVpaOEY3Y1BGdFRTQVM3V1c2WG9hZDljN0JKeWllUDhlTzhFUlFO?=
 =?utf-8?B?cS9UWnV0TWROeEhLNEVUZFk0ZXFuTUJ2T0p6VUVlZHQwUy9Md25ibDNXZWFF?=
 =?utf-8?B?ejV1ekJQRU9sd1dZM2JRN0dKOVBLUi8vVllJY0NQL2JTUUhyeGNiWU14RU9J?=
 =?utf-8?B?VkJURXo0NHczbXBIZVljMzJBTXBYSm5jWURVSk5Pd1pqRnduY2xUNEl5bHNS?=
 =?utf-8?B?VzJXVVB3UGlVcmRoUGhzQlduYlVlS1NWa3hNVUZUL1lScFl2TjlRaElpOUZo?=
 =?utf-8?B?MFUzUFVyNU9SSGJ5ZG90RmdwRGw5VUZTZVBlWlFLZThIcDBYNmxVVlR3WWta?=
 =?utf-8?B?SnhQRlNnQ2Q4Z3BpTDMyS041MFZKamdwL0lxRHd0aEkzQXE4a1I1b1NQbUEy?=
 =?utf-8?B?VU13a3BRUzdrS3ZXVkFsWUZOakhVODNZQU1NbUJWZWU5YTdvUzNyc1N1dkxZ?=
 =?utf-8?B?b0JZUkk5YzYyanhjYWdHRTluYVExQkg0OGJlMWYrMm5RMSsrM21YaTZSbXVB?=
 =?utf-8?B?V2lOWDBtWkl4alVyNzNlbWxtTXY3ZEFwaXFPaW5yTmduRVdSbUZrVGw4WnJx?=
 =?utf-8?Q?CXbwmY7c22msM?=
X-Microsoft-Antispam-Message-Info: QOvoGOz6BUycyYWyXtv+IkS2KW4PpaLG4JE2gD3BACwyf7K4/H2xS5Pwmvt98QUgZNKl5SAU0Ob/IIFXXtqvkfYteK38vUGtrazEdMi0HlYTA80JaI2qw/WrcMrp3rn/ZMHN2cdxe62FHy4m+H/V1LuBGq5Uu2faqmG1u+SMPVKCG3qeRhL4V5lFLSOsjORV
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:6W4Ja86gcZdTItKGr41oeh5vHWu7qWgyoA5tM+sdovdb5iwBRy5UCmStc5cKOaZ4t0bdzr47iPZmDTmZzSd6BAXguh81N2SGQWaCa/90ViS3DaEQJHXbTepD+0ysX3VR5j2jmGTqvThAJ43nEMHuF6eUfyTChSPFerk4ijPXBJvwa6VY+Qza1qEoCqnMQUF59qcfBb9Ai2LO7S3Ee5C95rkl5z5/axcxVXxU2QKF9TnIqhyIAA+2L7X6SGoCnDQ35YV1uo7Nxw9PBb9wvg0rFLm2aZ1X4xbJN+/AmeY0r9Or6wCrfHra2CqBTa7Lov4SadQpRnsxUy9wUE/3o614q+OiHiAoo0J/Nli0A5wxHlkyaVopIsZ2HEERaQc/9muiJRwGD/tv5F7WatI0DA11S/d5q0Wn+4u+PGh8AtcZZtcpqrLHM5vr+82AzuHX3lDv0UZ83h47pYaiH/4jVoGbSg==;5:c0uX9C49XUhA+2yytHowR+WHhwLld7yM9qn9+m/mMnRpL7X2BACc7RsFXQcCSsZP4Jau5IOJq2CKb1qdpEb0/I7yCaJRdw4qIPSf2yL3oYmAKjrvrFKTm74vggS17M9qksXzNho7rDp7ZpxWFgKpZQEvZEvnV8awlR36m9YPxXk=;24:/+LxZdU53adu7+5yLJpdn2VQWbuyYYAju1Zq4v9bA5EO3QJLD1n4JT1+iZ43SVir3qNt+u5VD5cPwXj9/ngYLKh5fyfMZCOclhC10zDPxkg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:XWKErYJ50cnWUC6lzYPFrAlyoZucCXU+JfNhO8c+At5w39gkQlcrpS3yMVe3ceWGz+FY6B2316FxtDpYF7fKLx3tN8Db3vWiYgpw+QVpyx0AtzoHutbr5YSh1traxTiRlzWITBUhIipNe3BlXfoqiPMsI9rEEcD0aMfutT0NLW1VZqN1UFVwx29nlzYpKXHoiwqBn0t2EDGN2ydov/0/dK0AYlIT7umDW0LnAKyjD16EIYUaAvhuz0GoA6KFUdIW
X-MS-Office365-Filtering-Correlation-Id: 6b799398-e935-4a2a-84d2-08d5ba4cb431
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:14:52.7936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b799398-e935-4a2a-84d2-08d5ba4cb431
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FAF4c6010351

Follow the recent trend for the license description, and also fix the
wrongly stated X11 to MIT.

As already pointed on the DT ML, the X11 license text [1] is explicitly
for the X Consortium and has a couple of extra clauses. The MIT
license text [2] is actually what the current DT files claim.

[1] https://spdx.org/licenses/X11.html
[2] https://spdx.org/licenses/MIT.html

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts    | 33 +------------------
 .../boot/dts/berlin2cd-google-chromecast.dts  | 33 +------------------
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts    | 33 +------------------
 3 files changed, 3 insertions(+), 96 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
index 1c475796d17f..64a297759eb9 100644
--- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
+++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
@@ -1,39 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree file for Sony NSZ-GS7
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2. This program is licensed "as is" without any
- *     warranty of any kind, whether express or implied.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index ca24def0ce13..540115172d3a 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -1,39 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree file for Google Chromecast
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2. This program is licensed "as is" without any
- *     warranty of any kind, whether express or implied.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 57aa5f8a7c77..c162f98cb8e8 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -1,37 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2014 Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2. This program is licensed "as is" without any
- *     warranty of any kind, whether express or implied.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
-- 
2.17.0
