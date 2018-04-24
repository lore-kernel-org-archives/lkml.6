Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx486yOGZAemjqzY3O8ehWVB0dwLAykR3vfqOxMOPEPNBxJbyFVcpIiMwTh0G9YoAOZat0SZN
ARC-Seal: i=1; a=rsa-sha256; t=1524532060; cv=none;
        d=google.com; s=arc-20160816;
        b=GdXL/rM1AGSVbc/m966Qz4GBsPL8AnXD3Hg46JMFHe6nOkZCpnBim6FcD7zOCWnwM9
         0SIkASmxRsQNcqHqA/Yudh/MCoD6974QTYHzXOv5eilROloB4hV+TWyUvq+figwujiqG
         MTnrvETAoz5kSk1eJCRZY5UGxRFSX/jzcHDJH7enfOtN0j8X8t++FEEBCDL1ASV9HmGl
         yEYyQrKfhrSrm96Ca+gkfMUeeFETbSskDgDfLXaCZ0vkv1qqc34DZPY5Qp6uja3FxfJR
         DMubzrpFCxJDK/EjSHozd/JFPqrR1YTXFXQNZbN6utvROUB4VDIpC7+7ciq2efSi5Exl
         WBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=Z8741vzgLyrkydMMXCIbvAz8JlphCE4Z7MZARBaKEaA=;
        b=lFo/cIC9t2jaiDUXQCdDwfkfgHGT4pg0wzp5zYZdMLrWdTrOMco27X3kQOTDAEfHep
         0PkmSxaOCMEsfb00iz9mXkCv0gkJCBSZtm81Ij99wOuGoAwkZQGA/gBT80t2Wc83bfSk
         9VhSNRTzRL0Sn7N/5uah6DK6LaoHyqkj/dkDjMNZEgPzB3cBIbflhqUav+pNxa4xkRVv
         IT86nUMCHVR5PlI9IJh579YVit7EN6zGj+GZjUG1yKUV0/c0Xj12HYEh47RylLzq539R
         RvjoGc8Jdvjq8cNv+iv2D3YLx/gL46AUWijpnEN2lAUqwJbgL48eajfq8EzMML6R3UIi
         SHJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeDXBHj (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 21:07:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56402 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeDXBHj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 21:07:39 -0400
Date: Mon, 23 Apr 2018 21:07:37 -0400 (EDT)
Message-Id: <20180423.210737.2027945447387234727.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: update .gitignore with missing test
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180423140050.4508-1-anders.roxell@linaro.org>
References: <20180423140050.4508-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545796050250563?=
X-GMAIL-MSGID: =?utf-8?q?1598587729616325511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 23 Apr 2018 16:00:50 +0200

> Fixes: 192dc405f308 ("selftests: net: add tcp_mmap program")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thanks.
