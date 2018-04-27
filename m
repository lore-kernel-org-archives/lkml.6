Return-Path: <0b469db2.AM0AAAZF0rYAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa45e6@bnc3.mailjet.com>
X-Google-Smtp-Source: AB8JxZq2KsXiI9/ATiwppeIZQNHnHody1WfVgCIlrWbLecaPQ0y6yVXANPG9u8uCrWM8R8zYfdPB
ARC-Seal: i=1; a=rsa-sha256; t=1524864954; cv=none;
        d=google.com; s=arc-20160816;
        b=vbvSH3604yRqTluf6J4grxLyKgLzvJrHJ7WnBX+oWujswT229wAmQJTATijEiR6LI7
         oMoFVE5sJ6j4dpZd4tv0MdtWK48Clecto4baC4yZjQH8ManIUZ+Dmf9cmHfxpU2GpfPa
         Oc5qip17GGk9m0oufNODe8D2BraR5GI2eSRFHXJvWXvFPWFc5JjjlhIc5bEY+66lhQ46
         Ksfd/kK1Gq5CbCHj4511X0GUaYKxEFHTPd1BWWTw82jMgB/gospSPL2/UoiBL0ctN0w4
         +bk8Mjwbjm3rlO2xhMitYcgC+GaFI6WzhBz2wzVYfr4xZC23sJpvvdD6+WfAEbIf6Gph
         mM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:cc
         :list-unsubscribe:date:subject:from:message-id:dkim-signature
         :arc-authentication-results;
        bh=SfVjcc3/L3MUrsnsiT/XUZCq2H4KBJCMx4SGDfOZk9o=;
        b=XUeNTIwf3Dy8B+lKlZze3Ar9kwGgM74Y8PuVDoTmj/kJmJbc2pDeDy0uWWayts/iPb
         tXiQRqzmLhEw5vVWadKFQUMBLIEXfkV4Xc5TtZ0n4EcEeE+KJyYVETWQNTDqf4w2EY0S
         00Rd92q3qULrxo1QRBdIBc+pxTlUtkkKSDsjFrFOnOLdgeewvOioxLcmlfGbgKvLD/ep
         2YMiS7bdVBUXQBkt573TUgEZCNsy3NBFOF+80EPlt12c8kMzrquzMUT/HoeQwpNiXAgp
         zuJiPKZDL3HNvMI+IPVXD2PdFuX8YKbz33aIIcVKJRR6TpBkTDnEh0e7X8xTDd8QuUF6
         7Jjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@elg.io header.s=mailjet header.b=WxKTU1ib;
       spf=pass (google.com: domain of 0b469db2.am0aaazf0ryaaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba45e6@bnc3.mailjet.com designates 87.253.234.107 as permitted sender) smtp.mailfrom=0b469db2.AM0AAAZF0rYAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa45e6@bnc3.mailjet.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@elg.io header.s=mailjet header.b=WxKTU1ib;
       spf=pass (google.com: domain of 0b469db2.am0aaazf0ryaaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba45e6@bnc3.mailjet.com designates 87.253.234.107 as permitted sender) smtp.mailfrom=0b469db2.AM0AAAZF0rYAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa45e6@bnc3.mailjet.com
Message-Id: <0b469db2.AM0AAAZF0rYAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa45e6@mailjet.com>
From: Efstratios Gavas <xtrat@elg.io>
Subject: [PATCHv3] staging: wlan-ng: prism2sta: fixed indent coding style
 issues.
Date: Fri, 27 Apr 2018 21:33:34 +0000
List-Unsubscribe: <mailto:unsub-0b469db2.7334.s2jgtjolj2u5@bnc3.mailjet.com>
Cc: Efstratios Gavas <xtrat@elg.io>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Aviya Erenfeld <aviyae42@gmail.com>,
	Aviv Palivoda <palaviv@gmail.com>, Dan Carpenter
	<dan.carpenter@oracle.com>, Christopher H Pezley <chris@pezley.net>,
	Thibaut SAUTEREAU <thibaut.sautereau@telecom-sudparis.eu>, AbdAllah-MEZITI
	<abdallah.meziti.pro@gmail.com>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20180427065801.GC4361@kroah.com>
References: <20180427065801.GC4361@kroah.com>
X-CSA-Complaints: whitelist-complaints@eco.de
X-MJ-Mid: AM0AAAZF0rYAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa45e62nEeur7UQ6uwO7qgNU6prwAKs_E
X-MJ-SMTPGUID: c9be303c-cf30-48bc-b10b-5fee9da674da
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
	abuse@mailjet.com with a copy of the message
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598936794627162983?=
X-GMAIL-MSGID: =?utf-8?q?1598936794627162983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed format/style issues found with checkpatch. No code changes.
Corrected alignment of variables after open parenthesis and line breaks.
Checkpatch now returns clean except for line over 80 char warnings.

Signed-off-by: Efstratios Gavas <xtrat@elg.io>
---
v2(unlabled): changed title info
v3: improved changlog description
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
