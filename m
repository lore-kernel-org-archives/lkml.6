Return-Path: <boqun.feng@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519283235; cv=none;
        d=google.com; s=arc-20160816;
        b=qrrOFF2iZ3bUZ0R9UcNI5z+qmn8fCOoOVMyb+FDJBoSgpPa/C10N6cFbJqbWL8rzto
         pxJpwT7wPHbkhECR7uh6pvasB9Yc5l6KCUAfbuaSS/ohhcwwyc6cNu654uzlbWTH2j7S
         fom/afMWKhQDDymFC9LJulop4gc4W1mzOrg7jJwq5SLx5R2QyY6HOkAZuqHgs9vNS14W
         88BmNsPNnk9HWzKF9QS1wAe6mHOqyiyaNEFXmtO5k+Ud7MYtpabkkwXxUpvl2tOGXrAw
         TMkjNbCA7SnaLKwxfCM7yrwwrCZf30XxDoLrxtQuycT0huwsQ7cAMigyxxhHZDOib5WK
         7+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0r+0UU3ixP6WXvIe2gFv0V205M1lcSGDAFsB9aZ0oyM=;
        b=xtaBJef/aY5gazGzG9DNUKNiuSq310IwQgKOlyDqvtPUkJFqhiAJFFRHP5/YIH1c3N
         BxiKST7Lvr10rLIKy/6UZcAacrs7XDAaAf1W68tg+3bzoXxt/KlnnYOnV6TAhunBzpdC
         jON8FutFA4cYlLU3UZr0LhlWQAzdcoOanupKCbH89fb1pDQM2B0k+Jn6lf2QLJoNSfjT
         XejrI2QGdPwuOAGTYhE6eVOuuqzotyval6mL0KFGvmP3ywn1F4DGONlhDcvaFc6HUdZC
         dU9V0b27zFzsA6NOUX8iNe5wHl25EFEeXGw5Anv9rX71IddBLCLWimsSQJaEjlghHEyD
         q6hw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uA423sR0;
       spf=pass (google.com: domain of boqun.feng@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=boqun.feng@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uA423sR0;
       spf=pass (google.com: domain of boqun.feng@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=boqun.feng@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227pCTNifFANDiB0bW1kgunqBQay6fYpWRWJtosbOcQDuzpyk11qDT5WlRp6nyh4Y6fazCidiw==
X-ME-Sender: <xms:IGyOWi0sqav0WIP7sqsvu-M6qGml2tXiQuxP6gZgWqoZ55HQOeJHQw>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC tip/locking/lockdep v5 17/17] MAINTAINERS: Add myself as a LOCKING PRIMITIVES reviewer
Date: Thu, 22 Feb 2018 15:09:04 +0800
Message-Id: <20180222070904.548-18-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593083938836146742?=
X-GMAIL-MSGID: =?utf-8?q?1593083938836146742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Recursive read lock detection work touches most core part of lockdep, so
add myself as a dedicated reviewer to help people find me if any of my
code introduces problems or misunderstandings, also if they need my help
on parsing logs related to recursive read locks.

Besides, I'd like to provide any help for lock related code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..197dc9c5162f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8239,6 +8239,7 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
 LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 S:	Maintained
-- 
2.16.1
