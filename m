Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932935AbeCEFda (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:33:30 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:27553 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932788AbeCEFcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:32:46 -0500
X-IronPort-AV: E=Sophos;i="5.47,425,1515423600";
   d="scan'208";a="274206554"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/3] dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8a77965
Date: Mon,  5 Mar 2018 14:32:43 +0900
Message-Id: <1520227965-4471-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.138]
X-ClientProxiedBy: OSBPR01CA0013.jpnprd01.prod.outlook.com (52.134.224.25) To
 TY1PR06MB0992.apcprd06.prod.outlook.com (10.164.99.26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1026a5a5-5a19-47b6-24c5-08d5825a83eb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(8559017)(2017052603307)(7153060)(7193020);SRVR:TY1PR06MB0992;
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;3:w4UuguUu510rhsh1mPeCytdWOLqWqYn1fh6ZbenoW5X2cS48TezBi+35plWOuH/0j4wX6dTQKVu55qxyGLWRkyLm4KNLY4rA5WiUDStXNag3lT1tAGpo34oXHFzClKPnfhrVnyKDFZHLWNj3cvMVjow5s/sa4iUoIwt08s1WjVr50VbYkrjfmLJRUDVEPp/gxNfltUu/Dyt9k03+JiLSFPxicwEfUFxt0X+GSDsuxoQkcCufRHfwveWhBbFforx9;25:oP9hugh7XAygH0FC2x9knHzyUjGZ1nwnL+1rDUtDfesTsKB5ViDQfTcXjEcwnNmM/T2TwbLHYTWSPG87deeqt32U4S6XVGK8TZhpwWtaBkFY7o+ay71fllPIMSL4h2N2nl7Bst7/LxQQmCHj5OyYcZE6yII+ORk6eAJschK/xmfl1V08D68GBKlDlm40Bbu2ftTDvDirMnqQhYC3CSfsFJp0WGsIuxhisd3UhMgUMpaIRrR5m88bxZUN6Lsa7KlgbhIexZpiuN1wpS3DvY+fTzU6LWUHQzVZMAdSvEvo+xCZ6ZkaiML8+kxVz2r+CCJZ9CA3fvo+MZ0MbeA5xw48TQ==;31:Ws3knI2IyBTQxxa3nhTjOI1ykiWwoj0o947rUuEzfNbARtVcktzqZBjJPSBQOH85Iw18CwxGpaVs0edKFpLaXvaY+I/0wte61ySg17fGKrOh3Af2/6DVumueF5X/5HEVnsgzderoB6OPYvNWo/XZ1SCEdRlR81SNSdnQXBhLAxD6D5v6tUA9FJGNb9nXp9uAvscM4IbjUz1EKKfXphntPtqu2VKmLsOI7hKDx4ictJg=
X-MS-TrafficTypeDiagnostic: TY1PR06MB0992:
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:mmXiSWig69Vlox067qQFhVTaTFvhoVOsji1EMNUxlogk52JpWOeribXoizPEBbY1aCN6Dhj9IO3Edi3Fs62cnRe5a3Zcy9pUUKSFyv0IsZ2woOu080ueCLmvTd5swgAY9gm9s6OlN2F1rHhxYBEv09rROZ5f5RnqJegeW73hXWl7RIEDuNTsWjLKZiq6ZV/4g+uSyewmGcMBMI3p/viEU4E98FFyMEZLWcbVbMimmeH/y6/Og/36hUx75sbGVFGY9M+0tp5G8S3G55nbfukUK6/hqlbEI8MxYw3cauKxbFWulCoXwCwEuRgN58eRWPddcdXRqI9kiumn3RHBIlJ2lcuJS4N+88H2UT2O2IScnJjqhzNIxU9UQ8pWkkRGoaIWt4Xiwz6r4jrEUYg85H7niERG3JS5m5AQABCvGEUNR94zdxPQ9dOQ6Ja8rLbMi7gcIQZBFOFtggwF2y8bQV9KYy0Djl0UpcQXmYF3W7HjNOBgJs+WHq0okXN34snL2G3Y;4:LCBrjTc+I9sjvNZQs7XAmYlJr5NGbai0DvlSJzSrAAOoBphAl1d71vMVPWN1UgoSMWnJq8Dr6+ModxQVsEctsr+9FLOe5f6RWg4yOyZ1ubclrOTBkrH2b17hfSokh+5lYsee0a8HFOxRSoD0e03BIgHue/e0ci7UWOCEAzNrE+Zw3YF60d68V6H4qX2duO/CHroebB+plNfUWY3j2V85d4YIYJ9t+4hid0WYQX4FqKw/zuEWI8hNF2fE5UrAQJ9zrKYIDowUCbTJslOFQj8KaQ==
X-Microsoft-Antispam-PRVS: <TY1PR06MB099284D87CAA3E8E0448C15AB8DA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR06MB0992;BCL:0;PCL:0;RULEID:;SRVR:TY1PR06MB0992;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(8936002)(50226002)(66066001)(68736007)(7736002)(48376002)(16526019)(6116002)(78352004)(498600001)(26005)(305945005)(107886003)(36756003)(2950100002)(6486002)(3846002)(42882007)(25786009)(4326008)(53936002)(97736004)(5660300001)(6506007)(81156014)(81166006)(16586007)(386003)(47776003)(316002)(2906002)(8676002)(105586002)(76176011)(50466002)(106356001)(51416003)(52116002)(6512007)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR06MB0992;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:0;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;TY1PR06MB0992;23:9sO4i+PWD5+J4E0tQP0PSc/kFhjJ/17x1pypm4KB6?=
 =?us-ascii?Q?C/zNvQX9ti5ybh7KDmUlkCnG95IXJG0dOzxgbCYtuSE//JYbpvmilLwnHVu1?=
 =?us-ascii?Q?EpsB3wmYkbtDA40A1WKMY8Am7iI3uTNrTjlkocEBSdRn3pYzX15Uy5hPOI6Q?=
 =?us-ascii?Q?GGrVNUZE5LAEtilrXeKlfjiZaLJqY9INp28GzkfhDlVw31hk9gxNctWJUIJz?=
 =?us-ascii?Q?SHHgXDOkQAQEf1Bb16NWFVJN7FZVOlSmQVKpBRLf3gb0vKx4lhG4y59fSQF3?=
 =?us-ascii?Q?2wTjTy6ejluB0ra2xE2IK7t336tms4v0PljWi5/ApoYkQuZb7qWdhsO+MRdT?=
 =?us-ascii?Q?X5+HYKrlzUzJR6uY0gQyG54A0/rMHeKDx3tp/pwBx0PyeGLrPSTB1Taude00?=
 =?us-ascii?Q?E7h3Kvj+QX+gEvNwEuy/0gtS89Ft22+DoqOBaAB9Q55I0rzll9/iINLHyxkH?=
 =?us-ascii?Q?Z7roKhRn7dk1zM2oNKBNBUPix856w80GTb6o4vWkldMDjzsDQfpO6vNn/NHs?=
 =?us-ascii?Q?ot2wtcSDlhi8IUCxnXLAIrukFvDpG2cTmz32cvwA5qnro3a+nMjbk3HPkX9x?=
 =?us-ascii?Q?HIlwhIQZ4BklLkuqlugspxZDGUf+sHBuzYSAGINTsxqvgKGYq1WBaMXne4rQ?=
 =?us-ascii?Q?2UyCztylgmVy95GV1hvnMjfH13oPPc17OX9ZmM3M9VHtFu3uFzx9bjWUjxQK?=
 =?us-ascii?Q?abL0WYNNVH0swuctpvBaS+hFzvKmoCe5MZjdo3/COE0C2eRS/CTBk1zKEvhe?=
 =?us-ascii?Q?ATGxbPzUfX+LiQKIPH25JTbm5OiOXbKUO4EDRl49XFr34cLz2vF+ecQveWY5?=
 =?us-ascii?Q?LO0XZP1S5uvx6t0KjzbTFyVYn8skYtwrfyWMqsFtzEhIAwCfzgOl69e52Uab?=
 =?us-ascii?Q?v6FOdz+TmtFIb2qYdTdwLlbKtqCXpI8+5Rrwrwsaeavg1hs9EkQAU1K6oVi5?=
 =?us-ascii?Q?vtclTYVEs04g+8PrpznAryRigo9sQEK+TFmeThrUnnwbnZuUVIbmA4l4x5dR?=
 =?us-ascii?Q?YM+dYxFnQBgDFq92rCU0MDCOtKfHBMAqshIXRrJ3QQI79KjQwbzrlEJt6cMW?=
 =?us-ascii?Q?OjleMn3VKONXkqIBIo8Ppe66B3ST/7bwEWuDsa95DbmYhfvlznQSczbMQn2D?=
 =?us-ascii?Q?NBNoK7hiY1DCt6nJMecLKXVzBcPJQxx?=
X-Microsoft-Antispam-Message-Info: bprLmCogbGZMgUqVpzqOBZT231mUvoWdxg0vEBcKxHxc0VPSmV1HiSbSBIgYMslTzXu1Bd1Ds/6pOM1eTRH574n9gGNPPOnp+KYhNYxCwSGP+V/DOf3qVgRUSzNHeKlV4fkiGa/2nGChj4f8Xi8seAlZfKX88xetRoB/Bk+mCnRhkpxxDVBKrehk8vn232k4
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;6:70OiCX1pF8rbbTeyt3eRHWV57Rv63h5FQtEPRXC8UrUBZ/F4TRoTVyDd276920RbMTLUi2xFNWGXFtS1itFaQICeM7QgUDgwe9INu52LwjER/LfMtXb9IDO1jfr0UUQxZKBhpZOhL78R6aw+SIgrLD2+w3uZH8dhH7x2Etw5REgCf/dDbLoonLRH0NOtb5gQcI9Z+vR8S/tevywq+bqLM1pK8mR0OLCYIoshbbrFmY/cKxOlsRISaC792yYf2f4z0LphUzx3fp5hY/MqG3N3bAtcarg9TE37TFLBdW726SmaLsrOW/4P0fSIzyQWoPHdp6urQ36ATvipOjr6gnuieJrbW3LYZH75iTvJa+u6gtg=;5:K54/fUIqenONNow0fd6TLx92rzAjyuOdfV4FQlglPiTetjxGhbGQ1eQlw7zeljID5+kPHV3ggF4DyW6Sx7IjN8mdQB2gA4hObsb+PPGAQD+OR7+6YdXnILeMXOYx9qu8hXqEO1MB0PlPCMQswy40pNtXBpjiqPHxKixnoFz6lAc=;24:E/rloeaOt7oyMTP4dJztRauJKan4GAINntqldwcTKEJv5sAbNbdR2PRbpc3UWfDNvxohfRSuzpChFivEXSrZ0IEvG+WAvosq3fahGkovi9g=;7:tkayDyXlJQ79PjwqO9jl3fG8y782XQ8Ix/4NALUnQP8Per7dFjkZLY5MtHUIlSeHqsPu/0JlQH1A6QdHkgJ+5SES8mRPqEWbctja/INqHkjlhnSAtuFIlmK4p90DbTUL8iZOiVcP1XOI0eC6oL4qah5bJa38wi2PDm1eRu9BEFYX8nKyqhbcF84Ah/83F9xFkh5du9Q6W+e84Y1Wny2KBPusVVhKicH2a4puZvQAi0Rh6Dv4i5KkDhMfcHJVEEkw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:KqDMNK35OVILD8wsjfRv6dUN6epQ5L7DH8+SSKvuw6NxqVdtsqJbtnd/E7tMf7aJ0HiypVLqyTzz390ocH70tmqDqISXgNiy8PGy3T9VDW0RID2BsnEXGtI6Ba4wHxk3dMoJr60qHpap5rrdb4JSLghHASJAM4vjP5HB3RE1eE0=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 05:32:41.2498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1026a5a5-5a19-47b6-24c5-08d5825a83eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR06MB0992
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for r8a77965 (R-Car M3-N).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
index 99b651b..dbd137c 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
@@ -8,6 +8,8 @@ Required properties:
 	      SoC.
 	      "renesas,usb2-phy-r8a7796" if the device is a part of an R8A7796
 	      SoC.
+	      "renesas,usb2-phy-r8a77965" if the device is a part of an
+	      R8A77965 SoC.
 	      "renesas,usb2-phy-r8a77995" if the device is a part of an
 	      R8A77995 SoC.
 	      "renesas,rcar-gen3-usb2-phy" for a generic R-Car Gen3 compatible device.
-- 
1.9.1
