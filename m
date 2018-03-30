Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/+Cn64oWBau08t3pJoHO1Bk6/FwUYjXjh4dL2Z6CeujlhRTqCrBbEwR3t6oHaF9jLqljsj
ARC-Seal: i=1; a=rsa-sha256; t=1522393781; cv=none;
        d=google.com; s=arc-20160816;
        b=bxi6YNFVSkIRBWOwgeKzUixItodaDq2WJoXtofFIVTt6BmnNBbGt6+4XDY2J+PRy/x
         HoD6rTWkTX0M2l6xzWWIcJWHALtZ5HzbmDkIYH23VRVQO5Akyska2o0vVVB0X8qYBqpo
         2AARx88MB5IVosQcjyIO6vSqsNiKLsnRz6UvhsclBsr8lKcNWqKGjMKFuJCE1zujWEGn
         df5s05XMVVtSCMONBf1IWUv3JAgL2zg+tWbiZtWbWnx6oGQzpmjAuTNc+n55Wkly1WqQ
         H567ri8wyDCWu720bOd0aXyP1j71FtogquvO0WvtPDNtq5dG9/r3ANWEAcFjz2OkROiR
         06Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UduXLF+TlvWKRVm5ewANEX9L5nGJ+KX+OOz1jkn+CVM=;
        b=EJugmbDO/r1Db6sHW+pfjszyViapnUhaofOmDNchZnUL07WDFAIqvrbdQffyfUleOa
         JJ8N+1QPWttY07v9KYzHvIbOtYwhKsck7Nntb3MC/mXxwmQuDTbfBx0VD7FBtmF8W/yZ
         XKsWWA1q/BHy4gOVacbl4kLt3w36r+V6s91kzveVy93mdeUSEfKH0dEbXNY/6U3GSSOY
         /SrHX+dO9nVr9+yAIaRpDxj874Fmwfk+hZGrPoOP6Z3RRM7Ul9bU2jkr4wOH8StBkcyK
         bHV3ef7pMUrJfbSBZZtns//ifFxVidkzCxOq205t9DWr+F58F4qicIoKnxyPP88WQ2+F
         RVow==
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
Subject: [PATCH 50/76] staging: ks7010: Remove trailing _t from 'struct hostif_mic_failure_confirm_t'.
Date: Fri, 30 Mar 2018 00:08:13 -0700
Message-Id: <20180330070842.25224-50-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:q8knK8dmTBNkZK043r6yGf+NIjH8qsDdgPSvoD0lLD0k6vfFJKx
 x3erJqLb8tu5yIvX6o4v2XrzVGQDJyxNKofmFXW2cWbaGo6BONIvBmjimpg1lk5FGlfs6/B
 Cs52kc2pRQwHJ0O/Z3mP3J/XvExPWVqJhw7iWbJhQEEsCzbTiWvu4VEca2wAQmrHQJallos
 rGKtSN4tgKdXNQFNWf3VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sT8c5zpkdzc=:Ay3yy3D3QFQ3GFzH0chNO1
 zw1WfhFb/YM+h/ZM71vsEa92olHQtGjcCPLMOzJJVNjPV23qfyRuGXrvSVjdzAB9d3HfWyB/m
 j3PBrRuXHGWQaOWUV1QWmSO02Z7Z0a4/mnkdwNfnqW9qz08VHvNjNxvCItQjW10vkAaEWr4Cs
 Njm5U070yU2GrGD7Paja+yAj4FbqfEMR3WwvMxITF2V7zCUs12gQdO8hjotn2gfeOOnZlCWWm
 o9fR7CjTDZuQARFdPNjnlP0kBUiBdxug+9SVXUTGFtCKXYMbn9ITo8nIfnsmjbeubEUHAU13n
 8t74ibxTrBKjj8n8U+nNzTDNPTMwoUDXS6qKzmdBRTAY3fIKioRGlGyYtUollpxCVv3Y2vOKH
 nmhKPvQLdpeJ8707+9RmsQ7D+ZX650DuRACvz68laQ8aX1O5Jf3/A8QAPZCPxIR96idc4NziD
 NJd/UOjp6rcn7Xlfqlw28KbsrA24I2ld7K9XRel7UByYwaQN12Hu4t/1aDO6cUYHzRgIYw5AR
 d1BIVImn2qXpBeaArFJs195EoTQahnM+kGXbmrsMzCoCKAygE6P588c22B8vckjUG/Ei8xvfS
 Ghg22486YzXGFf/ksvWD2R0MOdlC06F1NFbormL6nTqeGz+Vp1XQUc9mcmCrOOU9cseETqUlG
 umPzSKILt8mp4y5+zmRM+RFRzjSxHnE/HIL3DaHURxVSQP27NnWQo3jQVmqtwAq8MRpcx7eVy
 2/29OOBFogq5l8lhErjBmyF7h7P12vHTfrgOKPReFNjbK/MCpnhcLj6vsipSbfyqkcWuMUTYn
 bzOxDVB3bOP23jRWGJhCD1nySNQFR0822VW4k/Gmc68MPQuUQVQGb4E5gpG1CrRMCcEJ+CGbd
 +ZXfXqm33Z56CKJ0nK9Xls1CIY+BzDcyg6ozSno5x7fP2XoIba9O8p/qggRSa3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345581679993990?=
X-GMAIL-MSGID: =?utf-8?q?1596345581679993990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_mic_failure_confirm_t' with 'struct
hostif_mic_failure_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 659e2b895bff..f67f4c2b0730 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -518,7 +518,7 @@ struct hostif_mic_failure_request {
 	__le16 timer;
 } __packed;
 
-struct hostif_mic_failure_confirm_t {
+struct hostif_mic_failure_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3
