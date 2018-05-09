Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870874; cv=none;
        d=google.com; s=arc-20160816;
        b=byX3E+BDaC7SWyJiJ1SilrEjMD+jRSXGqcA1BJ8ED8n2MAZbH0ro7TuT7Gjy7bm1Bp
         3FUsZylhqW3ysYotn6pVXGvGwD+2c9CgWzGdcy7JiM/ERIeOKbrC98zhPbFHiwVe7/Cx
         HkcpSub05MZLS7VQw7zOargZaQ732eAjWg/Y5CrHN8P+Isn59o4AKKgg68qX3Co6OijB
         3ekf7Cv8CwvyrZUOPK4WzMmv/J12Q3DmTkN2rFBB/EzfqFt7E9198kEGtqb2aHlwv3Ty
         jeggQHqsNZLpi9yzZdAXpeeD0AHzatBM1usGDMLDEnM5EFbycIigaPEkV81+gASkFZVi
         9jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GWSFu/p0icXeZfV2GGmRSjJWUCYAoHalwz5/EHU3XaY=;
        b=lPvoQg85O4qwhql8mgfgQm2lE0j6/QRqv2YGR88CixHLLa24/fHjQlRxXA4Z8yd4IV
         2b4QLxRGAqSm7NSd0ZdOqeedNbKcEoA30oNhTXP41wCKuGyw/lFzofnzIzbFNZeUK/lf
         2ZsKI4n4vaoNct0z+WQ88ROzZAbGB+d9ARrxhyiOGKgmgs03Y0w/F97Eyhdxdx2zgS1H
         fLH3kqXrXoANMVFXh1dN3t44F5mMqLGPOKtv8aynRo7hIuWmNorI6B684cqp3H5ko/Hq
         8L0tOXFQ6k+GyIxSwH5G+7G0gnJ1o7NfiYXdBbhp2yZMygFEOTe1gX9CDOSJOeRslkn/
         tW3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EDGfoI4s;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EDGfoI4s;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo3IdngjYrJdtxnnHoIsVIE/hdhVk3Ke2pyqvsPqE5XqS+XfYpjl8xwpvXNoouQiQewX+FEWw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v8 24/24] MAINTAINERS: Add myself as co-maintainer of qcom audio
Date: Wed,  9 May 2018 13:56:35 +0100
Message-Id: <20180509125635.5653-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991578299218121?=
X-GMAIL-MSGID: =?utf-8?q?1599991578299218121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add myself as co-maintainer of qcom audio drivers

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20032feaa9e7..3df5f6226827 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11522,6 +11522,7 @@ F:	drivers/crypto/qat/
 QCOM AUDIO (ASoC) DRIVERS
 M:	Patrick Lai <plai@codeaurora.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/
-- 
2.16.2
