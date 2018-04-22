Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48+CLWwK1fmCI5Cvpq1G3OHO8mblS+c59+8/JW9pX3j2qjNmlfMy2jWOB2agiJ5iNmZnvm1
ARC-Seal: i=1; a=rsa-sha256; t=1524435136; cv=none;
        d=google.com; s=arc-20160816;
        b=gzOzI4Pie7Bc9OvU4vglW1Vo7qOEV9IHjguB4X7rHDzhUfpcff8SuHY8s/9S6Rg5i5
         XN/bPlSmG6uuXd2YeASOJmrzq+krP+oB39Ba30TLRPrDDRfi4cRuMsJ2qmpcv81gmsx1
         bWIywCc58wiBNs3/cFhkT0iXCXDOJUolkHKSBTeL8csau7kiBwtM1EKWnVuZtTOE6WL/
         YlcE009gqUlHKlRGp6OKg8y+EGQdTwhG0Q3up6yCUa5b3DrV4n7qBMAR1PFXqyxdA9HM
         1YM664+SLCVlpqYkbFaIZB24i+5Je+XhukNKH9HuPuJoZqITFmJ4cc58Y/3ZMapLP0MP
         JwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=DMYc39iNIRSOBnk6Tkmy5hS+0Zo8rjAcyUG3cn6nnos=;
        b=RVq67rZRluQnzMSd4su47ovEj+oVLBEOXoFE42/amSx8eSxFqJ/rNRWfHEyCUHPUTA
         nEsadHrxgLhtL/ncLZYwvxcvdolMpym3quhkL5h2zmpYT3PjllpewHbnk1tOR6jiD0Ne
         ku6luLAMkzhUT4w30i8Agf/+TSp4crUdrlBD3XPTCalD60QDI/XyEbFont6bTivbxo34
         xMQ6jgRi1RtskYL6yzNtg9v2l1UIIG65gVxBPVyOZ+WMhOP+3mtgwhzIjzkq8danTDrj
         ijGbgzYXg3k5VOIO6UBc9GH69ohMuIWVrdlrmEMmVC64G0ojx1zCbdVhjdF1XzZgXMvL
         NMFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422220833.078058446@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 00:02:12 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [patch 4/9] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid
 identifiers
References: <20180422220208.772527041@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=LICENSES-GPL2.0--Add-GPL-2.0-only-as-valid-identifier.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486097354490733?=
X-GMAIL-MSGID: =?utf-8?q?1598486097354490733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quite some files have been flagged with the new GPL-2.0-only and
GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
GPL-2.0+ identifiers in the SPDX license identifier specification, but the
identifiers are not mentioned as valid in the GPL-2.0 license file.

Add them to make everything consistent again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 LICENSES/preferred/GPL-2.0 |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/LICENSES/preferred/GPL-2.0
+++ b/LICENSES/preferred/GPL-2.0
@@ -1,5 +1,7 @@
 Valid-License-Identifier: GPL-2.0
+Valid-License-Identifier: GPL-2.0-only
 Valid-License-Identifier: GPL-2.0+
+Valid-License-Identifier: GPL-2.0-or-later
 SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
@@ -7,8 +9,12 @@ SPDX-URL: https://spdx.org/licenses/GPL-
   guidelines in the licensing rules documentation.
   For 'GNU General Public License (GPL) version 2 only' use:
     SPDX-License-Identifier: GPL-2.0
+  or
+    SPDX-License-Identifier: GPL-2.0-only
   For 'GNU General Public License (GPL) version 2 or any later version' use:
     SPDX-License-Identifier: GPL-2.0+
+  or
+    SPDX-License-Identifier: GPL-2.0-or-later
 License-Text:
 
 		    GNU GENERAL PUBLIC LICENSE
