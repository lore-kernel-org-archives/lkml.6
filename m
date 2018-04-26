Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736204; cv=none;
        d=google.com; s=arc-20160816;
        b=B1eWintlbRehHqp5L4T6MVuvQovlkY+UpZrKVlqTgaC/IU8KB2rjt341yJ0a5KyrcL
         JG/N3IoHU4toeiLeJaqOs1APqx4g7z2jtr2OMHDfE1YXR6YclIyv1MJqdmBQTVc8hE84
         8lgFGVAsAKbqajpospr+49BNiyDan2dU60njKjDnkz3793SJ83CA7+X8O8ezE+ks+kf0
         16nhse5zGOI/wSHAlzJuNgSZsbYfJWBOn5k7x8JwLQQZoewMiZvfkw1fPonTnJ9/vKCK
         qxUS4XKCFxG2dh+zFq/C17Mai31dE8XszEyLxf2tlvc3QxDmGhMfmfYpYC86CzkI63cq
         3vqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uqhhZQ4sy+9siQY10dvdgb7PKlafLRjTMC8XUNrvQpY=;
        b=GlLGAzi9FO+qXOdlV84vYt2Lxh2LJbvSWUCuPsNTxqFeYY+IWfAGZlp5l50GRwTsQF
         7wgGwLhgMugn2t0Z0lj02g8rTQOfg4nVEOs3fvu2Xd1Vq8U4FHKfx/+ddlmIQYibd+Jq
         Z0o+/DG4y3aPcCk/ezvRlpuWymSHj39RJj9ILNfUVnE2Umh2b9HvAlvDw5sAsDKgjHiI
         8Ri5GWvj3mihqXiq71ljqrGJ/awSy0DDK+W2GREzpJSGEMFLBtqRnV4vhSHBzDQrCtM8
         K7uCny90IJNcAIvpCEqB/ilyslI1ab7hVdvJ9eQ+zzZ0VM3fBlfnLxtfm38WPnjk7oJm
         1qtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=U5I7AsOQ;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=U5I7AsOQ;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49LigyZ0vOWMXT+M//Gxjgfz8qqOdFNOQkKgGniAJxwP4pO1ecPvWC2dbMrqZ00duP02Fz8zQ==
From: srinivas.kandagatla@linaro.org
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
Subject: [PATCH v6 24/24] MAINTAINERS: Add myself as co-maintainer of qcom audio
Date: Thu, 26 Apr 2018 10:46:06 +0100
Message-Id: <20180426094606.4775-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801789724298458?=
X-GMAIL-MSGID: =?utf-8?q?1598801789724298458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add myself as co-maintainer of qcom audio drivers

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd66ae9a847e..8a67b0c61bad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11531,6 +11531,7 @@ F:	drivers/crypto/qat/
 QCOM AUDIO (ASoC) DRIVERS
 M:	Patrick Lai <plai@codeaurora.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/
-- 
2.16.2
