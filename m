Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZqpHnlREFx9g7+GnbIu7dlC1CYUBTymEvePAUqCYTH7oei416O1bs/yuaU1ULmUmOq22AgL
ARC-Seal: i=1; a=rsa-sha256; t=1526008724; cv=none;
        d=google.com; s=arc-20160816;
        b=qA5LEqM+O6oAMwAcITynQty8O84aR+aRa7sXrExE+nEXElaG7pC/xuejZuXANl+8B5
         oP8sKGNYODgdITNd6AuMCiQhyU+wO6+V2JTPDyz5GxxKznOAR8vAzTKrjJInzAvBvtb9
         jRjCaAt3vGAsQyEHW4bYHrFsBdDOekDu2p4LZB/0O5zOT+hVZrAPwr9ApxklhQO8SuYb
         Ifx0NKeN5AamU/M32FTzGICN+SSt4Qfc2ysYowA3hw7VSIsN6QMROz/XSuEw4eHeoLVy
         xqZR0txAYMd0ufaXJW3Au1t7JSknQM9iCobsngmGHex+rNDpzuUvrBIVXmXmXHGYB1FA
         hwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=syblOWVnHbUQ+YcRFyEZy5K4U46wGxM/knw4LMA9lU4=;
        b=PqFjHhFAV57DGg88smDUiBNRLHp7kJQoBLl33C8s1XN+D0x2x+M3F3x0qHdo2AWB1D
         ca2wqAHOXB+03C2GmdDwZvUkBHNZOPdcDCKttDqLywelc51ZMBvkolw3TGirpBtH+m9d
         UedqVhFW/uNPOBVe/VCdVqTd1sRsC2YGmwXrNU/HyaiVhrLyu+VAA5rxlLbrmlJ7olzJ
         Mya8NVXJ7b2jxQqYohJ5W8Wyf8WT6LJ38+QxiYbyF5ZDR9oBIZBST6Co8vfJ1NVWida3
         4kMAvxxQgDKW7eUXgSeWBhUSvzNd32ZhPWKBcGkbEwdeBcwsZSaJW8C0k9w6kLLp/2QU
         y6wA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=EvTvwbng;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=EvTvwbng;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: dt-bindings: Add q6core dt bindings" to the asoc tree
In-Reply-To: <20180509125635.5653-4-srinivas.kandagatla@linaro.org>
Message-Id: <20180511031834.6BFF644007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:18:34 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600136124522365616?=
X-GMAIL-MSGID: =?utf-8?q?1600136124522365616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: dt-bindings: Add q6core dt bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8c943ef123669b0c4100d69039326696c1662d60 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 May 2018 13:56:14 +0100
Subject: [PATCH] ASoC: qdsp6: dt-bindings: Add q6core dt bindings

This patch add DT bindings for Q6CORE DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6core.txt | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
new file mode 100644
index 000000000000..7f36ff8bec18
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
@@ -0,0 +1,21 @@
+Qualcomm ADSP Core service binding
+
+Q6CORE is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6core-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6core" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6core-v2.0"
+
+= EXAMPLE
+q6core@3 {
+	compatible = "qcom,q6core";
+	reg = <APR_SVC_ADSP_CORE>;
+};
-- 
2.17.0
