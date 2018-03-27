Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELuQqyHIkKn5cYcd93BPd5xehfpkx3NGPvu0Nfw9lh68Q5qOjic86M9UKRcgw8z2eebafaqP
ARC-Seal: i=1; a=rsa-sha256; t=1522140090; cv=none;
        d=google.com; s=arc-20160816;
        b=ZHnWMxz4VMdfIT0aEmLN3HkFvDLNWetvwbDxHXVAd8IwWQluKE5+CGTJZjPpdp5Gi6
         xsgAHGe8FCau03mLvKFycjngzt3AH7ZcISTEYhsrP9AqOahao++H/n+DTfhS2JwEnniv
         jPuVT++OnylPeu1DP+YPOjsm58DtlMY04kDU7rs1mE2AwTNJu3thM+4vXjy76w3Uo2Xg
         JpkMJNSOitlamaVPcOyxd9UybQ7k6df74Ji8ur+EA95ArytGbxzCwEx4pWyaYaeHpAT8
         gL0yXgsymdxicfA4XbZ6QyfkvQckll+I4EZrISlmnduXqEjuOly03x9ng8qCL78Zspxp
         zlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=zghWSDk3ldEc0CnxbKklSpiv3ljqNYv+FG4942ajNxM=;
        b=v+FGl5ckURQ22kni1GmSjzEuY/UB+G+ogdjLOalhStttPZ9Budhm1aQgL+zEo7g+0f
         uIjwBCW9xgWVL6/wlHaoWQHgeWJOvmqT02f/9SYdPw4GHlkDMPpZDT3Y7aPAWnKhLZyr
         ArzW9Pjw9qBNQkW/ioxGW+xDwkcpacNmeJxQF9nvF2UiMbNwEjazfsgwrKK9/SUx0zf5
         L1m1Ow3DIAXvJnUo9UVlAoEZxDoXYePdE6SQEuN7ei4S5laB76zqj+T8GluVsnX/0fra
         j3OwE821ggDTiULVAcEoxKz1ucZFHX/M2hRIiVe96VHCrcCBp0SRekPLUAuCscfUUG/m
         SaIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 08/23] staging: rtl8723bs: Remove braces from single statement conditionals.
Date: Tue, 27 Mar 2018 01:41:00 -0700
Message-Id: <20180327084115.16129-8-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:rqymD5m2CTLXs1ReoMo1V15+HY9n1GejEM/NzBuz6nW1zP5OzDX
 qFwROv390I+nzEjzD9r1BlgaT4ofZuBV5u02ET5KXX3rJAKVn+y5U+SqaPlrLzM7wqu+HuS
 /+uRGoEEzcB7pSwCD+XNT8wDNoJOWvpLwdLigsOEZWGanrV2xNWUppIXzoHpxDRcUyk8pXF
 Ysk//SFqorEyxuY//O9Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+T1MRW7nfjw=:aPvdTPNNCkVdPHhuyU/oCy
 SxGTvRLxLosm/UYXpa+sBn0LkItUZt69uSeTRhqABAcKIrMXfYPWGtZfW1sJ8nY02G6cOSR9b
 l1R7o/S81CnWjxpEueq96LumRzrghe96d/mjuaRmvew9AdgV9b+W9AvoL02V1d3dRI7BWeZoq
 oanP65AveXt2YJpa+ZoH/gG+LzeTzv4ZoKtIsTGqGY30kFgDey4VCTO9tYWe6uCJ5HMF0QABQ
 CqKAxCIFA3vVv+6kbwMGVvRktd7WCd3BahU0fphDmB2uwaUUTQyOFCmwlsxEUS3zstT90LhI8
 C+4jo6kpLK+MAo9nC6uHO4XguuvlPkPLh9uBWuQbRU7g2/zRCmjH/NT0tz7W1LM0T+DF8wH5J
 O79wXj+v/CZGnG4uC26ssVBbEG+/h6kip/oIqe/UT5shyR9isCHVirQfZTre/bFK+QzdA5KIe
 E/+juu6tiPMGzy12XIOq2SZW9pf8omN3N0vQcju8v2BmBkttK52D7dl4+P1/vzVJw0KtvyQkV
 5ZuyYi7IJBqb+vbA6VzH/RDJ9k37VQ4WjTMglnERW69Gss4c+FgOHBFktHWY7APNsawEvvn+w
 Fo6PFXBDNtxs+0eCxEw911XXStZFUxRQ/j3JAAXeq91KCBwETjLiaIP3fswLfetYyjZdtAdI8
 5wu++4x5wBJq9HeXzZZ2EVaW7DbeaSLeJAFspa3+ocotTkcHR4uTn2yvqGOzLgVZaWD6n0qeJ
 bTDX8r1KETYhnIrUBQ8NeDRYQW8PdR8+K3JOvA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079567742818274?=
X-GMAIL-MSGID: =?utf-8?q?1596079567742818274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Several conditionals in rtw_wx_set_auth() contain a comment then a
single statement.  Move the comments to the top of the conditionals
so that braces can be removed from the statements, which saves space
and makes the code more readable.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 3e78fc28a8eb..1cacd7fff052 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2151,13 +2151,11 @@ static int rtw_wx_set_auth(struct net_device *dev,
 		 */
 		break;
 	case IW_AUTH_TKIP_COUNTERMEASURES:
-		if (param->value) {
-			/*  wpa_supplicant is enabling the tkip countermeasure. */
+		/* wpa_supplicant is setting the tkip countermeasure. */
+		if (param->value) /* enabling */
 			padapter->securitypriv.btkip_countermeasure = true;
-		} else {
-			/*  wpa_supplicant is disabling the tkip countermeasure. */
+		else /* disabling */
 			padapter->securitypriv.btkip_countermeasure = false;
-		}
 		break;
 	case IW_AUTH_DROP_UNENCRYPTED:
 		/* HACK:
@@ -2172,10 +2170,12 @@ static int rtw_wx_set_auth(struct net_device *dev,
 		 * be set.
 		 */
 
-		if (padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption1Enabled) {
-			break;/* it means init value, or using wep, ndisencryptstatus = Ndis802_11Encryption1Enabled, */
-			/*  then it needn't reset it; */
-		}
+		/*
+		 * This means init value, or using wep, ndisencryptstatus =
+		 * Ndis802_11Encryption1Enabled, then it needn't reset it;
+		 */
+		if (padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption1Enabled)
+			break;
 
 		if (param->value) {
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-- 
2.16.3
