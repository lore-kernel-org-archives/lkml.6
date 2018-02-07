Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518009418; cv=none;
        d=google.com; s=arc-20160816;
        b=unITNAEJ5bYTdsYCI7qVif/UA4DxH4AvWVrq9yEzaJHQjQ/Ca/9rkxWEg6OA6h1Pop
         c4bmhBKkhErG0yS3+X3eGOAYXSoXck4xkKYEySczDl1zfRsRcPp5zQub80lCb1Bnqy8L
         t/D9npMBNYLtKzGZxXwTFIL0KIC8aufgdaOSF9Rf42GTU9oM7Eq/z5tm4rVDXAM2Bcju
         FLU0YzdMGxT8/fQorfet/F07AIttes8dan8kYtNgzgtz8DPjl5Uf1UkcBm1trbxPPIOg
         9RaxPDT12J6Q3a2XWDflZ/xhUFTHpQuMCRGTWPpm9SGtwzJL70XoOrL6Ho/yrukNou3l
         iDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=k6i4NIB9N6DDkzLrlnMtQMsijRjwaLC2OeleUP4Vizg=;
        b=N8k8sfPvu+PBj6sCkx+X0Z1yV9d2DnZ2D8Gr693hHdps61VjydN42BUEThi+EgYEaf
         5Fjm+kkoHtr18iyRn+KCflgk2GGFcYA35h7wE5anItpLHSQnfvFRgAMRl9DGG4QkXTjA
         +HmV44323jl5SbQJJf2Tz7p+HLgr5gA5QqoBk3Nu5uqKqhfICMbxADtnv2NEbSPe94ct
         lrYtW+tcGS4FC1Wpj3nRm/rzfdYaxgbqUpQ2J8rYBloJXuE+1edHyHaE3zSH6nuC7WAR
         lXcODoICzjbgTz8np9IMSRdUoUh5ld5nHT7xefMfA1I43gLafb8uG7Qqqmk3RxpNg1t0
         4NVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=by7Jlx/y;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=by7Jlx/y;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226FoK/Gz0VhYSGSyYtGp0OqUyDCO+MkRG2NcESIZFxusq7lDLxqNvefb3ZsDHUUrL4s7qzueQ==
Date: Wed, 7 Feb 2018 18:46:50 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 0/2] acpi: document sysfs interfaces
Message-ID: <cover.1518009225.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748243274775450?=
X-GMAIL-MSGID: =?utf-8?q?1591748243274775450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Patchset contains documentation for two acpi drivers- dock and dptf. Description
was collected from git history and reading through code. This might be useful
for tracking changes in the ABI.

Aishwarya Pant (2):
  acpi/dptf: document sysfs atttributes
  acpi/dock: document sysfs interface

 .../ABI/testing/sysfs-devices-platform-dock        | 38 ++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-platform-dptf      | 30 +++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

-- 
2.16.1
