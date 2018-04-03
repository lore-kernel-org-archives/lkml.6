Return-Path: <gauravdhingra.gxyd@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522780379; cv=none;
        d=google.com; s=arc-20160816;
        b=VTjrAIeR9xvdMjdeX4YfeZ/eQu7r+GjjPjNAYknT+6xqzPLZNC3YUbC9yB8m6GL1wd
         iq5JDGy02rB3QGsvJ9blqvOBpQxV3rRvLpg0MZJTwJUdsg44RnVnWHbi+sYJIAruPXVG
         k1GML4jzdolSW3y6KEYDlyMijTqrTXghwXO4Oal9GK0neSy1mAH7pOFI6MP/ogydU5kn
         IJaKI2TdmRsE4Js5LWuqA8Yep9sw6ksDJ0ONS17iSNYbpzILOwXTqpUf/7a7LtQnPdGr
         md53a76tGZ3EzHSkan+Cvf/qkuXEiDoLb+6QJkLlTU9n2l1hi4VDqDeBGQQ9MsgJMN8E
         kI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=/BaQDNF7OHk0kZoIwnPRkCohb1BNST2GbUvlt4FRTAs=;
        b=lIpyZHqlO6omRud/K1zUYRKII1nmOJ7bNTLbKdAe7jj945rkIZu/k1B9lq7SZvEjeT
         cyuz+CuPXXPPy1ZhSIYlbB91Dk5Rgx70HFQ4gZY8MEOZvAB+uhy2fZTG1UAfAVJrZrYd
         t4ATGF0zeqIgPnUwH2g3oDLiwVgyh0PlgMrkaXFi0ngJ+ABZK3tYDqNgbCGEymNgd2WA
         ajO66JdsacfXEzcZJmGM8phqHHWAzH24OrTlm+HrZNjGHHtg9CaBx4R3mzdG197K5sOY
         ye1Dlt2x+iKfmV9UvvpisKqGErYpJmBbH1i0WcDZ2iJcXOsd+et/kLIHP3d3I+f6Bscb
         kPbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cXXV33gB;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cXXV33gB;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48ndMMg3JkS3shjng7a5xRCZZrw/zojnROWTA1uvEIPH81iq7f7XzPchnqNTOeN6k8oyn5YtA==
Date: Wed, 4 Apr 2018 00:02:46 +0530
From: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
To: mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: Fix warning to limit chars per line
Message-ID: <20180403183246.GA23438@stallman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596750959468280779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Wrap comment to fix warning "prefer a maximum 75 chars per line"

Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
---
 drivers/staging/greybus/audio_codec.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
index a1d5440..01838d9 100644
--- a/drivers/staging/greybus/audio_codec.h
+++ b/drivers/staging/greybus/audio_codec.h
@@ -23,7 +23,9 @@ enum {
 	NUM_CODEC_DAIS,
 };
 
-/* device_type should be same as defined in audio.h (Android media layer) */
+/* device_type should be same as defined in audio.h
+ * (Android media layer)
+ */
 enum {
 	GBAUDIO_DEVICE_NONE                     = 0x0,
 	/* reserved bits */
-- 
1.9.1
