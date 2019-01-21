Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4AC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5559820855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c7jd2VMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfAUISr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:18:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53099 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfAUISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:18:46 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190121021945epoutp0121034f2726a8be8e4f6fb9a382a88c87~7u55ggfy80040000400epoutp01S
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:19:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190121021945epoutp0121034f2726a8be8e4f6fb9a382a88c87~7u55ggfy80040000400epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548037185;
        bh=9+LKi0gxHqCnM2B7H/kbxsksJ5BxaiPauaJ+Mm7+jJI=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=c7jd2VMjTQQpAV4qv0ZPNvgv0RA2N0qoWBr6tbK3be0HzYaXWunMpscCejXy6O4Xv
         82fVLrE6njKTsUZV/wN9ym4x3Gr1qRoIoDJJpUMT1LSlDhsrPlWgSqc8v/yaoEgT9K
         mIOFs1+e/v9lNbp8VOk+unbe1VpAQtikkWbr5bs8=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190121021943epcas1p2668391a2bda630ef8cff0829668c97c7~7u53GilOE0089400894epcas1p2j;
        Mon, 21 Jan 2019 02:19:43 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-aa-5c452c3ce332
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.09.04288.C3C254C5; Mon, 21 Jan 2019 11:19:40 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] PM / devfreq: consistent indentation
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
Date:   Mon, 21 Jan 2019 11:19:40 +0900
X-CMS-MailID: 20190121021940epcms1p57620581b960dba9805dfddee903ccd6c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmvq6NjmuMwd1+S4vrX56zWlzeNYfN
        4nPvEUaLub8nsDmweOycdZfdo2/LKkaPz5vkApijsm0yUhNTUosUUvOS81My89JtlbyD453j
        Tc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgLYpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        UgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7Izfm9/ylLwS6OiZ/cFtgbG0wpdjJwcEgIm
        EvfvL2bsYuTiEBLYwShxefkhli5GDg5eAUGJvzuEQUxhAVOJS1OEQMqFBJQkGm7uYwaxhQX0
        JToebGMEsdkEdCW2brjLAmKLCORIfD9xkB3EZhbIlFj26jEzxCpeiRntT1kgbGmJ7cu3MkLY
        ohI3V79lh7HfH5sPFReRaL13FqpXUOLBz92MML0zpvyHmlMt8ajnIjPI+RICLYwSq2ZuY4JI
        6EucmXuSDcTmFfCVWH6oEWwBi4CqxLbFq6GWuUh82H+VFeJQeYntb+cwg/zLLKApsX6XPkSY
        T+Ld1x5WmPt3zHsCNV5N4tDuJVBjZCROT18IdaeHRH/DYxZIWAVKfDu+nnUCo9wsRIDOQrJs
        FsKyBYzMqxjFUguKc9NTiw0LTJDjcBMjOH1pWexg3HPO5xCjAAejEg/vj3suMUKsiWXFlbmH
        GCU4mJVEeDOOO8cI8aYkVlalFuXHF5XmpBYfYjQF+nkis5Rocj4wteaVxBuaGhkbG1uYGJqZ
        GhoqifOudwBqEkhPLEnNTk0tSC2C6WPi4JRqYMxnXmp29+71x1tTJ2oJ9jHNkpUounX0QqRG
        5Hpvn8UKx3+ybSnOzPZ+q3Tf5P2EB41NPF/+XH2i28+ZP3Ea4/qA511vs1R/8uo8ueZ6rJD1
        dHFt3EzTvtIDEUx3X7+Pupm2p3SDzt/5cvyb6l7o+H56Oetc1oFdfjwLNvxKzK1g/XLs5efr
        KllKLMUZiYZazEXFiQC9F63FdQMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190121021940epcms1p57620581b960dba9805dfddee903ccd6c
References: <CGME20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up with complaints on inconsistent indentation from
Yangtao Li, this fixes indentation inconsistency.

In principle, this tries to put arguments aligned to the left
including the first argument except for in the case where
the first argument is on the far-right side.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4af608a..428a1de 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -528,7 +528,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 		mutex_lock(&devfreq->lock);
 		if (!devfreq->stop_polling)
 			queue_delayed_work(devfreq_wq, &devfreq->work,
-			      msecs_to_jiffies(devfreq->profile->polling_ms));
+				msecs_to_jiffies(devfreq->profile->polling_ms));
 	}
 out:
 	mutex_unlock(&devfreq->lock);
@@ -537,7 +537,7 @@ EXPORT_SYMBOL(devfreq_interval_update);
 
 /**
  * devfreq_notifier_call() - Notify that the device frequency requirements
- *			   has been changed out of devfreq framework.
+ *			     has been changed out of devfreq framework.
  * @nb:		the notifier_block (supposed to be devfreq->nb)
  * @type:	not used
  * @devp:	not used
@@ -683,12 +683,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table =
-		devm_kzalloc(&devfreq->dev,
-			     array3_size(sizeof(unsigned int),
-					 devfreq->profile->max_state,
-					 devfreq->profile->max_state),
-			     GFP_KERNEL);
+	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+			array3_size(sizeof(unsigned int),
+				    devfreq->profile->max_state,
+				    devfreq->profile->max_state),
+			GFP_KERNEL);
 	if (!devfreq->trans_table) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
@@ -696,9 +695,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-						devfreq->profile->max_state,
-						sizeof(unsigned long),
-						GFP_KERNEL);
+			devfreq->profile->max_state,
+			sizeof(unsigned long),
+			GFP_KERNEL);
 	if (!devfreq->time_in_state) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
@@ -1184,7 +1183,7 @@ static ssize_t available_governors_show(struct device *d,
 	 */
 	if (df->governor->immutable) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
-				   "%s ", df->governor_name);
+				  "%s ", df->governor_name);
 	/*
 	 * The devfreq device shows the registered governor except for
 	 * immutable governors such as passive governor .
@@ -1497,8 +1496,8 @@ EXPORT_SYMBOL(devfreq_recommended_opp);
 
 /**
  * devfreq_register_opp_notifier() - Helper function to get devfreq notified
- *				   for any changes in the OPP availability
- *				   changes
+ *				     for any changes in the OPP availability
+ *				     changes
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  */
@@ -1510,8 +1509,8 @@ EXPORT_SYMBOL(devfreq_register_opp_notifier);
 
 /**
  * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
- *				     notified for any changes in the OPP
- *				     availability changes anymore.
+ *				       notified for any changes in the OPP
+ *				       availability changes anymore.
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  *
@@ -1530,8 +1529,8 @@ static void devm_devfreq_opp_release(struct device *dev, void *res)
 }
 
 /**
- * devm_ devfreq_register_opp_notifier()
- *		- Resource-managed devfreq_register_opp_notifier()
+ * devm_devfreq_register_opp_notifier() - Resource-managed
+ *					  devfreq_register_opp_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  */
@@ -1559,8 +1558,8 @@ int devm_devfreq_register_opp_notifier(struct device *dev,
 EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
 
 /**
- * devm_devfreq_unregister_opp_notifier()
- *		- Resource-managed devfreq_unregister_opp_notifier()
+ * devm_devfreq_unregister_opp_notifier() - Resource-managed
+ *					    devfreq_unregister_opp_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  */
@@ -1579,8 +1578,8 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
  * @list:	DEVFREQ_TRANSITION_NOTIFIER.
  */
 int devfreq_register_notifier(struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list)
+			      struct notifier_block *nb,
+			      unsigned int list)
 {
 	int ret = 0;
 
@@ -1686,9 +1685,9 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
  * @list:	DEVFREQ_TRANSITION_NOTIFIER.
  */
 void devm_devfreq_unregister_notifier(struct device *dev,
-				struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list)
+				      struct devfreq *devfreq,
+				      struct notifier_block *nb,
+				      unsigned int list)
 {
 	WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
 			       devm_devfreq_dev_match, devfreq));
-- 
2.7.4
