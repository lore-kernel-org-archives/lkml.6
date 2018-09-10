Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A902C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C7206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9C7206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeIJSOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:14:07 -0400
Received: from mout01.posteo.de ([185.67.36.141]:35682 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbeIJSOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:14:06 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 078502118A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 15:20:01 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4287v25kFYz6tmF;
        Mon, 10 Sep 2018 15:19:58 +0200 (CEST)
Subject: Re: [PATCH v4 2/2] tty/serial: atmel: add ISO7816 support
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
References: <20180906134214.29031-1-ludovic.desroches@microchip.com>
 <20180906134214.29031-3-ludovic.desroches@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <ea441610-1337-d14c-7171-f0fac158bd9a@sorico.fr>
Date:   Mon, 10 Sep 2018 15:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906134214.29031-3-ludovic.desroches@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ludovic,

On 06/09/2018 15:42, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> When mode is set in atmel_config_iso7816() we backup last RS232 mode
> for coming back to this mode if requested.
> Also allow setup of T=0 and T=1 parameter and basic support in set_termios
> function as well.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

This seems ok for me.

Acked-by: Richard Genoud <richard.genoud@gmail.com>

Thanks !
