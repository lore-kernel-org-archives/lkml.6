Return-Path: <59542ba7.AMoAAAZ9qy8AAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5sue@bnc3.mailjet.com>
X-Google-Smtp-Source: AB8JxZqJmmfrW1wCG+2lqQ52MSn6k9IjKCCp2gFmcD21Zd5jRDpop4z3DyZOTXFdq1WAKQ2fFfFT
ARC-Seal: i=1; a=rsa-sha256; t=1525074847; cv=none;
        d=google.com; s=arc-20160816;
        b=brL9pzG0ZMKJrZLN9cGm6VSefgZJnqOl+xUg9gwMm6jkYF8z5aTooHfXHpBPKj8yOM
         xWFMvhWS6/TlzRFfF3N6hcr9dQ3bH31gxFAZqOgh5vfL+DZhzMCPoVcH3hckE3mAlLq7
         d9z7jcRbM2dK14+wC+GPp5RSq67Fbz35TKmFtSQMa3aIWP/adE2raO118Nge1a0P0ALn
         LsTo5bAZkT/JhMFAfCTSQV2wOvq8Cof0H2Opd7HfDaPNUOdT3Ssw8ULDDAQIRCFp5ujX
         MvOM4HowUq7nkljucmlUtfh61c8neRWyFR3Gqsk/rJFVTCZ7i7uMCnYsPyUfl4POi5wR
         6HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:cc
         :list-unsubscribe:date:subject:to:from:message-id:dkim-signature
         :arc-authentication-results;
        bh=SiplKY5riMFtvAbsku982eEzvkhWl+5M/JXk8ktKTdg=;
        b=or+UB1bR6ajk2ouaRfc+UrjbwusqkeWa45Pz3NggiTNoGpd++K7K0pT2ui0ZwFZWLP
         xnKfLv+hvUiAWG29o1I/B3trjTAmVB9LB2ciWkF2NB3cMd4vW71ijkryyv26dy6E70am
         HjTanZgwk1uCrne0Vn8EYKwE1O1SqQfan0IC4L1M7FnJv4ZADmmhkxQqVq2JO5ZodBI+
         9cqyfVZsxughyEeaY5SOiWv/IrDuI9cCDlNoFGFKRvrDJTBzCsrlY/T1gmbEnGU1wfVj
         GHKi6q+ORceqi4bPvvtWeMZDsB05QkcwDDQPf1891U7offhksZUhy0A1lNPhJZnv45nl
         FaXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@elg.io header.s=mailjet header.b=CSHEkemJ;
       spf=pass (google.com: domain of 59542ba7.amoaaaz9qy8aaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba5sue@bnc3.mailjet.com designates 87.253.234.139 as permitted sender) smtp.mailfrom=59542ba7.AMoAAAZ9qy8AAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5sue@bnc3.mailjet.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@elg.io header.s=mailjet header.b=CSHEkemJ;
       spf=pass (google.com: domain of 59542ba7.amoaaaz9qy8aaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba5sue@bnc3.mailjet.com designates 87.253.234.139 as permitted sender) smtp.mailfrom=59542ba7.AMoAAAZ9qy8AAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5sue@bnc3.mailjet.com
Message-Id: <59542ba7.AMoAAAZ9qy8AAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5sue@mailjet.com>
From: Efstratios Gavas <xtrat@elg.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] [v5] staging: wlan-ng: prism2sta: fixed indent coding style
 issues.
Date: Mon, 30 Apr 2018 07:51:18 +0000
List-Unsubscribe: <mailto:unsub-59542ba7.7334.smpiz61mzt1o@bnc3.mailjet.com>
Cc: linux-kernel@vger.kernel.org, Efstratios Gavas <xtrat@elg.io>
In-Reply-To: <20180429131954.GA5972@kroah.com>
References: <20180429131954.GA5972@kroah.com>
X-CSA-Complaints: whitelist-complaints@eco.de
X-MJ-Mid: AMoAAAZ9qy8AAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5sueAYBHyKNET2qCwDXgQZdDwgAKs_E
X-MJ-SMTPGUID: 38b256b8-b324-4a44-924a-0d46c5fb4aa3
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
	abuse@mailjet.com with a copy of the message
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599156882798466532?=
X-GMAIL-MSGID: =?utf-8?q?1599156882798466532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed format/style issues found with checkpatch. No code changes.
Corrected alignment of variables after open parenthesis and line breaks.
Checkpatch now returns clean except for "line over 80 char" warnings.

Signed-off-by: Efstratios Gavas <xtrat@elg.io>
---
v2(unlabled): changed title info
v3: improved changlog description
v4: corrected patch versioning
v5: changed SMTP settings. changed maintainer email and removed
    upstream contributors per README to eliminate double submission issue
---
 drivers/staging/wlan-ng/prism2sta.c | 52 +++++++++++++++++----------------=
----
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/=
prism2sta.c
index fed0b8ceca6f..914970249680 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -764,16 +764,16 @@ static int prism2sta_getcardinfo(struct wlandevice *w=
landev)
=20
 	if (hw->cap_sup_sta.id =3D=3D 0x04) {
 		netdev_info(wlandev->netdev,
-		       "STA:SUP:role=3D0x%02x:id=3D0x%02x:var=3D0x%02x:b/t=3D%d/%d\n",
-		       hw->cap_sup_sta.role, hw->cap_sup_sta.id,
-		       hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
-		       hw->cap_sup_sta.top);
+			    "STA:SUP:role=3D0x%02x:id=3D0x%02x:var=3D0x%02x:b/t=3D%d/%d\n",
+			    hw->cap_sup_sta.role, hw->cap_sup_sta.id,
+			    hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
+			    hw->cap_sup_sta.top);
 	} else {
 		netdev_info(wlandev->netdev,
-		       "AP:SUP:role=3D0x%02x:id=3D0x%02x:var=3D0x%02x:b/t=3D%d/%d\n",
-		       hw->cap_sup_sta.role, hw->cap_sup_sta.id,
-		       hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
-		       hw->cap_sup_sta.top);
+			    "AP:SUP:role=3D0x%02x:id=3D0x%02x:var=3D0x%02x:b/t=3D%d/%d\n",
+			    hw->cap_sup_sta.role, hw->cap_sup_sta.id,
+			    hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
+			    hw->cap_sup_sta.top);
 	}
=20
 	/* Compatibility range, primary f/w actor, CFI supplier */
@@ -1189,7 +1189,6 @@ void prism2sta_processing_defer(struct work_struct *d=
ata)
 			inf =3D (struct hfa384x_inf_frame *)skb->data;
 			prism2sta_inf_authreq_defer(wlandev, inf);
 		}
-
 	}
=20
 	/* Now let's handle the linkstatus stuff */
@@ -1241,9 +1240,9 @@ void prism2sta_processing_defer(struct work_struct *d=
ata)
 			/* Collect the BSSID, and set state to allow tx */
=20
 			result =3D hfa384x_drvr_getconfig(hw,
-						HFA384x_RID_CURRENTBSSID,
-						wlandev->bssid,
-						WLAN_BSSID_LEN);
+							HFA384x_RID_CURRENTBSSID,
+							wlandev->bssid,
+							WLAN_BSSID_LEN);
 			if (result) {
 				pr_debug
 				    ("getconfig(0x%02x) failed, result =3D %d\n",
@@ -1260,14 +1259,13 @@ void prism2sta_processing_defer(struct work_struct =
*data)
 				     HFA384x_RID_CURRENTSSID, result);
 				return;
 			}
-			prism2mgmt_bytestr2pstr(
-					(struct hfa384x_bytestr *)&ssid,
-					(struct p80211pstrd *)&wlandev->ssid);
+			prism2mgmt_bytestr2pstr((struct hfa384x_bytestr *)&ssid,
+						(struct p80211pstrd *)&wlandev->ssid);
=20
 			/* Collect the port status */
 			result =3D hfa384x_drvr_getconfig16(hw,
-							HFA384x_RID_PORTSTATUS,
-							&portstatus);
+							  HFA384x_RID_PORTSTATUS,
+							  &portstatus);
 			if (result) {
 				pr_debug
 				    ("getconfig(0x%02x) failed, result =3D %d\n",
@@ -1404,7 +1402,7 @@ void prism2sta_processing_defer(struct work_struct *d=
ata)
 					       &joinreq,
 					       HFA384x_RID_JOINREQUEST_LEN);
 			netdev_info(wlandev->netdev,
-			       "linkstatus=3DASSOCFAIL (re-submitting join)\n");
+				    "linkstatus=3DASSOCFAIL (re-submitting join)\n");
 		} else {
 			netdev_info(wlandev->netdev, "linkstatus=3DASSOCFAIL (unhandled)\n");
 		}
@@ -1501,7 +1499,7 @@ static void prism2sta_inf_assocstatus(struct wlandevi=
ce *wlandev,
 	if (i >=3D hw->authlist.cnt) {
 		if (rec.assocstatus !=3D HFA384x_ASSOCSTATUS_AUTHFAIL)
 			netdev_warn(wlandev->netdev,
-	"assocstatus info frame received for non-authenticated station.\n");
+				    "assocstatus info frame received for non-authenticated station.\n"=
);
 	} else {
 		hw->authlist.assoc[i] =3D
 		    (rec.assocstatus =3D=3D HFA384x_ASSOCSTATUS_STAASSOC ||
@@ -1509,7 +1507,7 @@ static void prism2sta_inf_assocstatus(struct wlandevi=
ce *wlandev,
=20
 		if (rec.assocstatus =3D=3D HFA384x_ASSOCSTATUS_AUTHFAIL)
 			netdev_warn(wlandev->netdev,
-"authfail assocstatus info frame received for authenticated station.\n");
+				    "authfail assocstatus info frame received for authenticated statio=
n.\n");
 	}
 }
=20
@@ -1674,9 +1672,8 @@ static void prism2sta_inf_authreq_defer(struct wlande=
vice *wlandev,
 			if (hw->authlist.cnt >=3D WLAN_AUTH_MAX) {
 				rec.status =3D cpu_to_le16(P80211ENUM_status_ap_full);
 			} else {
-				ether_addr_copy(
-					hw->authlist.addr[hw->authlist.cnt],
-					rec.address);
+				ether_addr_copy(hw->authlist.addr[hw->authlist.cnt],
+						rec.address);
 				hw->authlist.cnt++;
 				added =3D 1;
 			}
@@ -1697,8 +1694,8 @@ static void prism2sta_inf_authreq_defer(struct wlande=
vice *wlandev,
 		if (added)
 			hw->authlist.cnt--;
 		netdev_err(wlandev->netdev,
-		       "setconfig(authenticatestation) failed, result=3D%d\n",
-		       result);
+			   "setconfig(authenticatestation) failed, result=3D%d\n",
+			   result);
 	}
 }
=20
@@ -1937,9 +1934,8 @@ void prism2sta_commsqual_defer(struct work_struct *da=
ta)
=20
 	/* It only makes sense to poll these in non-IBSS */
 	if (wlandev->macmode !=3D WLAN_MACMODE_IBSS_STA) {
-		result =3D hfa384x_drvr_getconfig(
-				hw, HFA384x_RID_DBMCOMMSQUALITY,
-				&hw->qual, HFA384x_RID_DBMCOMMSQUALITY_LEN);
+		result =3D hfa384x_drvr_getconfig(hw, HFA384x_RID_DBMCOMMSQUALITY,
+						&hw->qual, HFA384x_RID_DBMCOMMSQUALITY_LEN);
=20
 		if (result) {
 			netdev_err(wlandev->netdev, "error fetching commsqual\n");
--=20
2.11.0

=
