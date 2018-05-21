Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpX4wUaO2JTEbaHHluwacnvgL1lrRXZNvLVTOzlwBjrDA4MoxK4/A/X3ua5BgD39cHKdhsM
ARC-Seal: i=1; a=rsa-sha256; t=1526917631; cv=none;
        d=google.com; s=arc-20160816;
        b=CKRReiJy5fay4gEL+lYNfSR2Xi7CBAZds4UGkKK4/HzB7DnmQsdgMY88ultylTer4C
         vr1nnjCE5ZfYQIlWMpyx9yQnuKLrTVCuOXEhdHQqtfUbjfzd0VIpnAlmMJCsyZP3lnzt
         82JcdKrC/pYdoXETguYfgAgxTTZLn3WKx0qaJaQ/RxEEtIgXE/8tp3CwRHShc1+gsAYM
         wfvP45suVbV+5/lbZJblfTkjgGy1kWyZmsWhwNC1+ZZXjaoEXJrMnxhoZwzL5HOcxfFU
         O8vy+sg15Wn2ueW7Kyxuyy0iAc61xJKHTYitGTt7mBQV2DClR082t8OClxY7z4Ilua4W
         EbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9p/bvz/clAF4tfANlS8+aGX/we4XqJguxF3Kk3V3g20=;
        b=lf8Q6dwOrBb0nzuGa+jQ5w9gBpbSuU5cuUYr3PaZF5CdTm8G34RZOJRMi32i3J8xkO
         xUh+ugf1Cv8/jQ9An8BeOzp6+0deOdrs/qvyTWGI3KoFZfgFD9KE7TQonjQIeayyDQMv
         wND6crWGkTshNLSyL+q9Ttmu9T7Lp9zOWP6uhGENqE4wU44Zsqcfuno6zijjSsC0LhYV
         Y/vUDqUu2Gve3Ir0rfL5chhxfVP9ndLUwNoxqkPkFT4k4nEK4ZBEwUSWdSEI8yaaTQcT
         mcPTt8toYekV9GqWNqt946KQ8cL6aKy25mufePmlSlagf/6z489d7lL8F/on0FJAISuK
         9l2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=azsfbmA1;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=azsfbmA1;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings" to the asoc tree
In-Reply-To: <20180426094606.4775-23-srinivas.kandagatla@linaro.org>
Message-Id: <E1fKn1d-00070i-Rf@debutante>
Date: Mon, 21 May 2018 16:47:05 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601089182030577661?=
X-GMAIL-MSGID: =?utf-8?q?1601089182030577661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings

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

>From be64027d18b163b971756af18d520cde6d21bb9f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 18 May 2018 13:56:09 +0100
Subject: [PATCH] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/qcom,apq8096.txt           | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
new file mode 100644
index 000000000000..aa54e49fc8a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -0,0 +1,109 @@
+* Qualcomm Technologies APQ8096 ASoC sound card driver
+
+This binding describes the APQ8096 sound card, which uses qdsp for audio.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apq8096-sndcard"
+
+- qcom,audio-routing:
+	Usage: Optional
+	Value type: <stringlist>
+	Definition:  A list of the connections between audio components.
+		  Each entry is a pair of strings, the first being the
+		  connection's sink, the second being the connection's
+		  source. Valid names could be power supplies, MicBias
+		  of codec and the jacks on the board:
+		  Valid names include:
+
+		Board Connectors:
+			"Headphone Left"
+			"Headphone Right"
+			"Earphone"
+			"Line Out1"
+			"Line Out2"
+			"Line Out3"
+			"Line Out4"
+			"Analog Mic1"
+			"Analog Mic2"
+			"Analog Mic3"
+			"Analog Mic4"
+			"Analog Mic5"
+			"Analog Mic6"
+			"Digital Mic2"
+			"Digital Mic3"
+
+		Audio pins and MicBias on WCD9335 Codec:
+			"MIC_BIAS1
+			"MIC_BIAS2"
+			"MIC_BIAS3"
+			"MIC_BIAS4"
+			"AMIC1"
+			"AMIC2"
+			"AMIC3"
+			"AMIC4"
+			"AMIC5"
+			"AMIC6"
+			"AMIC6"
+			"DMIC1"
+			"DMIC2"
+			"DMIC3"
+= dailinks
+Each subnode of sndcard represents either a dailink, and subnodes of each
+dailinks would be cpu/codec/platform dais.
+
+- link-name:
+	Usage: required
+	Value type: <string>
+	Definition: User friendly name for dai link
+
+= CPU, PLATFORM, CODEC dais subnodes
+- cpu:
+	Usage: required
+	Value type: <subnode>
+	Definition: cpu dai sub-node
+
+- codec:
+	Usage: Optional
+	Value type: <subnode>
+	Definition: codec dai sub-node
+
+- platform:
+	Usage: Optional
+	Value type: <subnode>
+	Definition: platform dai sub-node
+
+- sound-dai:
+	Usage: required
+	Value type: <phandle with arguments>
+	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
+
+Example:
+
+audio {
+	compatible = "qcom,apq8096-sndcard";
+	qcom,model = "DB820c";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI Playback";
+		cpu {
+			sound-dai = <&q6afe HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6adm>;
+		};
+
+		codec {
+			sound-dai = <&hdmi 0>;
+		};
+	};
+};
-- 
2.17.0
