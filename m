Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49PAbmsRqrmLJAjrZH4C0hyb43IEyO2WfYqR3gztCWw1CQqWvWG3B0OzPSXK9Ehq5pSXzpC
ARC-Seal: i=1; a=rsa-sha256; t=1523584399; cv=none;
        d=google.com; s=arc-20160816;
        b=0O4d0QY8Vtgca379cmHUYl607ikxIzOyFaaDc/ZLNAO2a7k0rJzhD7+zmlTaCwPxxw
         7Ax1AyqWz/NM1cvuBDacNZgDzLRTJ6onM6xm3d2HNBCaxk0Pt3l+KHB07iPxrg/3qCQ8
         +iDJ/9KqmVTp2vAd1cR58fBzEMDZx9AoMeB8/Wv5blKIDy7vn2VVxfRE08RODedEpkG0
         /kYjvBlXODXsyVziWSP+sxkqCX+fDxogtGONb9KQTCaNTDOzommc8hPAItLtaOjFE/sl
         mjg/pogan2DpFk4AVMBetsyHIEm6jicmQK90zBNM3utvSbeUzS9RdjmvUWHFbvRdIRb1
         J0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=wGcUUsoyAnpVRPQPFDh7dbeMK+jsGdrOSUIkgfEDTiM=;
        b=HIDxKQ02m/yJLtYQ9K5FZjEkPbur93ImVyn02uTSfRi1QkmcRRd/adgc4+P5eaEmm2
         aHq8EZQxSLOvXK1V1d7Y3BTKc1C3jzIadV10wilbVIpIj4oPX4hqcurgKa6nqyzpUKXk
         SMQAnN1aqkXI/7ulSaSPQfM/R9u0GoZCzXlFjja/oheDM85wTwxuYGGAcLWRoH+vocOD
         mZJfRnLC4N1yT+wfMBsiydOQjxfaYpSKMbowMTy3EINAy+syROi4qsIyzAXzFD2ogn9b
         /WwvtU8uijA9dBGjGaPujMiWC7+Vmev/+YRykLYmZMMR/cmGOoAPSUhHZZMQ3hQu14RR
         Hf9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbeDMBxC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 12 Apr 2018 21:53:02 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeDMBxC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Apr 2018 21:53:02 -0400
Date: Thu, 12 Apr 2018 21:53:00 -0400 (EDT)
Message-Id: <20180412.215300.1371548831144372410.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: add in_netns.sh to TEST_PROGS
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180411151734.15507-1-anders.roxell@linaro.org>
References: <20180411151734.15507-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597463499107881201?=
X-GMAIL-MSGID: =?utf-8?q?1597594035580432109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 11 Apr 2018 17:17:34 +0200

> Script in_netns.sh isn't installed.
> --------------------
> running psock_fanout test
> --------------------
> ./run_afpackettests: line 12: ./in_netns.sh: No such file or directory
> [FAIL]
> --------------------
> running psock_tpacket test
> --------------------
> ./run_afpackettests: line 22: ./in_netns.sh: No such file or directory
> [FAIL]
> 
> In current code added in_netns.sh to be installed.
> 
> Fixes: cc30c93fa020 ("selftests/net: ignore background traffic in psock_fanout")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thanks.
