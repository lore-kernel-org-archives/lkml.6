Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517902728; cv=none;
        d=google.com; s=arc-20160816;
        b=k7+5mRsKmVZGJ8k6sRMxq/5r8HRBcyytFFcnXsGEq/fjy16jH6CtzMARZKFFcAVHT5
         eK6mpDrc8pCOIKMEuKzPiKKb/ixsrFs8WXn/H+rbTi1olYdos+q0U5czY39u2b2qmUNj
         4pmFMjq6p9zyhcz0Urhc4tL8VkSmHNb1re2JZHT3bDxF7ka+aekgjW/WmgWZJzrPGA5u
         I0l7Wjdyb4revHedrMGOmij5GicAqPMzGeRapB9YLZZQ+MQbWytbBzUTrlS3Abn4V1X/
         7xCeoWVbm+LRp7/yMJT9rG7KyGDkcjEtgTDbw6cRGZN0whdoL2aXFfXLqwNGpApTC75J
         8FJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=xYR4v97jLDA5peHF50VaaF829Sl3ux3WLvb6rLzh9G0=;
        b=gb5O9VRLS5BhwtTle6oENNfqgZDgPLS3EUgbC5iYBne8bqEPayeXxTQ8e0hvWxu9hQ
         tDgFiP3VkojPCX/VHFbIycYWKdo7mV54LI38j89BZaGp/eSvbzPLO2m9WVmQCUtIRa6D
         wA28gEa7HvaERRwyu3NL88J8UEN1A5HZfiq+v6r2VW0z0Q/X4KJDGvqttsLibe5aORU5
         NC+f6D3iqCsTh0YzRagmSz5JShvmxSk10BT2kgVSFz3dA3aixI6XQOB2NooYuy+6G9oK
         Jijy2ph3T7psCMkhQGbdgZK2gRzisvL75Wcbl6sir6CxKHAwmEfJMWA9OvakNerhBVZq
         egwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=W9vKmqLx;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=W9vKmqLx;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227dQKqk+w5dE/34RhJ5oXJk3ghYD2IDzNAkWAsr7ezp/lyQ44QInyONoAFiLecyG5WLYaetuQ==
Date: Tue, 6 Feb 2018 13:08:41 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lee Jones <lee.jones@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2 0/3] backlight: document sysfs interfaces
Message-ID: <cover.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591636371851497694?=
X-GMAIL-MSGID: =?utf-8?q?1591636371851497694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Patchset contains documentation of the sysfs interfaces for the
following five backlight drivers-
1) lm3639
2) adp5520
3) adp8860

It was compiled from data sheets, reading code and git history logs. In v2 of
the patches, documentation for lp8788 and lp855x devices was dropped as the
attributes contained debug information.

Aishwarya Pant (3):
  backlight: lm3639: document sysfs attributes
  backlight: adp5520: document sysfs attributes
  backlight: adp8860: document sysfs attributes

 .../ABI/testing/sysfs-class-backlight-adp5520      | 31 +++++++++++++
 .../ABI/testing/sysfs-class-backlight-adp8860      | 54 ++++++++++++++++++++++
 .../ABI/testing/sysfs-class-backlight-lm3639       | 11 +++++
 3 files changed, 96 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639

-- 
2.16.1
