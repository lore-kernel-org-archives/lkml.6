Return-Path: <aaro.koskinen@iki.fi>
X-Google-Smtp-Source: AG47ELssvXUv3/6Srw0Rabq8c1CyKSlab2twO8uq/PDChixO4D77kWR6WFB0lUNvAI7s/izFgwhh
ARC-Seal: i=1; a=rsa-sha256; t=1520194705; cv=none;
        d=google.com; s=arc-20160816;
        b=fHqWVS3gojtac1SSJPuzynhKd1tUXuBCMqedT4NJ/4lJfew7xWDGTv/MfpFSc6B5HX
         q0rT+UfKgjwZxuZIN0LX9Cc+aTm7VlWRZ80Rb22xlZnkn+lP/rbEvJfuUGyThJvtFrWe
         fxNq2OiP6OxsvNMIMBgTPa7xhWSWmPPddRdBghCGx62S0sPG8yySG9zblbydIXFs5QEF
         zU7KZpO3CrA93ex1fsDmGFPfGuuH8RKtl3ewxVm8fB6OjwqGn7i9ppE9KM3pGtFxUaRd
         nT4EFhA+GGZVjYHwobC7xnm5FeA3bCDgS6U8PPA5vObrztjFdrDtDP+GYAhjGJnoGI63
         TbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=DWDP4Q7LYiXqa3dnW33SQ6eO2bjAmJ8Ei+w4bJw8UI4=;
        b=sCfcjiFgkUY+LYnKGvJgBSHalUrWlr/ebq6RdWR9oDyEz+FV6gHAKs2+n/dZ4Qlu82
         0T/qht0M1Iy/mEAOI/fCCr0kgpl3q8rbNraopI755Ydw6c5ycXkyZpppUTks1PFT96/N
         zJOwiAhr37T/htk05lMjktS47gsw3Uj1TO1E77+y2ew6gKcImqyhNgVFNoNRBGj/gBEM
         yK6tTTBXpO20ZW7qBvsb/gtroykN/Tw6WypIuaYkgFY9Y0GBiNyilf8l/rhqz7r65Aiq
         YDFvOmcigLd9PRYDgU+KgHLUJDfD9H8vPHEIvjCyLcpYulZF3tMttV9QZrYePwpH5DVd
         fbAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 62.142.5.116 is neither permitted nor denied by domain of aaro.koskinen@iki.fi) smtp.mailfrom=aaro.koskinen@iki.fi
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 62.142.5.116 is neither permitted nor denied by domain of aaro.koskinen@iki.fi) smtp.mailfrom=aaro.koskinen@iki.fi
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] documentation: add my name to kernel driver statement
Date: Sun,  4 Mar 2018 22:18:14 +0200
Message-Id: <20180304201814.19641-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594039683394131327?=
X-GMAIL-MSGID: =?utf-8?q?1594039683394131327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add my name to kernel driver statement.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 Documentation/process/kernel-driver-statement.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/kernel-driver-statement.rst b/Documentation/process/kernel-driver-statement.rst
index 60d9d86..e78452c2 100644
--- a/Documentation/process/kernel-driver-statement.rst
+++ b/Documentation/process/kernel-driver-statement.rst
@@ -103,6 +103,7 @@ today, have in the past, or will in the future.
  - Auke Kok
  - Peter Korsgaard
  - Jiri Kosina
+ - Aaro Koskinen
  - Mariusz Kozlowski
  - Greg Kroah-Hartman
  - Michael Krufky
-- 
2.9.2
