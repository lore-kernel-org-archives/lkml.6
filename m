Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDQNLb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:11:31 -0400
Received: from mail-he1eur01on0103.outbound.protection.outlook.com ([104.47.0.103]:21376
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753363AbeDQNL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] dt-bindings: display: atmel: optional video-interface of endpoints
Date: Tue, 17 Apr 2018 15:10:48 +0200
Message-Id: <20180417131052.16336-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417131052.16336-1-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:XrFrKz3j6nWu9VNa7BMjl5TbVOYrogFTkLC84UrrBvpbfNZlCMAkZTo3Q5DWQg5GV6YTJ5Sacpg+ue8+QHv0wnzIMn9maeSA5bTh/i6d0KZaZWFUW7Kl+I7Y7ZzQcPm55d3JJfzILSMQwWjP1yBb7ykcbTyWZvIH0aPIs/+c6uMvZql/1TI4C0HBjbPyjGgmObdtoh4tKQNq+xF8P8dc7HeuaP50jQPUIqFlvVWKjgwED1ukcfPFOJVb/H1f5uwR;25:Mlga41DxoO9Wd9AUSORrbYDSz+aocguZShZ0kdXe/h5wovrMkATjLoY9Phyx+Guv9WKkttdTKAqNs7Z8xidLHKHjVgkOAXEdm3nUuKPDgZi2ngrRlbpeSJzwQ7dOSPAlG2GYJOHsMraNtMCZ/+aQbSbCfhuxS9hwx6iKQsgv4UtnpbhZXsdgeH1Rz5OuCkyQSVQr+BoQWV8zZxHN0PUddM6Qa/QKLatfEzfYc441H9q0Yv96YpOZdLdZMERl1hMo76BN5nSqffbQP9J3WuKxnMTlm1y6Teg9loLLmI/9/tsolMd7tzichd7k37+gBko4lC4mhrk2s6XxVyKTgnYjIw==;31:oLYfFk2baVMZM/tbEdsMk0CAybQaU7ZTCK7PLamXOi6odraLW1GN/cBCOG7/Jp27uncq1UBDqUrCzWsNKMS3XOa478hwe4c/Qyl6gnhn78kIXbZ0d0XEGZ7/e7vufnXs6OCkDy8uy27uSVwQ3f3rYj+kUJvcMbkMeZgK6bl1xQiun84p50fvbZlEKKeyt2ImyLMwdu2+9GPKHkE3Jdu/Qc6KbwsPQncsbY1dVd6W2sg=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27782C29CC7880249DEAF81CBCB70@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:Af4nRxlQAr3OoCPS7Hb1199HZZu/ig65iYalqJOiqXBTBP/gWERwNW8uhwBVHR8MogOOe1/XqIg4OQ/eJQbFcGXVPZOdazEeutgwLKqbX9PwICPPIZXKiCVAoFkaqiBHQ4A9GHu35uSh8Kbpm7LCjMyGB18i3Y9hj2GTrj6oBftA0E+h+LGP3Zwaz5sYHxNRVMzdcWV7yYdsdWI11MCXu3H9uDiqNbxl2JXngWoIkagdtdifWJ8tESMQKtxfPhiEdH4aXEBZv8+t064HVC1IiA==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(346002)(39830400003)(376002)(189003)(199004)(386003)(6116002)(6506007)(8676002)(51416003)(106356001)(97736004)(76176011)(26005)(52116002)(4326008)(53936002)(3846002)(6512007)(476003)(486006)(11346002)(446003)(2616005)(956004)(6486002)(305945005)(6666003)(6916009)(7416002)(86362001)(1076002)(2906002)(2361001)(2351001)(105586002)(50466002)(36756003)(66066001)(47776003)(81156014)(74482002)(54906003)(16526019)(186003)(68736007)(16586007)(8936002)(5660300001)(7736002)(50226002)(81166006)(48376002)(478600001)(316002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2778;23:EDB0QA34qFAziXwjJK4pM6nSgSwNsEz5KYu/tdB?=
 =?us-ascii?Q?F45gREBCDff3PB71jgTxus19iaVYmsox8PiYPipJ0HkUVw/c59ibUUYqE0jt?=
 =?us-ascii?Q?UKjDQSSUyMsP1DdulXILrtiaqJyPnXAqPadaWFFsYYzb2KI4sTX+2ZzlJG61?=
 =?us-ascii?Q?RC8s23Bb37a0nziecy8YL5ncfGTphVDmNyaiFRsehGCEImdLBihWGqK3zBwI?=
 =?us-ascii?Q?bc4DAfEE5GJlKmH0qIHQiT6gNyl1XTtlRUo2nWqnI7MU+IWDwit6+7PIW0xd?=
 =?us-ascii?Q?7jOcBHgIFqYcHPImXUZfTwjRaLAfjsu2Kx7SItTWLDwbo2DfZhB03LfutPje?=
 =?us-ascii?Q?inytoiynwciCcdfWoSFRPECeV3lLfOj6DXGZlUa2cd99DS+yDzGLSLHsDsas?=
 =?us-ascii?Q?MqtjwhQYe41yloeRIQa2cHjeoDxyY4eYF4Dc3n48FAbr/X4WWzp5E9t0Juoc?=
 =?us-ascii?Q?0BA0v68TZnCnXgCfPka3H4ryuHjeAbv9/0W9gBhph9Dc2qxB8O30ivHENoiy?=
 =?us-ascii?Q?kUuD1IDeGZJacsIovxViOr2vV2xD2o0Q2KnjXATWOrjNL5IDKK1XmLJPoCcW?=
 =?us-ascii?Q?91ODxUPM0BZOKct7SERT6Qs9xsn/7vfvgOijNEDQHCW7sQ51yDwLTMlAPJ3L?=
 =?us-ascii?Q?a+EYF1tFxUQJFQG/TAIxnIrDjcFVkXavTODseu2jERCiEygg6BxGKmW+lu/5?=
 =?us-ascii?Q?KQaOGI9nu9kP02s+q1Oe/3I4wt6iye9K+8u23BwF6dqcOytR3FygnbyrtNqA?=
 =?us-ascii?Q?w80jLURdsZ/c0/Q2gH9+uUaVnbBSZIcLTARkCFvGBVG8mvHWfPPaPQGxFK6W?=
 =?us-ascii?Q?Ovr+d0cFxXZJfT68k6BnK5Rfaq2rORDdLv3ENYu719pLv/LAbB3k8GwkcRK3?=
 =?us-ascii?Q?pukhkMf4c/UokMUdgP7wGOVN1q3/tplk0d5F9WyMzALrowmKNkiwdLQA8M27?=
 =?us-ascii?Q?ekuMNH01KQJWQmHouiQ1+mt5XbrsZjTRCuZ2XT8a7wKrQbBMnJsGIB9q/Ho8?=
 =?us-ascii?Q?iOVh8mPSUIqDnxZco3BHr4aTrfcKKUbNehiT+VQZOTdupF+kGsW2+kjBw7DD?=
 =?us-ascii?Q?Shdw25XTwPu8clB8TUXfF87Ncc60L3ZFv8b+sMTrR2ex6Pg9gLIBHTMDqb3h?=
 =?us-ascii?Q?yWIoVuGh5oL+Gx5ButUBL+mF6Gh3uEJfIqozDiGyQX7oC/5l2DJ7bXft5I2y?=
 =?us-ascii?Q?pxosrPba8VrBWn5FDiljpap3CWJMOwNoVg+lEV/TS4YI5Mi4pGdcYXmqj5lR?=
 =?us-ascii?Q?eVARk6tYwdDr8n/DgFPfHQfbyiCLi3D2Oqa8DTuc1Ebf2sGM3wMY9y9SnPiD?=
 =?us-ascii?Q?UPLbuSVPyE9AClQEi0/VgxF8=3D?=
X-Microsoft-Antispam-Message-Info: 2TOwMtPEalaQMlSM+giOW48bqpFrAXzrOsK0Bq3kHflv+B8slGXxulqIe+N1WRWShFfXl/b6A4tYfoDiz3JW6ZTSR/qQNZaXQ7+Awaced6gxa+/0UkLO1Ylkuwzgg4ok0Vk2AeAKvzbo6Lt6kz6uBm+HAebWvCk19r2l/4C9mL/ZvTQB256G7jO+RItC10zP
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:of00b4CBfhaEPhrwU6WPPJ7pyPPWBC/F9t6Mdid63vtPjhd9sydUP+rp8Gr9z+qanRQKafom14IEesbAFgfEMlZkEEok/CUHElEUYNhyqnU8aNe1cC6hcr3M06mpLqG8YwQo5zGlE2kX8Vl0aRZQ9AOB0sI3x5IC4zLElN6gYC3tGACqMT7AOmf1xN7XsZebPPlHp2hMZIcL7+n5K39nw/sfLczsULyxnQGNJH7Z0VJagyj6MFA0rPaYcQ/QVIblGwAl71N4g7UAmP+wHQ5Kl2LvbUspKSsaAMOeK9KFVxE4EEB0ZMj28WgFWxSSz2o6i6yE+UgT/DL7IvkgIBm+CYvF+B19Irsl++ww4RyebJ09P6JttxulRgF5dJO1mSp0OHwd8H1UZVRFz25sf34RxiVTTVS1VcUWcF32QHJR77PmkxdbRFiMiGK7YmszuCvg7sFL2zh7f9Yq3nEJiD3iNg==;5:jeRz10+NIiYCvXotjtHdANugrGjFzGHwbLRXTDQqoh1qrM7K8KWMUEoGKx68zVP4vU3URqGbgGxUS85vIKL9DbFOPhb/QIAIEJ380aOXkz4OahKgmiHsAym/OCJgF6xm0ggiSocOFvkbvTTcJkJ/Ds6A29gvP3KF2zQzmNUVjpw=;24:VhMy1fkNxBfgKerCLP5GOq3pnlzjfVnnv3ashzd7HsuZYKrbe3aPhbEsNPfeChx1Yyps+oNkiVE60Z3EOXjvuSRDfvSUZ5HqWSIITzJ8FOE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:ddlP2X6qZpYqZ+jB9L9LWBci5A8UJ4cFf4qVjWCJuIih71TO6MOh5p8fSvEoaDHQNeN/9bNIbItVC11cnKjDaE8R25ZByJBId10nrkZ9+JUnseEIwbnZQc1OuZmvooEoOSCwqRUz+w3Tk1HfCklfBHOekfIlgpwAb25qL67J6YKkMycubNy3kWobCdJOaWjTItJSkmgqY6rX/WB9q6bBH9jkBKU4pL8d+cc8S7scwUKq31UhAxEX1HA8oT8QVI5p
X-MS-Office365-Filtering-Correlation-Id: 45e0ecbb-6bd3-4ea8-601a-08d5a464b82c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:11:23.2487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e0ecbb-6bd3-4ea8-601a-08d5a464b82c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With bus-type/bus-width properties in the endpoint nodes, the video-
interface of the connection can be specified for cases where the
heuristic fails to select the correct output mode. This can happen
e.g. if not all RGB pins are routed on the PCB; the driver has no
way of knowing this, and needs to be told explicitly.

This is critical for the devices that have the "conflicting output
formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
RGB bits move around depending on the selected output mode. For
devices that do not have the "conflicting output formats" issue
(SAMA5D2, SAMA5D4), this is completely irrelevant.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..244b48869eb4 100644
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
@@ -15,6 +15,14 @@ Required children nodes:
  to external devices using the OF graph reprensentation (see ../graph.txt).
  At least one port node is required.
 
+Optional properties in grandchild nodes:
+ Any endpoint grandchild node may specify a desired video interface
+ according to ../../media/video-interfaces.txt, specifically
+ - bus-type: must be <0>.
+ - bus-width: recognized values are <12>, <16>, <18> and <24>, and
+   override any output mode selection hueristic, forcing "rgb444",
+   "rgb565", "rgb666" and "rgb888" respectively.
+
 Example:
 
 	hlcdc: hlcdc@f0030000 {
-- 
2.11.0
