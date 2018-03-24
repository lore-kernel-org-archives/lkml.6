Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521890861; cv=none;
        d=google.com; s=arc-20160816;
        b=R0AtrCu29sMsHzcFHlZrG8VwEKP/2X/b+r7oFG6rxsEado+lF6sJa6WDmiN0lehT1s
         IcMl4Ms6UBpdPUeuyukGd7heMvu+/xS7JAnjhEOf+adT6+qxHKq5Vft4N1O6EO8Tr5PO
         0tuoM+KqksMO2kVfwqGeRhAL/EFhm6nzCjT5kJwkHoxIu30u8X4NqytVjuqQMVxqgQbk
         kV65/hMXpP7rE4Nb+jkST1+nWSKiApRivBgEhM11PgGzj2M4QQQmUbyYm42Tp/TJBrks
         pMY2Re78s6AAS+Wblt4+x92oBfwp8QfiMEclh0W4dehfrkJuZH17CmPS2Q2+lK9sjOpd
         eacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0/2CRlx4K53JoeFoyFHBhWN1XlJVmLYOFnC66EUwWso=;
        b=KGGwi7s5rH/U/TfSYklYvXKHthsa7ndCJ4JJWfrl8WKU9XIZxiKA51xdPjDlsuyWh9
         QJ0cFtBUS5rl4xrDX/1QvpiC0BxKkYiiLuESo7wNsCZQE4++U3vlf+oTokVhN1b9njmV
         hZQAhV6HDBpxlQThEPrWKr0f++OCdhdnu04dBceVryqPRjMg/cb7Ih5Du6wvqd++YxKT
         KhiEwslMQ6xjKnIXSXh4q4V0/khKnqLTKrGMX/wY0NuZcTnH1AYgC47xA/uqJ1VDWEaM
         KthnkQ0ysoASi+VkArsZi7V7Z7az698HCsGQUP2A/AO4GnmPmvGOUYENuF5MaEgMsdh3
         5isg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CQ2lAiP2;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CQ2lAiP2;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELucAKO49acwb9uiOeRNgzpizURfo5tS9CbVz7WlU+8YOM7MuN0i2cLQTezHgiozl3exUDcxWA==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>,
	Tomasz Kramkowsk <tk@the-tk.com>
Subject: [PATCH v2 2/4] tty/nozomi: fix inconsistent indentation
Date: Sat, 24 Mar 2018 01:27:30 -1000
Message-Id: <20180324112732.29424-3-joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180324112732.29424-1-joeypabalinas@gmail.com>
References: <20180324112732.29424-1-joeypabalinas@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595818231687037662?=
X-GMAIL-MSGID: =?utf-8?q?1595818231687037662?=
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
2.16.3
