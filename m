Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeBEOm1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:42:27 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61613 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBEOmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:42:18 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180205144216epoutp02537658cd2cf7754905fc41e38978da65~QdQR4bo7W2587125871epoutp02b
X-AuditID: b6c32a37-433ff70000001029-a1-5a786d47469c
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org, tomasz.figa@gmail.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] clk: samsung: Add git tree entry to MAINTAINERS
Date: Mon, 05 Feb 2018 15:41:58 +0100
Message-id: <20180205144158.10500-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmga57bkWUwY951hYbZ6xntbj+5Tmr
        xfnzG9gtPvbcY7W4vGsOm8WM8/uYLNYeuctucfGUq8XhN+2sFj/OdLNYrNr1h9GB2+P9jVZ2
        j8t9vUweO2fdZffYtKqTzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgydj8/xl6wh7Vi//l3
        bA2Mt1m6GDk5JARMJP5/PsncxcjFISSwg1Fi4YonjBDOd0aJJS8WMsFU/fu8gB0isYFR4kbj
        KSjnF6PEnndn2UCq2AQMJXqP9jGC2CICshK3jv1kAyliFpjFJHHp7RqwUcICDhJ3Xz9hBbFZ
        BFQlrv+5BxbnFbCWuNm0HuooeYn3C+6D3SEhMINN4sOXh1AJF4k5n94wQ9jCEq+ObwE6gwPI
        lpa4dNQWor6fUeLEmmaYZkaJO+0ToJ6wljh8/CLYZmYBPol3X3tYIZp5JTrahCBKPCRObDkE
        tctR4tyJu2C7hARiJfo/vmKZwCi5gJFhFaNYakFxbnpqsWGBsV5xYm5xaV66XnJ+7iZGcMRq
        me9g3HDO5xCjAAejEg+vQEZFlBBrYllxZe4hRgkOZiURXqfr5VFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeQMCXKKEBNITS1KzU1MLUotgskwcnFINjApf66zt9G9OLDCe2Zs+51V0r1eYxvbo
        /Tf9dnLs+Kiu+sD+e5Dbjtpvfe3mezqub5i3VjYlcYr17zd7EuQtjoSKKiWJNs0/YX9Cb1mO
        fuc6lf9d5m8fRP77NvfKJK8DLV4d2ZzurNPEunyrVaJNFTXvTWDwu2oSWOj95/OW8y/0Bc6w
        /i/UUmIpzkg01GIuKk4EAGp/84XUAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e+xoK57bkWUwYzd2hYbZ6xntbj+5Tmr
        xfnzG9gtPvbcY7W4vGsOm8WM8/uYLNYeuctucfGUq8XhN+2sFj/OdLNYrNr1h9GB2+P9jVZ2
        j8t9vUweO2fdZffYtKqTzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgydj8/xl6wh7Vi//l3
        bA2Mt1m6GDk5JARMJP59XsDexcjFISSwjlHiztK/jBDOL0aJ9Tu2MYFUsQkYSvQe7WMEsUUE
        ZCVuHfvJBlLELDCLSWLL3f9sIAlhAQeJu6+fsILYLAKqEtf/3ANr5hWwlrjZtB5qnbzE+wX3
        GScwci1gZFjFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYSNsOa/XtYLy/JP4QowAH
        oxIPb0ZWRZQQa2JZcWXuIUYJDmYlEV6n6+VRQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2L
        FBJITyxJzU5NLUgtgskycXBKNTDWir4P3xm6nrGXV3zLRuMPt8wLSz0YHXcdSGNeUKgkf3Tb
        L6Hpb9UeG7Hq+3ncOMlbkspX92AJ644Z+n57lfgv97xvFL3CcFSlSo3LTeH614KS75N87l/Y
        vV1k8ZLA+ypCPq5/Z6rt+HL8q2T9kV+/WCVX5TI0CL9gC/rbvd/igt1Ol+qfEw4qsRRnJBpq
        MRcVJwIADAbmYyACAAA=
X-CMS-MailID: 20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4
X-RootMTR: 20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4
References: <CGME20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing git tree entry for drivers/clk/samsung.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..502442dc08eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12001,6 +12001,7 @@ M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 S:	Supported
 L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
 F:	drivers/clk/samsung/
 F:	include/dt-bindings/clock/exynos*.h
 F:	Documentation/devicetree/bindings/clock/exynos*.txt
-- 
2.14.2
