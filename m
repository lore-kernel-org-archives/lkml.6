Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZqOIjbaJrLY50TFd2dpc9yS/iLakYHid2PB0YLaI8y0USXWh4lg5Dac1lpircdGTne/CiG8
ARC-Seal: i=1; a=rsa-sha256; t=1524849261; cv=none;
        d=google.com; s=arc-20160816;
        b=dwdQ1peH0gYVLm2JuRsHh0sBKlSvBfxuCMt/X48ukoVsFElgeVCGrHJ/1mPaOi9rSn
         RSBA5T96SrJcRFfeH6j0zQmzBWZHwze0xRSY4yOfckydEGFHI3UIJ0yOrH8UVb335TSG
         sevOQ8Pi7eIgn7f95l5C5M4m4FxHtKXi0jEiZXBnaJj9JQT9ORlg4L61/+F5Ue0bP33e
         4jjuCcnGZJA0QKklYoS7eEil7HrxTY7APIHe9Zt0jYTv29i9alPKalAIyx+FVRlzHcn4
         XeUpZHhpQ+DJPd19L6GWiW/X4cP8QylU2ouFYPvlWVYD+ERzshfwEVz0a11LWxpUZt74
         NCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=64YsFfQMoKqdyp8F6bDg7Lpy9BCXPRG9AZ4nGx7d/24=;
        b=ew+z722lwbzdt38WamC9vna83EQQ9x54U23jzzANyMpcHuaW0WTO3Amdd6bfeqWYzz
         C0IgumK54ms+WJOsdEFEbds+bulQmHpjs6iVSduHEOqsDVVPVFiMMzQLlF7TYu+NjFF3
         P9CXK2z9/pEuUbjvNDBQCg8CuIdv9wofz8FPisuelRsQWn5aeGJ2FuxK3opzsbqrfspN
         bWxqKxGfeNHV9layoVkEOGj66EuQizLC4OSSJke4CqH658NiuzvcN1wy01C1ASeG2wvS
         xsTiVt0aKeeINkp+nQdOHvvRa9gr5WsBTGVbECPGEEHec1q4fsG38fQPfO202KS/VCsM
         RvHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758606AbeD0ROE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 13:14:04 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55024 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbeD0ROD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 13:14:03 -0400
Date: Fri, 27 Apr 2018 13:14:01 -0400 (EDT)
Message-Id: <20180427.131401.2013176564896918298.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: net: add in_netns.sh
 TEST_GEN_PROGS_EXTENDED
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180425213206.7531-1-anders.roxell@linaro.org>
References: <20180425.132513.1786379382285267245.davem@davemloft.net>
        <20180425213206.7531-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598667778719810638?=
X-GMAIL-MSGID: =?utf-8?q?1598920339590638470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 25 Apr 2018 23:32:06 +0200

> Script in_netns.sh is a utility function and not its own test so it
> shouldn't be part of the TEST_PROGS. The in_netns.sh get used by
> run_afpackettests.
> To install in_netns.sh without being added to the main run_kselftest.sh
> script use the TEST_GEN_PROGS_EXTENDED variable.
> 
> Fixes: 5ff9c1a3dd92 ("selftests: net: add in_netns.sh to TEST_PROGS")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> 
> respin against the 'net' tree.

Applied, thank you.
