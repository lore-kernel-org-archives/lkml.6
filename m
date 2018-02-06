Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517902789; cv=none;
        d=google.com; s=arc-20160816;
        b=GIP12aJFvYFZ1eK3YmGye3wnTItGPecU0S4LI7sTxYrSzq6vZgMZ/Cj+LD/eig7Kv/
         t+rX4NzelpvYzW8dlBol9pCZPQiGk/9UuI1orTS6jvwzC0lhV8/U8llyXAKiB2VikEYC
         8padLEUhNnptjcoMVGNge7yyuuEeafBkOjDkvNtOAMSlJZWN8Rk9yBpO1daLVg7K7Ws9
         2W1eS3njfG3CUmP1xPuIHSN+TqxKGnU9m4xlaKeTW1Kxpf1q9+jF3bTdeO3LVYQ3sBHV
         9WJ/3fjK/BiwfOi44QzrEuJzzfki5w4C6VT4Ot7TACHUm+QvgrSuI8Y5gU5q0uolBbyd
         mLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=aeexPeoTF9wYVxVvdbz22mBvz7HJ2XGRSL4S4HxYWJQ=;
        b=rN9H5N6TT4u0CklCxGfOO6CTCY3WlksvU+MX/B2pWhkxV7d9MFUCyxuRIggkHmvypm
         c3RhHMj/hZhb9V3BIhHxxF5wfZOLqdnpdJGkntTIfMUHFMAzYUI2Ir6K6theZU5HyhL7
         WhKdQ78HzMzklShlGuHGjrQ97HoXWJrEcq4HpW4DRDe+HJBr9lYKwuZ/NexTEI9Zhy7+
         d1yvumOvp+y6XxhqOWdRSHgIZkfvNOBtM+PV2j2eo1R8LE54Jg8Ivi2fMNksdFeeIw6X
         ikWqmi345/PK5Is4qI7IQcNKtQx1ppPjomYZwYG40I//Bntb5Hm5+tUWFyN96vcSDHTO
         vK2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Dk+iAUxX;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Dk+iAUxX;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224dp7GMEnwzH75esKspZZPerHhNBF6G/SCXPFLDhL4+yDhf1qcz/wEzNkjcpTyMx3aJlUacpw==
Date: Tue, 6 Feb 2018 13:09:42 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lee Jones <lee.jones@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2 1/3] backlight: lm3639: document sysfs attributes
Message-ID: <aa8c36f78ba1228ac7f8d377797b2f1b11574b3b.1517902411.git.aishpant@gmail.com>
References: <cover.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517902411.git.aishpant@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591636435898483685?=
X-GMAIL-MSGID: =?utf-8?q?1591636435898483685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation for sysfs interfaces of Texas Instruments lm3639
backlight + flash led driver chip by looking through git commits and
reading code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- Update contact information

 Documentation/ABI/testing/sysfs-class-backlight-lm3639 | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lm3639 b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
new file mode 100644
index 000000000000..f7e92a82ea25
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
@@ -0,0 +1,11 @@
+sysfs interface for Texas Instruments lm3639 backlight + flash led driver chip
+------------------------------------------------------------------------------
+
+What:		/sys/class/backlight/<backlight>/bled_mode
+Date:		Oct, 2012
+KernelVersion:	v3.10
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		(WO) Write to the backlight mapping mode. The backlight current
+		can be mapped for either exponential (value "0") or linear
+		mapping modes (default).
-- 
2.16.1
