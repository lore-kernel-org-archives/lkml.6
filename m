Return-Path: <kernel-hardening-return-13079-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/nXdMW3gA4ZM+pQCPe7Ro5wVJzwpa4VCHtomVP+bUedTleyr230dGh5sEHBjq5LAGbne02
ARC-Seal: i=1; a=rsa-sha256; t=1524414734; cv=none;
        d=google.com; s=arc-20160816;
        b=MGgXN2pDkuvAwzE60QEPDczz1DsH/rqWscxkTWp/jq0aYwbyNYelCsamWkck3OP2yx
         33wmcfD8i4RHOjiRbrlmSXg6Ds8+/d6GOD6U4ekgo2bgt2eo8Uz+kQKmw+ry/ZmLqlS+
         9Gz4AKZA1haZNr1bFjrm4DBxAa0PDCJRztzcA/54kTH1d08OF+tRiSU47ivLAjuA03Jw
         S9XWfwrAWqzzigfXIgw8o1YOLg4zcwkWIEZQObjI9TFOIUO5qihGdzve8cug//NKQQeW
         mfxh3kXiMIBQ4IowwUsK1L4jbWLjXmiJrvqk2Qo/mQeTWLddZYMZxZz+gT2l6hQob3+U
         9FBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Cy9MD03RuMqWof3u+bKFBFKZhDQM76wcsiQ8Z+xhdWA=;
        b=H4dAjJoJV1ds7ZyBfKvXJf1OcUe5aQZBchJKDVdUNqNBsu5kQrtdfpI5OpKs3wAJU2
         G+iWxsfslYDKCONVHDQphhUcy1vpqX9bXUpFV9H9ELPTZTUaTDJquIzGVAviAql3rW1A
         6GpI6xC6cOHD4iANoaYMMZp4A+z/ZsSm9UxGfGq2XGwKm+JdRwgDtrw23QyU/4fTU2T5
         bRaakSQZWISDCQdWF3yL2Vas2hH2vC0awv1YBsbj7fzMZtTUBresohjRXp9ha6L/4PcZ
         M1NKsUx4UkXtpkaob9+VYlczJD7oF9Y1XKX4L3NwJU7U+ANB0PA+15kYuAWLkInZmHg7
         kbCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13079-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13079-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13079-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13079-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180422162512.555421729@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:48 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [patch V3 03/10] rslib: Cleanup whitespace damage
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Cleanup_whitespace_damage.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464704735712819?=
X-GMAIL-MSGID: =?utf-8?q?1598464704735712819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Instead of mixing the whitespace cleanup into functional changes, mop it up
first.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Alasdair Kergon <agk@redhat.com>

---
 include/linux/rslib.h           |   12 ++++++------
 lib/reed_solomon/reed_solomon.c |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -39,15 +39,15 @@
  * @list:	List entry for the rs control list
 */
 struct rs_control {
-	int 		mm;
-	int 		nn;
+	int		mm;
+	int		nn;
 	uint16_t	*alpha_to;
 	uint16_t	*index_of;
 	uint16_t	*genpoly;
-	int 		nroots;
-	int 		fcr;
-	int 		prim;
-	int 		iprim;
+	int		nroots;
+	int		fcr;
+	int		prim;
+	int		iprim;
 	int		gfpoly;
 	int		(*gffunc)(int);
 	int		users;
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -192,7 +192,7 @@ void free_rs(struct rs_control *rs)
  *  @gffunc:	pointer to function to generate the next field element,
  *		or the multiplicative identity element if given 0.  Used
  *		instead of gfpoly if gfpoly is 0
- *  @fcr:  	the first consecutive root of the rs code generator polynomial
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
@@ -209,9 +209,9 @@ static struct rs_control *init_rs_intern
 	if (symsize < 1)
 		return NULL;
 	if (fcr < 0 || fcr >= (1<<symsize))
-    		return NULL;
+		return NULL;
 	if (prim <= 0 || prim >= (1<<symsize))
-    		return NULL;
+		return NULL;
 	if (nroots < 0 || nroots >= (1<<symsize))
 		return NULL;
 
@@ -254,7 +254,7 @@ static struct rs_control *init_rs_intern
  *  @gfpoly:	the extended Galois field generator polynomial coefficients,
  *		with the 0th coefficient in the low order bit. The polynomial
  *		must be primitive;
- *  @fcr:  	the first consecutive root of the rs code generator polynomial
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
@@ -274,13 +274,13 @@ struct rs_control *init_rs_gfp(int symsi
  *  @gffunc:	pointer to function to generate the next field element,
  *		or the multiplicative identity element if given 0.  Used
  *		instead of gfpoly if gfpoly is 0
- *  @fcr:  	the first consecutive root of the rs code generator polynomial
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
  */
 struct rs_control *init_rs_non_canonical(int symsize, int (*gffunc)(int),
-                                         int fcr, int prim, int nroots)
+					 int fcr, int prim, int nroots)
 {
 	return init_rs_internal(symsize, 0, gffunc, fcr, prim, nroots,
 				GFP_KERNEL);
