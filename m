Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AIpwx4+lHaE13c3URo1WUZzT9t8cgQ6XT5kM9vWsc6bFvDS5YTrkD29C73ZTAEYpyvf7WB2lhEeC
ARC-Seal: i=1; a=rsa-sha256; t=1522241555; cv=none;
        d=google.com; s=arc-20160816;
        b=KWBQFAo5NtS14YjpqmT5iiTM6W16zaUNem02nGFgJ1lYaY3+855B6NTohq1lA7FFen
         aY+LphiHUq+J5EC4DVM/3BvP3uwjaS6TILcpxOogiBXwMS4okJLjtTTpMrHrFw7Ilxx8
         uOLqbUkCuaII1dS0y+VQ7zNzWYNHca2y3zWmMpVdH6Lh9xUFJBGd8mNDctfZMZJBo8fF
         qcFpjwGjsLXH5SQbhXkeTnfUwq0dp5SA2JObl+oo3mULq1Y+00nxT+LgGtBV9O7FZ1+s
         w3+Ryjb6bBPj/tWunuq0XaUy08OhG91VxJC7fG8SHNVCL8z0P2xx6iWaObg9oNgCp2Wk
         AJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=uuHgpALEHQFpVBWDBZH2CWvFxO2C9R2auBMEbJ/XsKQ=;
        b=Lj/lZy6pUIVCOhpBMrOJnuHFn5PdePSmptzNHlgD0jq1J05z5xGF3bTP2KlZP3vGgr
         6zOxgP/K7BasBzWGVLbdtOnt2Cx8CZV2L392T/g6zUo5gsun33K2uoF4keX107eDEhRI
         gI+JbDoK/1SuUmKqvHlZO5fh9/py+Lo+bVYmbNe3yFJsYmAxMqhociYhgfEgnfsUWQJW
         3Dq49bjaeonY3hIb7gLpR90R+6j0xfZ9IcuM/VAqFIhiPsWP43m45fPKUJRYQytd6YkT
         DY+e5XDZNWHfomrqvFVfh/84P9At8XApRvwNSeep5PN8OpLCzulaNHUW/MasP2Sp5QmU
         SGuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
From: Niklas Cassel <niklas.cassel@axis.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@axis.com, Niklas Cassel <niklass@axis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove myself as maintainer
Date: Wed, 28 Mar 2018 14:52:17 +0200
Message-Id: <20180328125228.4394-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596185961436657150?=
X-GMAIL-MSGID: =?utf-8?q?1596185961436657150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I am leaving Axis, so this address will bounce in the not too
distant future.

Fortunately, I will still be working with the community.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f8cc197f829..27f79a94a20a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1207,7 +1207,6 @@ F:	drivers/*/*alpine*
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
-M:	Niklas Cassel <niklas.cassel@axis.com>
 S:	Maintained
 L:	linux-arm-kernel@axis.com
 F:	arch/arm/mach-artpec
@@ -10837,7 +10836,6 @@ F:	drivers/pci/host/
 F:	drivers/pci/dwc/
 
 PCIE DRIVER FOR AXIS ARTPEC
-M:	Niklas Cassel <niklas.cassel@axis.com>
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 L:	linux-arm-kernel@axis.com
 L:	linux-pci@vger.kernel.org
-- 
2.14.2
