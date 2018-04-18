Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524065787; cv=none;
        d=google.com; s=arc-20160816;
        b=N3zBUN77D23RbcyNf/06VR8ZSM7SnugyR8TGSaamTozYwbd+FGJ5TSafWGn5eLvC+4
         ciWiSedL7LGOZJws2VBVT/wTHY/0YCW9Ci6HYqZfLRnQQfl2MFjv2vJkDFOsPuJszCUP
         c94j7X1e8Km0+LhZPmkyj4upPbbyoQ4mApwCJBg8jC7RstCnXDwd+kHuqLLxTAIMkx6q
         +H/mcmZyABpwThRrjBPe16Q2rn0DB9uhYu/V5qfPR3VLLx69joTtzSYXbUoEdYhRsYUo
         FXa65pjE7B8L/lbh9bKqh9FT9hZQD6rhnb8V/WdEKeqhua3IYABcx/hh0e2KORb3pi9o
         xNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=nYsisKTgsGJBZYa7o7tU6yWfnQoorhUAfOciKLdZFlE=;
        b=Ubl1vWlgnx9UU8veIp89f81drgChqRf5WNY3RDWGAfsEctQOvy7dWGIXlkBLgUT6px
         EcGCb2ikNkxBmmGo+2GNJNfmeBbLaEmamklUp4lyzQmhOqxEmhvVYRXEogr6i4zgIa+x
         xTEXp8gW9N9Ta2In3zYbpxddHqXv/MKky34a1nIbqxTvlEOl/+hNe2tc19XVLwi0dkly
         fU25QTTHio9BmyBKslAW/Lhh85SRuZvmVEPRoCHypishIQX2TR6DnKHz1SpizlvI/jIH
         BgZt3uHYeffPV1eTGC7RsP2p+TCTDZ78R3xXmI1w0NlYfEzi042s3rXM3z6ZoVJKV02x
         /mSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BOp4yveZ;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BOp4yveZ;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/s3Q3hmkcQ0WmXOgEudweXJbLNoVr/Ga9fWWiJ1EeF/4VTDR0RZwFE+GombT7brw0hhPoQjg==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	bgoswami@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 23/23] MAINTAINERS: Add myself as co-maintainer of qcom audio
Date: Wed, 18 Apr 2018 16:31:57 +0100
Message-Id: <20180418153157.1960-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098807506122546?=
X-GMAIL-MSGID: =?utf-8?q?1598098807506122546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add myself as co-maintainer of qcom audio drivers

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..9a78c2879a0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11503,6 +11503,7 @@ F:	drivers/crypto/qat/
 QCOM AUDIO (ASoC) DRIVERS
 M:	Patrick Lai <plai@codeaurora.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/
-- 
2.16.2
