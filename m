Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520377095; cv=none;
        d=google.com; s=arc-20160816;
        b=T3smtvTSBVyqbl3nlLMPbJEmb4j7ez/ZygIgeHhGTN3b3sexdDjxOWhpKj2Ftpi+30
         99agc/sfji8Ij4vHk7MD8eIMBEyGIyyOUTNhdDRKMlgsT0cXt7sybN03drqMs4CtNXl7
         uTv43KCfUUN5sC4Upy7NjE7kQHywPBxfExBTrkEP9qL/hrr5rLUUc98qcXy4lLzIReu4
         Zr3g1LHTZZiwjKCc6H065iCRtnqfiWkwK50nUwEbzsG7JdxwVT9lrELo2KLHo3FW/nie
         TDDsTWc6V6F9HQSoK4lfGFMNSX+qvPtXettsar/lr1hexuJMbhEBjlCoCI+kLlVqiQWi
         BhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=jGhVj2aTvZpcKVzn+/8hJkIK6D4+E+XvUuuuutDlFFk=;
        b=Nu7eXY3IgQ1sZ+2hgg54BC9qn3tSHc9BSnFLUIkrZTB6S/QoYBPtqjOFvweaJIEDvg
         gt62NX+cZWOdkTFK+P58cAH4/fS90iHAVAk69UFTHPNa+7j9eVgG3Cu9UhFbuUWxi5hq
         BlIveYz+JWm+A8czzSCe9F9f1iBWR/1iWxjJ9Px4SuHKnX6AjvY/rvL2rIotU+/Rf3KH
         NHPU89zwfTKi1N3/78ESkD/gaE/EjjcikP8cAI7HNJ7IsqKzYo4j78u8mef0RiEXy9Y+
         kkORF1J5OfNzKWK6AohiqLcpNb98pcb8hagzBzUp9x4ZvykRWQZpRAGg3qO404Odou2p
         dzuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=kZMHPMHk;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=kZMHPMHk;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtliSpeYXdTbgEM1f7auqFgPx4QbCyegRrvuSoFjOYN642KGO5vXhPOfi9vUrGqUiJrPDtRiw==
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] lkdtm: Relocate code to subdirectory
Date: Tue,  6 Mar 2018 14:58:08 -0800
Message-Id: <1520377090-6724-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594230933229457960?=
X-GMAIL-MSGID: =?utf-8?q?1594230933229457960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Please take these two patches for LKDTM. The first is a mass renaming to
move under a new "lkdtm" subdirectory in drivers/misc. The second just
adds a missed SPDX line to one of the LKDTM source files.

Thanks!

-Kees
