Return-Path: <wsa+renesas@sang-engineering.com>
X-Google-Smtp-Source: AB8JxZpwwwQASsk/UJfF1ZtSKzRewC7+2q3TntiY0t46r8jxCnUhGZF841+zb1HErZ6sGI3KuVGr
ARC-Seal: i=1; a=rsa-sha256; t=1525605855; cv=none;
        d=google.com; s=arc-20160816;
        b=TG60wXZ41zucJtBUnb7SwgPL/Zoh1s8mdv6z8ziQ0eKyDnRmB652d/Ut3BWojjEvqS
         DOAKIPfqgZO0Fp+aKP5xBBMRpKxYjS5QfBWQ9FcSDgTsu3eBGzhdtcDtcdRcwQXPaHwI
         1jgBRv77uJyaNfGv3wjDop0eOqyaul+R7Ncieapd1ZEL22HP5JNzOyn8A/ooEhqfOwqB
         c+8VywmT8m5bWRwRrZDzmPA5xn9R3hJ7ZuxkaNCsPIKTtAt7YFragF/fUxolRI4Z8JJm
         sy+0weVAvcdstdbbfmAfbL1KJPVNswWbBJWHi0phqI4sm9fMnPvlpf/1Q9q4WBUOQXIv
         ynWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hbhzHOSvtj635AUSYzOwkpReS68QnEJISTzLWjNvmNM=;
        b=Guky+jNU4sITI2YSkJVtxv6lmaR3eWc2C+oP/fEQgnX98DDBtr845OjlbEAsEOMgp5
         WW2jpgOJC9K4QQJIBLl83q/1/ZDmiLIJXOZiY85EQbFT11vkCBv4CQQVHk9lBBOcWxQC
         fu+ydcO2p1py4DZUj2tCWXV16wBFSqAQaOeCN9ozjBkcKbEPQBeALN1lo8u9HIosmBrr
         x3kWd/Hs/4uMBfQz6fOEFmnKaQXDh7/4F4z5dr/xKe8DfK5JoYLjqg95Ar1nrRt1lENQ
         oEjF7c8s9IYwpUSyqTDBEOMJyqeuAl6rY2MgkIbyXYdoEWNIcKSTNhLej0QP73pYLQrj
         g45Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 88.99.104.3 is neither permitted nor denied by best guess record for domain of wsa+renesas@sang-engineering.com) smtp.mailfrom=wsa+renesas@sang-engineering.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 88.99.104.3 is neither permitted nor denied by best guess record for domain of wsa+renesas@sang-engineering.com) smtp.mailfrom=wsa+renesas@sang-engineering.com
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] base: core: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:47 +0200
Message-Id: <20180506112404.24872-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599713685495121358?=
X-GMAIL-MSGID: =?utf-8?q?1599713685495121358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816eb887f9..4993bd8dfc52c5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2684,7 +2684,7 @@ static int device_move_class_links(struct device *dev,
 /**
  * device_move - moves a device to a new parent
  * @dev: the pointer to the struct device to be moved
- * @new_parent: the new parent of the device (can by NULL)
+ * @new_parent: the new parent of the device (can be NULL)
  * @dpm_order: how to reorder the dpm_list
  */
 int device_move(struct device *dev, struct device *new_parent,
-- 
2.11.0
