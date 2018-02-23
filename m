Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225s7+EGY495q0OI+FR8rEJKz6ycSR71RlGgviWeyd4vfqXT99ctZlhB8QaqkZtt6Q0kBgFH
ARC-Seal: i=1; a=rsa-sha256; t=1519410811; cv=none;
        d=google.com; s=arc-20160816;
        b=cs92MTxzyy/zOTVEXejm1YShDf5jJa85QUYGFFn/BPvtYU1Ovk8o6Qv9UiryEwMHDU
         UZV/MeFI3TwXWrT3aGun2bzKsQ4AAlBS/RM4VhsyTLmhv9PIio34UjbxJF0bttSrLSMZ
         JzroLf9147T//7FfBlvFawxn8kbNlJt7x6rAPKdukzo5uyomNJFNlE8PcXkzaDaSsYiT
         17LnCj+G1lpYGsfhGjY9GCy+EET+EjodglRmSUMRY/ifLFsolKgQVp1QxoPUN2ZCTMXG
         B/Lu6+E3ebrhv6tKmic0sGYbGFiT21XNMvKR9hXp1MvlqxtOz8JN1XeGmU4r3y2SMP3G
         GUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZjT95x1KJz+6VFh6Tx4j5XiX+CsQuzLxP3dmjciqMVA=;
        b=Kx9GsOhG0jvJ66nRdIGDG1IyWpnV1Ya4T3+QtwK9oRQpWINqz9TjSvMWiVmuImaBjX
         CkHGZNktGa8llrbGO262E8LPSTVwtUKp2PW7lKIfoT7trd6jS9jng9BMOLl7H4OJyFxA
         1GGAStrhmmvpHcCjJ+C6WZtDt/IqchmPb9Uxt5O1/p3A5GwbtnwX+gi1x0eeEVOop8An
         SPJeyUYGR5qQlW4ftTfH3p+/bIb5PaBzk3hSfGIyYJsmCD7C21ITr9Eb20Q9xUrmCXWx
         5pC0SSlfR/k+tv/x1HiLFeQnD4awVKEw9kCevMDIvts5ioniEwdA74fY9NhicMFeDPLz
         83ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 021/193] ASoC: ux500: add MODULE_LICENSE tag
Date: Fri, 23 Feb 2018 19:24:14 +0100
Message-Id: <20180223170329.389316802@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217561163131306?=
X-GMAIL-MSGID: =?utf-8?q?1593217711387704017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1783c9d7cb7bc3181b9271665959b87280d98d8e upstream.

This adds MODULE_LICENSE/AUTHOR/DESCRIPTION tags to the ux500
platform drivers, to avoid these build warnings:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o

The company no longer exists, so the email addresses of the authors
don't work any more, but I've added them anyway for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/ux500/mop500.c    |    4 ++++
 sound/soc/ux500/ux500_pcm.c |    5 +++++
 2 files changed, 9 insertions(+)

--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -164,3 +164,7 @@ static struct platform_driver snd_soc_mo
 };
 
 module_platform_driver(snd_soc_mop500_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC MOP500 board driver");
+MODULE_AUTHOR("Ola Lilja");
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -165,3 +165,8 @@ int ux500_pcm_unregister_platform(struct
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);
+
+MODULE_AUTHOR("Ola Lilja");
+MODULE_AUTHOR("Roger Nilsson");
+MODULE_DESCRIPTION("ASoC UX500 driver");
+MODULE_LICENSE("GPL v2");
