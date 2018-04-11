Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeDKISb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:18:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34622 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbeDKIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:18:29 -0400
Date: Wed, 11 Apr 2018 11:18:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] cpuidle: menu: tidy up some indenting
Message-ID: <20180411081800.GA4625@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8859 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804110080
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These lines were indented 4 spaces less than they should have been.  It
was a little confusing.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 1bfe03ceb236..b733dc6aa42b 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -426,8 +426,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			 * tick, so try to correct that.
 			 */
 			for (i = idx - 1; i >= 0; i--) {
-			    if (drv->states[i].disabled ||
-			        dev->states_usage[i].disable)
+				if (drv->states[i].disabled ||
+				    dev->states_usage[i].disable)
 					continue;
 
 				idx = i;
