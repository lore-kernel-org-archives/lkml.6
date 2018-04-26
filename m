Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756330AbeDZLxP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:53:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14978 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756111AbeDZLwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180426115242epoutp0402e53c7d36c5587efbb98a93dd00c1d0~o_jEqPFCF1672516725epoutp04j
X-AuditID: b6c32a35-9cbff70000001024-32-5ae1bd89f5d2
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 17/18] thermal: exynos: remove unused defines for Exynos5433
Date: Thu, 26 Apr 2018 13:51:32 +0200
Message-id: <1524743493-28113-18-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmgW7n3odRBju2W1lsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsavhI1PBMfaK9lerGRsY97N1MXJySAiYSOy8NZ21i5GLQ0hgB6PEyhk3wBJCAt8Z
        JRqOOsEUrVs2jRmiaAOjxNfn1xghnF+MEkcPTAfrYBOwkpjYvooRxBYR0JI4cWk7E0gRs8Ac
        RolZDbtZQBLCAj4Sc/9tZgWxWQRUJU6dWscMYvMKeEoc2vse6iY5iZPHJoPVcALFLxxpYgEZ
        JCHwl1Vizuz7UEUuEpOW9bND2MISr45vAbI5gGxpiUtHbSHqmxklvu3YwwxRM4FRYs96IQjb
        WuLw8YtgC5gF+CTefe1hhejllehogyrxkLh/8CXUKkeJh192Q70P9MzMTV8YJzBKLWBkWMUo
        llpQnJueWmxYYKhXnJhbXJqXrpecn7uJERyDWqY7GKec8znEKMDBqMTDG7DwQZQQa2JZcWXu
        IUYJDmYlEd741odRQrwpiZVVqUX58UWlOanFhxilOViUxHmf+pyJEhJITyxJzU5NLUgtgsky
        cXBKNTCu377I0vvE/4yQFrOfH6UOp8yOTxSoWW19vMM2Ykc6r2ZqeprUpVbtDrOrH9s9lRdv
        F1DX5DhWP+GTk2nEptBdNWsWTFL+9bNI11rvXPT1W6WaUe890pJeHOrbv/sKr1R21ruwVxsY
        2GtPJk7fzGbl2hL70aFZUvKSieKB+Y/97K23zHjQpKDEUpyRaKjFXFScCADRVPQ/vQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xoG7n3odRBjuvqltsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsavhI1PBMfaK9lerGRsY97N1MXJySAiYSKxbNo25i5GLQ0hgHaPEtGdfWCGcX4wS
        /yfeZASpYhOwkpjYvgrMFhHQkjhxaTsTSBGzwBxGiecr5jCBJIQFfCTm/tvMCmKzCKhKnDq1
        jhnE5hXwlDi09z3UOjmJk8cmg9VwAsUvHGliAbGFBDwk7ve9Z5vAyLOAkWEVo2RqQXFuem6x
        UYFhXmq5XnFibnFpXrpecn7uJkZg0Gw7rNW3g/H+kvhDjAIcjEo8vAELH0QJsSaWFVfmHmKU
        4GBWEuGNb30YJcSbklhZlVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwen
        VAPjNBaLny87pxSFvDc1kqu+eSz7+2Yv0ZuyXWKH+pYt2LRgSlNUo7rVSn/ub5w2B1e8/NOe
        VM5hqH/o017HOzIccx0SJknXdkmwSrK8OFauw3Tt1LkLe5ku598J9/v2MmDhu/07Y3Zs23zs
        5qbZiqq3j+sGhGYdtZqw9LrGxRbV2ecElXwsznkuU2Ipzkg01GIuKk4EADwH8U8WAgAA
X-CMS-MailID: 20180426115241epcas1p4472048bd1647d9151718f573e6f1025a
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115241epcas1p4472048bd1647d9151718f573e6f1025a
X-RootMTR: 20180426115241epcas1p4472048bd1647d9151718f573e6f1025a
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115241epcas1p4472048bd1647d9151718f573e6f1025a@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused defines for Exynos5433.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9639acf..ed02b40 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -96,11 +96,6 @@
 #define EXYNOS4412_MUX_ADDR_SHIFT          20
 
 /* Exynos5433 specific registers */
-#define EXYNOS5433_TMU_REG_CONTROL1		0x024
-#define EXYNOS5433_TMU_SAMPLING_INTERVAL	0x02c
-#define EXYNOS5433_TMU_COUNTER_VALUE0		0x030
-#define EXYNOS5433_TMU_COUNTER_VALUE1		0x034
-#define EXYNOS5433_TMU_REG_CURRENT_TEMP1	0x044
 #define EXYNOS5433_THD_TEMP_RISE3_0		0x050
 #define EXYNOS5433_THD_TEMP_RISE7_4		0x054
 #define EXYNOS5433_THD_TEMP_FALL3_0		0x060
-- 
1.9.1
