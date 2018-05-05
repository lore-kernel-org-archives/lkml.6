Return-Path: <xtrat.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525491939; cv=none;
        d=google.com; s=arc-20160816;
        b=VOgCyKicjBRB6fKA72xJBrTnQQ2JzedmI/lZJC4I4L7NWGSXJycCaaHNUhR0wn4ONS
         CFRblPfSRpR4q6ymgvD6SjOILvgfi1tZdN7e0KE+W+fctCKdjXiXDetaY9l5l42EuDx+
         DmVEDGhEmJNGzk6zMcSzDass8kl6xpetFRgAvkhSlmeAJFgqSWrGLipRdwYiFFPDrB7u
         SuZFUxUho6Vc3XWM6L7fV0/GIMf0jG7nvWcypF6Fu44rgTtHmdjc/3TboNwpqOoMKV5i
         OeLX8YmeiNqRJG7+qO3SqgCSz6803F+0MpPCSd8KkKC9CoVhJdd+wbjh/8GPm3D77lv9
         IiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=p/OeYHRbRX/5njXOE6qg6rzLrWMnGOaVwRCOhvTaztE=;
        b=cJI+lL2KkDRIV5m9UklGtxPRc5a/POaMqCHyTyTE0gX+xqhXc4ZlpUbdKqObVYdhPD
         2vMAF0l6MBN+w8oVtSVLG7y97wbkcjUPNwv4zddWzBahxtpV8q+FmOeH1gZvHxe0ssas
         qlrB02yRO6leLU8C8pOW09zyFD9WPveYeCWYtSxi6oZvHKX+ihN2MKSKfB+HbE3f/WMm
         Lz1QwOVHp3eP3g6yZL5wWTVN7I9oF1faZPqt57G7KnZ+jz8XaV+zNsFVj/ngLQUoZ1i2
         IWolctqUO5+aO789DJer/0q2u58EAfsK/IQ6l+3s7CKXXGzfRLpTasG9p0eoaMfcqhzJ
         Gzkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c+6j3uo6;
       spf=pass (google.com: domain of xtrat.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=xtrat.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c+6j3uo6;
       spf=pass (google.com: domain of xtrat.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=xtrat.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZq0kHY8O5ZwAckFx2MQ/sWH9nuLB3G6AJzVWnwpSD7udoW/Uu4GLpy7b7ryZP4ww8bpCLVhrg==
From: Efstratios Gavas <xtrat.dev@gmail.com>
X-Google-Original-From: Efstratios Gavas <xtrat@elg.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Efstratios Gavas <xtrat@elg.io>
Subject: [PATCH] [v6] staging: wlan-ng: prism2sta: fix indent coding-style issues
Date: Sat,  5 May 2018 03:45:18 +0000
Message-Id: <20180505034518.21895-1-xtrat@elg.io>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599594236778992089?=
X-GMAIL-MSGID: =?utf-8?q?1599594236778992089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed format/style issues found with checkpatch. No code changes.
Corrected alignment of variables after open parenthesis and line breaks.
Checkpatch now returns clean except for "line over 80 char" warnings.

Signed-off-by: Efstratios Gavas <xtrat@elg.io>
---
v2(unlabeled): changed title info
v3: improved changelog description
v4: corrected patch versioning
v5: changed SMTP settings. changed maintainer email and removed
    upstream contributors per README to eliminate double submission issue
v6: changed SMTP server. changed title. resolved duplicate commit.
---
 drivers/staging/wlan-ng/prism2sta.c | 52 +++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index fed0b8ceca6f..914970249680 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -764,16 +764,16 @@ static int prism2sta_getcardinfo(struct wlandevice *wlandev)
 
 	if (hw->cap_sup_sta.id == 0x04) {
 		netdev_info(wlandev->netdev,
-		       "STA:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
-		       hw->cap_sup_sta.role, hw->cap_sup_sta.id,
-		       hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
-		       hw->cap_sup_sta.top);
+			    "STA:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
+			    hw->cap_sup_sta.role, hw->cap_sup_sta.id,
+			    hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
+			    hw->cap_sup_sta.top);
 	} else {
 		netdev_info(wlandev->netdev,
-		       "AP:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
-		       hw->cap_sup_sta.role, hw->cap_sup_sta.id,
-		       hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
-		       hw->cap_sup_sta.top);
+			    "AP:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
+			    hw->cap_sup_sta.role, hw->cap_sup_sta.id,
+			    hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
+			    hw->cap_sup_sta.top);
 	}
 
 	/* Compatibility range, primary f/w actor, CFI supplier */
@@ -1189,7 +1189,6 @@ void prism2sta_processing_defer(struct work_struct *data)
 			inf = (struct hfa384x_inf_frame *)skb->data;
 			prism2sta_inf_authreq_defer(wlandev, inf);
 		}
-
 	}
 
 	/* Now let's handle the linkstatus stuff */
@@ -1241,9 +1240,9 @@ void prism2sta_processing_defer(struct work_struct *data)
 			/* Collect the BSSID, and set state to allow tx */
 
 			result = hfa384x_drvr_getconfig(hw,
-						HFA384x_RID_CURRENTBSSID,
-						wlandev->bssid,
-						WLAN_BSSID_LEN);
+							HFA384x_RID_CURRENTBSSID,
+							wlandev->bssid,
+							WLAN_BSSID_LEN);
 			if (result) {
 				pr_debug
 				    ("getconfig(0x%02x) failed, result = %d\n",
@@ -1260,14 +1259,13 @@ void prism2sta_processing_defer(struct work_struct *data)
 				     HFA384x_RID_CURRENTSSID, result);
 				return;
 			}
-			prism2mgmt_bytestr2pstr(
-					(struct hfa384x_bytestr *)&ssid,
-					(struct p80211pstrd *)&wlandev->ssid);
+			prism2mgmt_bytestr2pstr((struct hfa384x_bytestr *)&ssid,
+						(struct p80211pstrd *)&wlandev->ssid);
 
 			/* Collect the port status */
 			result = hfa384x_drvr_getconfig16(hw,
-							HFA384x_RID_PORTSTATUS,
-							&portstatus);
+							  HFA384x_RID_PORTSTATUS,
+							  &portstatus);
 			if (result) {
 				pr_debug
 				    ("getconfig(0x%02x) failed, result = %d\n",
@@ -1404,7 +1402,7 @@ void prism2sta_processing_defer(struct work_struct *data)
 					       &joinreq,
 					       HFA384x_RID_JOINREQUEST_LEN);
 			netdev_info(wlandev->netdev,
-			       "linkstatus=ASSOCFAIL (re-submitting join)\n");
+				    "linkstatus=ASSOCFAIL (re-submitting join)\n");
 		} else {
 			netdev_info(wlandev->netdev, "linkstatus=ASSOCFAIL (unhandled)\n");
 		}
@@ -1501,7 +1499,7 @@ static void prism2sta_inf_assocstatus(struct wlandevice *wlandev,
 	if (i >= hw->authlist.cnt) {
 		if (rec.assocstatus != HFA384x_ASSOCSTATUS_AUTHFAIL)
 			netdev_warn(wlandev->netdev,
-	"assocstatus info frame received for non-authenticated station.\n");
+				    "assocstatus info frame received for non-authenticated station.\n");
 	} else {
 		hw->authlist.assoc[i] =
 		    (rec.assocstatus == HFA384x_ASSOCSTATUS_STAASSOC ||
@@ -1509,7 +1507,7 @@ static void prism2sta_inf_assocstatus(struct wlandevice *wlandev,
 
 		if (rec.assocstatus == HFA384x_ASSOCSTATUS_AUTHFAIL)
 			netdev_warn(wlandev->netdev,
-"authfail assocstatus info frame received for authenticated station.\n");
+				    "authfail assocstatus info frame received for authenticated station.\n");
 	}
 }
 
@@ -1674,9 +1672,8 @@ static void prism2sta_inf_authreq_defer(struct wlandevice *wlandev,
 			if (hw->authlist.cnt >= WLAN_AUTH_MAX) {
 				rec.status = cpu_to_le16(P80211ENUM_status_ap_full);
 			} else {
-				ether_addr_copy(
-					hw->authlist.addr[hw->authlist.cnt],
-					rec.address);
+				ether_addr_copy(hw->authlist.addr[hw->authlist.cnt],
+						rec.address);
 				hw->authlist.cnt++;
 				added = 1;
 			}
@@ -1697,8 +1694,8 @@ static void prism2sta_inf_authreq_defer(struct wlandevice *wlandev,
 		if (added)
 			hw->authlist.cnt--;
 		netdev_err(wlandev->netdev,
-		       "setconfig(authenticatestation) failed, result=%d\n",
-		       result);
+			   "setconfig(authenticatestation) failed, result=%d\n",
+			   result);
 	}
 }
 
@@ -1937,9 +1934,8 @@ void prism2sta_commsqual_defer(struct work_struct *data)
 
 	/* It only makes sense to poll these in non-IBSS */
 	if (wlandev->macmode != WLAN_MACMODE_IBSS_STA) {
-		result = hfa384x_drvr_getconfig(
-				hw, HFA384x_RID_DBMCOMMSQUALITY,
-				&hw->qual, HFA384x_RID_DBMCOMMSQUALITY_LEN);
+		result = hfa384x_drvr_getconfig(hw, HFA384x_RID_DBMCOMMSQUALITY,
+						&hw->qual, HFA384x_RID_DBMCOMMSQUALITY_LEN);
 
 		if (result) {
 			netdev_err(wlandev->netdev, "error fetching commsqual\n");
-- 
2.11.0
