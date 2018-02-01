Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBAIYB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:24:01 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:43726 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeBAIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:23:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180201082339epoutp04688247535e44bec9662faf794824a8b6~PJgjjqri-3232032320epoutp04n
X-AuditID: b6c32a35-891ff70000001031-7b-5a72ce8ae2ea
From: Andi Shyti <andi.shyti@samsung.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>,
        Andi Shyti <andi@etezian.org>
Subject: [PATCH 2/2] Input: mms114 - fix license module information
Date: Thu, 01 Feb 2018 17:23:20 +0900
Message-id: <20180201082320.24031-3-andi.shyti@samsung.com>
X-Mailer: git-send-email 2.15.1
In-reply-to: <20180201082320.24031-1-andi.shyti@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7bCmvm7XuaIog9Z9hhbbjzxjtVj84zmT
        xeFFLxgt2h91slrc/PSN1eLyrjlsFhPX32N1YPe4vuQTs8fOWXfZPb7POMPo0bdlFaPH501y
        AaxRqTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
        KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVog0NjfQMDcz1jIyM9EyMY62MTIFKElIz/nXd
        YSzo5KjYP0+/gfEHWxcjJ4eEgInE2XNPgWwuDiGBHYwSd248gnK+M0p8uNsPV3Vz7VomiMQG
        RomHh7+yQDifGCUubV0IVsUmoCnRdBtirohAgsTyzh/MIEXMAksZJRY2L2UBSQgLOEssPLuc
        EcRmEVCVuPztO5jNK2At8WHefnaIdfISE7Y0gdVzCthIXF37jR1kkIRAB5vE2r52JogiF4mF
        z34wQtjCEq+ObwEq4gCypSUuHbWFCDczSmy7nQzRO4FR4tPer1C9xhLPFnaB2cwCfBLvvvaw
        QvTySnS0CUGUeEj8PLsI6n1HiX0H/0J93M8ocejzG7YJjFILGBlWMYqlFhTnpqcWGxYY6hUn
        5haX5qXrJefnbmIEJxMt0x2MU875HGIU4GBU4uF9cakwSog1say4MvcQowQHs5II75t9RVFC
        vCmJlVWpRfnxRaU5qcWHGE2BYTORWUo0OR+Y6PJK4g1NLA1MzIyAicHS0FBJnDcgwCVKSCA9
        sSQ1OzW1ILUIpo+Jg1OqgdHKYsp3Z+fKVb+8uHIlV8yI3bzkTa20YoZvVW/Jve/axqkbbR5P
        POvV7/buremq4wftnt/P1fNUex11PThXcNbxeF/B1XcCtW0feRw3UdfUl6sQ2/hHbmLPpLlN
        c7773Jh5YltEuPvVwJ1ZBa9f3+nc7moSktU8NSdfe/6Oa8vXdk4J+ukjuUWJpTgj0VCLuag4
        EQB+3ZqePAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xoG7XuaIog3u/5S22H3nGarH4x3Mm
        i8OLXjBatD/qZLW4+ekbq8XlXXPYLCauv8fqwO5xfcknZo+ds+6ye3yfcYbRo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDL+dd1hLOjkqNg/T7+B8QdbFyMnh4SAicTNtWuZuhi5OIQE1jFK
        fJx+jRHC+cQosW3iJUaQKjYBTYmm2xAdIgIJEmfXvmAGKWIWWMoosfPWfbAiYQFniYVnl4PZ
        LAKqEpe/fQezeQWsJT7M288OsU5eYsKWJhYQm1PARuLq2m9gcSGgmpn7rrJOYORZwMiwilEy
        taA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMIy2Hdbq28F4f0n8IUYBDkYlHt4XlwqjhFgT
        y4orcw8xSnAwK4nwvtlXFCXEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC
        1CKYLBMHp1QDo72/wH7xN74GQZl7VU+IWCm3RbNzp+pum2QvnWWaJbfo2h+X1vX3JWKmMskW
        pP/k4fQzuWPCnzSn/nmqh7vNg9rPGsqegs9/TXYq+/O0ncNtWs87bk7FCJ2lIs579iTmZhiG
        H83YdkVvzfRfRx58Pxrhsp9DcHMVd/CCKyLvGs4qX/wf98ZUiaU4I9FQi7moOBEA19dZXB8C
        AAA=
X-CMS-MailID: 20180201082338epcas1p1b51e19d17ab9259cf18e031fb8e9f318
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180201082338epcas1p1b51e19d17ab9259cf18e031fb8e9f318
X-RootMTR: 20180201082338epcas1p1b51e19d17ab9259cf18e031fb8e9f318
References: <20180201082320.24031-1-andi.shyti@samsung.com>
        <CGME20180201082338epcas1p1b51e19d17ab9259cf18e031fb8e9f318@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has been released with GNU Public License v2 as stated
in the header, but the module license information has been tagged
as "GPL" (GNU Public License v2 or later).

Fix the module license information so that it matches the one in
the header as "GPL v2".

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Reported-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index be7926555432..a5ab774da4cc 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -621,4 +621,4 @@ module_i2c_driver(mms114_driver);
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
 MODULE_DESCRIPTION("MELFAS mms114 Touchscreen driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1
