Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AB8JxZrt/xswFS1ZvXmqDJVUc9XATjTB3IeWBmL0m4cebfYFdAZBgGwjxRTV+Km1pnEmp7XwI3Dz
ARC-Seal: i=1; a=rsa-sha256; t=1526637841; cv=none;
        d=google.com; s=arc-20160816;
        b=F1gwisqV9u9o8m9utS/aU59g/inC4ybC/GQiujtbixKC56HewbVwGdz63r7tH3U6oM
         XahsuPvwrEU7XIlc5ECqeRDD4Zco8xCH6AKr7GZzp/SSWo4EexhuJc3vLE95HMEMWw08
         CbzNPB8UP8cr/MLMwye5HgW7rmO6fpppdmZqfb5Bpb6Ddy7shtf/Z1BsC9FZE2jrAkfn
         4IUb/nsvDYyDg1k0lrNkom18l4gEIN1+vDB+B9aDJybnBzyyQyJCmiVybXWOXli7+WWc
         PXU0ibMA3fYPBSVCd4gWL5gFDNpPW/2NIqLBlK/EHMdHDiBJRcZmpo6KrKivo0Ze8zYL
         omHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=GaO4/HsU+Rv9hg0x7xyG02PPOukitUOoMxC4PLCST0o=;
        b=adBGef7cd5PybHJrAhPFBUXw4Ash+nHS6UO4jiFBOuUNeLCxpKyrLaKuMqlC86P3Kv
         IUGkASm1LMRSPLPpKBusDahnP8Er6KHaslsYL07fyF4IjMmf2MWhDswzNMeNq2PjJnuo
         z8Kv6V1mh/oWEL+jYviFHbpWJwAFjJHX6YloZ/YRm+YhzuuS2iFeZkv+tIb2equSCtFh
         agqwHobfTdSvVJEpmrsBle+IwLAt12Mf1buqqw+ukEDc9WusXYZaSBnnkRsB/6CSb7Ue
         Cm7X+XtzE6534pXdX/3dbqAjXkiOlLDqGsFcSa6VBtS1V6yRVCF836IME/fy5ggRC0Rl
         8txQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Christian=20L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
	NeilBrown <neil@brown.name>,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-mmc: fix spelling mistake: "Eanable" -> "Enable"
Date: Fri, 18 May 2018 11:03:59 +0100
Message-Id: <20180518100359.28036-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600795801355233684?=
X-GMAIL-MSGID: =?utf-8?q?1600795801355233684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in N_MSG message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/mt7621-mmc/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index ddac4ce6457b..11bf4b4c3403 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -2032,7 +2032,7 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		return;
 	}
 
-	N_MSG(CFG, "CD IRQ Eanable(%d)", enable);
+	N_MSG(CFG, "CD IRQ Enable(%d)", enable);
 
 	if (enable) {
 		/* card detection circuit relies on the core power so that the core power
-- 
2.17.0
