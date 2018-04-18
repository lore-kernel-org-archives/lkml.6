Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AIpwx48THsLWKyOCqyVBySIEycr86y+Co61I6f1SLsch+gjn2OoK+G83XnT/y2C1kioqIJUZX+0D
ARC-Seal: i=1; a=rsa-sha256; t=1524051329; cv=none;
        d=google.com; s=arc-20160816;
        b=aOET6SHlkljyYSrJi/y+rDQiftdqkTLs2qN+lwycXQASi29drGm3fY2iyRksZHkwLs
         KiTJTj7rcq0iPeNDiz3BgwFv1LV0lOglNSJ4vwLCHJYyiiGs96iutSjskhFDL4Fy4Qf0
         V8UysYzmxsTQ7y/le3ugOmaaCd1rJkxXIkKzUk7TBoiQN++vxNv61/utqsOQbWgEySCu
         xqR6WGq30hHULoeebiiiEX/N+xQ17TCmFmCGUby/ROv6Wft2wGKpy88GKjJrvG8yMSnJ
         ZW5+L6mvByNtAIstBFDStVX3pUftHAUrKgVP69U/+F/3C74tKasa2Vz0R+B98fBzciCN
         z7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=ZkxJRMQLyP7wsDaqqeXYbp16uEhRZsDyu41aA1MEfzc=;
        b=GzK/c0P8Xfe6h9TmKhaIf0R9KmnIHhvh3pxKI1dmefz27/ejOhqhCwGFJ3OgXDpjJd
         M8gN6JkdSmgyTO9TatXPZo1WIaxoQvTGrJkvxpYeE0KveP8gT4B9/c9jc+FhVk2yU4lD
         bA3NWyUl8SGStLWCtkRTZYmS4IXU3ZHEPlv6FsaXiBvPRkdv30ORj1Cng5+RBOPIY8VF
         fOEtS5aIp0g2g67cOdPVcoz5gtiuUk0akDosBAE3avukKXu7yloYwbvPu1NVP0txb2s1
         /qvTzXybkjQrt9EypG6+T8ZzB6I4yieG84X0MbCdvvf2NNymdqdC1TRx6kg1HLOvyprS
         /AoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: nozomi: fix spelling mistake in macro NOZOMI_STATE_UKNOWN
Date: Wed, 18 Apr 2018 12:35:28 +0100
Message-Id: <20180418113528.1468-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598083647326458964?=
X-GMAIL-MSGID: =?utf-8?q?1598083647326458964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Rename NOZOMI_STATE_UKNOWN to NOZOMI_STATE_UNKNOWN (add missing N)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/nozomi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b57b35066ebe..bf05946d80a1 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -155,7 +155,7 @@ enum card_type {
 
 /* Initialization states a card can be in */
 enum card_state {
-	NOZOMI_STATE_UKNOWN	= 0,
+	NOZOMI_STATE_UNKNOWN	= 0,
 	NOZOMI_STATE_ENABLED	= 1,	/* pci device enabled */
 	NOZOMI_STATE_ALLOCATED	= 2,	/* config setup done */
 	NOZOMI_STATE_READY	= 3,	/* flowcontrols received */
-- 
2.17.0
