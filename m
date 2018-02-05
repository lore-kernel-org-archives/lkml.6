Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBEV3G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:29:06 -0500
Received: from mout.web.de ([212.227.15.14]:63981 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeBEV24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:28:56 -0500
Subject: [PATCH 3/4] HID: logitech-dj: Combine substrings for seven messages
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Message-ID: <c2521760-689d-772e-1e3c-401e51c8ca60@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rpiS6OT/IJwNKcxQFlnYA9r/X1e2TP81/ellFsZhKn+n6JD2CSA
 wY6yIDu9YnxJ532dqa0dE/q0qS0nwHWMRGAUSCL88i8hzQIi7u+BbN3HYSjMTZEReXCmMSf
 jccxZTinOpJ7B0kx01Rc29tnUlWO1wsreqpmbhTFKxtVp8haDFb5KMOuXfknJQ/imwlD17i
 r+L6AUj96BCInDipdnwEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p2iPdemcG/E=:nWLt0CZXC3We41gkbljCXU
 Fo7MUrr30KEZbYzb9aCtHXOZRX9MSI6eLvQe4S9GdcppZaaT214e8TBolwUe4YM3l6MCfaH20
 190qyZv/MS6DpV55lvEAEHowxYVqU8+YA2ef+nY7UWdXmiKm5lpwap1GksAv5ycqRB8o03aGr
 h0bAQmV017K67Eu8h0fer6iIqK2q9kFPIJhMxtp71vSGlHQ1GGVnYfZC6Txd0ZVS2wMM7DaiT
 a8YoXgigFzB3nU37XTHn8K68r0flsDXqLek05EwdcWMXhfNMYGm85ChuaxpnvM3fnzAaieKkM
 GXtpNPLB58eJrh6OoZWXU8+Pai8RdWt61oo1PHw0iWVTAAPOU0hGuHJCY+GOU1q35/QxyRiBV
 /wzcYy3VTlmOqk30doXv0cbyMQo412eBnkYJQwZPAhG5VPIYJ7C+C9Geg/aRcsvMeEYHRCXrV
 J0bznqsbwAighHkLS6ITpQIFASghpe1+1atlMBlGWJcXI8ho9k9I7EEXqgQJ+Fobro4fkEkNE
 KXxWjpMYYQAaPITvng/Oku5P7oiTf0px54pNsuvxccLNzuFSgL6dtmPAghIo3rlFy6H9ICdgg
 2EUrSZ3pHFMUMp0SQ5R2Id2mYCoyX9v7o1Aepyg0XUTap7WKyjpHSeqsp0XilEthMk/t/UEPg
 V78rQHmfdCfZNXuGcX5sqMxC0NnuIcmvjC5p1jTiTFzkjDDAoTg7xr55tj7BQaCjGesHL8Y0r
 Lq04IDHK7SqZwzsKDdyvZouGCDlR+SQWQ/uFczoE5git8Jo1c6nO8mJ8Bd8/Nb56FNY1eLdff
 cZWFOvOWVLaD7pT/n/Gc+ANBxN9IJ3GQY6+ormsSP9epiOdEvg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:06:20 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 0da00d256ca7..f1496c6303ce 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -463,16 +463,17 @@ static void delayedwork_callback(struct work_struct *work)
 				sizeof(struct dj_report));
 
 	if (count != sizeof(struct dj_report)) {
-		dev_err(&djrcv_dev->hdev->dev, "%s: workitem triggered without "
-			"notifications available\n", __func__);
+		dev_err(&djrcv_dev->hdev->dev,
+			"%s: workitem triggered without notifications available\n",
+			__func__);
 		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
 		return;
 	}
 
 	if (!kfifo_is_empty(&djrcv_dev->notif_fifo)) {
 		if (schedule_work(&djrcv_dev->work) == 0) {
-			dbg_hid("%s: did not schedule the work item, was "
-				"already queued\n", __func__);
+			dbg_hid("%s: did not schedule the work item, was already queued\n",
+				__func__);
 		}
 	}
 
@@ -502,8 +503,8 @@ static void delayedwork_callback(struct work_struct *work)
 			break;
 		}
 		dev_err(&djrcv_dev->hdev->dev,
-			"%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
+			"%s:logi_dj_recv_query_paired_devices error:%d\n",
+			__func__, retval);
 		}
 		dbg_hid("%s: unexpected report type\n", __func__);
 	}
@@ -517,8 +518,8 @@ static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
 	kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
 
 	if (schedule_work(&djrcv_dev->work) == 0) {
-		dbg_hid("%s: did not schedule the work item, was already "
-			"queued\n", __func__);
+		dbg_hid("%s: did not schedule the work item, was already queued\n",
+			__func__);
 	}
 }
 
@@ -541,8 +542,7 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
 					     HID_INPUT_REPORT,
 					     reportbuffer,
 					     hid_reportid_size_map[i], 1)) {
-				dbg_hid("hid_input_report error sending null "
-					"report\n");
+				dbg_hid("hid_input_report error sending null report\n");
 			}
 		}
 	}
@@ -770,8 +770,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 	}
 
 	if (djdev->reports_supported & STD_MOUSE) {
-		dbg_hid("%s: sending a mouse descriptor, reports_supported: "
-			"%x\n", __func__, djdev->reports_supported);
+		dbg_hid("%s: sending a mouse descriptor, reports_supported: %x\n",
+			__func__, djdev->reports_supported);
 		rdcat(rdesc, &rsize, mse_descriptor, sizeof(mse_descriptor));
 	}
 
@@ -1068,8 +1068,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 
 	retval = logi_dj_recv_query_paired_devices(djrcv_dev);
 	if (retval < 0) {
-		dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
+		dev_err(&hdev->dev,
+			"%s:logi_dj_recv_query_paired_devices error:%d\n",
+			__func__, retval);
 		goto logi_dj_recv_query_paired_devices_failed;
 	}
 
-- 
2.16.1
