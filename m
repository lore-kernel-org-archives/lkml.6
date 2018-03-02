Return-Path: <arushisinghal19971997@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519958893; cv=none;
        d=google.com; s=arc-20160816;
        b=H24YgQRSeLfkgIgSYQ0CKxwete0AnNjI2JfFzg/2IrxI0Ekx1Odo26chcAxWuHB45R
         HenUuNtK2J6mbsHcSFzNbBtnmKF52dHgdMNynLJj+Cc0vTz0BNPkNmM8228y8UAErG0o
         yBV3cnme075nUMJiQdN/4o1qq+pMIJqotXF4XQoCRJNRa9rzl805G7bzAXwsmZroFqyG
         /fs1CkzEJkaKrMubd0ab+IVF1D6z2lmcN9tYxNbQPl+WPUJhAJaWjjR/amqpV9fP3etl
         HVAJ4/aZEjZKrFnBlFwUcbjGH+WU1Va5i4wJocYY8Z9SfxOZtYeDve/1pDb9gSVt/lMu
         KQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:dkim-signature:arc-authentication-results;
        bh=8lXCtt5fUNlOceIxx94o4ZjvXbWOgNSekMHzQa/skRA=;
        b=aTfBrSm/s9AQjPADHsSkadWM3d9PXNFvIhTSuRYurD00a4gJWkWWu6xr3cskCpN2UD
         nRR5ctcYl4qKVhL1ILmoFHDzZZ44O0BzoupY37E3uecIusIJy56rRPUc3HzwSPIRzUbe
         S091PXjtdhW689HR3uZRIlALqoNo5CvpfEtpgBRXbbDAOCl9yPVAb3BGZ0SwQmKnTqfG
         tQ033I4NsLRgS6BQC4qU867SJR+Nhe7sHATQGO2yTDtGsIyHqlz7T7Gja/FgEeZsO5Ws
         0bqfyTmJFqNkTRtVi7pzpaUKX6Od2UptMbvj1JXRA77T5hNZf0WRscwscMAY9T9MGYUi
         DiyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Q8YYSASB;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Q8YYSASB;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvCdQLzIkQDTSICSV1P8IJ+Zpq5k/DNPUSW0Jq9msXo26p09Vd/Sjj3CkpcHLgVnoILDT5xQg==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
X-Google-Original-From: Arushi Singhal <arushisinghal@gmail.com>
Date: Fri, 2 Mar 2018 08:17:49 +0530
To: Larry.Finger@lwfinger.net
Cc: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8712: Fixed 'tabstop' coding style warning
Message-ID: <20180302024749.GA16440@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593792416569980359?=
X-GMAIL-MSGID: =?utf-8?q?1593792416569980359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace a mix of tabs and spaces indentation by tabs only.

Fixed checkpatch warning "Statements should start on a tabstop" in
rtl8712 module.

Signed-off-by: Arushi Singhal <arushisinghal@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index ae79047..ede99e9 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -161,7 +161,7 @@ struct _adapter {
 	u8	EepromAddressSize;
 	u8	hw_init_completed;
 	struct task_struct *cmdThread;
-	 pid_t evtThread;
+	pid_t evtThread;
 	struct task_struct *xmitThread;
 	pid_t recvThread;
 	uint (*dvobj_init)(struct _adapter *adapter);
-- 
2.7.4
