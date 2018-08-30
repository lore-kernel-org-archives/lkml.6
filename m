Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D4CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1FF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1FF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeH3TP2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:15:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57282 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3TP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:15:27 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XsE_X5BgvgK9; Thu, 30 Aug 2018 17:12:31 +0200 (CEST)
Received: from [192.168.1.100] (unknown [78.130.197.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B3401EC0200;
        Thu, 30 Aug 2018 17:12:31 +0200 (CEST)
Date:   Thu, 30 Aug 2018 18:12:28 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <000901d4406c$9d04f360$d70eda20$@codeaurora.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org> <20180830104307.GC20005@nazgul.tnic> <000901d4406c$9d04f360$d70eda20$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
To:     wufan <wufan@codeaurora.org>
CC:     mchehab@kernel.org, james.morse@arm.com, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "'Kani, Toshi'" <toshi.kani@hpe.com>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <9AEE3BFF-5F17-4C72-BE0A-76006BB64890@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 30, 2018 5:20:32 PM GMT+03:00, wufan <wufan@codeaurora.org> wrote:
>> > +static int ghes_edac_dimm_index(u16 handle)
>> 
>> get_dimm_smbios_handle()
>
>This function returns an index. So how about get_dimm_smbios_index()?

Sure.

-- 
Sent from a small device: formatting sux and brevity is inevitable. 
