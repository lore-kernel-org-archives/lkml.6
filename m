Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934405AbeEYEm0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:42:26 -0400
Received: from mail-bn3nam01on0121.outbound.protection.outlook.com ([104.47.33.121]:51376
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752852AbeEYEmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:42:20 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, <claudiu.manoil@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 4/5] dt-bindings: ptp: add ptp-qoriq.txt
Date: Fri, 25 May 2018 12:40:37 +0800
Message-ID: <20180525044038.37756-4-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180525044038.37756-1-yangbo.lu@nxp.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(7966004)(346002)(39380400002)(376002)(39860400002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(8936002)(48376002)(106466001)(36756003)(53936002)(356003)(39060400002)(2616005)(2201001)(85426001)(11346002)(76176011)(4326008)(8656006)(105606002)(446003)(476003)(50226002)(77096007)(50466002)(126002)(305945005)(97736004)(508600001)(316002)(16586007)(486006)(26005)(110136005)(2906002)(51416003)(44832011)(81166006)(336012)(81156014)(6666003)(1076002)(47776003)(5660300001)(86362001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR03MB399;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD023;1:UfrRkNZbY0eHYhUciBprSBxYFKGxW+FR3H4UfTrzgxGBo9O6ewidoWca42F5zU85JGqvBXCBdXHF+SqVAo1zGOokIctJUNgawB2pBhJQUOLsl98x5dy7i4JnKJDqHfNu
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:DM2PR03MB399;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;3:OmkkmjmqcTebEWwX9PE827p3MVwxP9R6P++/JHnkqFrmMyH/q/EH9y9oYasT6EgX4IuYOygenc3pH6v8+SzsvC0v47K1RoX8YEjRCCC5dS5dKXbZuLhFUUONI/vH9HKDru8SES8qc3FzksKPnx+8HKkfy+7Z3k+Z8MJGdZfYZXXJ6PlF5xaNbSu/QssKJiTkk23i4Fb90bbMJnJGgTlsMyEMawnNJcEJD759vIYLC6lHaTMteDV16QvdMGo7LvqE4brqr1EDwLRP+JULoHhG0qeqDzAedTbBPZ8eGNrXEZQ4piQclgBZ6q4tcvOSezh4CdvhFhm6pye/xJ0DnoZX0r9DOcV+y1rfa8cejHJpNzw=;25:V5j9niROpot8KGcWZz6M846TQx1FwJ5zquKa8E/FLirjNB2YJu1/hi9hwsPso1CND04sCPYl6NBmdYQTjB590BgeIiVFef8sxpMeR6YSNy/hHebM+nVGyNdFDb4RnVusfWHahTy3bpnGvr4WqhmD6B4z9uHzWsv2OXEW/NDp6dgHMAJVpi9RmOX2ZnHOXk+jIKC3+gFQbSwn5rqqzM6bI6xavG1QMWcUafak5ckWLCOAUtvf1RGpavn5Am/WARWvLWhPpE2ITSm9ah8LchPfdW49YNDaGBbNodjeo5PMRrwydTjiCVvAe+jRaD5gzZdFA0hDERD77Y8enUhQR3Sf8g==
X-MS-TrafficTypeDiagnostic: DM2PR03MB399:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;31:M7eFxEOmZNEpF30bh8PyMibJC4umoFC5GMUfvQNTwWpjuW+/3wDfJT8IUxRqG8lAQLc3wLMfelXlI4CmCouBsKZN0Yn4RLr1wQjg1iXp/jBAKalcxHGnx12LiiPH/j11Yu0pfMeVdl/Hb4IiCSLhygTApnnVnZscBGLF1iEYjsQumF2rH96X05H0x3SyXr4cPLSI5LASX/JNgE67qTG8/bKlXogrl5iPWB7RR+yrtB8=;20:qEpx0nFtosR1as4i0vDsFMOFZ+Ova+dI/KgLKxgCuPBaii5VPYnJbe5HY8DTF3V0wTXMgP//v8HGJvN7rMaJfUQXR++07U5OnKIsqBkgPCAfhKZP9Ege7aaw46wBunGyo3/R+p6P5cMlsUv6p5+h64U0/u5+vcjzTm749XPcAwqY1BljNfB8txmTE8Blt1Ya3ALlo6cINYuQVu49LAa1zEd+/QsosgjHLWRAeYVIOkXvwSgAhGHBm9HSQYoKfdBzvuqy/0sjAeqL+reUTMAlpXQi6cjkvjpgXgp4QgKBSsuMc/fACpb8vMWxI9cU5IEjYrpHbt5X2jIssR1wyCZ2f4kIjjh2QWFkBq/rDqlkZGj/fTYs4xbE8UqqrAow4N6rmQBTZ4Bkyw3UwntTFlW1TST00xCI79m8glzhUQhJ2Mtzrqc3VEwIusph9Qyurj1Y0UGHF6U5vJwSTgZaY4KNBQwFZmJDX2eUDnpu9OK0cihA0P8JQoOIYLlOvicWKr9U9y58DRPPLd4TGFL7amzgZcZi0dBL8Q1Zbu9QyGq0RTxmDkWPSx2oght8fDzcOlXEyoQTqvL6Xyk6KQOJYzCQcPOtHTlpwqQFK1wKs3WKb7I=
X-Microsoft-Antispam-PRVS: <DM2PR03MB399D06F0B88279C51828CAFF8690@DM2PR03MB399.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB399;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB399;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;4:borz6uKaDqRCiYl11ujEfpl0ahFxZXapFBbPsZw8LpTBG94dGfTsmwsHWlNpq7HuH1EoUQIGNK/AvHLzi7pla3zCGiDg0XTLtWEoB1EE2H3b5a6RXvusFAvKzUktZdVlVX1d7Jjgq16MMtM6AQcbYTiVqXFgb3OX6XMlMeuBsvYA+kyLC1w+9FiOsIqTQ3jgR3NiFKr7Azq7MgUjoCWKe6Idkk/X8JAnqWNoF0HXI7Rlytn74YvKjDue+eKxXKR99DjhJR4ntfs8Ps7Wf9kUqOwBwGoOvlwl1n6fUeP3Eo0FeHZAjCD136x5JWQspDcW
X-Forefront-PRVS: 06833C6A67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB399;23:GKlx6sH/xOyyARdU2NSX/65ObtPJ5dGpSHKuj0tnIi?=
 =?us-ascii?Q?sepMsZrt0mt68ctRTjEuJQzsldhZ0NljYC8hcrT6sGedAzDG4wVMt+ACt6hV?=
 =?us-ascii?Q?KYsdF9564Vq3f0UES84yclgA3S/ec4Z5db2USi4HQNI69kyfVBe4Ivf5aEaG?=
 =?us-ascii?Q?H8+MOW9vbFXRNEkyBT/DBICqVDMN+QbBEBzI3ET/BJ/V520Xru2w5RMjy+U4?=
 =?us-ascii?Q?gmotamAeOtIo5Az9w1nrjUQ/nbc0nBSEh0g9aZIEcrE3Qdwaf3viU31kPNzl?=
 =?us-ascii?Q?EtcgT/IBa3LgZIWthkV+3GOQfpB8q76uSerQ4eTEFpDfFvxbdBBpTyhJImZv?=
 =?us-ascii?Q?Qffdsc4alqwQwbNzYen++S1/JGvXbSq3YOd1G532XB25locwWmsH8Cz8VjOi?=
 =?us-ascii?Q?ziNpE+OBBqz6D31dKZcQuSdwkaZ/VUX91yzNNzlztwyE9yNWTcn0nyk+XqGI?=
 =?us-ascii?Q?tdV7OQ55ROGDQPyBPzcDWsLjtU3CFqqeKnSS3um8iQEkqhGWT1ijwsTTCcdp?=
 =?us-ascii?Q?gxvSfHvZAB6lWKr7J4KsnVP/V2WUaBhQgLomNT/hRGP0TRSA709IgZiVncPw?=
 =?us-ascii?Q?LxO4hP6zU4EEkJUHv1Q+LmdqINWPf8MtJDd4afKVSx17T1lWTzrIp95X5eS4?=
 =?us-ascii?Q?KW2LvUaV+LZLuzj4ZXNQuYfm6NCZtsBcGtD5MG+PRekD4pHMgkfcULmgJ/UU?=
 =?us-ascii?Q?fxWelhL/VEEnY9pQhVGyeu1VQbe3efNuqEGypY5ax/dRQbjwgM4/UkV/TOKM?=
 =?us-ascii?Q?fq+gREeLxDTsHQpTNRH4QRXhQa+07gfhI14VSnqBatcr6HDjbFGmNKdczjSD?=
 =?us-ascii?Q?xfes2rWk9YV8tEIYOdYeCkGRYkdilPJuvMbU/IOaNnXUEUhYfrp9P2We2JlJ?=
 =?us-ascii?Q?AQiqSEoMKsjgHhnZxcz3Ng3l4DEqcuyowndGSjam+dDr3lObMGC3CCvyiq42?=
 =?us-ascii?Q?AXGQbYprGii18NDzf5jaaCXFkLIYWQj2wm3POKOiJKJJgjM3ilqnSXG99m6l?=
 =?us-ascii?Q?0UYrTluBX+gTTbpf/XavZ8Bc4Z9W+M9D6gi0xHbRVRTbUxurb09JkNd9+OmK?=
 =?us-ascii?Q?+tiV5N0Frb5bhxfm9HUsm12SNavBNp3L7e+yivKx/AGQsQu06ItZz+GjkwVj?=
 =?us-ascii?Q?nNscJb9Jcy7B3pDBoHwf8zuyjNN1GkbR7/fyAVWksUlTXUx4Pw1L4CCTcofY?=
 =?us-ascii?Q?0XKqBdPlBbs5IueyIqGOYCUvmKWq0E61nz?=
X-Microsoft-Antispam-Message-Info: sFDS9kjPDxVu/P57x9cZygGIY+R69TaWqxOnw6pbGdqgfPU82bj+LKxvI18YbKhCPNxdIE9MokVuOVKw+wJv+vHC/8CX619+sk5YHjOFAJ55aUKLD5e1aJZFk2q7SsXf4Y6jCVAf62NonFo9TJDd8DXmNSZGHdObFrJ1PYMwWaQImWw0iI7VZzs+P2/avfe5
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;6:MHZ0CWsPztmuJ62CoofoaxEdjKXwVHpIz8Go/3Azx5G4pqGFIR5j7MlrfBX0uujcUJqARa+8gXLcph2RwW/7X30hS2G0cHDKJ5z53qWD+i0cwRjsvhQ7ybjIR/RaIJv3JPI2t6MrBsgqiYU4sY0WxcKCeebpicjKx63C+niScYM+XlLFzOhA1aOuiE4ejfvlYi146/kYh3SfjQ/YvvlW7AHhAaLrPjyWIqq9aKACgfq2Gly/ekhXsLG4JszngY19s2+J59UQJlrNSA23/3itaHDGu3TSpXYDeYAmEesSkkJynCBoMxoP36YyGNqP8IqI8SrOyutGcVuQKkNZRS77N3Ez6Z/rhA1wyZoQq/B9L9lwuIYcPMSCCNKeN0gmQaYeVY+gsLjKO8HCOPuMnLY4s/9Omr6lNHB0SsfOHg7q8ebwvi3UZp0okgyszdyMuMuLF94kd29FYtLwDy4iFCS7hw==;5:Wuy9FgbT2N6PDbR3Gw4WMoWpylkje0sZLqVmAH3EoS3Ed1Jl57c4zvBIH04AgC0pKFHy2D7FRCFN/q2sbiAJOzfXgvkia3kR+SI917Rv9Y+f83xxmjBYW5QmpTRDo0+jl7KM+X411A46yX/8VA1Xn3GXhg+23GXbtAtxcSMPAGI=;24:s0S/YEXpRMzN/AEZOu7DLR8cb3ral90ual3+xc4F84vQydjVRFhqL5KefAwq7GMsnRk6PtE4svzBN51+iUGq6lQeEjlTPqZuyG9/4POcK4I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;7:yYdMi0l6/BTb5GMePWGX7r1lIIhoojxDvlCV7ZjJnyYr1Br7e1VcVdShjYn7VEEtvt1ndVRY+gagRueHLPUeJBCSKL9KPuocsuOdSOGHkFvPwFo0kHcicAK1tNDLs0FEuktyWitpt2Hem61RNhM03o4ogqJHD3a6ymTK4rr+PlZnzRvnp3b1XesgGamFIZo7F6Cli4BH+phgibrlmltR6oVpCEW91nR8cbl3nTQI9f2WbS/WmQHgEVbAUchvE/RS
X-MS-Office365-Filtering-Correlation-Id: 230da214-0d2c-49fc-96e4-08d5c1f9e299
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 04:42:13.3811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230da214-0d2c-49fc-96e4-08d5c1f9e299
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB399
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add a documentation for ptp_qoriq dt-bindings.
The description for ptp_qoriq dt-bindings was actually moved
from Documentation/devicetree/bindings/net/fsl-tsec-phy.txt,
since gianfar_ptp driver was moved to ptp_qoriq driver.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |   68 +-------------------
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   69 ++++++++++++++++++++
 2 files changed, 70 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-qoriq.txt

diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 79bf352..047bdf7 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -86,70 +86,4 @@ Example:
 
 * Gianfar PTP clock nodes
 
-General Properties:
-
-  - compatible   Should be "fsl,etsec-ptp"
-  - reg          Offset and length of the register set for the device
-  - interrupts   There should be at least two interrupts. Some devices
-                 have as many as four PTP related interrupts.
-
-Clock Properties:
-
-  - fsl,cksel        Timer reference clock source.
-  - fsl,tclk-period  Timer reference clock period in nanoseconds.
-  - fsl,tmr-prsc     Prescaler, divides the output clock.
-  - fsl,tmr-add      Frequency compensation value.
-  - fsl,tmr-fiper1   Fixed interval period pulse generator.
-  - fsl,tmr-fiper2   Fixed interval period pulse generator.
-  - fsl,max-adj      Maximum frequency adjustment in parts per billion.
-
-  These properties set the operational parameters for the PTP
-  clock. You must choose these carefully for the clock to work right.
-  Here is how to figure good values:
-
-  TimerOsc     = selected reference clock   MHz
-  tclk_period  = desired clock period       nanoseconds
-  NominalFreq  = 1000 / tclk_period         MHz
-  FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
-  tmr_add      = ceil(2^32 / FreqDivRatio)
-  OutputClock  = NominalFreq / tmr_prsc     MHz
-  PulseWidth   = 1 / OutputClock            microseconds
-  FiperFreq1   = desired frequency in Hz
-  FiperDiv1    = 1000000 * OutputClock / FiperFreq1
-  tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
-  max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1
-
-  The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
-  driver expects that tmr_fiper1 will be correctly set to produce a 1
-  Pulse Per Second (PPS) signal, since this will be offered to the PPS
-  subsystem to synchronize the Linux clock.
-
-  Reference clock source is determined by the value, which is holded
-  in CKSEL bits in TMR_CTRL register. "fsl,cksel" property keeps the
-  value, which will be directly written in those bits, that is why,
-  according to reference manual, the next clock sources can be used:
-
-  <0> - external high precision timer reference clock (TSEC_TMR_CLK
-        input is used for this purpose);
-  <1> - eTSEC system clock;
-  <2> - eTSEC1 transmit clock;
-  <3> - RTC clock input.
-
-  When this attribute is not used, eTSEC system clock will serve as
-  IEEE 1588 timer reference clock.
-
-Example:
-
-	ptp_clock@24e00 {
-		compatible = "fsl,etsec-ptp";
-		reg = <0x24E00 0xB0>;
-		interrupts = <12 0x8 13 0x8>;
-		interrupt-parent = < &ipic >;
-		fsl,cksel       = <1>;
-		fsl,tclk-period = <10>;
-		fsl,tmr-prsc    = <100>;
-		fsl,tmr-add     = <0x999999A4>;
-		fsl,tmr-fiper1  = <0x3B9AC9F6>;
-		fsl,tmr-fiper2  = <0x00018696>;
-		fsl,max-adj     = <659999998>;
-	};
+Refer to Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
new file mode 100644
index 0000000..0f569d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
@@ -0,0 +1,69 @@
+* Freescale QorIQ 1588 timer based PTP clock
+
+General Properties:
+
+  - compatible   Should be "fsl,etsec-ptp"
+  - reg          Offset and length of the register set for the device
+  - interrupts   There should be at least two interrupts. Some devices
+                 have as many as four PTP related interrupts.
+
+Clock Properties:
+
+  - fsl,cksel        Timer reference clock source.
+  - fsl,tclk-period  Timer reference clock period in nanoseconds.
+  - fsl,tmr-prsc     Prescaler, divides the output clock.
+  - fsl,tmr-add      Frequency compensation value.
+  - fsl,tmr-fiper1   Fixed interval period pulse generator.
+  - fsl,tmr-fiper2   Fixed interval period pulse generator.
+  - fsl,max-adj      Maximum frequency adjustment in parts per billion.
+
+  These properties set the operational parameters for the PTP
+  clock. You must choose these carefully for the clock to work right.
+  Here is how to figure good values:
+
+  TimerOsc     = selected reference clock   MHz
+  tclk_period  = desired clock period       nanoseconds
+  NominalFreq  = 1000 / tclk_period         MHz
+  FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
+  tmr_add      = ceil(2^32 / FreqDivRatio)
+  OutputClock  = NominalFreq / tmr_prsc     MHz
+  PulseWidth   = 1 / OutputClock            microseconds
+  FiperFreq1   = desired frequency in Hz
+  FiperDiv1    = 1000000 * OutputClock / FiperFreq1
+  tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
+  max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1
+
+  The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
+  driver expects that tmr_fiper1 will be correctly set to produce a 1
+  Pulse Per Second (PPS) signal, since this will be offered to the PPS
+  subsystem to synchronize the Linux clock.
+
+  Reference clock source is determined by the value, which is holded
+  in CKSEL bits in TMR_CTRL register. "fsl,cksel" property keeps the
+  value, which will be directly written in those bits, that is why,
+  according to reference manual, the next clock sources can be used:
+
+  <0> - external high precision timer reference clock (TSEC_TMR_CLK
+        input is used for this purpose);
+  <1> - eTSEC system clock;
+  <2> - eTSEC1 transmit clock;
+  <3> - RTC clock input.
+
+  When this attribute is not used, eTSEC system clock will serve as
+  IEEE 1588 timer reference clock.
+
+Example:
+
+	ptp_clock@24e00 {
+		compatible = "fsl,etsec-ptp";
+		reg = <0x24E00 0xB0>;
+		interrupts = <12 0x8 13 0x8>;
+		interrupt-parent = < &ipic >;
+		fsl,cksel       = <1>;
+		fsl,tclk-period = <10>;
+		fsl,tmr-prsc    = <100>;
+		fsl,tmr-add     = <0x999999A4>;
+		fsl,tmr-fiper1  = <0x3B9AC9F6>;
+		fsl,tmr-fiper2  = <0x00018696>;
+		fsl,max-adj     = <659999998>;
+	};
-- 
1.7.1
