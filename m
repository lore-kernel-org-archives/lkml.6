Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/LRCB7dFOoqZ49zEWnhM2CJw7dxZjjCMvwb8KqZSuo7KbXjFjxbfQJ7pz/6+xqudNs01wv
ARC-Seal: i=1; a=rsa-sha256; t=1522393768; cv=none;
        d=google.com; s=arc-20160816;
        b=wA79hGP+FhoqEd+dr17hZBieYIy5wQ2pZMYqxMYy44f1EU8MT8JxbBNjZzNg78ubCp
         /P5AydKhsAiFYH9yypTCbuR8dhCGL0PXc+i9q2TzpwZOACVeXLX+9xXMK/e4cfHjt1Jp
         1elqzA1rgRQ2RIEolcjZLjMp218G2Uk4Ntmldr8FiER9tdPLob9CqxKkUt/gcaUsfuF/
         jLRkJXYEG7h+dTLMXm/yc7fqmjPvj9AZC6cNIZ/0vkhiuGyRd8BnAx0wsT3mkeMV4XUR
         MK1uwAH0UYTqVlmFd0sXg/95saYqCDBoe04Bvk3Fgl6BjtKg4RmjpNsNXq5Vk44iM3Xl
         l9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=b9ykVjOm3TNWW9qYoOljjhWRxYcu53ri8GtyecJRjH4=;
        b=D1VR0TVHUpmCZLouiwkogCcJLCYkS+EqtAZ6wcAfkUcq+KiMtdpqwLtnxwT3XQWDEI
         lEfdVo0+NiJESyc9Wj0u2WdSpB+SsVDkX8eaO6Q36e8OzQixwdHMs7m8ac7eE5rDNaUl
         A/jMeIttIS9QSZ8hUSDuPNe0EZDH4q4kwPe6JywZHv9m+7ZUAWpWvSkuxeDW+lH+krK9
         yeX8w3lgwn0PzkWsxGc0rxxMi/QkNFvuLpgz8g/t96q00/kFM6PtUdtzkylo9SvdmtN8
         C6dRsr0qFnhbjYmshDKX68k/++bEdiWUofwyswYW3YdEN0LJSZNeERzmbB3shSMpq7yR
         8amw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 35/76] staging: ks7010: Remove trailing _t from 'struct hostif_infrastructure_set_confirm_t'.
Date: Fri, 30 Mar 2018 00:07:58 -0700
Message-Id: <20180330070842.25224-35-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Ub9sZawTE39lyXdMCakUZIpfxYx/8vUqG2y8ubhmLmBhLnOqnXI
 sddcIbXUINl2oUsXoPP8O6OpK9hlsPr5XhTdRTv/pNR7uY3g0yoUvvNxOym6ZwEMlequMsj
 utBz7thTqTUQeuo/TG+JyTV2oYh9EdBRmb117nDc+PBbC6yCoc9r2uGCYznAmfJ1VX30hif
 16iQpm6f4AHUcrl3IE+hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yh0OaydAA8M=:SKXHwO9LzTWFscTJ6+vT9b
 ehGR5+fnrfy5wraWuk8quel60uCKjuawJhCJJW4iHaZvVzD23DDYRtJbhx3eHAUVKCi0DEkoh
 wqaaBuoU7nsK34gO1tJ0pdT+k3ALPOROHVd0YzCf//82eXayGF0IG8gqMNjShO9o41f3o4Pkt
 ki/DlwNP4Rxtwt1WcJsPunnvDBgieo0OyCQrA5yjsZn/+UDnmihNMhkkt0wkGh8XBUKTEdjV9
 eFov7cRd6OWkGEASwgK8bsJA5VbkEfnuHwnHlQWVvBuu3POSPuWscGg8R+WdUI1NO0uu+D/k6
 5Uh1SY00rgxIdqjHEC5yIUaVALzfKUzpfBCYDDlLyGzpzrR9cHpuqMBcPy4stV2iL1ZOnlgkp
 IcE1Ib1y7gLtkNYMgUzCJNHEOsHO7E3AQHnW2ypDV+aKxTInVFr8uDCuILpUyNHmK7uW7Zn3+
 kewd26DQLmS5DjYiycQVZ+drh3aLckNcgChqiplvJZcmSNgR9KiA8icF5p0BY6EkcvYXrnIqJ
 a0CUv7zP5sLreIOwS9lYWCTYukVfqS+OyeWlijMZZ+jVNwUiJJM8t4yA9y8rFDlE6BBbNPhHx
 OWelVpXCTylt1xtwZdF6V9a6OSuZNKYnL40rNf+LZYt+KBoFqMHOAwUuBMxftfSqZEpeMrvxB
 V6GiIQh4ZwFYf5Bv5Hvx0dG+vgno4Lz8B/6amPTHEDtd8o8S4RAtwQhVAcsyC5koVcI9uYpit
 XoXUUT53q+TXt0MgJ75jjegKxJMy9WhRTF+6lg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345568491642708?=
X-GMAIL-MSGID: =?utf-8?q?1596345568491642708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_infrastructure_set_confirm_t' with
'struct hostif_infrastructure_set_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 1d79f07f12cc..9deb53edb344 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -389,7 +389,7 @@ struct hostif_infrastructure_set_request {
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct hostif_infrastructure_set_confirm_t {
+struct hostif_infrastructure_set_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3
