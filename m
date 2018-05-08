Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZpcuG4iYw9HAgQzikL/6MF2Cmnc/PTs8szlAM22JdnVMsyvTUACpaLV9WqKy1GdEwiB9gCc
ARC-Seal: i=1; a=rsa-sha256; t=1525803191; cv=none;
        d=google.com; s=arc-20160816;
        b=YR7TK9kWqeJma3i7h6EOP8A4U2PaFwxie41zbFkoioAEgJdCHvbygLkcGQfB0jtIuT
         YFpplETcRh88eMK6OPsNZ2pRv4/ph2OIeeyYcWf6LJiaY39S3EPBUILSEb7o6zUq0OXJ
         F3WmV6y7Gvwk3KYf/iKiElmxVVJ57MP8WDDC90yMUs4UunZrr2+ljLb8Qh/xhOUYYZ7i
         XyH/oKXiSKgenmdOOsCLm20zf+/Dcd20I93VqjWPqRtQgW5b6rQOJMT6YvRX7OKBNnNr
         ct+CjkWvzx55dpnZStI94oLkfHTVU/s1Rsosym+sKedSYzEIS/RX5yWlBgYfC3Qum1+p
         /Tsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=cICutjd7xctFwgpit4Fv4x6/AMw4C9M9DA5UPjdjlhw=;
        b=x3uYPg+qFCWQ2EjsMG3XzaLe8cRrlDwL9V1chaGqARbP+7QY8Dupu1fWn77vYZAM5K
         L/kWWDpKnnn+CQYz6yPcRl5bvHirZNYvE/niSyqbxwdDEwtZgJEwAnV/CBsjcC1tu6dA
         vY05BzT/1Kz9Of0MtAPtgpkjQdDro9aAQKk8n7DO9ayqc/uO1RPtuZLehmIb0EnJfPe1
         tzaitMB/0WscD5XJ/kNwJABpu5ROnkFR0R0pO2MlzkEc/hMp2K4Ph7zEdjecO8f5OPDT
         ZL5oSfrkmRQHieO4SaQc9B+Yg952OKTEMywy0aDJ+MIPu0BZgc2eRRTYxZrkCwxtSYsb
         ZKag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MDknyoVk;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MDknyoVk;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 12/13] Documentation: remove stale firmware API reference
Date: Tue,  8 May 2018 11:12:46 -0700
Message-Id: <20180508181247.19431-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920606656661836?=
X-GMAIL-MSGID: =?utf-8?q?1599920606656661836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It refers to a pending patch, but this was merged eons ago.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/dell_rbu.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
index 0fdb6aa2704c..077fdc29a0d0 100644
--- a/Documentation/dell_rbu.txt
+++ b/Documentation/dell_rbu.txt
@@ -121,9 +121,6 @@ read back the image downloaded.
 
 .. note::
 
-   This driver requires a patch for firmware_class.c which has the modified
-   request_firmware_nowait function.
-
    Also after updating the BIOS image a user mode application needs to execute
    code which sends the BIOS update request to the BIOS. So on the next reboot
    the BIOS knows about the new image downloaded and it updates itself.
-- 
2.17.0
