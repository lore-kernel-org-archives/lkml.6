Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeCPHUl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:20:41 -0400
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:15340
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753184AbeCPHSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:18:01 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 28/28] MAINTAINERS: Remove Blackfin from MAINTAINERS list
Date: Fri, 16 Mar 2018 15:08:26 +0800
Message-ID: <1521184106-24475-26-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(50466002)(36756003)(53386004)(107886003)(6306002)(478600001)(47776003)(48376002)(106002)(2906002)(426003)(26005)(86362001)(5660300001)(77096007)(72206003)(966005)(356003)(8936002)(305945005)(186003)(4326008)(51416003)(6916009)(2950100002)(316002)(7696005)(8676002)(7636002)(2351001)(246002)(50226002)(336012)(16586007)(106466001)(1720100001)(76176011)(6666003)(587094005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2624;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD022;1:0Mkl0QkPyCREJ9qJxa1NHR1nN9dHzk1onYHUwnjUkWJTgq/dqRpAoQpyxyCfRThsWhE1SqLIFcY6yq5Lwd2S03HFv5z+0EAHa8clxsa/0Jlc0YI09slLrMFJaKDwa5Yn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e0909a-226a-482e-875e-08d58b0e0c8b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB2624;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2624;3:XOENDELX2zac8EvICsYrqGAE03tvTmTq8kSHiUom3+fiA4SfA2NRhmyl2gQa+khKQwqV7gDBoC2RKG+a7IThRZshAFu0t4a9yj55JDyg0NVtnD4hLJ+Y6xjCzumb0+IiNgPFI3f/MhU6pHI/O5PP98UnHdIphQcdrersZ3AH0ARzxtiYtWAcze4C7LV6Czgg9KVZOTQbCN7awWhbY7aEnrSyDdl1LnxqWUTQzSK8TD0TjxTuYMofXjIb8GKSJ9IF6dq/kHVlDSSZynQtuRTDt5M+JHakQ2391M7rnDvdH5ENLhSgcoK3562DehZyvHbP91rAIJtNHVTWuaz2/BZ+qg==;25:zCPWBoRxccNGK4NtKyULXfsDiUIhZay7V5gC+CmbuKBIadx7TykDahMh8yVg2TLkcGCU2FOwnPXxcbxn9PYoQymglbjSf6Vjngk9s7D9nA9dL4f177ls8w6+7DV6SaxLl+Tz8VPMNA+HIHkzm06R/ystWwW6s3ffq0Fkri1k9ukS/zHbKelJl7RgeE/Z99R6CP08qkcPbz9iKb7LMEKP3MEZoU8mht6Kzff22rm2MwSk54y0nbd1Cd/Kl7QI4slkl4akcXjlSq5CNWiR4XUOpM03c8y9DBhmhX2O9CeAmHVsQ+Poc053PXta79ZIevwRUqsIVmaHG8yCetbMPtG/zQ==;31:QQR2W8LLj8n51cI9zkl9zTikAG1fWcTEt+9uLvzUuxv/+h7IY0ju8Y/n3/1ql5/pSzyzrxIa0zfkJPlDG9GuYrXPKamAPUoWhhyTz+tcIBAemNzQmUgRT+IzyPEqcNBv+Re1HBuoGQEYgOmmnfH/LvFXKLG58zufqgSuxP2vo8IBcBCIf4inZvwNiqCvlchDtrVZsNSmDZ5BQh+r2l1w1ZrVJ3w3OXWDnQTtxIyvYME=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2624:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2624;20:oFrzdNQIl8oUv6MOZrbifECj7sABiguXNYRsQGQIi+3Ft6L3rNR6svTCTP/O14DJDBvLN5ThE5eFIyC0jIRk5dq/us6+Cpg2rJy7dtUAbt4vZJztRMDdWZNh+9AlzJLEzBhZ2Kgg3DJ4Nc53JL81k55Mc0fQeOg9vVyfotyR8oQYac+lAQO+9k6lRSYtOO+3lFJ+OtqH1CyN4oyMzKme0lb44t6ltQmnV7UBHbTJVbTOHvR5jE4qFax9yAO+/GlFTssnPAvvarBCpenltuwqeYk9IT33t2HaO09Lat60m5fc1+ilFkF9pH1h9n5ofulBLxcBmS6JxB5V5J4p4cm0dHpoKjNJVNMKlhNMZ7HgFvf1ZjVeHrfAQYVe1cJ4nH/xTPWD/UOJpSyXQyaCSwe1yBDmzRpltcHIuVKR8nmgUdxKpz8uY7vpScGxcEuVBUvAnwkscPiOFio32ibdSk6H7KmPmMu9oUu7ILIXnLk1wiXBXmefI3F01fW7AJBtvLr/
X-Microsoft-Antispam-PRVS: <MWHPR03MB26246D160D97B808A81DDC38E0D70@MWHPR03MB2624.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(143289334528602)(26323138287068)(232431446821674)(42262312472803)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2624;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2624;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2624;4:Imof8Q8lGRs7PVDvA+Ryy+DQNVK3PDEAZYrFPL2G06+EEnHvfkCxPUExfq+GGbWoZgp9ezrip1c9gx1s+n7cSbogPkA9xFUdWFLtkQTbtk+Jvty+WnFNoiVpVbqZx6VwaarFjFNkgzCSF70j5MSlFrXAqzw59B+2hNjbknX/baK10P6AyA2urMQuBEQpDpHO8whvwm+eOfB2JzGZj5olPgtUhv5JU6JTL2rBFgUIuC9PGUbH7gJZGCH9YKeYZi/ZWUZwvZsm144byjqU2k1WsGhvKaXn1NZ8h9Rbk01TM6bU1j97Adgm68PXX7Kzit/0TYRe1lNv8f7n+kKiK836UIGuRf3oJZs14XdJvCaB7UJUKkqFJfwtoWdOKDn8rm8tlQETT+Gy03XELTu8kasJqKVmImHG+31RGfQDOAxc6mBWS+emEWNTPe9LvGatUbf1mNG3MRazNstYKfRf3xIxbw==
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2624;23:+wDVM4LXa7VAe4u189aqEjy/mSiqDUxztOIlMoqFD?=
 =?us-ascii?Q?ycgzm03MYazsu2nurmniHUC7+toY4oOcvtU1347y4w15wKlHkYk548f8kble?=
 =?us-ascii?Q?t1Xk7yGv0nyB0rvbeTY40fjbWbIFXK1G9fxIrOr/HPFKCfzNlBkOrCufi4M9?=
 =?us-ascii?Q?rF5wzqdPQeNbg309NDTOZmi43Fa3kxkgMym3NqQuMQIJ8dsR9J0IWD4SesIZ?=
 =?us-ascii?Q?44vVc/5IzgBqRAQeu4YqFd8bMGv8jl4h9FhfoLTJ9bBKDK8G12yzKXEbCGA8?=
 =?us-ascii?Q?IzAQKxmgXqxfZg1VjS/P7o9luif+iw1LGZY6q3Y8VOuOgXRk9NRoioUdoHzq?=
 =?us-ascii?Q?V8K2wZh7PB+y9tMv9ItFQ4W1kBGOLAUzjL8DZwvZ8t9EmtjtYjC1vPf+MR/J?=
 =?us-ascii?Q?ClTOduUB/fAzKz4xml6eMa3lpt7vg+093PRXw6yKTJc3VaOZ5hoYaEVchP5g?=
 =?us-ascii?Q?o6wYpsqCro6WU6wJGtHIStzZym4jFgpmpboJBSfuqAiRVMY4m0MHfjlZAJUZ?=
 =?us-ascii?Q?5pTOqNJDaG3y2nsL8nc3+02SC3C31vN8gQygYMTGwiEgYBKuLSBEbRcKWpGT?=
 =?us-ascii?Q?16hHd8FzvlyAn/R5ofuluBxgTCjTQ72M8k9Zdzdoa+cEM3Bntsc2kD4PgTsQ?=
 =?us-ascii?Q?J2Dn3MxNB4FjFDDh1hFNDDHUk1F3dgDoYE+ig00/PV0XHdCjpqseJk6jpnzd?=
 =?us-ascii?Q?Q68Tr9EmwbuRtXmQkBQrNkNcBeA3qVPd07SWLqMX/KRi+odPl7StgO2dRtv9?=
 =?us-ascii?Q?3OwAku/BF9ylkoYyGzR+rzinguRtys7Bz2CPDQ2lEikY/2EIIN4IA23467kk?=
 =?us-ascii?Q?YpqPtIAsF5wO7Ol9tHEW1FTaaOeKkK0XmuUZ7oJUQL6hEy81W7idfsVseOFT?=
 =?us-ascii?Q?DNCIGfdeyisRF43wqEqbSmeo58IcmiPm/nKfQR3YChwdamp69wOC5BszWOrX?=
 =?us-ascii?Q?/+pgiGQEgV67cLFMxwo9jo5MlO+m9aozpVggRV57+8fxuqKWO2kKby1WGEte?=
 =?us-ascii?Q?Nn2o7OeZKsS47lhIzsUJKQSNLQIn6EVRR6I+RXr1G4teLOhyD914UvonoHeS?=
 =?us-ascii?Q?2QvvE1jcu9rPEJRbZkoeoVYO78WQShxgdfDeckl8oHAzV3/gg=3D=3D?=
X-Microsoft-Antispam-Message-Info: xwl2daJG+o8ZOL7ECmnFyOKJkTsm20XU2J+1oqgydyd2K5un8IPMcsMDDn3xHxFr2k807HW1/58P9Yof/9rugf3xmxUQX8zT5dhqhbMksbMRpOhcfbww6/F3CQqDJwTXqAvhmyaEwepHAHyZPspVHa6E/oGTqmlMS6sYYjuAPifmw9CTiJF5BjGWbUjGyc2v
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2624;6:MTtLOfeFh09sTM+E/fadu9Dz4iK+CrNak80AhuLzj8xhE1YFcyhfxyQt3V+zZ/7DoY2SZhx4iGM9dXnUnuJqNSb6VLenAumrgZvCJKPgp9PHSsi+3I/+j3KqGh9QZT0lBgoUGdkOtcD83VqCVYdai0vERsF7jYPWWw7FlGNkeYGZ0qAYRAnSDBtxaMrSOmiQeUaQZbpOkr2lE9tWkdHWOuXRjipNCOfFyKZS3nEPFxNhnc9QK+Y6+i1bPqziCbLchSepUNjMp11lap1T7mlI595+YFGXrPOx0k3sC4pgzRWP0ZyV6xaiLHUXbIoF0g9fhFFv5GKLnk/jYb1SrCtNIwLxwNz1aEVPQqJpDboRbyk=;5:yNGQh0L30A7uJXEQuRANQnRRcMuo3TQg60PhYUIS4jw1UyYufyrEeRN95H7M3kbOy+VFVArBQbs1SlfmgEeCTsqFztAYeiIqB0grcxE/8jfWIzMpQxLKk0HDK5UaZavpmPBUzVAW/P0BgMiMm9aolfG17NiAHfrQ1Y5TN7qh9/k=;24:Q8K9AQvRtCc5+0kv94IJiART9ESpK80QK+49G8tFhTjXEWfRh4yDm5dF8BLMpmtAb8yZVsy4d7ezaLX6EAnHmN0+YBJnr0rlZqpMxZIeONQ=;7:MfYgQUaX08j7SCgPXqcyQk26iRgt++OseBtrIm+NpMj4D3Qv/nGtx7xOLTXWbwc4BcvpajOCtpJDQuGrERVt9UBzae3oOVrzUypjcO+9+gxnbDutC0dYrKx7FoUT6n+nk2f43zSE5BCkUqduwIa0NfvQeSO7EJThymSRWXG0GdiCDXpAmW500lm9sidvvkL7egx2QwIjKYYIvIEOt5iZ0M/e7oyGH9PPUJaekH0q5k5mHFTaczJhUrUxblSk7j16
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:59.7662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e0909a-226a-482e-875e-08d58b0e0c8b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2624
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin from MAINTAINERS list
---
 MAINTAINERS | 52 ----------------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf..f5a0857 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,13 +841,6 @@ F:	sound/soc/codecs/ad7*
 F:	sound/soc/codecs/ssm*
 F:	sound/soc/codecs/sigmadsp.*
 
-ANALOG DEVICES INC ASOC DRIVERS
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Supported
-F:	sound/soc/blackfin/*
-
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -2629,51 +2622,6 @@ F:	Documentation/filesystems/bfs.txt
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
-BLACKFIN ARCHITECTURE
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-T:	git git://git.code.sf.net/p/adi-linux/code
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	arch/blackfin/
-
-BLACKFIN EMAC DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/net/ethernet/adi/
-
-BLACKFIN MEDIA DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Orphan
-F:	drivers/media/platform/blackfin/
-F:	drivers/media/i2c/adv7183*
-F:	drivers/media/i2c/vs6624*
-
-BLACKFIN RTC DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/rtc/rtc-bfin.c
-
-BLACKFIN SDH DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/mmc/host/bfin_sdh.c
-
-BLACKFIN SERIAL DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/tty/serial/bfin_uart.c
-
-BLACKFIN WATCHDOG DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/watchdog/bfin_wdt.c
-
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
-- 
2.7.4
