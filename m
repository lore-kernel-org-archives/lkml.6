Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AB8JxZrN8J/jHy/ruqOPEzL4elBYgyKh6c6viF1B3Sgjv6tDwdxXHmw00LZkC2m5w4tSehXLTtHL
ARC-Seal: i=1; a=rsa-sha256; t=1525685768; cv=none;
        d=google.com; s=arc-20160816;
        b=Hl9/fyM35CJFWUALVMn3eoCW/MLbSFwIsi31JbgGv2EOdqAgYZkIGoAQnHadv5J/9d
         gkhypYrBDKrQibkoKKpVDeVUUBYPgYB7i1QwD7/Ee9umw3ZVTqfTysGLd+NCu8AN3V/E
         rfgUILP6lWoYWZu738qHgkDBpesZb8FZDyAiXN2uB+CF7Uow6XRBriRNa0k2B2Gp2Wqd
         jZyT/sASwY7a2FVW9c61Edc6pHwpFPAQypY7sqULo4mArA6a2VvR7qP29DQOafzbozId
         QAZD+K93OHL5RC69mEleSKEhQ2as0aaylTn6Cr/lWPlIWTB4m6sxBvzzrUPPzcRetBfq
         aTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:references:in-reply-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:arc-authentication-results;
        bh=g7P7FUw4MURw0WySFJ9B/4x0mAfXdW2SDCfPdx/6SGM=;
        b=WnFmz/4KhWtggNGyDXWUUeNL4BFQ7xODTE6RTeEFt9Am7HRNSO73tRD36tu4cxjf6J
         xCCPzkiXOkC/tnHP6VYTkTCUxA39X6dJQLr442jQ7N96lwMdZnpcsmXdkCZtnvpBdmFC
         y6KcHhXWjHVp3sP9pQ9CH56+Vr8otY1azu/yBVPA5EIt7X2Tlhcmz6Jjv5JFq+VxcB/+
         WkkjcpwwkLWzqO95kHE/Z1uNcLQtAONlLZpg+0jPd9oVWxZdx4ErWdsiPt+2z+i/s/Pw
         ciesHrW1uYSd1FxfUzopUZKnpnzuJhj6QTYS3qjyvmhl+/apNezhJCXe5TygL6MmBikS
         cgNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <treding@nvidia.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	linux-crypto@vger.kernel.org
Subject: [PATCH 03/18] docs: */index.rst: Add newer documents to their respective index.rst
Date: Mon,  7 May 2018 06:35:39 -0300
Message-Id: <e6852448ac11e827f86dab1e183b82af6a320559.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797480361597979?=
X-GMAIL-MSGID: =?utf-8?q?1599797480361597979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A number of new docs were added, but they're currently not on
the index.rst from the session they're supposed to be, causing
Sphinx warnings.

Add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/crypto/index.rst     | 1 +
 Documentation/driver-api/index.rst | 1 +
 Documentation/process/index.rst    | 1 +
 Documentation/security/index.rst   | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index 94c4786f2573..c4ff5d791233 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -20,5 +20,6 @@ for cryptographic use cases, as well as programming examples.
    architecture
    devel-algos
    userspace-if
+   crypto_engine
    api
    api-samples
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d8352c0f354..3ac51c94f97b 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -18,6 +18,7 @@ available subsections can be seen below.
    infrastructure
    pm/index
    device-io
+   device_connection
    dma-buf
    device_link
    message-based
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 1c9fe657ed01..37bd0628b6ee 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -52,6 +52,7 @@ lack of a better place.
    adding-syscalls
    magic-number
    volatile-considered-harmful
+   clang-format
 
 .. only::  subproject and html
 
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 298a94a33f05..85492bfca530 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -9,5 +9,7 @@ Security Documentation
    IMA-templates
    keys/index
    LSM
+   LSM-sctp
+   SELinux-sctp
    self-protection
    tpm/index
-- 
2.17.0
