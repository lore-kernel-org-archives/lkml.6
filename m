Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3C9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3435625D0A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3435625D0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934935AbeFZK35 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:29:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:47527 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964777AbeFZK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:29:54 -0400
Received: from [62.203.87.61] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fXlEM-00037B-A9; Tue, 26 Jun 2018 12:29:50 +0200
Subject: Re: [RESEND PATCH] bpfilter: check compiler capability in Kconfig
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Matteo Croce <mcroce@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
References: <1529985336-27522-1-git-send-email-yamada.masahiro@socionext.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <23c880a2-8c93-567a-553f-a3438505e223@iogearbox.net>
Date:   Tue, 26 Jun 2018 12:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1529985336-27522-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24697/Tue Jun 26 06:38:09 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 05:55 AM, Masahiro Yamada wrote:
> With the brand-new syntax extension of Kconfig, we can directly
> check the compiler capability in the configuration phase.
> 
> If the cc-can-link.sh fails, the BPFILTER_UMH is automatically
> hidden by the dependency.
> 
> I also deleted 'default n', which is no-op.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
