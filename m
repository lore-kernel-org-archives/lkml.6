Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524635292; cv=none;
        d=google.com; s=arc-20160816;
        b=dv+1ADiqUKczCb/XdqyvlI5R+zvvTskBwVe2lEBClTaAJz5tLX0bZvOxsEYy9xjX7C
         G9mL61fi9o3bf2p3EZsgkW+DVdcp+uszgWpXyi82AzbXtv7vp0YukNPLOMUhNQeTrfSQ
         mYJNZIeEcEX2JudX6TupKziwiasjAcQqeOFNolRezKd8x64Jvbhlbfr2ZoBG+NgYkpJ3
         utTS5iDsLqf827O31QGcVZeZZz9WzIWmZoBSX6rqm/qRuoqgWg1PA2R20MmXd24YPT/M
         hjdncNo1VXCPjsHlX+orE3rZYwMdC9nIm/KJktxY1WpNLviR5Co6RXIFNFH6b9tSBeT/
         N0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AJeB4c0B7lSWwgZwHdkwKVI6S2rPbV9K1MnonqAaPA8=;
        b=rovzEp5SaPIMht0TdmM3I+kIlxr8mqe/aTSR3IsP/hlMxUt1HN7U6ykcG2nLtqb0JM
         ny8mJXkuFk//6BUYqx+wL63f12P9P4v7iD18w2OSRw52aCBceANnaqsda74i/ysiTX4Z
         iKXW3CaKFMpSdLasDeNMI/vzh1ZI/NpGJQDBEYuwLIFYTNs9cOK+XLktIzO1CieszJaY
         MaQ2y3MBqhkrBxS20bGyYj7VL0wO2GF1/Eaeo0Uea8NEaqIk5YdnJNf+S8ziEDlHs2mJ
         501HmbQX5tOe3D63BTalnsOXwG5xTZ0hA+F4NNm42E/vVvCXcT5K254J7IldZU6KzsyD
         2Iag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VfWd+qVf;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VfWd+qVf;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/jluRGwzHC/cPS/oIbmNOxWMeEPRVMZR7FM4QhGpQ44qadKP6i/B43ruCU9DadQ9GSWdzrgA==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 2/2] tty/nozomi: fix inconsistent indentation
Date: Tue, 24 Apr 2018 19:48:04 -1000
Message-Id: <eebb4bb5023839ee77d19e8d218d0766cf33711a.1524634929.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
In-Reply-To: <cover.1524634929.git.joeypabalinas@gmail.com>
References: <cover.1524634929.git.joeypabalinas@gmail.com>
In-Reply-To: <cover.1524634929.git.joeypabalinas@gmail.com>
References: <cover.1524634929.git.joeypabalinas@gmail.com>
X-Mailer-Send-Delay: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668999067037785?=
X-GMAIL-MSGID: =?utf-8?q?1598695976436414530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Correct misaligned indentation and remove extraneous spaces.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 drivers/tty/nozomi.c | 74 ++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index f26bf1d1e9ee0e74eb..0fcb4db721d2a42f08 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -100,45 +100,45 @@ do {							\
 /* Size of tmp send buffer to card */
 #define SEND_BUF_MAX		1024
 #define RECEIVE_BUF_MAX		4
 
 
-#define R_IIR		0x0000	/* Interrupt Identity Register */
-#define R_FCR		0x0000	/* Flow Control Register */
-#define R_IER		0x0004	/* Interrupt Enable Register */
+#define R_IIR			0x0000	/* Interrupt Identity Register */
+#define R_FCR			0x0000	/* Flow Control Register */
+#define R_IER			0x0004	/* Interrupt Enable Register */
 
 #define NOZOMI_CONFIG_MAGIC	0xEFEFFEFE
 #define TOGGLE_VALID		0x0000
 
 /* Definition of interrupt tokens */
-#define MDM_DL1		0x0001
-#define MDM_UL1		0x0002
-#define MDM_DL2		0x0004
-#define MDM_UL2		0x0008
-#define DIAG_DL1	0x0010
-#define DIAG_DL2	0x0020
-#define DIAG_UL		0x0040
-#define APP1_DL		0x0080
-#define APP1_UL		0x0100
-#define APP2_DL		0x0200
-#define APP2_UL		0x0400
-#define CTRL_DL		0x0800
-#define CTRL_UL		0x1000
-#define RESET		0x8000
+#define MDM_DL1			0x0001
+#define MDM_UL1			0x0002
+#define MDM_DL2			0x0004
+#define MDM_UL2			0x0008
+#define DIAG_DL1		0x0010
+#define DIAG_DL2		0x0020
+#define DIAG_UL			0x0040
+#define APP1_DL			0x0080
+#define APP1_UL			0x0100
+#define APP2_DL			0x0200
+#define APP2_UL			0x0400
+#define CTRL_DL			0x0800
+#define CTRL_UL			0x1000
+#define RESET			0x8000
 
-#define MDM_DL		(MDM_DL1  | MDM_DL2)
-#define MDM_UL		(MDM_UL1  | MDM_UL2)
-#define DIAG_DL		(DIAG_DL1 | DIAG_DL2)
+#define MDM_DL			(MDM_DL1  | MDM_DL2)
+#define MDM_UL			(MDM_UL1  | MDM_UL2)
+#define DIAG_DL			(DIAG_DL1 | DIAG_DL2)
 
 /* modem signal definition */
-#define CTRL_DSR	0x0001
-#define CTRL_DCD	0x0002
-#define CTRL_RI		0x0004
-#define CTRL_CTS	0x0008
+#define CTRL_DSR		0x0001
+#define CTRL_DCD		0x0002
+#define CTRL_RI			0x0004
+#define CTRL_CTS		0x0008
 
-#define CTRL_DTR	0x0001
-#define CTRL_RTS	0x0002
+#define CTRL_DTR		0x0001
+#define CTRL_RTS		0x0002
 
 #define MAX_PORT		4
 #define NOZOMI_MAX_PORTS	5
 #define NOZOMI_MAX_CARDS	(NTTY_TTY_MAXMINORS / MAX_PORT)
 
@@ -363,11 +363,11 @@ struct nozomi {
 struct buffer {
 	u32 size;		/* size is the length of the data buffer */
 	u8 *data;
 } __attribute__ ((packed));
 
-/*    Global variables */
+/* Global variables */
 static const struct pci_device_id nozomi_pci_tbl[] = {
 	{PCI_DEVICE(0x1931, 0x000c)},	/* Nozomi HSDPA */
 	{},
 };
 
@@ -1684,16 +1684,16 @@ static int ntty_tiocmget(struct tty_struct *tty)
 	const struct ctrl_dl *ctrl_dl = &port->ctrl_dl;
 	const struct ctrl_ul *ctrl_ul = &port->ctrl_ul;
 
 	/* Note: these could change under us but it is not clear this
 	   matters if so */
-	return	(ctrl_ul->RTS ? TIOCM_RTS : 0) |
-		(ctrl_ul->DTR ? TIOCM_DTR : 0) |
-		(ctrl_dl->DCD ? TIOCM_CAR : 0) |
-		(ctrl_dl->RI  ? TIOCM_RNG : 0) |
-		(ctrl_dl->DSR ? TIOCM_DSR : 0) |
-		(ctrl_dl->CTS ? TIOCM_CTS : 0);
+	return (ctrl_ul->RTS ? TIOCM_RTS : 0)
+		| (ctrl_ul->DTR ? TIOCM_DTR : 0)
+		| (ctrl_dl->DCD ? TIOCM_CAR : 0)
+		| (ctrl_dl->RI  ? TIOCM_RNG : 0)
+		| (ctrl_dl->DSR ? TIOCM_DSR : 0)
+		| (ctrl_dl->CTS ? TIOCM_CTS : 0);
 }
 
 /* Sets io controls parameters */
 static int ntty_tiocmset(struct tty_struct *tty,
 					unsigned int set, unsigned int clear)
@@ -1720,14 +1720,14 @@ static int ntty_cflags_changed(struct port *port, unsigned long flags,
 		struct async_icount *cprev)
 {
 	const struct async_icount cnow = port->tty_icount;
 	int ret;
 
-	ret =	((flags & TIOCM_RNG) && (cnow.rng != cprev->rng)) ||
-		((flags & TIOCM_DSR) && (cnow.dsr != cprev->dsr)) ||
-		((flags & TIOCM_CD)  && (cnow.dcd != cprev->dcd)) ||
-		((flags & TIOCM_CTS) && (cnow.cts != cprev->cts));
+	ret = ((flags & TIOCM_RNG) && (cnow.rng != cprev->rng))
+		|| ((flags & TIOCM_DSR) && (cnow.dsr != cprev->dsr))
+		|| ((flags & TIOCM_CD)  && (cnow.dcd != cprev->dcd))
+		|| ((flags & TIOCM_CTS) && (cnow.cts != cprev->cts));
 
 	*cprev = cnow;
 
 	return ret;
 }
-- 
2.17.0.rc1.35.g90bbd502d54fe92035.dirty
