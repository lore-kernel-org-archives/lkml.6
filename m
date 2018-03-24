Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCXAbm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:31:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36234 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeCXAbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:31:38 -0400
X-Google-Smtp-Source: AG47ELvnuLY9L+WT1fJRVxhvYLTD+sbCDVWkZ6yzCTdHtyVBpmVmX9JHgUbVSFtRW425FeqY4KE8Hg==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 2/4] tty/nozomi: fix inconsistent indentation
Date: Fri, 23 Mar 2018 14:31:25 -1000
Message-Id: <20180324003127.4287-3-joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180324003127.4287-1-joeypabalinas@gmail.com>
References: <20180324003127.4287-1-joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct misaligned indentation and remove extraneous spaces.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index f26bf1d1e9ee0e74eb..0fcb4db721d2a42f08 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -102,41 +102,41 @@ do {							\
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
@@ -365,7 +365,7 @@ struct buffer {
 	u8 *data;
 } __attribute__ ((packed));
 
-/*    Global variables */
+/* Global variables */
 static const struct pci_device_id nozomi_pci_tbl[] = {
 	{PCI_DEVICE(0x1931, 0x000c)},	/* Nozomi HSDPA */
 	{},
@@ -1686,12 +1686,12 @@ static int ntty_tiocmget(struct tty_struct *tty)
 
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
@@ -1722,10 +1722,10 @@ static int ntty_cflags_changed(struct port *port, unsigned long flags,
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
 
-- 
2.16.3
