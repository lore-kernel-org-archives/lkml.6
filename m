Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AG47ELu+wevohRZKMQaHzF54Dd8SEi4n+ET+qx8F8tnoFX3xVlGmUrqnRTtqjN2990wEMpIEHiod
ARC-Seal: i=1; a=rsa-sha256; t=1520552472; cv=none;
        d=google.com; s=arc-20160816;
        b=k2eQtfb3XeOeNCUjTCgmj8psjwWiYVTRqVF7W+IH9rii+FT6xYiLGsdXtnuS1/9hRJ
         XpyFDUUxGpLQc8grZiz2Zr5fTjfIxAYvS7BhJ6rAszZzGO9z1+ytu6VQz1tXZdTzCgu/
         7yOsIbfvIdCkPRaKhMxlyDCHJ3OdNqDmK7zsnLsLuwE2K6TSrcbSILnT9TTNodqs6gOn
         Llq5uLfVlGtqE4r/Tg85nAA5I4P6l/QXCuVEn9EpSMedb5Qo9XT7yU5Wy1/bwzrPOqxy
         C/VKAAjymvcL3IZ04xabGDLApuBOMReRl0S69uZxLfQfrQAxCq3aIPxKDMXpK1wrLsJN
         NRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=k3+rFgGulOEVhXKDRP2WI5NSsB3uTvID9JpAgaAKR40=;
        b=IJnu2ieIlPuBxaIJ9OAgChd+PcC+jhK4HQmMc0m1NRPqZvPzV3HwaICLpWRE2LfSl1
         MD9scxGKAfrEFgRvnpBu8wMBDDju78EV6Bf5PM1uw8e4pCsVhBZCM7dwRkDvWHtZk/w+
         s9PSWhVH0f8hFt8nFQfSRP3G8Ug5VLDdbQTh4mdvG/fgY2GKiBThheEbCGcag5OnwYNk
         IGaQBwrDSM02Ugzv1z23y0H++15o0SKIJgaeiJ5h/P0bU7S9RMld4ukj5K43OVC7V5gv
         muoE1FswfBeYTzHLml+apk47fx1TqIiLAnG3tKKflm+bn8ET9yWrZkNm0EBr+5mZVqgt
         bUnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 2/8] Documentation: driver-api: Move gpio.rst to gpio/index.rst
Date: Fri,  9 Mar 2018 00:40:18 +0100
Message-Id: <20180308234024.24145-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:VDAzRHM8LKEcX/zaXEAkD04gHlvpcQUPyGpsUCn0SYmGuU26pg1
 gw6jBekiTEZaFSp73vpH73HJafjVYGXz+IzwcPOrLi9hFYVbD77VuzGhuenZ5ZNoCBNWVl/
 o5bRlyK175uKqS+OrmOf2Tgw5mUKgxXDSRFidbqTJKxyMEyiZy5sXeeWl6URxH1ekrgtB0u
 WDIhJedODgwbgtQ8Zwgwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yRef1sQjel0=:2CamwxpMHr8Uofyx3EiCiO
 LiZtqKc34knkDqPEbgsdy9uUdbFR73dtl0OEuU4dwr+i/ZLZCA4W7xi/fLk6ToomadERvPqGa
 ZYPRMLjpIkOuz+eY2IaxBNb+9hMMSd9//0A8KbtIidKXffSmpvfHP1616+Z4B6A9raF6gtko/
 CFzoXl9M+vHL5143y8hAdPo7R2SYDGxFwHUTylkET5KWUpph9gmVgpcwr7PS9JVJaS+guinS1
 BGE/pL3UEYJzdzp/50PX6jWVCLOjI5zDZi1GUame1kCEfRUgDhEwUk7+yM/9vRDvOf4Ouk+Fu
 bq04+M8eWe2k4Nd4fJz9UxwweEZXOrGHLgzcLVyaiX/OBQUCS7ozXkkZcDbRbl/eWxKJUGuEn
 Lsw6ja730fyFs9SGlm4eMF54AdmCh9KemOpTY539fcMMP9JN5ZqXYDWY2IiKBFa4CWN2bU9SC
 k5P5i/rfLw2nQ1XSi5A3QbQPBVR+rXUE49N1u4rcU3vnhe5f9e6m6BHky1sK+2aRk1lyJg2hJ
 4uIAP56pv/6KPjfsD7YEyMSZEw5jxdlTWelNfpnxu9A2LinxPRADgTCT/GmwP16IMULw3+L1I
 smo8+Emlr0MzvsKw9QDXVJJ7AqbosU4pKGI//JrK6bH2rYfQnn7pf07ZZ2whS3OLLKfGwOYUk
 OU9V3ZSvXrVwWmixXuWHO5KSriK1X4u7Wzqvu3lco+uVSCyScUrRAJ65Z5mOoQWozxZ0hX2xE
 UmJ6HFSTaL2rtnGPiVBJrWQ2+iDaZaMSYsNAUgP84AtMR3Ahpfh5YwyAx3XjiE0NTH8TvkYCf
 t7X2D5Ru3hqTROLM83EAYcRBku/fP0SUGIbhPc7LTfhDv2hI9w=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594414829894946837?=
X-GMAIL-MSGID: =?utf-8?q?1594414829894946837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To make space for more files in the GPIO section, create a
Documentation/driver-api/gpio/ directory.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/driver-api/{gpio.rst => gpio/index.rst} | 0
 Documentation/driver-api/index.rst                    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/driver-api/{gpio.rst => gpio/index.rst} (100%)

diff --git a/Documentation/driver-api/gpio.rst b/Documentation/driver-api/gpio/index.rst
similarity index 100%
rename from Documentation/driver-api/gpio.rst
rename to Documentation/driver-api/gpio/index.rst
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 62d056471c0d..9b54fb99d9ca 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -45,7 +45,7 @@ available subsections can be seen below.
    uio-howto
    firmware/index
    pinctl
-   gpio
+   gpio/index
    misc_devices
    dmaengine/index
    slimbus
-- 
2.16.1
