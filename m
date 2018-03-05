Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AG47ELuhMiUDG0EdqfJAibIzy+OTSkWWNlkTiy5UsLpxyMI7hl/tb/EmZVKNDibnBpIE95Du+E4D
ARC-Seal: i=1; a=rsa-sha256; t=1520222323; cv=none;
        d=google.com; s=arc-20160816;
        b=kzmG3VSrehVYnAEPnozTJVH2tYfgCcxRM1ZxdBdhRwopxnU6sLEvPFKVsc8S/59rPy
         Y6ofksfcL61WGruy/L5rSKxTLmplYhViGRdFPvgKqQTh68OiGplO2+wgffa5K2ytpV20
         pK7YALbWvv8Jz25XIo42om2XmU3pSkSxKfGSLuj5zL2wicLJdkxyhX7xJh0bbVPLmZ08
         FJ54jeWNF+ymGecxzjzrrGTImE9ac+fJy5BZ5bmzOLmcomFrmHVItTsLL78w0I5fBThI
         eoT+2P7cys9AoX26qonbrwhrgsVcaBWSWUuyRqiHmxPQzwBcYi2Q8WH7AyXSFA8d7e43
         d2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=xhJsLzPCPpy2fb8Tkt2zQ+pBIbOI4rWrt0F9mMTnPJk=;
        b=oG9Y9UdXj7MBklNdB4Zwznu2g/q8c2KetTP14TUT8B8lVa5XcCbN3gM4RxZyvo2K1s
         p4DZwYbLByKk6ZtT4pvDcRmfjVMG6X0/9NwElPSC5Da+QJMCuaIUDD4/5Ge9m05tkwQF
         ghG33mU9+LZdVld28eqr1sp+kWzGO7t/d7qjrrngGBH7HL8aDf0ZqZuBpNNhlChiwIFk
         eKBbcLEb28iH77GL1RtaVXrhEa2/lOqhzrTZi8ozA+sqys3O5gzmnCX1EOjp/N/kVVGO
         kuAoIUT+NAQqMA45MprtTqbx54Hbx41Vsfqfb2+N/vicIeeTqAh9fleJP0wlg9D6kdKX
         pC+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=ge6mOj/e;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BJtJVvoj;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=ge6mOj/e;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BJtJVvoj;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:ccCcWsQ5e2TKiJm5fFAYBxORXFWDqfkIc7NY-KrMiYex8cCOpdGtsw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Joe Perches <joe@perches.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: add Co-Developed-by docs
Date: Mon,  5 Mar 2018 14:58:21 +1100
Message-Id: <1520222301-11874-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520222301-11874-1-git-send-email-me@tobin.cc>
References: <1520222301-11874-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068642266552204?=
X-GMAIL-MSGID: =?utf-8?q?1594068642266552204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When Co-Developed-by tag was added, docs were only added to
Documention/process/5.Posting.rst and were not added to
Documention/process/submitting-patches.rst

Add documentation to Documention/process/submitting-patches.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

The text in this patch is copied basically verbatim from
Documentation/process/submitting-patches.rst 

 Documentation/process/submitting-patches.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1ef19d3a3eee..698360641ecd 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -510,8 +510,8 @@ tracking your trees, and to people trying to troubleshoot bugs in your
 tree.
 
 
-12) When to use Acked-by: and Cc:
----------------------------------
+12) When to use Acked-by: and Cc:, and Co-Developed-by:
+-------------------------------------------------------
 
 The Signed-off-by: tag indicates that the signer was involved in the
 development of the patch, or that he/she was in the patch's delivery path.
@@ -543,6 +543,11 @@ person it names - but it should indicate that this person was copied on the
 patch.  This tag documents that potentially interested parties
 have been included in the discussion.
 
+A Co-Developed-by: states that the patch was also created by another developer
+along with the original author.  This is useful at times when multiple people
+work on a single patch.  Note, this person also needs to have a Signed-off-by:
+line in the patch as well.
+
 
 13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
 --------------------------------------------------------------------------
-- 
2.7.4
