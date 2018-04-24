Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZrghOu8h4eD8EvnM07YPppVmp13TLkvlA2s8K3zgHkYklKu1fQgGFH4b6XQUTikErLR/fAM
ARC-Seal: i=1; a=rsa-sha256; t=1524606975; cv=none;
        d=google.com; s=arc-20160816;
        b=phr3ozcJBrjc5ciIeOLLwd/PFSV0xYXPx61jdYqYSSWC+TyxujppxQqZ4dkanQAPCE
         89VD6ZWU8S6hI1MNPwqLfeaX6Qn6UACWvrBES8inwPnjFmBWOAkle5IF+Vc99Yi7vdQd
         wBNYvCGZp/BLEwrNE2LhY5nLql0SL5QMDy2ldCsp//TqjF8ALTfBSo1r6yZjo+x5+R8q
         Na71e+4XYHaE4P4WBxx/T57xrOlXmmKVEkPOOKsL+ZMweAJF5CAyKU7F4Lyz1BZmQoZz
         d6daIXO4dj4K4S149AGUUj8kQnL3GdFXBMMSLF5ScfajJKsWhDB6Lcb9/NnH6l+sPHkH
         zgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=1Ojr2+Ha4RNIMGA9ow81PpTNjIVS5uIw4PVBfImfCu4=;
        b=KTR72j3AlJXmJERH+YUvbybfnhksgwWgRRFJNdqst8ltcVNvS9VT3F+Vk3bVX+hGZQ
         jVvz9qifjruy2AgOHIAa7K9LfeLyGFoOZZndWhPUFv7MdIvmTm1b2GDmW0WrOyXXk5Je
         90/CCcC5AeHvpnJPjHKy2MORb42wBE3Ud1FmZ/eXll4fW5D7+ONx92ZYSb+yWho9S55D
         rgI3E6P+N/djB/wRujNMGxjNUd5fPbolsoW2bPToOX50Sux7U6oNiobYBwpxIBMMxeln
         u9mD/n0s6RHl4xyljpu3K7oBwI3I3qLNxUnRXSr5t9LGGPPIS0GK9/RDuvzXwiyl78bF
         gdng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750779AbeDXV4O (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 24 Apr 2018 17:56:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:60033 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXV4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Apr 2018 17:56:14 -0400
Subject: Re: [PATCH v2] selftests: bpf: update .gitignore with missing file
To: Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org,
        shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <065a8bc2-6065-3d43-8b03-35ed693de7ce@iogearbox.net>
 <20180423225305.18947-1-anders.roxell@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <40ecbc34-f7b2-2585-c4b1-432c19972432@iogearbox.net>
Date: Tue, 24 Apr 2018 23:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180423225305.18947-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545167658218974?=
X-GMAIL-MSGID: =?utf-8?q?1598666283422415712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 12:53 AM, Anders Roxell wrote:
> Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> Rebased against bpf-next.

Applied to bpf-next, thanks Anders!
