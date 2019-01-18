Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E7620896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfARDKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:10:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbfARDKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:10:43 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BC0FD90931E33C3C2FA5;
        Fri, 18 Jan 2019 11:10:40 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 11:10:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <Michal.Kalderon@cavium.com>, <Ariel.Elior@cavium.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] IB/hw: remove unneeded semicolon
Date:   Fri, 18 Jan 2019 11:09:00 +0800
Message-ID: <20190118030900.14636-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded semicolon

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  2 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c    |  2 +-
 drivers/infiniband/hw/qedr/verbs.c         | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 298c6f7..9e630b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4578,7 +4578,7 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 			dev_err(dev, "Unhandled event %d on EQ %d at idx %u.\n",
 				event_type, eq->eqn, eq->cons_index);
 			break;
-		};
+		}
 
 		eq->event_type = event_type;
 		eq->sub_type = sub_type;
diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 93b16237..0555e5a 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -349,7 +349,7 @@ qedr_iw_event_handler(void *context, struct qed_iwarp_cm_event_params *params)
 	default:
 		DP_NOTICE(dev, "Unknown event received %d\n", params->event);
 		break;
-	};
+	}
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index bdd887e..df22cfb 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2116,7 +2116,7 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 		default:
 			status = -EINVAL;
 			break;
-		};
+		}
 		break;
 	case QED_ROCE_QP_STATE_INIT:
 		switch (new_state) {
@@ -2137,7 +2137,7 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 			/* Invalid state change. */
 			status = -EINVAL;
 			break;
-		};
+		}
 		break;
 	case QED_ROCE_QP_STATE_RTR:
 		/* RTR->XXX */
@@ -2150,7 +2150,7 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 			/* Invalid state change. */
 			status = -EINVAL;
 			break;
-		};
+		}
 		break;
 	case QED_ROCE_QP_STATE_RTS:
 		/* RTS->XXX */
@@ -2163,7 +2163,7 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 			/* Invalid state change. */
 			status = -EINVAL;
 			break;
-		};
+		}
 		break;
 	case QED_ROCE_QP_STATE_SQD:
 		/* SQD->XXX */
@@ -2175,7 +2175,7 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 			/* Invalid state change. */
 			status = -EINVAL;
 			break;
-		};
+		}
 		break;
 	case QED_ROCE_QP_STATE_ERR:
 		/* ERR->XXX */
@@ -2193,12 +2193,12 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 		default:
 			status = -EINVAL;
 			break;
-		};
+		}
 		break;
 	default:
 		status = -EINVAL;
 		break;
-	};
+	}
 
 	return status;
 }
-- 
2.7.0


