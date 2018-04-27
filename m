Return-Path: <0be70181.ANAAAAYeH9kAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa4rkP@bnc3.mailjet.com>
X-Google-Smtp-Source: AB8JxZrF0iagmCltpVBJKG+CEbnLcle2ycCECz+df2+4mMQNsmhcKMxSpM5PuAJeUc+owkizyxBn
ARC-Seal: i=1; a=rsa-sha256; t=1524807952; cv=none;
        d=google.com; s=arc-20160816;
        b=axVXSMvrRw15o5lSGy25LKdczBOix4LNiHSnw8zSRQsxhksoB5jZKLADTBSFvvI+Iy
         wsH2ZV0Ca++WcZoxKkzEvS8PwIv4ZL4aKVAGHEKS4c59Uz5nc7VeMwOUgozkZz/43lCV
         RhF2GLQ8gYuWlHu1ndt3tu2pQ4giB2YXRSulaOpswOSq0sBC9+Enhd9UKwbD+1BYPcbK
         uaXjnn82vDVz2u62ZRtXvkIev/y2c60OmNsvYOLoKw4SLOOZoQVfsTjypsKXo5bgkiFA
         0FK6QlQO+4wCuKBwW5byzgqeYoipIIqoGsA2fwkAW39Gjd0hC9HOY3eSfOfHSDGdLGLz
         rrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:cc:list-unsubscribe:date
         :subject:to:from:message-id:dkim-signature
         :arc-authentication-results;
        bh=mdlAxiZbKtYZY9Ff2n2LCVOT/T2oAQvnHRDYa9pOe1I=;
        b=lw3MRQwtegKXWbvxa6YceNZCkgyLDtaZkk6oFNBS2M7MQoBp5PIrMEdHoTVsTnd1N7
         3jd1ghhBcnZEIkWpd2W9hxWrlUcKZR/CK3Mk8+o5p0JVJFzpj9LTwZPToEiekBdeD1gB
         G5IIrYI03LlN60ycLH5uEDLSZWHE2X4MbD+I/CkxQPNeXAF1vEQ3ek/m2pxQnWyR3ltj
         bfUT6DNOere8bRoZoczXrfAZ6vASjcsNNJxUpZ9qnBjY+JVC/A5bRbmHJeEOcI6hG/2p
         MStrOXhna3bxtC6H6CD8d6FEBGRdjPnZdy3Y5uKbRHCnkm/5Mz5sxzbHLyHp+paYf8c4
         Bt8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@elg.io header.s=mailjet header.b=c1d1TNB/;
       spf=pass (google.com: domain of 0be70181.anaaaayeh9kaaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba4rkp@bnc3.mailjet.com designates 87.253.234.128 as permitted sender) smtp.mailfrom=0be70181.ANAAAAYeH9kAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa4rkP@bnc3.mailjet.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@elg.io header.s=mailjet header.b=c1d1TNB/;
       spf=pass (google.com: domain of 0be70181.anaaaayeh9kaaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba4rkp@bnc3.mailjet.com designates 87.253.234.128 as permitted sender) smtp.mailfrom=0be70181.ANAAAAYeH9kAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa4rkP@bnc3.mailjet.com
Message-Id: <0be70181.ANAAAAYeH9kAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa4rkP@mailjet.com>
From: Efstratios Gavas <xtrat@elg.io>
To: xtrat@elg.io
Subject: [PATCH] Staging: wlan-ng: prism2sta: fixed indent coding style
 issues.
Date: Fri, 27 Apr 2018 05:45:07 +0000
List-Unsubscribe: <mailto:unsub-0be70181.7334.s31zvq6m2lt8@bnc3.mailjet.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, AbdAllah-MEZITI
	<abdallah.meziti.pro@gmail.com>, Thibaut SAUTEREAU
	<thibaut.sautereau@telecom-sudparis.eu>, Aviv Palivoda <palaviv@gmail.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
X-CSA-Complaints: whitelist-complaints@eco.de
X-MJ-Mid: ANAAAAYeH9kAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa4rkPD_LPFWWXQ3mYqOO859jNHwAKs_E
X-MJ-SMTPGUID: 946aed3e-7cb9-47d5-b0da-f1cb78af501e
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
	abuse@mailjet.com with a copy of the message
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598877023838012015?=
X-GMAIL-MSGID: =?utf-8?q?1598877023838012015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed coding style issues.
Signed-off-by: Efstratios Gavas <xtrat@elg.io>
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
