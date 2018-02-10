Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518252959; cv=none;
        d=google.com; s=arc-20160816;
        b=ByULBL2A+WVF/T+kBEsz50Fmw/VI0zyLdfAXAELhbKk/tSJlP/CsG9ZSxVA+0rsErg
         m8mecYmbtZ5XuqA024MESUz/1wdYHaeV50OuP71UVm+bX8IfzG89ukvCEAE9mHeFTR9P
         SjtYhY9F3UHBECvteJEiUXHxwgAbYiz3K0vhxCWGywURZbrPyCwCFMg0JnjNiCeDZ5FO
         G3OgjpUuuJ1rpEJTfDgw8A95dLcg9liPcAIlKb8Vetj0SwYk7fdGnNYvd2Gf7rRiBZ0l
         1lUACtA+EU1s2IpEZjG+JujfNPhSX4a9woI5HDwOfkEWGujDAvIKuhT7K2UOb5qBD6/g
         4xOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=PDafXS0W7bQDBSb1RkK8vE9D6xFvCq5AeeOZNuDw7x8=;
        b=IaHmsIdufYq14eFoxjWrE/e5RZ1yZkCqYZWXN4IafxBYFibu1IrPksNEoELJMss03C
         oLbrJDBui0VWHABxB8uw9xQbwxH4IXBlp3NJmBR6QjHDqYPwNWW1fjfz5sAJbGepz71v
         pHr4r7982XuVpKCxHUPFHwiEyOteFlqSPS43PLtUdzMJF6WaQk6Hd38TvWxxnA8tVChp
         4/mm52xQRq+c3Ap6CLaUiro2sS9UjZYN/NIfpa7Ylo5zvKX3SGu/icFjGaci8GJODL/c
         HG7IM3m2JTKrP08JAotd5xhYHHyKVMWNzehGoXY4Aez+CTNHYcac2e+qkviqGDWZ6dLZ
         UGSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KZn7aUVu;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KZn7aUVu;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224nYDFKR0UzAPkrflAAIA3OBzhO00NlAXLu5dzxlhljBsZpxUPGWb1tDuE4ZmooDrB1n4nbfw==
Date: Sat, 10 Feb 2018 14:25:53 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2 0/2] acpi: document sysfs interfaces
Message-ID: <cover.1518252138.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592003615277879108?=
X-GMAIL-MSGID: =?utf-8?q?1592003615277879108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Patchset contains documentation for two acpi drivers- dock and dptf. Description
was collected from git history and reading through code. This might be useful
for tracking changes in the ABI.

Changes in v2:
- Split up multiple attribute definitions

Aishwarya Pant (2):
  acpi/dptf: document sysfs atttributes
  acpi/dock: document sysfs interface

 .../ABI/testing/sysfs-devices-platform-dock        | 39 +++++++++++++++++++++
 Documentation/ABI/testing/sysfs-platform-dptf      | 40 ++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

-- 
2.16.1
