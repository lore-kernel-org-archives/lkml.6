Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224UWh2ec2efOTkggQtiUfOy9n4B1nBX3qQo6SJYMNzqOdOWylJX8ZBFVEYOi2iJ0Lvm/5H6
ARC-Seal: i=1; a=rsa-sha256; t=1519253315; cv=none;
        d=google.com; s=arc-20160816;
        b=zRyzZNMVFbI2lph05t0V5Jas4e4Eljv8DLHj6EbNz8VIuObDXikmlF701B+gP9jmuo
         x7M+7mVVxh4IsmUAJ5QFAuKf1Ngz81Q3xGCmoZica6E2o+hJFtN9bJB2b0seF15clYz5
         MEq8o00GvCDx/Qr9oWIOXLYzGpdJP+XuHe4e1Bkq5lfc+vDXCPAWLFb0gGtn0d0n7IUM
         LfNIEoFIegmAA2utDrX0uKbfWRZC6ttvLxdsgOLTsBHysUrW+wG3WP397UG4b0ObQ6zC
         3z3LmJ/T9bXQAexHLWyhOPueEW0T+wScxAgqCBXlvQEtjRqGE/b5vsdn/t1EVKiDvXjq
         zYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=5lpwaa/gq/5wnjzmKspsq8WWzrhf7KHLV/P9HUxHor4=;
        b=CeKOIM/5gB943ZvESImWmF3HM3FeLR+EiTV1rFJ9iZK8MheDHOJC9C/Ppy7KM87mob
         y/Aa4k0w7aZQn4o/mipOhCj3sBZ1fVBBpzLg1jlOJSp9sNEPigTFiyj9gP3CeLmESk/p
         5jXdD1rwG/NVfH0feuwVx8GUjUAF4Gp76tVMeVVQHB0MH2tKYLEgUV4PqXwe+zW1WDs1
         xSkRcZRVOlWJ3pORTm83QpGSsgOFpSwqCNUPaGbpGltOml0SiNGmPEVzIw4PU2h+CXFa
         vOcBa58jmc6rK0SWrc9ZS6HRIMt8xy/W22/Z31OQzOgDeleRemV/Sngzwn7KiJiXzToG
         tvaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeBUWsf (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 17:48:35 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:36134 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUWsf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 17:48:35 -0500
Date: Wed, 21 Feb 2018 17:48:30 -0500 (EST)
Message-Id: <20180221.174830.160781272671654190.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: update gitignore with test_libbpf_open
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180221213001.18682-1-anders.roxell@linaro.org>
References: <20180221213001.18682-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593047628966433611?=
X-GMAIL-MSGID: =?utf-8?q?1593052565118633057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 21 Feb 2018 22:30:01 +0100

> bpf builds a test program for loading BPF ELF files. Add the executable
> to the .gitignore list.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
