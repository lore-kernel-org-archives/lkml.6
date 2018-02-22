Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224A4BjSkn0N/nvzqwDt1fR/UcYoHFUudGKv0zgXDSYbONl9YaLS4ZtaR5/gm1e/cFAvin+O
ARC-Seal: i=1; a=rsa-sha256; t=1519329052; cv=none;
        d=google.com; s=arc-20160816;
        b=f4CYa1874GlXRPOSz9bgAvq0xgoNH2nE+TX+Ulc7oREYM5/0gMqSjy1T9MwH31HHPm
         mfxMjZarDAytCdEpxkATlcWpKwp2OKsp7znP5eZTLaDzGZVQJzzivzo1jA5Le1czcpwq
         fvq+ylF3F7Weu94c3rm2tUYmESE0yrKCkjk3xtxS4CrI6yHObceWyCMZmCP55mP0js50
         x0JcjasCHzqKBJsc141wbTAzzuvf0nt5Li95pVEjHKS1ogHLpABmGoskm8HXZGmD1Ys6
         x1bIFAnfWzjA5BeQvwxflh2R9VBbTCeOdxCJip/F49CpYaHyCNOqaPQH7zRx9rC7srjB
         TVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=KgGfGDVT2iK4hoOCFVSvb2ge+0NScE1ipb7IfQo9ffQ=;
        b=raJPzKAEgUsxJ/0OfvPgVi30IVPDGXSn/TA9XAAk5wDVa9lMUUFr2GpJ1BbmVWhWon
         cqWm4NRAhhjSzXW7W6jGhSXYZ9qg+CeGzI3w3KQdIPAbbULrmuf9Z8FevwWYEVp9Is2v
         30dUWp/G+Xy9egxv1MQ0DlAASt0cN/ACYBQtQit5J9phqfOUznI9XBLufeP6Mgp+qb5y
         Qk1+1AREK9Qd7swq7FoAHSj9Y+WzuHtlPFstu+Voex+bZlDjm+zTY6tdxUi1hRx0MaO8
         EisUJPEeRzMq+QQgZzxy3CsThypUBtkI7wra0eigi5znWoz0izjvTE2PDSkbX5iRb7h4
         DzYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBVTuv (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 14:50:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeBVTuu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 14:50:50 -0500
Date: Thu, 22 Feb 2018 19:50:47 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Zong Li <zongbox@gmail.com>
Cc: shuah@kernel.org, vincent.legoll@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, mcgrof@kernel.org, davem@davemloft.net,
        keescook@chromium.org, fathi.boudra@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zong@andestech.com, greentime@andestech.com
Subject: Re: [PATCH] selftest: fix kselftest-merge depend on
 'RUNTIME_TESTING_MENU'
Message-ID: <20180222195047.GC27055@wotan.suse.de>
References: <20180222115307.15063-1-zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222115307.15063-1-zongbox@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593102038295942155?=
X-GMAIL-MSGID: =?utf-8?q?1593131980537478122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 07:53:07PM +0800, Zong Li wrote:
> Since the 'commit d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig
> to ease disabling it all")', the make kselftest-merge cannot merge the
> config dependencies of kselftest to the existing .config file.
> 
> These config dependencies of kselftest need to enable the
> 'CONFIG_RUNTIME_TESTING_MENU=y' at the same time.
> 
> Signed-off-by: Zong Li <zong@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>

Please add respective Fixes: tag with the sha1sum, and commit name.

  Luis
