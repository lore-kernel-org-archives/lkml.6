Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48gM4qdW6z6BPwNmEC+izK3Che3KLtcNHnWRibaQVPR7XEiUI4+W3jkF1h/IDsROl9cuwMJ
ARC-Seal: i=1; a=rsa-sha256; t=1522393767; cv=none;
        d=google.com; s=arc-20160816;
        b=gbmFOpNx9HbCkqVn5bgwdEpezCYHnc5oeHYuczpgHNkhClQcY+vdPy0RZmQejCZPgF
         5GsfcWLIK8JTjWh2g5xEbifRJn6ZuhQYX0btPTxcx5Rn7m5brDsxhQb2u43I24PfBuxg
         A4aRdcn5gpUAEw80A+755fmcdYxLjVKkUaxi5jLXHbCRXYL5fdauoAsyK7aruzCC8rbU
         WcotecP1K/6NCL9wTa6cpMULL2gbGwQSwMg2kmivrmpHPpr9Xbn68CXLgfUEGmSsPE57
         z5rTTONogyLM38SSYuH9NdjS37Ip+byD2J8BYoV4qrDBqW7dn4tpmUGXqGDfLmVBBM+P
         SJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8vPTFFKY+aYFWc4+cEoQenTkZdSz6hxJOTcHYN3R0Mo=;
        b=cMtRQwlK77qk2rytGX0NqMYoU9vQxtJnriaNo0EmjwrzK5kkb9Q2GMnYE44FxNwI/D
         HAnoX4ItvZQqyNc5xeqogVVhVnH/jpHNWjVEx87cygyhirGB0kcpulh80WB8dcoyR1Ql
         ktu69rJFTtG7637HHj0Nd2wcrQBzZ6iBy1c2s5/m26kku8w3RNWuNgDSSiOPd1S6rFAx
         cf0rYZzyGj7gHwSZgGb1DgpoH7AnYvhBGgDgHaMEftTu5ee96OCiJti7nJcX8MDnusTS
         QO9Lw/OvXF9gsR5EcmIzNVTiplle9qSNDL5PBykJN5lajIwKua7UDCihMoGDPXed9Kos
         XNgg==
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
Subject: [PATCH 33/76] staging: ks7010: Remove trailing _t from 'struct hostif_ps_adhoc_set_confirm_t'.
Date: Fri, 30 Mar 2018 00:07:56 -0700
Message-Id: <20180330070842.25224-33-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Z9EzY8jLDr989fFR7RPOF2Ocv56p6VDj/IOqmofJ35m5Cq8rx0s
 YC4fRjimLxXrqQCl23y+k1kXlyFGZK5V2VlPyc6bxx9vIGMWa0fJosI/6cudTr32z2T8cFb
 /IGXk+6yOW6wou6xLLko+f5qempLdl9dw/eDNhb3gu4QDZWwYy+MMOIc9Ck/hJ+wmLboxOO
 uxZefCCK5Zj1ysfWPY9iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:By2Zn9004wk=:iCOH1KAZQYbM97SOX3zmVH
 4cOmESmPs2VuCl0VzZPcyy6mkAjF4fSv0xZhRHeg4dlpCDFg74F+6ph9THhSsRS/OcTagE/3W
 NSz7LMdAUoQv0SDP8uyO611K64HWvQ7mqHCOt1btCtS7w61vLuaT5DynpAILH2EIg3v2Hkm27
 Fb38+mnrZP/9OqjH0gImNYDYCA7wseU9wZQVewtSkP8uc1dOH+/GrSu34lZjOHd5pUMcpErRE
 hSu6uB6Ng2nKsxMXxydZA02TU08sC841Es7pKGhiwLGdwz9RH3q7ANhYqr8OM26vhD6j4W6QM
 8Hk3vQXtU7huQ2e+JXEKddvv8EHu5pFHGAccyPFZgsa2zk0i9rBbv7w0+YD1CBzaZ2hAFrWv7
 MTvHNgjJ+GRKSE4hsZ9odXjzv4l37/NR9JPP2wTl4yf9Y/QMu0EmhYOE76n44trq6TJbRg+jc
 mFnTT+iMU0AMnZ/Q1K4XtIEszLjI4/sQ9e759NuYo4QOvXkzmH6ZGM9JlDxr0vzGL8NxZQVKA
 e81mYwmZDwmxlDy4yR1/ICDXg4DaURI4TK+nCKj8HD6aHfb800e+UOiVwzPH32LUTn5SxUMk4
 HtRcH0PmSshBHAUpW110JqgDoNiEDP4OdmHp3uOT1bs1ZpGQgkFVJT+4BtsCxnfD/1R40xIOl
 LNh+suFBb8+GbPIYD0QQWLxl73L777ICTbN1An13HJIQ8+ZqKqdaDjzv8g0614WZBTw4piUow
 OYm/TDXzjJzxruskZX+hvOqfnghneeWMZoEv+w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345566886293009?=
X-GMAIL-MSGID: =?utf-8?q?1596345566886293009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_ps_adhoc_set_confirm_t' with 'struct
hostif_ps_adhoc_set_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 665114736d17..be33a704c7c4 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -364,7 +364,7 @@ struct hostif_ps_adhoc_set_request {
 	__le16 channel;
 } __packed;
 
-struct hostif_ps_adhoc_set_confirm_t {
+struct hostif_ps_adhoc_set_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3
