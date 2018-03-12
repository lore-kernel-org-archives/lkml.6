Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvgit6B71juYt599vA3DTy5bVqfzgcGTkAn9WRjiCt7zQqhAI+s5/uovzrJ4aCL8F9ZjVjl
ARC-Seal: i=1; a=rsa-sha256; t=1520824066; cv=none;
        d=google.com; s=arc-20160816;
        b=P/INXndQiFkU1iU6353cueJt1ui2Ar6lePpChb9Vok3HT/wIA+CqH/Vz2O+U0aZ1br
         XbzADOpA5ENj20tXjyLxuJhe8wuBpzI2CXJcpw/Ed9kyz4cWaoxUl04ZKShGKKCneqCG
         BxwJjABgRSfd0TiZP/ARjUe8/X9cfQxvCs1Q6JnL9PKAYKX5y9xMDFO0xFhh85B6qyWV
         ht1xdp3ZX9PB/TXZoItchyY5eFXhTF4VVi4actJvgkH+IA8R/wCSKwEW/IqymmXWH/gI
         O1nQ/pMup94b6oTqN1dUVa+RepllQ0P2mNUbQmDNgmDXh0hxsFGF2SbFbXzIxuGy6Ycs
         H+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=mV3sjzPjy9wBhMORKZmEKAinxBxGFYhglgpjMBAGxyc=;
        b=QgQL4BzsBoU942w1+dty9PTs6WrMkQEQu2ddE+oGmm0gjTWwNujxfHW7bzFHLTfIEl
         +XllpzthkdE7uFKGm/Us2JBteFxJi+f3oPIjtiqh5GZYC4HkOxRxlvsmcB5fv1avwrZY
         5LBSPu8GEvmu1Pp3VXEtDxaYZyiLhin82tCxn9Ht1FLR1f76dtQtjQOOu71qtCHm8CBk
         cVD9b1OtRjq9jxiwkPj/Ec6R31NFk1+nx3+6nyPAUjhSVhSid0pKqyzN0s0bxonW66vd
         QlvPG969PZvJnwlr8oIz3KcBmK82FKmwT/MX8aX+7XQ/sTnp3a4a1IOQmIqwJDpiIO31
         fsOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 jikos@kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 pjt@google.com, torvalds@linux-foundation.org, peterz@infradead.org,
 ak@linux.intel.com, riel@redhat.com, dave.hansen@intel.com,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Borislav Petkov" <bp@suse.de>,
 luto@amacapital.net, keescook@google.com
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.844992350@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 079/104] x86/bugs: Drop one "mitigation" from dmesg
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699616853113589?=
X-GMAIL-MSGID: =?utf-8?q?1594699616853113589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 55fa19d3e51f33d9cd4056d25836d93abf9438db upstream.

Make

[    0.031118] Spectre V2 mitigation: Mitigation: Full generic retpoline

into

[    0.031118] Spectre V2: Mitigation: Full generic retpoline

to reduce the mitigation mitigations strings.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-5-bp@alien8.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -233,7 +233,7 @@ static const char *spectre_v2_strings[]
 };
 
 #undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 static bool spectre_v2_bad_module;
