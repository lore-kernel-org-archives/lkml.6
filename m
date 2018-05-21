Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqzpQCquMq+fCFxCrP2tQQtlmzNtGLMIxNJbt3IrnI6DtNUedtkYhtVtvgBK5MY1lcO5czE
ARC-Seal: i=1; a=rsa-sha256; t=1526937392; cv=none;
        d=google.com; s=arc-20160816;
        b=P9RX6VBnjvaCdC+pkfQyYiCaAlNbQ9o2/ggUlQ3I5zgfIJmUpGFjRJEj7sUvTkipbl
         3V7dQbBlz/So9uRx/aDV3rWQYgnddaQ3Kts50fsSl1e5s+ESFYg1jjWeQNGZ2S7D+b3P
         t6SI3432piZgmEA3MbPEb0oiNWDWzeyHEKhgzEXMmKY93DdeuJ66lY12kFtxrAg5hfQt
         JiSDo0O0phl3vASQ4zuKxMI34eLchp86ROPoCJRjKEexjeA39ufr9vCBlPDLMCDrFIl/
         oG8OF2zRb2H/2zrD14whyxMxyoIQBQ+73UzSqUrPpenCdZtMhJPjvHo5lROswBxH91xf
         wyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+j5wz+GnvjdhZhqLto514K/4oKIpoOr8Akv2iyRn+cI=;
        b=vjY5w8cEH1HPgb5dcTyAbp5d3mL0yaKN7dyr6SiMOAhvxanuRGWnTVFr4jY54/sb3o
         gkn6TEvz79fUdIWF59GSERlkKAcU1zecGG/IpDXWlc+sjhIavmJhFay4rXv9cUEDTn9w
         wqgWZmWazUlaCVvlUAiqbr1Gns/Hl0+PJAYiNmha73YEmKt8i+2Y0rlNWTpVLkJtSBlc
         EQ8BCO49dOrXO+ensrJ7d5ZkNz3MNYItYbtCtDHYWKUbDzPg+Ilkf2XbiraC64btUNBs
         xYl5bHgUc+/72pgjDOaUgkCRoYPQ45csZvld5bsFMgkayMSRmdgdo2MZozPKSWyGmJ8T
         N4xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=P8WJC6yg;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=P8WJC6yg;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 66/87] Documentation/spec_ctrl: Do some minor cleanups
Date: Mon, 21 May 2018 23:11:42 +0200
Message-Id: <20180521210425.937595360@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109903251925648?=
X-GMAIL-MSGID: =?utf-8?q?1601109903251925648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit dd0792699c4058e63c0715d9a7c2d40226fcdddc upstream

Fix some typos, improve formulations, end sentences with a fullstop.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/spec_ctrl.txt |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/Documentation/spec_ctrl.txt
+++ b/Documentation/spec_ctrl.txt
@@ -2,13 +2,13 @@
 Speculation Control
 ===================
 
-Quite some CPUs have speculation related misfeatures which are in fact
-vulnerabilites causing data leaks in various forms even accross privilege
-domains.
+Quite some CPUs have speculation-related misfeatures which are in
+fact vulnerabilities causing data leaks in various forms even across
+privilege domains.
 
 The kernel provides mitigation for such vulnerabilities in various
-forms. Some of these mitigations are compile time configurable and some on
-the kernel command line.
+forms. Some of these mitigations are compile-time configurable and some
+can be supplied on the kernel command line.
 
 There is also a class of mitigations which are very expensive, but they can
 be restricted to a certain set of processes or tasks in controlled
@@ -32,18 +32,18 @@ the following meaning:
 Bit  Define                Description
 ==== ===================== ===================================================
 0    PR_SPEC_PRCTL         Mitigation can be controlled per task by
-                           PR_SET_SPECULATION_CTRL
+                           PR_SET_SPECULATION_CTRL.
 1    PR_SPEC_ENABLE        The speculation feature is enabled, mitigation is
-                           disabled
+                           disabled.
 2    PR_SPEC_DISABLE       The speculation feature is disabled, mitigation is
-                           enabled
+                           enabled.
 3    PR_SPEC_FORCE_DISABLE Same as PR_SPEC_DISABLE, but cannot be undone. A
                            subsequent prctl(..., PR_SPEC_ENABLE) will fail.
 ==== ===================== ===================================================
 
 If all bits are 0 the CPU is not affected by the speculation misfeature.
 
-If PR_SPEC_PRCTL is set, then the per task control of the mitigation is
+If PR_SPEC_PRCTL is set, then the per-task control of the mitigation is
 available. If not set, prctl(PR_SET_SPECULATION_CTRL) for the speculation
 misfeature will fail.
 
@@ -61,9 +61,9 @@ Common error codes
 Value   Meaning
 ======= =================================================================
 EINVAL  The prctl is not implemented by the architecture or unused
-        prctl(2) arguments are not 0
+        prctl(2) arguments are not 0.
 
-ENODEV  arg2 is selecting a not supported speculation misfeature
+ENODEV  arg2 is selecting a not supported speculation misfeature.
 ======= =================================================================
 
 PR_SET_SPECULATION_CTRL error codes
@@ -74,7 +74,7 @@ Value   Meaning
 0       Success
 
 ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
-        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE
+        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE.
 
 ENXIO   Control of the selected speculation misfeature is not possible.
         See PR_GET_SPECULATION_CTRL.
