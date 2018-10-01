Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29FDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A5C2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A5C2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeJBCSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:18:13 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57703 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:18:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 178272152B;
        Mon,  1 Oct 2018 19:38:53 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F9PRO2mJTDUz; Mon,  1 Oct 2018 19:38:53 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 97FA721525;
        Mon,  1 Oct 2018 19:38:33 +0000 (UTC)
Subject: Re: [PATCH v6 16/16] cpupower, x86: Add Hygon Dhyana support
To:     Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de, pbonzini@redhat.com, trenn@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <cover.1536550549.git.puwen@hygon.cn>
 <c26bcce9f41bee8b6921f67e6171a49b17010b8d.1536550550.git.puwen@hygon.cn>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <8db5f167-3dec-5342-5430-ade222848c74@kernel.org>
Date:   Mon, 1 Oct 2018 13:38:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c26bcce9f41bee8b6921f67e6171a49b17010b8d.1536550550.git.puwen@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 07:20 AM, Pu Wen wrote:
> Tool cpupower is useful to get CPU frequency information and monitor
> power stats on Hygon Dhyana platforms. So add Hygon Dhyana support to
> it by checking vendor and family to share the code path of AMD family
> 17h.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>

Looks good to me. I am assuming it will go into x86 with the rest of the
series.

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

thanks,
-- Shuah
