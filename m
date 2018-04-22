Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx49lPPAJB8i214xodcbNWy4XxEK0KFB9qUEtwMVeotleCjKLEXLGT/EOJx8lv4XQIEI4suRf
ARC-Seal: i=1; a=rsa-sha256; t=1524435138; cv=none;
        d=google.com; s=arc-20160816;
        b=t4hdfh7rkpQzjartwQVEXTLO4ntBINztvs/lcmRoqamT5TtjGCU6jp9zmr5ybzU3o6
         d4NsCdXYByp2xL76Hz4S5Prcq5o4Jk9t6WsoYs+i9epb+DXyryrDmAZ7zdnqwceQobCW
         6XTHDGfV3Ejv0lD/i8uCE/DOmySVmcdr+YRniSSb8p9dPwObnrKu6074ME7p3mzTO/Tw
         FVdUw/wyJVOTrD0Fz9ZBYwmwRUqtU9oZhsduVMwwltZmBBSTAOcMVxsQk9b+1kQpENYe
         3wtmriU8UMfzV83r9vAlXL+rKA+93oWUbdUFg4L4EFdLw/I0wEtczM+hkSWJi9iYmo0V
         x4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=yRg5ZdBVMJ6+NpK0bgfcfd67ijK04nPG4MXzkzdP40k=;
        b=Li8zI2c3mP87fKKqW86FqKWuXywdK80IbNwhdma8gcogycwtNGo2NcMsoitHZJmptB
         rz5/F2fdPi8jfbR5JRtnzv1VQmV6lnK1mu5urnEqnUjHjCZ58CsPSQpI9p65yMc1SGR/
         X/UGKRN2ETj8LQkZDVofVjVivJ3Pcuk9F/Zt6JxFH1sn+iQ1s3onF+0bdkhJUJfVikkb
         XdWmuaRMJo24xJIgx7JBKYeZQ7TU4MztEezySrBqgijAnmpUUUCwjhDB0aN/Pvy8by3f
         DY73ZU265isc+N0zg2P3KQ2grQSZ89AN0WoGmWnHIJVZbR6VAKx9mTlW2wgRp5XqKIFc
         Rziw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422220832.982315239@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 00:02:11 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk@kernel.org>,
 Arnaud Patard <arnaud.patard@rtp-net.org>, Ben Dooks <ben-linux@fluff.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [patch 3/9] ARM: S3C24XX: Fix invalid SPDX identifier
References: <20180422220208.772527041@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=ARM--S3C24XX--Fix-invalid-SPDX-identifier.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486099682318202?=
X-GMAIL-MSGID: =?utf-8?q?1598486099682318202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GPL-1.0 is not part of the valid identifier list and as its meaning is GPL
version 1.0 only this would be incompatible with the kernel license.

As this code was included into the kernel, assume its GPL-1.0+

Fixes: 84b2170109e4 ("ARM: S3C24XX: Add SPDX license identifiers")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-s3c24xx/h1940-bluetooth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-s3c24xx/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0
+// SPDX-License-Identifier: GPL-1.0+
 //
 // Copyright (c) Arnaud Patard <arnaud.patard@rtp-net.org>
 //
