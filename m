Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524609564; cv=none;
        d=google.com; s=arc-20160816;
        b=HY1QmoKq0RuwetytfP5YAkyS2S5flgUNfPh5yD0wBMjCmd+KnVUTBCsQB/rmb6YiMf
         oW1fvfRnfCDwAJbpSRKZXQFlwIWu0VrfAV1lBkIqSe8bbby1eF8U8gdfEk50QsmL9uNt
         YZGNEwrSWaFA1oIk3HYxj9F4URKEvJen3h7P20+8YazMXr8FMyCC6bwGE36xR8ZvMNiZ
         njruWBAQSonkfGdJ4lKL3xafgG0fa8LUFYWKQEH+Y+UEv5BrXvtWz3LF4vJ5Rg9X9NhT
         7ym6PtVkSu0RUi843Y7p2hygQK1i3Mduk0g9pmHg/jkYbhKHlCjh/K2uXaklwF6YkRyM
         Ck2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GB5WUl0ThGhryoCdEUwmROZDw+JERBQOKQl4cZpVLOY=;
        b=xatbd/2sIqVnasNHx63OCIVrTtLny1fjeOu6Iz2rc81gRFX/0LycFDhYvZRVD1pIhp
         F734qkUk0AUc3j+Sm1a9J8c7qy6DjRUrmnO0ECS27OmyC7Xtq4bq3gkOrtKLtcHyOqbW
         meawdxkLOHwHxEwxyJM+OLzu5+8x8piP2Zcd/55JDqZBV1tx9AUQeJuxeBNsXKgC6sYv
         +IzVwtVayCQLQAGRLK9/IM/oNA+b9NX90JkzJEGOspXXeEIk0qa+h7O7dR+GiO4dhkK1
         LX9udVLyQhNz7f1GeOCUjaR9VNk67OlQMdL+q+x0tfcld0MGkh6qCfzYJMMaLVpYSncJ
         nw3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TY56oD3T;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TY56oD3T;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48SdAhCRnLFKnx88Z5+xHcqoniBybs23BMBLz5u1dCa/NGrnhT90UhbKAt7j739QvVEtGGKLA==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 2/2] tty/nozomi: fix inconsistent indentation
Date: Tue, 24 Apr 2018 12:39:15 -1000
Message-Id: <eebb4bb5023839ee77d19e8d218d0766cf33711a.1524606061.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
In-Reply-To: <cover.1524606061.git.joeypabalinas@gmail.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
In-Reply-To: <cover.1524606061.git.joeypabalinas@gmail.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
X-Mailer-Send-Delay: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668999067037785?=
X-GMAIL-MSGID: =?utf-8?q?1598668999067037785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
2.17.0.rc1.35.g90bbd502d54fe92035.dirty
