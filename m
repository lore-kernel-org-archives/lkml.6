Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvRl9fjMoJk8TldLFeKyLKMf0skIY+4ghMb2XxGEGC9kvWzBn+0qPMJ7DgT/ybnx1HPkxAj
ARC-Seal: i=1; a=rsa-sha256; t=1520777644; cv=none;
        d=google.com; s=arc-20160816;
        b=QjEc4nZsAnMTEOZ2SMRBWOMGDLHp5rjQOyJQA+mymmCN/lFT0cQ2yQBEqk2PFlrXRA
         ynaXdaHfwpKzgEyJ3KiMoisdqMa+GFSOUqoBAx6lzdHibgU36vQTi24VAwPmRXWVZKGY
         zzEwuyw9ek+E4yVNpFw+05vqMg1Ut+TX4sqF+U0YZx3xqEJZO/Png7TRJUGPC28f81r4
         Tzdh39HnXE600iCeVjYhlJoZYZzPkagQuc8t6S9FDudjXNC9Tk9xEp42SC1kfV9Q/VuJ
         U7iCMnpYejE023YqLZ1j7kj5p7CFg47jHINa3kB6hdqaXY/Nm1nMtcZ2p1C1PzFdCzaF
         R6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=FVxLj5UW3XvCk8yKDzg0W9hLpY/SJYfAuY2Izkg5Zw8=;
        b=okbqmNtdXh0FT2980gJP7kOJ6Qv4ZratkHKr9i9yVihF6Yiu6CCoPSi15eHpgluD+f
         sbEvkhDdS5aCw9oaLQla8U2Qk330JBI0p7QeL5BooqbSMIXaOn8UPC/B/juJUbodoGkp
         yHg8zQjuP1Ciw/fktIOQc4ScBKLKXVtvYeD4yyTvrgP10hLHwg/2Ep3JXXhQYvVK/zja
         clsUSSVrG+P3TPF4Piic79hSdSVP6kWXjpCkQzJ5vZ3Q05FUtaPj7KOCb67OPhDkXB8F
         bTqkYIX/uthk50fUtHhGs/BxAzB1Y8Lpm+QAL19MTRMaId+VHKntgTc7QjuMcfznuJ9P
         0adQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=rOEVfdPu;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=rOEVfdPu;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeCKOOD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Mar 2018 10:14:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40507 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKOOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Mar 2018 10:14:02 -0400
Date: Sun, 11 Mar 2018 17:13:58 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: shuahkh@osg.samsung.com, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: prevent carpal tunnel
Message-ID: <20180311141358.GA22705@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594650939397463300?=
X-GMAIL-MSGID: =?utf-8?q?1594650939397463300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Shuah, please do

	ln -s tools/testing/selftests test

It will save a lot of typing for everyone over the years.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 test |    1 +
 1 file changed, 1 insertion(+)

new file mode 120000
--- /dev/null
+++ b/test
@@ -0,0 +1 @@
+tools/testing/selftests
\ No newline at end of file
