Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176658; cv=none;
        d=google.com; s=arc-20160816;
        b=e+06LUJ1sR0Zb3r2aPaFVJcyyU2Plw1ejRi8x4YYyAdcZuLkJQxISygtSf70+4/cut
         ElNe4RQpTogL3IPdcsQ0hBUkKFRFR7VqEODeK6g7oKhfbrVH2nuk0BKrG4gD9q3hESZp
         jMGnQ7YwOPpBMvSu+e6rcItfxGhPbXLSqqdYnZYw5C8Mjuvudx7bM0ZllrAFDTHLcKZ4
         8PY/FPlyGvMWYPA+JJT6OohiV2ITxBm5xEcAvmbgBi38PTsVuJqwi4yO21yCqUHQJ6HC
         MXC4Yb9WTyVkXCopmQ97Nm9s3JD4wXUXG42Vvtu5KMAT0WaBSlPmAbEzVLMAnP7Qwm+q
         36Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6fiKuwYEGVlWuQNvo7QfhT05Hf2xHjEn6wDBkheRaWg=;
        b=0AYHTa22PxZZ40UPVFpJt/AC7X9nH/RpfgolvTjr8QrEm99pttmr4ZbnwIlx+H6eMM
         cdvcnop+lypaY0p8OuUecO+CgU0M/5kLQ7BzHk2HjAr1LFoxKnjy517FiWCtNCIqUIjK
         2VYi8LNOrFibGrjZyZ/n+EyeAn/TGjklPHaMVcAnG1+dj8MSQzouxmX0KOvLH611MKIl
         c86UTzpJjvZ5XD+lloV3a16TWPSRuxddrv+obPRZV1FJHD/iNd9ZwacP5VQW13mTVbrq
         sjmCXe5Tf24rd39jYUGtAFXzSWHgJJqGBI2KOJ2QgwyRAbtB20DIJxsRD/cQQvjfqcYT
         iH8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N/dDesTj;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N/dDesTj;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq83hAtk9/QXPCpn/+2IGJv4kicUCKDEA19TdAoUpIsXwccHzRdEfkTj7pz/t5UwOtQIynikw==
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
Subject: [PATCH v7 24/24] MAINTAINERS: Add myself as co-maintainer of qcom audio
Date: Tue,  1 May 2018 13:08:20 +0100
Message-Id: <20180501120820.11016-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263640035546137?=
X-GMAIL-MSGID: =?utf-8?q?1599263640035546137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add myself as co-maintainer of qcom audio drivers

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4340b783ab80..527e2658cfe4 100644
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
