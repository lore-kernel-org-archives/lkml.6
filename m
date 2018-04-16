Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeDPJTs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:19:48 -0400
Received: from mail-sn1nam01on0070.outbound.protection.outlook.com ([104.47.32.70]:39859
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752934AbeDPJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:19:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=wxu@cnexlabs.com;
From: Wei Xu <wxu@cnexlabs.com>
To: mb@lightnvm.io
Cc: javier@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Xu <wxu@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: add CNEX Granby to the pblk device list
Date: Mon, 16 Apr 2018 17:19:17 +0800
Message-Id: <1523870357-2118-1-git-send-email-wxu@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [115.238.84.139]
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To BN6PR06MB3491.namprd06.prod.outlook.com
 (2603:10b6:404:11a::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR06MB3491;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3491;3:BSIrlLd0WF+w3NmKzNsFUEygCWGdRjwok2Zh+RbEnlpAwKiBjXw4EYM/jZ4VBUZWNEpp9/clh5TVXmiu9I3s5P1nNI9NvEK55PD6FUTzxSfFBRihk3fBOL65rqsOt1RAGLfRFNL3/Hd6b4xfdBJAi9F6nyQ+z7Sd25+uIohaPNubhZAlH7jqziUg0Y3Pp3eoYAXUFozF03kw76kEde7sI7gA5jg9d+JtEFAmSVhNy77T2abTisVnLn5uncghUtWe;25:ZRQ8KjtR4pl0T1xss0Q/UQKY9ZckI8KAiUXNAjFBPfgiiONAfH2IuKnkjKfMtZJ97zB8xksOxcvnKyiOxqTDsqy9U4NVC34sMhjUtY4eUmpLYkUAF//5UrVNrJgKTqD2Hq5PmGRiy0YgXwMfJiYjH4nDsflbozjBNNG7NkvilpYRFVTsx8EVWYD0zefRx1lINRXI45ZgF7UysZGf4fTftRvah5DAGcNsEehF3qcv1dh7hvMG2+hjMswWGtYV6Yohfsu4r6l1l9aG1cpd6uFHvXP7PX05XXpaaF8SkyPZMjsS+CnptgV+f06N3ZGPo4eMRwLkC4cqO3ECrZ7kc/XA3Q==;31:CgRojsyt5QI6S/6LFnHbFGRgT2rZ6uzK0Q4EohldcKiFaXgBk3ijwGGgffWirsNTkwgYmQ9xvvAGQaKUCUlFM6onyxyhPFnu3z1o2p8n8fGveib6+anuzpNFtRUPKplj4cRHG6ANsQQK5GBMZA/1qDszA7/72xEVxL8qOq+JXxqJLKzhS8Su0UpJBxnINRPWZfpzKu5pVGnAAOWDnw+nKKqZ7NfXi84II08uqfNPKrU=
X-MS-TrafficTypeDiagnostic: BN6PR06MB3491:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3491;20:kH+vSo6KZJfxZ/gtLPeZF6OeQf7Zw39P/qtdat+6lbC8eEvWs0Q5DOJ/vMx/Nwiw8Bqpmylm12dt2PGopMxtWVqq/qTTEpNBNBMhHLfM1f3uQLX7ucWMZ69U8R7bgaMkrRkcOYKpTz/FFW4Co23AXXFvPCAFSBKpruhGNHa3vME=;4:jzkQKDYz8XFA7KUzFKumt33cIg0QOJQ/S6TW8KaKh/9yWRvCmPg6NnKFMaZ26/0Wq9QMdgOxPIvC5MSO3ymfQ8AO7MdxJqnpmWQSDY7R97k1/fvp17SulnG0uzth3ZaxmR8YpkDbMTBMN7gGSeewWEWQuldQAAx3WOwYsIUirf+Q6GSZmZ0+4kP1/eC29Uln4Rl10MZuOk6hH/uRYk5lUqUICrdLCiEy1Sel/X87cJejf2Kgh/6QGyrIqeoVMWIVDrjkDSGSKn1lwV5LCMpp0Q==
X-Microsoft-Antispam-PRVS: <BN6PR06MB3491119944D2A50BBFCC04A3C3B00@BN6PR06MB3491.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR06MB3491;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3491;
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39830400003)(366004)(346002)(39380400002)(199004)(189003)(316002)(6116002)(3846002)(7696005)(52116002)(68736007)(5660300001)(25786009)(86362001)(16526019)(186003)(23676004)(956004)(386003)(36756003)(59450400001)(1857600001)(486006)(476003)(2616005)(81156014)(81166006)(50466002)(53936002)(8676002)(107886003)(2870700001)(4326008)(2906002)(50226002)(8936002)(26005)(69596002)(97736004)(6486002)(305945005)(66066001)(47776003)(2361001)(6666003)(2351001)(6916009)(53416004)(478600001)(105586002)(7736002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3491;H:dojo.cnexlabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA2TUIzNDkxOzIzOklZamRrWXhpdXVhUlZDR25zeGNJOHlJVDh2?=
 =?utf-8?B?cC9TOHl3aGw5WUZYamZtRW9XUXhEU0pYZ1NVQ2p6TUpBWXlvWkt2Q2dWU3JK?=
 =?utf-8?B?UmdXS3VVb1ZJU1l5T1FOcERsS0RiZGYzUnlEZlNlSUdzM3JQNytrM3Zqa3NS?=
 =?utf-8?B?a1NzaFp1d3IyaUdOanE5bVgzRzU0aUNYKzRoNVE3M25BS3JSdS9hZHZjZVRJ?=
 =?utf-8?B?bTdXQ0ZzdTN6amEyUFV0c2RuOG9KVVRHeTZDcmJLMzdVQ2d0WUQwcjFpTW5D?=
 =?utf-8?B?U0IxMHdjVWtJc003QnUxTFpNaEIwTXNwZUNsTEdQUzV0dk92NVdlZ1Q3WVky?=
 =?utf-8?B?ODJ4bUkrL0k0VFhXaXpFb21IOHhiQmZSTk03S1lwZDNhRW9wcDVkSkxCdmhV?=
 =?utf-8?B?LzNMQmovendLR3JsWHl4eW1LNWw1Q2JGbXd0OW5LLzh2VU1uQ2NpL29ycUhs?=
 =?utf-8?B?eXFqOTI4eXJncm1mMzAxN294NkFyYm5wSG5vakZEWjdJQzFlYjRzMjRqOWZk?=
 =?utf-8?B?dS8xUmVrb0hBZ29EZnBiQlZ6clFVQzhrRTFaUHNyQUZzc2lSSUhwVUlSbC81?=
 =?utf-8?B?ZSs3blZucWJaQnpveTNOeUFvMDZPRHJmWjVpSlVlQWttL0E4UktWbm1SYWRi?=
 =?utf-8?B?ZVQxVkVEYmhucGlSc2U0eW9lUmZITFhSeUdGdlZvczBPU2JkYVkxMGRhVUM2?=
 =?utf-8?B?UzF2WWUwRFFTNlZ6ZTRDSENVMWJsVVNXOTZFSi90U045N1VrWEhyZnJnTThq?=
 =?utf-8?B?RFZPdTFlSC94YlNOVURnOEdyandZbnQ5UzRxOFNkN1RDZ0NRT2VUYVZMYkZt?=
 =?utf-8?B?SnNMYTE4UzNuWU9yam1jSmRJWmJOUHdwNTdsK1ZDTzhSNnZYSFdzNVhsYkhj?=
 =?utf-8?B?ZWVKNkdRazlqUDZ1a2ZkWmRtTjRyd0djWlNJYVVDQjFDeG1oYzBoMWxVNkcr?=
 =?utf-8?B?SmZyTHdBMVlBR01FR3JuZFhEdXFtNloxOEVrZVdPRjBDQlFRSjFRYlg2Q2RK?=
 =?utf-8?B?cGVsdTM2SzZDb3M3YXoraVh2ZDhHY2hMQTlyanROTGFSdXg4bGM1cjF4UWFv?=
 =?utf-8?B?Ti9nSnZYV1NhOEhjRWVUUUJVK3JlTUVjWEtndERGUVJBeVhWL2VnVk4vOU5W?=
 =?utf-8?B?UEdRY2tSU25tSk4xM3ZzZU9FSmpBOThpR0tkMzAvdUtLdmZhN2w4b0tHQXJ2?=
 =?utf-8?B?OFVOZ2hUWSt6RkZBZ1MzWnpYek5LcGRkZnZHbzFCRE1rWVNscW9nQlk0SDVK?=
 =?utf-8?B?NFJsZkxCRUtOamFHQjhQT1ZCa0JnL2ZqQWY5eG9LVjhkK051K011T3hqY3pG?=
 =?utf-8?B?Z0tQY0hJU1RidHBRcGlLOGlnMS9FNmtYd1ZVbHQrN2FBMjl0ekI2QWwvSDRx?=
 =?utf-8?B?TzhTdzE4M2VQSWVIL3ZOVXBvWGJ2WTIxb1JydCsvcVMraEQ0ejh4dXdNbHc3?=
 =?utf-8?B?RU1EaHVLQWhBeC9jbHhNMWliTFArUUR0SjRaNC8rZ3BoUlVIQ21PSVV4NlU3?=
 =?utf-8?B?dWIxMGJHclFoRmVqRlQ1ZGZRTzRXWUtwUGJSV3RKNXoxRVgvQW1FVEgwcjV0?=
 =?utf-8?B?R0RXbExvM3NKcUhpNTVzMGpLWEJQMkk2bmxZd1Y5RzNMdllDOWd4MUxpSjBT?=
 =?utf-8?B?SS9vSm9PZHFyY3ZyOGlFdmZrSldVMG9hWVZjdkw0YitrWTh5MzZpbGw0YWp0?=
 =?utf-8?Q?/hvoQv12DYkXK+uRJs=3D?=
X-Microsoft-Antispam-Message-Info: WGb/zlRF3wFD5PHUNXaOhFhKHq/Jsyx2mVzga3Y3tLFep3ugsJP1UJN58hlKXhLpm8e8l+flbVTAovWglnTFpop6lX/2lNGCsSli5tCVPkRWB5fEjpnSu2ogCt9E7FGCIUiSnmX/UZR2azIc9xL5969GKP4sLx67YVrXxCPMrsoBIiCzFaIHz6mRqdI1bq6g
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3491;6:hMzR6sUfDaE4u7JuxgWk2ww3Lm+u8sjmcUr4/wGNE5k9Nh6ZlD07es5QVTCVBZKzzOlVimUda5D6zF07iAQ4UFVwsZk7cJJoWkMPs7MZi5ObT4qmZ1BWhi7+NlRe74QirVN9xZy3ZZiIBwFgDom1km4e4lc3UzXU+vGPnI0uns7ROxbowwOetnNxwL8ELITG/petbDwmRGzYaGyCu5BO8TJokfQtJAwCS+WsSNQmHh7T6uTRJvy+BJVs9lRCOB1Ucrn971UmZK7UxE7qEiac6vw4vjqXADyd+OLp3Pt+tt8594yKHf8lvhGJu6+kPYJvOR8YVE2X3BhqIxH5UUxI6TJQUEOvwR2BlE51KzIFKmyL9ql2+L8jhCbFf6NfAc1dU+hULuxOZhqICBOBD1g6b2b+u+goo8OiwJ3H+CF+U2az2gw3DQaOHMx06MRpOXww9UnbdDwahhxA7LaQM+BG+w==;5:fw0pPQiaCTqF+9pChxIXA4RtC+DhP1F1kVMCt2Oep4xkba5qFiyQF1fcpBtbBXAhdGeqIjsdsRKP26ptLNGLc9XtED91r/MEW05R3pIJbybUh61VkxAUJedekCcfZznS58dvfvCel3XjclPuRSPVSF3swyHTmWRBtK0PGuaQU3s=;24:9aOIMesv+pYhXIUt4MW/nowXg8ZeHjhffrwQ3JR047viL1ezhTns3s2ccxZQwc/X8pZvBZ9IQKOIjIPfp1b4qDZdQjjKvh75mWiX/FFH0Jg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3491;7:A4BFd1YzBVB8yyI9AA7lt8X29tEMzwQJ+88K1avKicubg78OnQQAG5gL54tblFMzSC4CR9BKSQdQ1zRtEFZsepNcqUKPnAyWfeyBfB1EbRJrPpRtQS/mAUKz4soDzlk8IDUPI6+gyUQ8WBSjN4JZexV9N4htFO3GMo9fZTjgFbKmMdd4Qi+3qxdDAZlznn7ZQ6wa/xtXHGLJ5Aj3nZLe8LK6CqJGa/jsoqAcBHQ/JGMyr4ni6IYP9xDvLvJ+jM+8
X-MS-Office365-Filtering-Correlation-Id: fceebba0-6501-4855-5ff3-08d5a37b3155
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 09:19:43.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fceebba0-6501-4855-5ff3-08d5a37b3155
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3491
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new lightnvm quirk to identify CNEX’s Granby controller.

Signed-off-by: Wei Xu <wxu@cnexlabs.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cb73bc8..9419e88 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
+	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
+		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.7.4
