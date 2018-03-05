Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeCEFc6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:32:58 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:61936 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932813AbeCEFct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:32:49 -0500
X-IronPort-AV: E=Sophos;i="5.47,425,1515423600";
   d="scan'208";a="274206555"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 3/3] dt-bindings: rcar-gen3-phy-usb3: Add bindings for r8a77965
Date: Mon,  5 Mar 2018 14:32:45 +0900
Message-Id: <1520227965-4471-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f53d375d-5cec-4cac-4538-08d5825a84ac
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(8559017)(2017052603307)(7153060)(7193020);SRVR:TY1PR06MB0992;
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;3:6FbBT9DwOA90pd7EzWUVP+SOEkMYx1nn9zk9XgKVMM80WkbafRvH804jLZd7aNW+gfAkxaOp75J9WKgu5xu+JOs5xp4z1oQTh+hVeLgKt4UGo27r/xE9aBYtGpTBeOQ7dFSaku0N1szGGCNfFMRnmvpu1HDfTQDuWhrD+c32mCZEEXfG91On/2/yZksbtB/icMkF5zrUy+FMNWyDfNEiG5Z1imFe39b2amy7J67/MC8yGw7hBJEt8NwJLZolIdUc;25:Q3M745cno3VwH5mne+sz8xo3ZsedQ0gS0xMNRMD3rXXjaraDlESrWOXyQ0b2YlQxATThPMkseuHxvXoATiw4mhiSRCdCNPDq4bU21Z20s7dpclsbjnNniopZ0X9+fT0RLalia1A+XXEIR8lnVSyeF7bXx4xahLLF2ksK40jXZTIUN1Nf+sPWWggcPPf4dejXurkF162EogDFrEKo9ZxD+Bi8T4FGsda2ci5mUXRw+DYM+kCr3heg3CfEoHNQUiWEstd7ZqDwizDM6lKNV3S3+5x9vA5vlodQo10tmwAnRtRpmj0K29nuwzsRqdsTdd3JDpZ/WeIEjfMXhTUmj5drtw==;31:jUUINElYjhiGmsv6dzJeKgcxkwQB5L3enotIjHkij8ioXXdvRaacuAnZ1g8uCHK3jt3/ENKr9SDPqJZWuJ9+qpn31HqmWSLUkDtqqtJeaNQUPBMam/slVvv3WIJx/AUJKpfIciaWG8CIo7jGUwDDTBIwQ/Ro8+TTgJF0deqv1wJ46rGtcNCGFw/gUdJ84vpoKWaAgj33a7rnzs4DNdaT9y0zWPu1NGXyqC6/T4xnVkE=
X-MS-TrafficTypeDiagnostic: TY1PR06MB0992:
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:t/bt+WVR4II1H9a8J6lgFVBQ5u7rSnl4GOhoFy88gNGWRlYSgU+0aaB6PFtcj/hAQab7YLE536yYLOxIylEAK8wNwlUd9lnKEcelHnWGqYC5Rswj1z+E9lRZUbLY9S3fph9fs8lIcc7O7aBp9ffIhVq9rGEUrrgrrrtE6GeAGmKV5OCgRSIq9mcmtuKov63mdMpVVl+C7XEnguC1Z2JPUYW/TfDqI1CPny02CKI+wM3SsTHGw4TP/M74VPbU/ypwRvZtmZ8zqvSZf9P45XW5rElJOoc70WaKFfQoiPPCnpp7HlygGUF6xTlK1WdFP0B34bYcNwIMilqPH3XUMkuaoNsTOp0cat3DYt3Ty8CMRulGUudeQzKmsFnZghRkTojU62fE9nwAqongIgRmjlMzDvS402zETgT+rivFeKic3BKKXye7lTkUIUViudoSNuAwqsPaIoyenjfRKrHHAZtbp0+ZaKYgb53b3F06TuKT/20hDjAx42zDacEgG09eVM8O;4:l02H2ydMlxl7jcKVYRS/oY4nGdm8hYjC/aUvUjYpire445Eff9I9Aiq/iToz4MzEfsz4dz2YJACYuAbOj4XcEEMUKhEE9Rd5G6IVo0A8GTIm+xBJFnnDKeQ86bywK+cm/2xcRUknVgdN1OlcZVKEoIHY7BYLd3JVyFGhyIUxJ1mfoww4hTER40v1TNv5BJJw7jymDpj3vbCz7VjXjDJHh+T4ksC4A8eGS/dSuRpk0naXcFaDvKSa0qbPsvFp/zIPAFcm5UezHjO0sXory6VHXQ==
X-Microsoft-Antispam-PRVS: <TY1PR06MB09928B4F32CFB9288674B098B8DA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR06MB0992;BCL:0;PCL:0;RULEID:;SRVR:TY1PR06MB0992;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(8936002)(50226002)(66066001)(68736007)(7736002)(48376002)(16526019)(6116002)(78352004)(498600001)(26005)(305945005)(107886003)(36756003)(2950100002)(6486002)(3846002)(42882007)(25786009)(4326008)(53936002)(97736004)(5660300001)(6506007)(81156014)(81166006)(16586007)(386003)(47776003)(316002)(2906002)(8676002)(105586002)(76176011)(50466002)(106356001)(51416003)(52116002)(6512007)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR06MB0992;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:0;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;TY1PR06MB0992;23:cpmI4q8eSvpDUYS1KrREpwPluQDzWdOQQSDQt13uI?=
 =?us-ascii?Q?RWszGylg2jXLdgg69BGttyczSrRFHiDnLp+D/81Uloiuen0QTFtredEC9dmc?=
 =?us-ascii?Q?vYCMSCGQRoLG5JZzB9JbpVsSzJGvWfmPiMvTTmvPbzAhdmp36qE3PHkk5QKN?=
 =?us-ascii?Q?hhEcwBW6ne0+33WrVSWJXTnjk1suHH5dJkLOI3j0wCuLbYo5C8emHEpm/phl?=
 =?us-ascii?Q?/+7tNIaRPWZwxaLF/Jb5nXVYP8jeoboSGAp5KzOIGeXSlcZ5dDz5nwOWOXIJ?=
 =?us-ascii?Q?4IgPl30tHepjWbPujUpLPyq3iVuB6uAvDHBG3JHkSoi2IVEQ97jLIRClyeAH?=
 =?us-ascii?Q?doP6VVWhpds/fNAuGhWQ3lcSysn2GTlCfU1b8O6U86UgO6Pv0iosW+eg1HSi?=
 =?us-ascii?Q?NbUF8r6tJZx1XIbKLXP1krjNp+8mJMjfjuo2bnMHCeLhCMZtgK3PVUI+eZSn?=
 =?us-ascii?Q?EVmxzTOc2NrN7b+FxjSdWXStJ+/sOWGJHvgoSF4LyGbCfAMQrDSw5Ocgmhqg?=
 =?us-ascii?Q?jhs+4Hr87pAp4ogY3TQ85gojfAfEGZVJhF5zruNwY4k312AdNjA3LyvywaYk?=
 =?us-ascii?Q?5Mvt3NP62IbA01F1IyV/BOmNl0OkXoM9MeDuSPpR0qnwUNPAZ+oVU/cql7ug?=
 =?us-ascii?Q?UHSlFN6zVhAZ2agz0Ew1oVlnPn8S329sX6SfZLI54Bs/Ou+UOXnttqPFY8lQ?=
 =?us-ascii?Q?h/WnqmTX/KoOGmpzFYN1lSyESRAz1o3WBcgEmoqbdFSTJKUFIutI1yKp3KzV?=
 =?us-ascii?Q?A14iN1VEgXe+am819wqs6btBsYODHUeafgPR0wEiVlg8OlgwmR5KaS2BDkTy?=
 =?us-ascii?Q?D3KwYAgX3DCD1BBz/6IgEARwiMnupWQPW/yeb+co6ZJwncdtO2fb84VuUqr3?=
 =?us-ascii?Q?DGdZxwjbwI+MTDsh/bpo1VDHDkXkhpbeZFU6gDqncbVxfywi+d776pr4g7cd?=
 =?us-ascii?Q?SJa8yj0tXCSz1ohc5Xg4XFr8uAM7oLtvyLrLSaVEYNBjbB9lkdoUqHRILrh8?=
 =?us-ascii?Q?eEwsAnLKKN+ygjTOO3mswcpqbpaNAadm/gNS5WbpRxCFqwWdkR6MATuNA9Qd?=
 =?us-ascii?Q?yepBp7/Eh++LSpkYAksbgUGlqmpvfx3x149PvQcjlElHmlxtZQUKDhOlwE8p?=
 =?us-ascii?Q?+YeVCjCj1hmUrvrV+joyEZTAwGugZl5?=
X-Microsoft-Antispam-Message-Info: GAqyyAEyNcVKNAhOt5wARI1SjI+UQXRjHd15QTP1hae0Umd8ZcwHQ7cKdZrIgBIJn/57jXnq35XcLDGXjghAWgnAwcoq/dpHc2cdS6BRdlObbjxOAJxezCAxYcPQNs4UKZNu18PCvYxpFOCdHpH7tgGqoO2RvE/0RTXc2Bp5q3/cY0jGxVBD1neiuwPx26+x
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;6:PLT3j9eDVOB0yV7sJaapxjB0GupeFeNuSt6fd6f+dt6821BLU+NNqJpBjUNROeYZQlIXacnRF4XG0/2EXfKOnrNaZuBJ7cdtW4pAaMKRQxhpekHDuxBhzxdC6787QRoI2gB1fOYstvBDaBpTlQqSTiQLkehTnf/EwuU5ABtflamG8n7FZW9IiOEkGSIPQs/FbwQd13R0YvSV/b+EAnkTHcy5J3nbNhSTnovXiGhwekcbvcO9DU3wI6RBlmTJiIBxc0hv6pUPHx82i+UiuKaXwNZPvraBmUCYa/Fa7NVTOxsVd2SqzQkiT4KlPKFZEG1kFrEKUl7rMnIsPd8097FlU4Ne0t1Ss7N6x9Nrk7mEkI8=;5:IqRzRSokEcqY2RFzeFy5ai/ouYnXlgK1yM0N/O4xqe7zbhaGprXjlhFM7fVvmpa8vPiXby1bZDmLOrp25ow5Lw2lTMqlKgftqmviDl0izDwhylpbuda6wXbyN/AOOeVeBEIZc0nFm+j2nSrFP5IFqAwZZemUITSbH/RpN8PbMIw=;24:izFVgZ5uPqqqI6wuMO+Eanz8xDCt9wnNdEQ+DBtxYap6u8hRMCOZ9KX651az/KiK8tYSTtNaLihnfqN+zvqTFS9FM6az08g+ituv9daBqEo=;7:ZVdaFZFDq/Zco7cXrc+wm6xf5V/zfCNSnwEBaXtl2LQsAPvNeR+t4Efne3qBuDpzkD4w/osTbWuXQLi/h1XLTiGfmdczNJ8hYe0hwrzKfu4vk1jYdl7qSj2PtFhLTqgYeWKLqeO5mzanuqrzFN4zNRGOnhH/A7c/ceXl5jg2jHdwzjJ1c4nBXahQvjhU64Wo9FRy6jfERoQNaTSMKFhijV/Yj8PoOOQUkSg3HFQCK08Awx8Pli0ndoUVJiwkdAA6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:WDnLkgCaxSmeTHGn7eVsNOAl55I9EFxojomR0TbkFIWg+//flYy6eXgxT+h+a1CaluMb5HsJ3TVKwRkB92qClSvwYFvJ1fnrd5lNwQdN3VnnrsToOfIJ65widRbwivcjNqf5Lhr4h9DtqBx3DhmTu/tHfMXFWrDrs4B/rAnEcaU=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 05:32:42.5155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53d375d-5cec-4cac-4538-08d5825a84ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR06MB0992
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for r8a77965 (R-Car M3-N).

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
