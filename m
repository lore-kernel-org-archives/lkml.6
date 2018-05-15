Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbeEOGGp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:06:45 -0400
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:10801
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752089AbeEOGGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:06:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 14:05:53 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: berlin2q: add "cache-unified" to l2 node
Message-ID: <20180515140553.7e4d7c9d@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAXPR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:402:19::27) To MWHPR03MB2637.namprd03.prod.outlook.com
 (2603:10b6:300:46::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2637;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;3:RJPvXuoyJz+sODjyTbItSb3rH5vgngbvTHdn16y1YNvFRp6rAAMdQAnWVk9No+7Bdj6qr1YCEM0d3GYpa7Zko3efsVW7Dj4ufIEj6vKPOo1k4lLTl9LQQEV0dXH25AAV5Nhr1RwjaNBXUU8Olnv6F97SoTUSQQN4Qt3ce/EK+1ZpPHNYAoEhKvQTJW8N76MhKXkbE8ulUPIDcDBIIGnfObnZDcFKwUpioceSTZumcZe3g9Ep3K0Cy/QDAgN3vYRw;25:lxvMzINXSL8SWwm119FUQ2+dW5CcQrb6fdUZzhyT2+4qSsa9Pk0picHBGb/TnKiwr7M2Fiz/kVApjVg3idHZbq/obFMAFq0QPpPDUD1qDqcxdtPEoy23qoR7ZmCwTRp9UsbjiPUR9eWW/ccS7vq1jBkKjEEEhE6LgUf4lccLJzDxtW7EtuIS0oUH7KbIdLSi6zYp40q43Sh+NOSNYJI3raZ+GmMI2ivFCzU+0svkz5PecRcNStpOHQiWMDHMKabp5w+LHuDo01W2879D8KM2mS2zLYyoIR2TGBbTjrxu3myCIS24zkDjQ651hmLJje/ovnK4BD68pT+1v6ZzNzjVdQ==;31:rd2IKf4AOIk3Sd69Lqnf1/3gFULRhs9zDRd3yELVZgevmL7KzUPZ4CjprBjS5dK3L2YpNEdC7XgcSWMWM9f8o6TPTOiJh86Z/47q6c4VNxeQ2yCpbLeLMAXFD3ReoYgUHLuqlnrCB5r90kO29xFGMEaQThKSKdLkNU52YI90xJF9yc7kTV816B7LMsRc14CrBOceCM6uuezYxywNnjj2t+lz5lIjQesA5itsmEOB/QY=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2637:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;20:FCp3c+5mCLmu6wetvYUGFQxwnyoqaMh3RnQCw8ZHQpqdSvxTJSeF+E0XpgETiqVjzMgSPCQqO61LuMIF9t9gI+ofzQ5qYcfLNsxcA8EeRRMNiRKI1zTVNhnpFFjVFdCB9Uyz9bN7ECYPF/b1GJOXO2NKCxVQrCosl6uZTX6EPnBUvKiibFDE5uG7DLVhhRNnn4fFphkYQpVsg2KWVQ/yuGdBOZlHZrKFdk3vQzzM1AlulvKRnSUH3l6yCWcisVcCHiOlQGZLyjituqZsrRyREHRVmbJK4/T52xx/Bh/0HPgybMh1ItOLoXsAdCv1CUqSJfEErWItb+zALQBcrMxu83hO4lhxUsh/jKB9k29GzsedZF7LqAFU7eXqHPC1fwJ2lTLVE914MC7WdEgkyfc1Irt4QC43cRrHfUIoiQyPjVcpXCiYm8Ot+WXzMnPQtCyDMu9pc3IMWpgUefo8BQXYtBe9L/aJsz+JFDChijTX/+Buqgm3b5rnncqC5AxOa5wB;4:ebHYEXmbOrg0uMybBi+9gFUcralbPxtjbH0XkqbZ2M/xGPSjz9zGqGHkkwliWhHLrNSl7iQVMSzl6LMLAlpkF+scApHYGN8dGE2oBFlsqSq9rfuzGaYOyxr2Wwg3PHzcoK93apc0Y0g7oXzWHc9m0NbEg3N3QyIdLOp15oHCcTlMxoIG/R7z7kYXIofpjrh5+ryVZYhzBt9JzrSh0D8usaX115j0ZNJtDhKBo7IboHAS/V5YjQBYl8vmjTJTknEmNGxw+85b6nbP1JYyz15wVQ==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2637D3F2B524136157549CB7ED930@MWHPR03MB2637.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2637;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2637;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(346002)(396003)(366004)(39380400002)(189003)(199004)(66066001)(230700001)(478600001)(3846002)(7736002)(6116002)(1857600001)(72206003)(4326008)(39060400002)(23726003)(55016002)(53936002)(6666003)(110136005)(47776003)(50226002)(8936002)(81166006)(81156014)(2906002)(1076002)(8676002)(106356001)(9686003)(50466002)(5660300001)(59450400001)(486006)(386003)(6506007)(33896004)(52116002)(476003)(25786009)(7696005)(26005)(16526019)(956004)(86362001)(186003)(68736007)(305945005)(316002)(105586002)(97736004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2637;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2637;23:lzglAN7RJb/56KFS3YXddSC/B8fDBF6Y/hiftWNxz?=
 =?us-ascii?Q?6mUoffI3D2KVwTSKEZK4KQ1Eoo0NSmmH7IrOFNIGX0p4cwcn2lP/QHg9DLWz?=
 =?us-ascii?Q?oDKAprT7y7jrxDdh38l/WlVPmMUj2jQIgzYRfpKzORqOnKnt38tUiXvhxk5O?=
 =?us-ascii?Q?NY3b4R+eMt4k0Iqq3VWEmMIcbg3zH8dWNBHXf617u3PYs8SElg0dSe1QkAxr?=
 =?us-ascii?Q?FP/qsIYP9/67cKQX0PUrRpVaExEFX8QjhYsPn5uNbvpCQsQ7/6H+FnB8QWgp?=
 =?us-ascii?Q?YmkNJZhelS8ScN8YJLaYnFKfoeqPwDJ9yzlcBtVA6KcBq7yOUpFAs2uDdJyx?=
 =?us-ascii?Q?6OKwwCTy9Wtlhf8I8UYC05GOSFcvGL6/ClPyPILKElP2JjRkGCDBIlOCfZQk?=
 =?us-ascii?Q?AbDvTJ0NCB+G60X6O072p2h16ziFGn8r3v2ENUF9IFA1H9IUHDrnji0ve3lC?=
 =?us-ascii?Q?43+j3lHLvA89fVaZe0rHG7HFbb7w21C2o0iQj1eX/h/bbhQNmkmbHRZw+vmw?=
 =?us-ascii?Q?lCcICckf5auwr7AeHS8QHoqL5knNiKbOwUdmYubkRGQlLK5tSKXveVQjTP+5?=
 =?us-ascii?Q?RcCmtaz0mI4Dp+eTmReH8mSY8dXJQGk8Y5llu+C2QkehIQqQq6iKNVMOoP3y?=
 =?us-ascii?Q?CGUDJC2+/vr5/kzBFYeIEIprsMI1E6HEEuBaCcHEf8utfD3yvMhg8/3KEfm8?=
 =?us-ascii?Q?qqBh1OVo98T8FeAu28o0I1Ss1TwmA5mA46Hr9Cz1OUkNtArXK2eUxHCxSsdB?=
 =?us-ascii?Q?9rDfx4bBm4Bj0B5i4zuYPOSONRkmPA75WeOV7KailpN5C5W118Uxb1pXGbJj?=
 =?us-ascii?Q?GuOqwQHzCrml0XV84/IODX+NIL1ukDdaUclyFwJ94ZTPuPvUNvRlcKGbKzgB?=
 =?us-ascii?Q?bI+uienEnptRAVU1eXkkCgrUWrp1TsRCWmzCgJ0UCRuNh0XJfoqFjlhKe5C+?=
 =?us-ascii?Q?Uhxx5NtQFjvl76dBaI4eQkUzCedOS0ChqcZYi2s/tIbIf3YCFt3PAk27UdEr?=
 =?us-ascii?Q?UP2exJ1zmf5kLTx5bintp1ScD17LDOebOnUKyvIwN1V3aFyfI30o+AGaYV9v?=
 =?us-ascii?Q?Bvp+j1SR2ccG2bI4brY582xUAKPUBjvRkvBBbCYAPGCN1f1ZmWFCUIxx3NRr?=
 =?us-ascii?Q?xEZZ+wwu5g1UjOkktTUp33Y2R1tXUiCX3VqY66P2mtJHOti2/jDfc+6jwXad?=
 =?us-ascii?Q?NNXXaUyCJf++Ejf0pBGEOLI4D2wCuTZ/dAoIzYNwHUOAVvAc/Tgw3bThSxqp?=
 =?us-ascii?Q?/3U3vOk9FPUJp0Fo6Y=3D?=
X-Microsoft-Antispam-Message-Info: FSCJfLIdVLlRzGLNSIVRcZxY7WqpRDF1RdhU/4JhPssh8uF4FawGZeXMPUpMRq8ryvAsRPqUxF8jQ+Aqnk/hLRzmmRDJlN3UijpI49prDKzlWBSNnSx3T97KCJB7PcULp9JRLbPDeIfluIkEZdqpvF4OXEFqC+0vlsNgpsIhvUhF4AGB9MJ3FXjQG1U4pfOs
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;6:VClm+2f4ji/Jpqkp2/tSdfKwzQvxIOWgpPM0GTntMd8PQGHaHjjEKtSgVvwziQCUFP4SQ9iUcLf+674uuRC8Q3RbZutGTrj8Ysy1zrGV03kX5JPOjhpA96a4/xF8NwrhrvL+2tFLORdC2xHXrBEMp8NDOnL8TAGEg+SSX5kT3fI+M7/0PPkbgsCdLnkhlzCsxXdaRZr8bgZ3hgGs1MDkQqcSTnwyU1XcDb76A8m+dKbtwydFB/Y9H7DaA44ZlgLKQkr3Yj3j9lNl7obGPmSFhYBkvhvnjau1IWnC0JGhElq51TyPylHiX2qYVBsnDbMCCyhpDW5pEPi3B31FVn0m1+w2YyKyOMYE+Lo8rQR4eAIwdD+tzbcrmbHzDIdEqfIvrppUdsKD/tqZ+4J24x70xnCsOyjLB1Gkd0YUHIHOkMD3O8v98NPzcWJMkJ+enLuoOfiuBRB0UCegcC0+q6m5iQ==;5:goLo4Y4tq6xYi2aWbZ1McsOOD6Hjb6XhRRE3IIRBIaPDhk5KdRwAUA7/YVbegHA2Ml+lARe57uCx4Nl4xn47CJvUjb70j+ugZYVgteDbT8XylYkU0mPkeOgfTYUnIoTo9ETFYReMzAcEE4hCEHBDxG5D8Dh5nc5gjF/Z0ZfYQdM=;24:c+S6MwFOMBRpHh2Jip/vUv55Oy11C0tVw/p5EihroCvgBGXkSGZw6Qdi1HvTEfLz1BhbgGJt+rDgGhCzzxa3cVHOETWVBFMZ0RZQotBVFVg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;7:bcAM/SQ5uxi+X0wg8E7BDm3iTiPjmWg8V07TbSP3sX9sNMBBT/fZt/GL92bmk7mGzNUv+KHjQ8Y9LXianQ8fXEWrfgRkIKay68KOcL6Oxw4ocH3ch9fgdxWG6ENHurfka3DOxPemubA/63GIapwBi6g5g4ndd8jpJgViwmkG1HD+5oWxqagsopL2EBKAHNajBaqRd8TVoc1w8bFuh+bHkv7a8TfJ5vHLsI5gwt/MuGgaEIJdE2svhkLJhaoHjkmf
X-MS-Office365-Filtering-Correlation-Id: ac3bc79d-5be1-4b83-c7b0-08d5ba2a06ef
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 06:06:39.5719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3bc79d-5be1-4b83-c7b0-08d5ba2a06ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2637
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this property, we get this boot warning:

"L2C: device tree omits to specify unified cache"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index e23c49ae3ec2..7cba798152b9 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -149,6 +149,7 @@
 		l2: l2-cache-controller@ac0000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
+			cache-unified;
 			cache-level = <2>;
 			arm,data-latency = <2 2 2>;
 			arm,tag-latency = <2 2 2>;
-- 
2.17.0
