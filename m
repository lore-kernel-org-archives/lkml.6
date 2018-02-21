Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227j1c1U9YIw4ZBFXIpmFDuuRVbl0y158vn0R+8JfuDrZ8rIvQyVZ6uwsttAFdmJsm9eFB/H
ARC-Seal: i=1; a=rsa-sha256; t=1519218070; cv=none;
        d=google.com; s=arc-20160816;
        b=VzfbWas/pkLSpEHPZfHTCjknUq+SUa+qMvoIUclmSIiAVzhWXDXZfJVSnTjwibhPSP
         0ax5jmfRYnHxApu5vyH1EhcKNQW54y2m8/xTqHMqyoTNT7qg7AVTJBYWsdri/tyLjTMo
         sEky/DUllTFRCL7Ca2RfNm6XJPG+mNlcr+WjEeaL8ygLT9UIhP2ib9nLEV1IV9FxHcJa
         hMagQD9WyCTg1lL9BS91ZlpTLVKQmOWspaZWfa8Wjcz96m8sBAqtMvIqOT3OmRVZtgi0
         CQJsoRajIMwTs5TFsU5b/ZmMFQ6YkDWcPLJPP584tX2fsbIdD8zUF7Op4nmelBbM9Bjp
         KzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PLNvH6angp+KEY1xVQ3MAeURurrckYAgbagp5sjEm08=;
        b=wWHxo63CLzOXCGjwR2YJkIAAN89gceTPXQzDUAjmE5jhFj08UFRH6LZw5fkCqCDSXi
         DLvK3+EgouvEBwGUQpnTBUBoIh9c46i2guJjWDzq4NMBRLe0gpwRR8h9N49valOfpth9
         Kh66qLyUquOuTZtmIkkzGY/saizR93iGcvINE5KxC/wWb4CucwsPpoCc7C5NtHdZQ73v
         029W9ywGnP+SriOY70hWzcQ/K2DJrh7LxCEU4Ts18a804sxTXlHXribloNX/yBDJFb48
         WTlLphrrqGmCKbWb6tyq2JxdcdemlqDFl5aG8rHsfyLjgj5jOtV+Ip5r5qMmYZ9t+n0W
         sS9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matt Turner <mattst88@gmail.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Anuj Phogat <anuj.phogat@gmail.com>
Subject: [PATCH 4.14 035/167] drm/i915/kbl: Change a KBL pci id to GT2 from GT1.5
Date: Wed, 21 Feb 2018 13:47:26 +0100
Message-Id: <20180221124526.528389657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015607347882491?=
X-GMAIL-MSGID: =?utf-8?q?1593015607347882491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anuj Phogat <anuj.phogat@gmail.com>

commit 41693fd5237397d3c61b311af0fda1f6f39297c2 upstream.

See Mesa commit 9c588ff

Cc: Matt Turner <mattst88@gmail.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Anuj Phogat <anuj.phogat@gmail.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20170920203126.1323-1-anuj.phogat@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/drm/i915_pciids.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -339,7 +339,6 @@
 #define INTEL_KBL_GT1_IDS(info)	\
 	INTEL_VGA_DEVICE(0x5913, info), /* ULT GT1.5 */ \
 	INTEL_VGA_DEVICE(0x5915, info), /* ULX GT1.5 */ \
-	INTEL_VGA_DEVICE(0x5917, info), /* DT  GT1.5 */ \
 	INTEL_VGA_DEVICE(0x5906, info), /* ULT GT1 */ \
 	INTEL_VGA_DEVICE(0x590E, info), /* ULX GT1 */ \
 	INTEL_VGA_DEVICE(0x5902, info), /* DT  GT1 */ \
@@ -349,6 +348,7 @@
 
 #define INTEL_KBL_GT2_IDS(info)	\
 	INTEL_VGA_DEVICE(0x5916, info), /* ULT GT2 */ \
+	INTEL_VGA_DEVICE(0x5917, info), /* Mobile GT2 */ \
 	INTEL_VGA_DEVICE(0x5921, info), /* ULT GT2F */ \
 	INTEL_VGA_DEVICE(0x591E, info), /* ULX GT2 */ \
 	INTEL_VGA_DEVICE(0x5912, info), /* DT  GT2 */ \
