Return-Path: <pierre-louis.bossart@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoSpNnZJGFnmcDbAysS2wI3h0TQ68iTfAkZmvIiEz8WoarlUfRxwKLENLgErCL/Bbctf1Tm
ARC-Seal: i=1; a=rsa-sha256; t=1526500218; cv=none;
        d=google.com; s=arc-20160816;
        b=b4+hRJevj24LKfyBDMnN7P+K3FreDpx7QB/4GnZ7ZbzUx6l5UwiGil8YeKFqjRKGns
         tkNoRG3b/8p119l5TQrzqAfhgD69wM43EmyICWYnNGR92YkoPeWSOnsYdcVz78c7QhC3
         7NFJguMr9KK63mwA7tdLm+T1DOB7/CzbSpBkdnUqehIOBOfNyQJYrnbZsODMU88soYry
         0T/nJAIz0xJTqBcT/e3SqdpeHLiBTmwhVjm0Q8MNgtWpT/3BXBXqbOesKmlAXiLawIZk
         564J+n059SoZfOhOHED2m9wNbsClJ5mWLo5DYebn6ezS8b1iMIMsVTc6c8l4tFPWbEnE
         PuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=CI8I1L/7JPwNDBNqRYDdKhm8yLHNcYnGcQdY7uMP9yI=;
        b=J87oYyn8UNu19tmo37TizGgxhlsG55U+BSPj9mmCWm5h4gWuKsKDOo6ygYuEXLjYWC
         QXmrwFYGEkytzEzHCUZHyoWpg2U2ysleCp9sL9mN73TO5BdLAw8F0lOuRA+bJAOHE3tP
         j8x7yBsh6eCVAtL5VQDwJfl6hE1IBNd56coHOiXa85zzB2sxmZ6D+hl7noO6Fu3mHF28
         1i48cfH37aFSzZExlasBsxeVTLNdP0jO4GRAS0PWGtxQHk7l39J2aQNdNHcU10JUarcE
         ePPDYLiOkgPd6OPiVB4aFNSR3dw3BU8/giF596bl1Fg7AUHfeTvNwHmAAaWor7pbK7SO
         znXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of pierre-louis.bossart@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=pierre-louis.bossart@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of pierre-louis.bossart@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=pierre-louis.bossart@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="47014662"
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	vkoul@kernel.org,
	liam.r.girdwood@linux.intel.com,
	Keyon Jie <yang.jie@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: update sound/soc/intel maintainers
Date: Wed, 16 May 2018 14:48:49 -0500
Message-Id: <20180516194901.8128-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600651492835951658?=
X-GMAIL-MSGID: =?utf-8?q?1600651492835951658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The information for Intel SoC drivers was not updated for several
years. Add myself, Liam and Keyon (Jie) as maintainers to get notified
of contributions and bug reports. As discussed with Mark and Takashi,
I'll also monitor alsa-devel and ack Intel patches as necessary.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 MAINTAINERS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e83cee26e195..d70add4c253b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7030,14 +7030,13 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
-INTEL ASoC BDW/HSW DRIVERS
+INTEL ASoC DRIVERS
+M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+M:	Liam Girdwood <liam.r.girdwood@linux.intel.com>
 M:	Jie Yang <yang.jie@linux.intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-F:	sound/soc/intel/common/sst-dsp*
-F:	sound/soc/intel/common/sst-firmware.c
-F:	sound/soc/intel/boards/broadwell.c
-F:	sound/soc/intel/haswell/
+F:	sound/soc/intel/
 
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
-- 
2.14.1
