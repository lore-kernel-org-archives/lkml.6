Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeCBVDr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:03:47 -0500
Received: from mout.web.de ([212.227.17.12]:52127 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933204AbeCBVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:03:44 -0500
From: Mario Leinweber <marioleinweber@web.de>
To: kirill.shutemov@linux.intel.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, punit.agrawal@arm.com,
        Mario Leinweber <marioleinweber@web.de>
Subject: [PATCH 1/1] /mm/gup.c: Fixed coding style issues.
Date: Fri,  2 Mar 2018 16:02:54 -0500
Message-Id: <20180302210254.31888-1-marioleinweber@web.de>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:myf42l7jiio44AgH7Qu8JWO4irVhqxXMERNXPU0XUKZICGJrXQy
 DgyAlLn/qaGPeg/WipmCjyHnBcgz/xtqxmPcaozHrB9qntYWkBoJJYC7rCHV3V6v3BkRdYq
 K2pnOgTVMAzdEy1rSkW63D7g5nlE/JxacQmw/Rd5Qbrn78NEdeZ7J9QHs7572+Dq735ghyY
 Tr+DBOqKX/FOzril3FBPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c8WDYhwTy0k=:1W/C1kATeSdeDajbobq6hm
 r3UGdYSOa3abHSN7g2F0XTwCWk5WPVPBHcwAPmcoq/1hq+VqDLPioPNzUCfMsw+EfGcYdF/xA
 QdA1bVdRUx80pzAvP1EaRqO8sFZyMWe6MayQSPBofHRcLxDiWj491pJ1dKW2uCCIQ8b55VmCi
 +G0OMpSG/trHQnmWs7n/1Jr51S8b9ymXD2AOJS8t4CFkTzWqwl/Fx2cmOqbTTbfG1pHzF/kiB
 04Afy/9f+kH70OcfiI7D3q5fEL4X37ZOYH21VS7zeGhwxr94VaVhf2KIX0PRoX8klQfNd1qql
 o1IsP6IRwGEpw+g8oZ6Pa/7E6Hw/Uu9lc80lXanBO97/QhtrACXn+cDirE9QACNhpj7QaiHMD
 arIYkOO92ClUZUbgqRyJg29QoqY0XbImnyS1QXXYwX3e1JSDIToUZFQIpea+wHM5yJ9N5fk9a
 Cpg8ZJJ1HeTRLr8VjZEqqMRzKxrPkyeW8Wi4AD8FYatLxm4l3RK80nxL1NJefluKJeOygBFBr
 N5lkNGK7uqSFdRfX5wX3Z+Rg5/mp3u44Lk8whBXXww/3hDl3kP6z92uOmNTWfakgqGZQmSTRa
 kWhUy1+gM6jHFQqFx3PHdidHAeiltaIF33ZBgEJmLgUFzubG2WxMYmADIt4iA8rPgfN9Fu8GF
 Ikp/LKfHIWX6SDzMNpx2NC4ExKuoF1TdC9XX8LRygbjkHP0bdGhiBXorl5rv671RpqZ8S59Sj
 m5NIHHu23zOwTbfR+2fvXoJvQRl7reYBc704uR9cR+Fblc8vW3dem/wOxEx6/MoRjb81IloLq
 o7TplA9kL04aWhEcQYN8LdgIVPnow==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fixed style error: 8 spaces -> 1 tab.
- Fixed style warning: Corrected misleading indentation.

Signed-off-by: Mario Leinweber <marioleinweber@web.de>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b46e6e74881..dc42c3f48e71 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -531,7 +531,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	 * reCOWed by userspace write).
 	 */
 	if ((ret & VM_FAULT_WRITE) && !(vma->vm_flags & VM_WRITE))
-	        *flags |= FOLL_COW;
+		*flags |= FOLL_COW;
 	return 0;
 }
 
@@ -1635,7 +1635,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 					 PMD_SHIFT, next, write, pages, nr))
 				return 0;
 		} else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
-				return 0;
+			return 0;
 	} while (pmdp++, addr = next, addr != end);
 
 	return 1;
-- 
2.14.3
