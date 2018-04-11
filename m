Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDKG6D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:58:03 -0400
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:20417
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752676AbeDKG55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:57:57 -0400
Authentication-Results: spf=fail (sender IP is 192.88.158.2)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 5/6] powerpc:dts:pm: add power management node
Date: Wed, 11 Apr 2018 14:35:50 +0800
Message-ID: <20180411063551.30368-5-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411063551.30368-1-ran.wang_1@nxp.com>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:192.88.158.2;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(110136005)(68736007)(69596002)(48376002)(498600001)(105606002)(104016004)(6636002)(76176011)(16586007)(53936002)(77096007)(336012)(36756003)(59450400001)(26005)(54906003)(51416003)(446003)(11346002)(2616005)(97736004)(476003)(86362001)(8656006)(8936002)(126002)(81166006)(81156014)(316002)(8676002)(486006)(1076002)(106466001)(356003)(2906002)(85426001)(7416002)(47776003)(50226002)(305945005)(4326008)(50466002)(5660300001)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2189;H:az84smr01.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC014;1:cFPIRPpoNpsJJ9seAo+qs2pesyKuHZH8SrElXNih+wrm2Msqjaf73ncy6RPZjP0f3poVUsYtyIDoz2fkO8/FaxzBUDLYTKDgpMnfP6BLfHVa2rgc2sfLpJx0Aom7gDTW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(5600026)(2017052603328)(7153060);SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;3:TocgHl7syTixHwu/kjMFx3cadvd2xTgBbRvAfSG+kozRUes9DVFR3nMpU/dLzX1y65C/t04DA2MmNq9bfyvxTJqJzrTzwFUwIUJpoJQoGRxeFdmWWBxegGh1DjLV8oWPY/C3RGye1XbW0FFuF0NA0MwtJHmzi8tJBFwGIbJBlSNOZ21oxABOeQ5Hxf3GL3wRKtL1yK2llkfGlZJ4pLvT1KpSykC3TR5APC3ufRDUeSEWH/2Aqcj8t7g6CpPxxJ93qUxIJdy+FTSxFYCMd0BBhuquo2WbrcWj1nICG0w+N+iw72w74KEUoh9kbIgWB5BnPocm1RxFZVh0JwLJmhVBC4tGaI63w2QFq++nmMeAvME=;25:o/QOpHlivcmAZa+limCo+jBpcxWHg1m6IBZgybu6X54lKLqrdnIFzc4vuKwVvQwGGWDzqWUT65wctkmgIUV0AUJsyP8CAG1araocdyH4Ay+pAaYZi6fnPe55hPq/4MzsJk1lu5cm3akxfpwaQpAxoylnRqJB9m7eXEoebwY/dXnwEcANpr8w3ZJipZuBupj4Qhr7rnUL4y3rfGrpgT4pBYrKjKpaAu0mS8vdkeYwj2I64k23vymbkTyjQKbKabkdexA0/noBS66WvAw0js3JgHfG9xevIWCIOU5e4au2+eqr2cylt2yqdMzm/Don7b7O96m8Dbvka9O/OZIqHTnq2w==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2189:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;31:5t5Z9OHvtEgulzVotKkrExsLlzH1to3nS/sHd5OmscSIICXe4B35fWHaBdP3kO+tO90xBrvfKYmirGkqM4duw7VsdpA0mKqi0CXhfZYdLmlVSlGKx8/515akF2cv8+dXXbkWkctjuI2+gQpQCzk8iE5VqyV2QsG//SKgOFxc/Wa0DXWFODq/sTldX3bLRNjSaYpwHY1KzDYJBbOrWcPCjnXVB/JoVoAlbkI4KUpstHU=;20:W/Q+rEvEw+iBglJDX54bMV5MY/Srsr/bUcvGWEUe7mYzsi8sm7fyaRBC0GuahtSybTuAOvwydCM0/pSlr/2bkCk7r6ed6/S3lctEK78Ry8RVRgDL0ikJHowLi4/qt3w4PIftsJ3Qr10wbboDS2X8SCtWgxGGLnIVCHoWWsDPRIgaYzHkxfk8UVNx16juwDpUhODoaLmCWVeasUJaMzoLvfnckWyKSD2Fxnl+tV9frHz5Z13otKUL+oAafkoQby1h2KN29LoVrR9iSxx3pzoHDpwcSvS6wDq/5ggoBLIRsedu8KstotI7MMra5CUI1jnDkTN4jfzYK4LTYrdP6Me0x8MscD9EJwasBZBUNFpDY/06cf/jsGntNm7wifVvADWXe45ms/x1s7tzYBNEkExTwx8lB4QmOzC4cOTfS8lnXMLjlJmyNZ+OldEaUqytvUziEAGAmqUB/T0PwPjrl+EqahemKMbvRnH9dvmwdGGTGDF8fGMAQA9ZsgJaB6BHhg3NuwPfjP7F/Nx9Cx+ooL1oMXQvet3SEeKrPOk7HfdIPT34o/wv0Q4rmg9OalvkO+0ot9NR6wtWKCa4sZLB4pEQH5MGZYxwZ32S5GAa59GUQYs=
X-Microsoft-Antispam-PRVS: <SN2PR03MB21896D85D33AB84B772A1310F1BD0@SN2PR03MB2189.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(6072148)(201708071742011);SRVR:SN2PR03MB2189;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;4:/rnKBan8MbmQCxAqdGARG+CzRol+vEjyZImoRerhBwqXF1U/zMDifdhKkXxDYjPB28qmu7D0fM1ioXFgB6ZmS0VclJ/mcnVx+nAw2jafwwVcjYhkmVW9534OO4a1Wio16kC+/I5D8DpXJ7+fvO3U84h5gL/aCzAskRUX+rdjLjYftlarrgYoAVBwb1H5/Wk5vdj+zF1ZWNRib4RaZfwEHeAwSnQFBy65EDOBa874kig8mmmFh+FUm7Ll7ae+osvjI++m6OQwMlp7OTp/GPLldLB+qYQ+EZmXGYAI3m+fRcy9/OlWheEt/waeagIlSDPwZoLKS3KRcpZ67OjxzFS3d5NmuApMntwAK0bMUmObPDU=
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2189;23:etDx47CC4tIKdQTgwfAjw6kERqhGayCkapYUWVkK5?=
 =?us-ascii?Q?tOZ/BDqkE3cprAP6l5Hsc90RLJs/i0zvkvQTbTZ43LQPB+TNBeLUjbOkA7hL?=
 =?us-ascii?Q?zXmOrIF6VB4ZUEHOsgCFs9Rv2SuDJsM189oQETMZcWcJQmpisszPkJTHUW2G?=
 =?us-ascii?Q?BCns8ubyiinJe/jVVXOBNjC8UlxFdsq0Im4SvKxaSVpCr9nSHwdPRWk7N7vy?=
 =?us-ascii?Q?Rbr+PSjcGRW4hLa/m/XAhAf9OfvSBKIlrVciGQBr9sSY0JnHRbmBT5NVhyUT?=
 =?us-ascii?Q?RF4PqjW195C3HON9Aye3fs/xFMKZrhvMn8ERlFr738mCD5tt4kUR8uQkFkvj?=
 =?us-ascii?Q?7m+DLcoIJhyBjykaY0f9SdWfGZMjf5SFRQ+M8NOLWgm9+4rLI+Hj75AuPvhd?=
 =?us-ascii?Q?i75cTlrD7Y/H+fnWXFQszeIPS9ssNSd8K+hJFTcutLNYaj9kxcL0SilvucS5?=
 =?us-ascii?Q?lFag0Jxb8mUocF0UTwMTEoYDI/zKP8wEz9PS24K1YlCNTVyMq+IBEhngdFyB?=
 =?us-ascii?Q?vMPqPzVilJJioQwLS8FfpaHzQ21nA7c9PDvKksp92u1TgVhqfP1jbuG+JhIh?=
 =?us-ascii?Q?s6pPBNvoOeS5Qd6xvGwyJpaiwuI4vQ8CshoLlNL07v2PWaFxcNy/A62wiATn?=
 =?us-ascii?Q?fboKocSFngLRQFLHL+sxG1+oOU1pmJ3fNzaJQ8oBbf3bAztTxMQ13Lilp7rU?=
 =?us-ascii?Q?GqvrQXwKq/Piza4Mp5gYSFO6aI6/I1KeMne3WG1GiczX4hFb8Z8HMsyyCvNR?=
 =?us-ascii?Q?FCDw5EVDkq07V2bWMzcijyRxJkvLsX0KhPgapnoCCTKU2qYviU7XCQcYT8dj?=
 =?us-ascii?Q?zlUZo5fPirIOrzi7pUljuETPWaMFS5mHdI8NdZYzSf63303tWMYAOpujYRBT?=
 =?us-ascii?Q?AeMPXO4+bR+tYGtM2qK2nUND4jE824o0KNd34+f+87CMJYMsopjg9lEXqysr?=
 =?us-ascii?Q?JXRr1GgIByE06R7N6FtJGP//x4DTVplhofvXyJIxFuK0JYadlKMBPVc5GMqM?=
 =?us-ascii?Q?+hWXIkwWJJ6r6CLKX0NXSiFc0piNzTaoc+A4GReckWsFrAT08NJQwf70nJXS?=
 =?us-ascii?Q?IUSt4skzWoM9vl2ZSoq/XliPuaWOJ6SluIrWqWMZ0OqKGMkQTY29m2uZxH6X?=
 =?us-ascii?Q?L2D5CN0lf0IRzOoG28M0VQMv3PdsadGzpnNtndRHZV1OXkFl7cX72NBm0SV9?=
 =?us-ascii?Q?iVi+lLRFdlrW26+TUDvxAXWw/BS5r7HOciBcRlvM62skmeoNNcJQzV2K4QVQ?=
 =?us-ascii?Q?YfesLqIyOlPLDbajOiCm0qINGeTKn7ArYEHF/MACia0H0qrtZr0mIvgaYAvI?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: y2Rr78OT5U8RY9e0JAwcFpm5J7CrKGoCVVANWj8aS/CN67X+iv/AdCKXlZBO8GAUpwBgQHddSBYr27Hd7Oxy9edeCRqhmxUef0qJBB0QC0hc/hz/C4L8o46JdWulyav3DoMoHa7NDUChBDbbiQUdEnCRq744/kcKV82BoqxHPd2+/JjlI+WqJkuYOVrK+ZwX
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;6:IV7Rz4a/ob2hZ99Nqutpl+HVtlC2tF7ZrNrPgau/0726v5UgCDGRtDZ2CG7tf41u44W5z1gigUOLj7JSyhKwe26bBFe+90w1JgayBSsVKf2c4PhLn9X2mU3PabrE5hxkOhKqNzFLmg26NUWvsJCqL8YHzKQRKN3qFVEKStqqygdbJihyPc1v1GSJQCJJKa+mpBtt7Zo0Y3jB5ZZ5Jv1Kt0dN49m2bSdI3R4Ngab4NM/jlIoqtcj+2dzZM3SssnphDs+IO/X09eSFUEvNtQJJ8uuzaocGlR/+ksjYYw0AkZhL1bc1QGlcdbtcwnTgAsTrFbWO64nlZQp0kVnfiSgm376Z84I0LiMzbnMwVtaNLQzkWt6nKzrPWa4VH/ur8/QxjGUsRrPiLYqM+0rV19IojCekC93vIRa1H/bDWDBVYsz8ipEhhBIN4BHs0Wmzk4f9lQfm8rf+9dTtOTnq+vRV2g==;5:/9LZ7rPqvx5SYe5wZTv9lOkZkOTL+XhJJtLkNXv1mGO94oLS5kZDxEOi/+61LD8StZ/uoee61lYye0+jYKt7W6x7WY5s6Joa+YDIphc/EDaqVHxF4tjt1Bj9Oaa/KcMt0hYnkYCSIfz88zBCfS9ArFFBOyTpR7UQAt7rOfi+JZo=;24:9gO/YzWAbqz9pOZqQxIehRe9vjAdv6jY+V/mJ8YIABpwIBPJIOnT2xrU9f80f/Y6+4SbGaUekZwRxPP2CDbLwQ6gbEEllD/Ikm/IMn99Qyg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;7:zzAYbNFlhWV+Er1dcPT+T/F6i1DTwo9vr7FEQTvcH9qvmsG/ZFF7mLvnrNVNBzDEHaS5TFpjDtxe+jz/3cWjgwGiIJBi4gKPu6B/fxQG6Xnn7J5Evrxm7r34DsRo2C64XTiV1BdHRSqaeaXSyroc13Imnr0Rdf5KLUZSVd4N9TTnewyxI0W0RL3KkG4M23T6tZ7orNt0mgzly9dQ1p4RtbiUsHeMoZCIFi0PvfRqeklJN1hqGlRtcU6c0MjvSdJT
X-MS-Office365-Filtering-Correlation-Id: a4dd826e-dc99-40d3-1fea-08d59f798ce2
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 06:57:54.2693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dd826e-dc99-40d3-1fea-08d59f798ce2
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[192.88.158.2];Helo=[az84smr01.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Power Management feature on device tree, including MPC8536,
MPC8544, MPC8548, MPC8572, P1010, P1020, P1021, P1022, P2020, P2041,
P3041, T104X, T1024.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - no change

 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |   14 ++++++-
 arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi |    2 +
 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi |    2 +
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi |    2 +
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    8 ++++
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   |    5 +++
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi   |    5 +++
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    9 +++--
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |   14 +++++++
 arch/powerpc/boot/dts/fsl/pq3-power.dtsi      |   48 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1024rdb.dts        |    2 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts        |    2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts        |    2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts     |    2 +-
 14 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-power.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
index 4193570..fba40a1 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -199,6 +199,10 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-etsec1-0.dtsi"
+	enet0: ethernet@24000 {
+		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec1_clk>;
+	};
 /include/ "pq3-etsec1-timer-0.dtsi"
 
 	usb@22000 {
@@ -222,9 +226,10 @@
 	};
 
 /include/ "pq3-etsec1-2.dtsi"
-
-	ethernet@26000 {
+	enet2: ethernet@26000 {
 		cell-index = <1>;
+		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec3_clk>;
 	};
 
 	usb@2b000 {
@@ -249,4 +254,9 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
+	power@e0070 {
+		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi
index b68eb11..ea7416a 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi
@@ -188,4 +188,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
index 579d76c..dddb737 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
@@ -156,4 +156,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
index 49294cf..40a6cff 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
@@ -193,4 +193,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 1b4aafc..47b62a8 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -173,6 +173,8 @@
 
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: ethernet@b0000 {
+		fsl,pmc-handle = <&etsec1_clk>;
+
 		queue-group@b0000 {
 			fsl,rx-bit-map = <0xff>;
 			fsl,tx-bit-map = <0xff>;
@@ -181,6 +183,8 @@
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: ethernet@b1000 {
+		fsl,pmc-handle = <&etsec2_clk>;
+
 		queue-group@b1000 {
 			fsl,rx-bit-map = <0xff>;
 			fsl,tx-bit-map = <0xff>;
@@ -189,6 +193,8 @@
 
 /include/ "pq3-etsec2-2.dtsi"
 	enet2: ethernet@b2000 {
+		fsl,pmc-handle = <&etsec3_clk>;
+
 		queue-group@b2000 {
 			fsl,rx-bit-map = <0xff>;
 			fsl,tx-bit-map = <0xff>;
@@ -201,4 +207,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
index 642dc3a..cc4c746 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
@@ -163,14 +163,17 @@
 
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: enet0_grp2: ethernet@b0000 {
+		fsl,pmc-handle = <&etsec1_clk>;
 	};
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: enet1_grp2: ethernet@b1000 {
+		fsl,pmc-handle = <&etsec2_clk>;
 	};
 
 /include/ "pq3-etsec2-2.dtsi"
 	enet2: enet2_grp2: ethernet@b2000 {
+		fsl,pmc-handle = <&etsec3_clk>;
 	};
 
 	global-utilities@e0000 {
@@ -178,6 +181,8 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
 
 /include/ "pq3-etsec2-grp2-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
index 407cb5f..378195d 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -159,14 +159,17 @@
 
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: enet0_grp2: ethernet@b0000 {
+		fsl,pmc-handle = <&etsec1_clk>;
 	};
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: enet1_grp2: ethernet@b1000 {
+		fsl,pmc-handle = <&etsec2_clk>;
 	};
 
 /include/ "pq3-etsec2-2.dtsi"
 	enet2: enet2_grp2: ethernet@b2000 {
+		fsl,pmc-handle = <&etsec3_clk>;
 	};
 
 	global-utilities@e0000 {
@@ -174,6 +177,8 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
 
 &qe {
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 5f51b7b..6ac21e8 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -225,11 +225,13 @@
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: enet0_grp2: ethernet@b0000 {
 		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec1_clk>;
 	};
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: enet1_grp2: ethernet@b1000 {
 		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec2_clk>;
 	};
 
 	global-utilities@e0000 {
@@ -238,9 +240,10 @@
 		fsl,has-rstcr;
 	};
 
-	power@e0070{
-		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
-		reg = <0xe0070 0x20>;
+/include/ "pq3-power.dtsi"
+	power@e0070 {
+		compatible = "fsl,p1022-pmc", "fsl,mpc8536-pmc",
+				"fsl,mpc8548-pmc";
 	};
 
 };
diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index 884e01b..2c4787c 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -175,6 +175,10 @@
 		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
 	};
 /include/ "pq3-etsec1-0.dtsi"
+	enet0: ethernet@24000 {
+		fsl,pmc-handle = <&etsec1_clk>;
+
+	};
 /include/ "pq3-etsec1-timer-0.dtsi"
 
 	ptp_clock@24e00 {
@@ -183,7 +187,15 @@
 
 
 /include/ "pq3-etsec1-1.dtsi"
+	enet1: ethernet@25000 {
+		fsl,pmc-handle = <&etsec2_clk>;
+	};
+
 /include/ "pq3-etsec1-2.dtsi"
+	enet2: ethernet@26000 {
+		fsl,pmc-handle = <&etsec3_clk>;
+	};
+
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
 		compatible = "fsl,p2020-esdhc", "fsl,esdhc";
@@ -198,4 +210,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/pq3-power.dtsi b/arch/powerpc/boot/dts/fsl/pq3-power.dtsi
new file mode 100644
index 0000000..5a760b3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-power.dtsi
@@ -0,0 +1,48 @@
+/*
+ * PQ3 Power Management device tree stub
+ *
+ * Copyright 2012-2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+power@e0070 {
+	compatible = "fsl,mpc8548-pmc";
+	reg = <0xe0070 0x20>;
+
+	etsec1_clk: soc-clk@24 {
+		fsl,pmcdr-mask = <0x00000080>;
+	};
+	etsec2_clk: soc-clk@25 {
+		fsl,pmcdr-mask = <0x00000040>;
+	};
+	etsec3_clk: soc-clk@26 {
+		fsl,pmcdr-mask = <0x00000020>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index 73a6453..95fc694 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -91,7 +91,7 @@
 		board-control@2,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "fsl,t1024-cpld";
+			compatible = "fsl,t1024-cpld", "fsl,deepsleep-cpld";
 			reg = <3 0 0x300>;
 			ranges = <0 3 0 0x300>;
 			bank-width = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index 65ff34c..825665c 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -70,7 +70,7 @@
 
 	ifc: localbus@ffe124000 {
 		cpld@3,0 {
-			compatible = "fsl,t1040rdb-cpld";
+			compatible = "fsl,t104xrdb-cpld", "fsl,deepsleep-cpld";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t1042rdb.dts b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
index 3ebb712..0997643 100644
--- a/arch/powerpc/boot/dts/fsl/t1042rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
@@ -68,7 +68,7 @@
 
 	ifc: localbus@ffe124000 {
 		cpld@3,0 {
-			compatible = "fsl,t1042rdb-cpld";
+			compatible = "fsl,t104xrdb-cpld", "fsl,deepsleep-cpld";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
index 8ec3ff4..b10cab1 100644
--- a/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
@@ -41,7 +41,7 @@
 
 	ifc: localbus@ffe124000 {
 		cpld@3,0 {
-			compatible = "fsl,t1042rdb_pi-cpld";
+			compatible = "fsl,t104xrdb-cpld", "fsl,deepsleep-cpld";
 		};
 	};
 
-- 
1.7.1
