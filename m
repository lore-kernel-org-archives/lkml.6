Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648892; cv=none;
        d=google.com; s=arc-20160816;
        b=Cs9pM2JYCObozzLVzkcpjtxu9epGVchd6nuQiqn/K96k0Q2o//VsWgXhtOdoKukqn9
         3Hs2nF8SEnC+lU4GirVCeFCh5Mhdwr9xl93Ecaj3P0vfkXL5IrkWZxVdn7nEV5cC9jCc
         QzKm1s2gebP1uHtcDuhbgKMgLc+3oNbF8LTEKu2BJ5EDzBmkwl90k+UoLoJ429WAt3wx
         ukWaUr/I3KM/tnhruJXE4reHI5E6mxOBFfbAhV/QFbJ40RafSvC+wHEJKyZohhuCJGnJ
         WMQKqV8NlXYNg3qngVIesDy3ylSXf0twaCEENQ9BLPci+zvU7FcJ/Rqh24GFXHKY8HXz
         vtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ZicNPN2qc1NG2DCZ67p3mqOxv3nX0kWsDK3x7qtrNSk=;
        b=tEfdjHbkyofeytr7xVxZRCRpp9tT/pfjikuLKfvca8RAVsS353YV3x/qmON4POdLbx
         f1qJC0TGmzkTZ88UOcas7Qf+s9UOtrwC01R61vXEBzusah1HwWym48pTiAD4XZHuVj/F
         Dix1e0Pwo9LFeH5xdbchjgEsPCPVtR8kFVHDyYH+CxnzlFktIgOfray0WU7UDYeX911R
         DXi49Dhh5k7KlnLGMKvpbudg8CGZG8U5Dru51Y+R8u1SspvJOk6Uqpui9ky9CegZOlpq
         8nLZXpXLEgHykAUPiccFwrCf0akADKH7o3FLd639aYyTu00FDw+qhd4VDlXoO4QzGjHd
         PVdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Dk3JBrZa;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Dk3JBrZa;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtqEWJN5xHJ9tcZrUS0deMOAnfTEIzK8eBLvLKHP06lfJTbbQdp31qKOe2QD0+orhqLCcxY2A==
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
	srinivas.kandagatla@linaro.org
Subject: [PATCH v4 24/24] MAINTAINERS: Add myself as co-maintainer of qcom audio
Date: Sat, 10 Mar 2018 02:24:56 +0000
Message-Id: <20180310022456.26739-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515933149252787?=
X-GMAIL-MSGID: =?utf-8?q?1594515933149252787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add myself as co-maintainer of qcom audio drivers

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..7463122a1184 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11343,6 +11343,7 @@ F:	drivers/crypto/qat/
 QCOM AUDIO (ASoC) DRIVERS
 M:	Patrick Lai <plai@codeaurora.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/
-- 
2.15.1
