Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeB0F6H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:58:07 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:61673 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750891AbeB0F5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:57:30 -0500
X-IronPort-AV: E=Sophos;i="5.47,398,1515423600";
   d="scan'208";a="272235451"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] phy: rcar-gen3-usb3: Add binding for r8a77965
Date: Tue, 27 Feb 2018 14:52:27 +0900
Message-Id: <1519710747-26435-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.138]
X-ClientProxiedBy: OSBPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:603:1e::31) To SG2PR06MB0981.apcprd06.prod.outlook.com
 (2a01:111:e400:5213::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c676cce-6774-497d-a61c-08d57da6fa95
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(8559017)(2017052603307)(7153060)(7193020);SRVR:SG2PR06MB0981;
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;3:qizF983Nz0bsKhGplwE/1y8R0SJA2P61SFP8l6btIC8pHXVZpDEiVu7mcRCWORxxsiK49+fYvxixF2SKlv2wKUhCUSjN8zGKzCw5zV0cs9R2IqZz7OzSUh0ba4EC11g12vO/tPn2lwTCCsRzsO1q6PmV9GyXty9kTxBY6QkAQiQ1L2DMOizgjcPUtVDZCT78S3MMAeXYRS09hSj42h3q0nn7v1T0wud6AvF0ViiVwC067SsQ3uuyEOpIjJrWbd/a;25:FTqOGqFu9GNF83GlJqVYrPlzhSuUrTaINMdEfihnI6RxuNMmtmiwop7OdiONblZgTnHvjRXQlELEetGTXIgVC4hpmIF4PtvdHtz52DslmYyGNKFyjw7XsRaUmjkAJZgo5nAMmqDJMao2UT6LC5+IgXfcUbCZyoTGAWrp0AWqC9fgHj21YtXFhSYL0wfsMlu+bE+Nmhv8IZ1yqJy69RLGTin4K9UTHxumKrFQcFhWy4S0QeS9OlS1d4TjW3bR3vo3gQISuXdZbPadEfhA6WXIOMsOGOiiqPeKR9J9WqkPJ/e4tCZG6J8V9j7YK6S3cvjkmAP0mpkJ5WnEcNmZCAA7rg==;31:lNzMIrdgwl63qbbf9vaHqv44jHR7mAup7TE6QxenGQgYM+flKA6WS5cqBm1x6oGkFwYnPJ/G7lj0MHqQyzpCM1NDjx7WXqy40hRtDHs+YSUWUg9lFT5qGCtvr40Y1IzMcfBm3X4wwdr/Thadp3/2wFi38EnOYS/jcajqIx5OOqhDruAlFdGxkCs/hpXhpHoZl+OW7fAP+EhrLP/nvcWzjlvQEJZDvhMZzFWWa8vFEfA=
X-MS-TrafficTypeDiagnostic: SG2PR06MB0981:
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;20:q6Ea52by8GWPhIoBl1Pisg3Wbn/+ZJcBMccdIfATR0pMV3vyYgODEi3z2Y5NihS059jJR6D29nqlyd18e7v1fA+4X+b0Bl9r+dCPKj/x05cV9PCYHixjRDuuQ5s1fTwMdJxps/tXTPbyO9yWREWwj2w1COtXBpya76EF/Rg/nyjIEQHQ9g4Twp3aCFNyGj/JD23+Zs8zMJVL3VxsbtjOOVTTN4U+pA6s9ocU9deWuNp5ZmMsIfneuO4CbhlAcvLGPsVLeTxaFmsXvWs2NpoEku5DCDnGiXgpFyLG22auxOmDQHmY9EQ+ASV59fANyY3WNHPZpYNArCDw4hCxRSYMdJ26DjULimzgqkLvX5poBYzQJD6O5ULLC2EbjdoYcRGzXMKXpJFlhEeaJ0fjjxqDILEMA+lsU+Xqw8j7CeQQj9pPqp8wHLMB3qTcPygUrUjrOmwhng+03gQnpde1gwgkp1d8DIOSmqwIFG7pmRy6YNPpvnORBGnXjEa15n3iOftY;4:p2eVe2YkOYrsuzPLG3w28gCu3RLO+Vad9ZNkj8u02nG/UQYJXlMNaaREYeqk5hnigcY69G1+iYzFEGcGFR5JCo+k52fsj6dKIV28K24/X10+Fm/g/Ic12zxoFFe8LVMcLYUH3akJS/EudmDVtIzwb7YpxEn2M52sZWSheF/aa1MFmTZopTNRHLtu3f27bknlLD3BOeqRW9GveLMyPu04X1d21JiVDrTBuBurDIlgpm4CG6cwTJCCHegLgP+1hXk+uIX17yisZlcn7Gj8uN/+Og==
X-Microsoft-Antispam-PRVS: <SG2PR06MB09812AA0CC3A95DE030C2108B8C00@SG2PR06MB0981.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501198)(52105095)(93006095)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:SG2PR06MB0981;BCL:0;PCL:0;RULEID:;SRVR:SG2PR06MB0981;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(2950100002)(106356001)(8676002)(386003)(6506007)(3846002)(26005)(76176011)(42882006)(16586007)(316002)(66066001)(6486002)(52116002)(68736007)(47776003)(53936002)(6512007)(50466002)(51416003)(48376002)(498600001)(8936002)(97736004)(36756003)(7736002)(107886003)(25786009)(50226002)(78352004)(305945005)(105586002)(4326008)(2906002)(6116002)(81156014)(81166006)(16526019)(5660300001)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2PR06MB0981;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:0;MX:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SG2PR06MB0981;23:qefl+B00YOk+5avlpPC/4+9zfY8YLDDAAPbqsdyMp?=
 =?us-ascii?Q?Q7OYhNPHcPUiobak3DYV6bEvkoMBccRAXsS0z8zncpdF1x5BzN3i2tyAi8K3?=
 =?us-ascii?Q?ooX2nPx+1nwB8peh7jHpAVBaXD+iANhfZFMUgRHdXR07omgR3JF25P3ihCVV?=
 =?us-ascii?Q?YRyVESY2J8OpXfCJ8Is4AegqV7mZwrnmh2y9WVbpm3SZlrs5Tau7WsQ8t1na?=
 =?us-ascii?Q?ct3bcAwXfsymXk9YJVMJxj2IZOEZELxDuNJpAKgiOmhnYNfHchFoie9qhYO4?=
 =?us-ascii?Q?6/e36XqksFW00bjaHuErlsQxuGQxsBUQgmz1qxWUwvStzf0fEoASxBgIXn2c?=
 =?us-ascii?Q?nzcs3sNHh/Euuj+HndN88drepRb5cjBbHA68TzwHj5bdejBpbPRjjyY+il6Z?=
 =?us-ascii?Q?JokASnPiG7B7yV0g77nZ7cy3mLUgOR+/BrHwEiFqUrMn9I9C/Bl1m/HMyjZp?=
 =?us-ascii?Q?pyHHOyJgoc/jWF3niIWU4sT4s9/DLqm/wvSEQfEsWSHyiYlevBIpM11aNfTx?=
 =?us-ascii?Q?hr4Znp6c4VljkgSGccLQjWKzGE+dfyatl2dnVeX9CzesR1U4nyYRc72CHwXY?=
 =?us-ascii?Q?TGd4gK4bY8aCi9m/u5ajNATlb+tAnRLul5eR6+WvTEf28KAJtJpN38VfhXd+?=
 =?us-ascii?Q?wBlYx71rvO/aXdEMMD8CeRJoKBVOYR0zSlsWMW2IjSpa+F7QiMcWrwuL+0RE?=
 =?us-ascii?Q?3QSIKhMOHq5BU8Jm8WDGoBO3XYi2FMlaveIp1U0oteUUsGCVznwKwdXh80Mt?=
 =?us-ascii?Q?gmoS8DTZHrwxOoAT2kgU7bXXlvO9i6dDQpelEBUO6ElWMrpF78h2y/tjvc/9?=
 =?us-ascii?Q?4BwaHwGc+7CpnehGzA52xxX7hpLHq5AAiEgkhk/JU0Nc/L+sYnhJVXTG0/1t?=
 =?us-ascii?Q?JB3c+CWMo+G0ioPkRvkWC1qR3+p8njfOC33fuQ8Qbw0VIp46QyzhXr21Jq0n?=
 =?us-ascii?Q?Y8LrCrjyvIah7cAIbAyH/BffdbM+9Ld3StO9+fsKmEyDClN9cVK+mkKmBSvB?=
 =?us-ascii?Q?VnG/xBkoZsKTr14tu2TytTmm8To6pqbG3nZTPC1OyfJtzHQNvskaZUAizEnz?=
 =?us-ascii?Q?iqDVqytHyiwz5Afa43w5GSUIqW5zFOVcisYQEV1FkcY3xMSZZKKmDolgbRWU?=
 =?us-ascii?Q?0M4PLeGr16INaeiwJARKxM49NznX/6h?=
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;6:C5N0rng/bPaPL+CWL97Xgk3gLSqWUeXEoUAAr/3n+jptjLSYw32CL7x1G/Vlvyduc5sJrTyxzl7Dgzin+y09iiAsVvz1LL1yHwPbrOb4r4evUO1pSVTKxyr/SoaCLiKw7SJFZfhzQH97pLCijXbRj6mJrv+2anJpmIRJNpBflBET6XqK3pi3cuFUx9N2TWdBya2NUr1F/rTm3iXDwnmfWAcAiOWi4FKpvUgP1mLDNkzdgf68Pj8jGG/kaH2d5ApwnBR9AH4aG4X8Mbf9mHb+tnGbhTMxCuZQOWrtG6XNRub7JkmCsoJhzsuzlfuGRsLQ2i/Uq/m3b9vQhKRLNyDNFFx7RcvpfOCAYusGDF78Tvc=;5:/F6g3cbSI0u9NadTMjL4E+WiyaJfcrihClyX407WoFXzCpL7kgbYk1r/h5bbknqWM4dXWj6x6QGhZGOpmEqbsvWsG+RKh/JxJMmSPup4mumsyBjo3Me3pPcACxTW2IGegmbgrzHdIQUYF8rN7nHd7ARotNBC4hcxwf06QI7LgZA=;24:r/8wLAJw1dtxJNP0jH9sbpjAqmFhaMLpBugmTNbcrCzuuDUAHbN8vqJgA/p48iG99lwo6JZPn8vxfPgfYRzeuTXuBEAGouqZjWs0e7M9zlA=;7:bSLFaeOk9+hefadqWUJ8ufFRQ26IRZ1VoMU5nc+pqQb5MSVYiZUCZHaIz5ZEx2mFkuH3I7KlW8BLsIkWbbYgZ5R+fWJC3oC5D3F0iAjyIRE8tIlYADo/kbAZRqCdM0u9Hnvk7wMuTK686vvAttt4xP197GW97ouX+mWs2QREyS4ZUuKNDhdm9RgeN26AhP1CMrKtqkynTtmPWmaqZterOjwKdTmRyOwGFf9GubwPaW7uxfWzuWVOJRyt8E5T+48G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;20:A9EZALM2iuX/rDiZ7bHjQaRKZMtao5pWurS9oXI9DyXqtm2sKh5wHJaqGZ43Woq8ZtSLtcN/fvFp4LTYNVpbeLxFipaRmdsZslm1POj9HgWE5zagJrn+A0cxU4WtBLshplFrGxPs788vC6o3RGmopr/YJFnn/MA6B1VrY58zGKc=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 05:57:25.6666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c676cce-6774-497d-a61c-08d57da6fa95
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB0981
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding for r8a77965 (R-Car M3-N).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
index f94cea4..47dd296 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
@@ -11,6 +11,8 @@ Required properties:
 	      SoC.
 	      "renesas,r8a7796-usb3-phy" if the device is a part of an R8A7796
 	      SoC.
+	      "renesas,r8a77965-usb3-phy" if the device is a part of an
+	      R8A77965 SoC.
 	      "renesas,rcar-gen3-usb3-phy" for a generic R-Car Gen3 compatible
 	      device.
 
-- 
1.9.1
