Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELsc9xDSQ08rkAiB/DwS8h3bTEvxsnvLIkbUpZRicSep4PYSCkw9jnlzaKq8Gxll9t51SCzs
ARC-Seal: i=1; a=rsa-sha256; t=1519429605; cv=none;
        d=google.com; s=arc-20160816;
        b=LlG6vfmEjsjlUXxIgfNKAdftVcRW6bfjx/EZwPk/4rc1fWM8sbc01DaR4/LMY0a2Sz
         buEFqCB/eLancUU+6ipWfWkZU3xUaBgDyqB9QMERfELpe8otTBkn0MK/67R50K2+2hJQ
         kS2hu54Y7pgf/FkgEmE2d9CkOawa2Znp+yS+F8KzFZNkorCipTICYUH/2h8i6EBS8XN3
         TDwlTOfQt3+KcFdw1/FBgEvxQbROnEpaMuuDqlPr24wT6Y2du/KRHI9rX56OlNwh+aPy
         jct+kfSgCjd8vwrwfbHV1X5YD0h2ZzsAezuXORYnnOIyrzEGoaVIKt9i3OqgUYm2hgLx
         jmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hbR1BchfMLvBstctK28wOKWeEhY/YQh9m75xjszlDoA=;
        b=0lBQsvhp56Bz9zcRgmOyYSTmJ+8E98ErMJ2cuxNTKRqRUov3RgDlvFtUYcjlgz8mf6
         vrHgXm47Ncvj0WBVN6DVrc1wOxue4Jk6tVgyss/HYi+vd6i8LBvzVrw5ag63hOndQL87
         ymnWO523iDmZKXKCdrugHffueWKkk15Bki2A4Ag5xG2m0BWs10RHjS/WM1UMOYclLCWn
         cyb4XBt/Q87FVazaryAQJkUhJqpfcAH7zY9kFg8tfMHtLQ6GQDGWFiDQ/5tGJ0GhNAn7
         Vb6V8MfaRBYqwEWsFtPglQbn1YVwkpapyH6iIhnXg4FCQOYVHTjhFvLvD2qEnabPT9VT
         xOWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	deanahn@gctsemi.com,
	dan.carpenter@oracle.com
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH] staging: gdm724x: hci: Remove unused struct sdu_header.
Date: Fri, 23 Feb 2018 15:46:30 -0800
Message-Id: <20180223234630.26894-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223081526.GA12617@kroah.com>
References: <20180223081526.GA12617@kroah.com>
X-Provags-ID: V03:K0:IzW8SLiVs+SiiA1/ZMkhDl8dp8LrW91lC0Gn3jw2PVQdXdllFIZ
 Zz0DIltl4qKswGQVZ3AIARkg2w9+lODp9W2nHarfGfoE2hlX62vtyHylzQc9CYJuU7yoR0V
 afOes3r7sJr52ZA4mc5OtORNQLA3vKTtdSKslODfZ4+6tEL6NpegNlDn4ROyAkEfWMndh4Q
 LLL3A3Ybk6XN9WvGJoZIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eXMYatCcT3s=:GnCqf1ozfsC9XV/g95C5AG
 FATVU9R6xOskx+R6e4d95XDP88IedGYAFJQO+Kr538B+B7EPNvV1ftKNziRsukh9QVofiCoRI
 vfeLJKHCKCq7Y+Rt8ufI1ehq2hs6uzo6ZtE08siZId+aHXtEKRrOaQKufCpZteRmPPwsjGhsE
 YYY+jbaffugFRd/GkE2epWRN2/F0jE41K1y1iJCIxXn5CCcVaVFO1BXndSQPvFP/Vx1Sukq/d
 WjAMoYLkXin5T1swg4SFNZv+MTTwGPCaipn+PsBHfY7YoSshOXAG7EwG5CpMIbU/pXwVJbTk+
 DncRxDrL7lcYlOSXXMPRGUz8pmZDTcgbhPmT2aCzdB/9bd8LnlH/vG+zn5JR9hQyejpEobX+R
 VGXt2RpiWgaelCckevJj8tiayP4BjMXSZlznC4Q0GHC8cDUhjl5w+/FYiXiTQkGEgOWiX5WFt
 P4cOCKnoulJDgLMG9qC6KiabgMRKF08nzkaMFihHYRvazdIS8YkMrCK9a6rsT65V1sE/EXzFS
 p7oo7YaX3BI4xN01e/nf8bXSIxpZuWImqNZnkQU/+sjGCEaLo6UQxOENueWo/xOP4Nl+qXj2f
 VhhRoQWgFcR4XkPFJsQuTJg2l43ouQnsWcGRiWLGbrdHn7esT0twLE0i/f5DEQxpolceH+Hsm
 5FG7cr2yKobt9OwN7ymaCmd3e7zVKRMv+CuA77sn+A6Qb9cwTxs4vs4bXxsiyxhGzmZAlLAlw
 JADyzhkTRSmysbLWbGrqd3c8f5ksSAPbJeAwJw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593237418167069853?=
X-GMAIL-MSGID: =?utf-8?q?1593237418167069853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

struct sdu_header isn't actually used anywhere in this driver, so
this change removes it on the assumption it isn't needed for any
API.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/hci_packet.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
index f8837c7103ac..695482464596 100644
--- a/drivers/staging/gdm724x/hci_packet.h
+++ b/drivers/staging/gdm724x/hci_packet.h
@@ -47,14 +47,6 @@ struct tlv {
 	u8 *data[1];
 } __packed;
 
-struct sdu_header {
-	__dev16 cmd_evt;
-	__dev16 len;
-	__dev32 dft_eps_ID;
-	__dev32 bearer_ID;
-	__dev32 nic_type;
-} __packed;
-
 struct sdu {
 	__dev16 cmd_evt;
 	__dev16 len;
-- 
2.16.2
